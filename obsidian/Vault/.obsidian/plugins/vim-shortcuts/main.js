const { Plugin, Notice, FileView } = require("obsidian");

module.exports = class VimShortcuts extends Plugin {
  onload() {
    this.vimReady = false;
    this.lastPdfLeaf = null;
    this.wasFocusInLeftSidebar = false;
    this.lastPointerTime = 0;

    this.addCommand({
      id: "pdf-next-page",
      name: "PDF: Next page",
      repeatable: true,
      checkCallback: (checking) => this.stepPdf(checking, 1),
    });
    this.addCommand({
      id: "pdf-prev-page",
      name: "PDF: Previous page",
      repeatable: true,
      checkCallback: (checking) => this.stepPdf(checking, -1),
    });

    // Wire Ctrl+N / Ctrl+P directly to any menu/modal/popup scope's own ArrowDown/ArrowUp handlers
    this.origPushScope = this.app.keymap.pushScope.bind(this.app.keymap);
    this.app.keymap.pushScope = (scope) => {
      if (scope && scope !== this.app.scope && !scope._kfBound) {
        scope._kfBound = true;
        const bindNav = (ctrlKey, arrowKey) => {
          scope.register(["Ctrl"], ctrlKey, (evt, ctx) => {
            const handler = scope.keys?.find((k) => !k.modifiers && k.key === arrowKey);
            if (!handler) return;
            return handler.func(evt, ctx) ?? false;
          });
        };
        bindNav("n", "ArrowDown");
        bindNav("p", "ArrowUp");
      }
      return this.origPushScope(scope);
    };

    this.app.workspace.onLayoutReady(() => this.registerVim());
    this.registerEvent(
      this.app.workspace.on("active-leaf-change", (leaf) => {
        this.registerVim();
        if (leaf?.view?.getViewType?.() === "pdf") this.lastPdfLeaf = leaf;
      })
    );

    // Track mouse clicks so clicking a file in the sidebar doesn't auto-collapse it
    this.registerDomEvent(
      window,
      "pointerdown",
      () => { this.lastPointerTime = Date.now(); },
      { capture: true }
    );

    // Auto-collapse left sidebar when moving focus back to the editor via keyboard
    this.registerDomEvent(document, "focusin", (evt) => {
      const leftEl = this.app.workspace.leftSplit?.containerEl;
      const rootEl = this.app.workspace.rootSplit?.containerEl;

      if (leftEl?.contains(evt.target)) {
        this.wasFocusInLeftSidebar = true;
      } else if (this.wasFocusInLeftSidebar && rootEl?.contains(evt.target)) {
        this.wasFocusInLeftSidebar = false;
        if (Date.now() - this.lastPointerTime > 300) {
          this.app.workspace.leftSplit?.collapse();
        }
      } else {
        this.wasFocusInLeftSidebar = false;
      }
    });

    // Make Enter and 'l' (in file list) both open the file, collapse the sidebar, and focus the editor
    this.registerDomEvent(
      window,
      "keydown",
      (evt) => {
        if (!evt.isTrusted || evt.ctrlKey || evt.metaKey || evt.altKey || evt.shiftKey) return;
        const k = evt.key.toLowerCase();
        if (k !== "l" && evt.key !== "Enter") return;
        if (document.querySelector(".modal-container, .menu, .prompt")) return;

        const el = document.activeElement;
        if (!el || el.tagName === "INPUT" || el.tagName === "TEXTAREA" || el.isContentEditable) return;

        const leftEl = this.app.workspace.leftSplit?.containerEl;
        if (!leftEl?.contains(el)) return;

        if (k === "l") {
          const isListPane = Boolean(
            el.closest(".nn-list-pane") ||
            leftEl.querySelector('.nn-list-pane.nn-focused, .nn-list-pane:focus-within, [data-focus-pane="files"]')
          );
          if (!isListPane) return;

          evt.preventDefault();
          evt.stopImmediatePropagation();
          evt.target.dispatchEvent(
            new KeyboardEvent("keydown", {
              key: "Enter",
              code: "Enter",
              bubbles: true,
              cancelable: true,
            })
          );
        }

        setTimeout(() => {
          this.wasFocusInLeftSidebar = false;
          this.app.workspace.leftSplit?.collapse();
          const leaf = this.app.workspace.getMostRecentLeaf(this.app.workspace.rootSplit);
          if (leaf) this.app.workspace.setActiveLeaf(leaf, { focus: true });
          this.app.workspace.activeEditor?.editor?.focus();
        }, 50);
      },
      { capture: true }
    );

    // ArrowRight / ArrowLeft when a PDF pane is focused (repeats when held)
    this.registerDomEvent(
      window,
      "keydown",
      (evt) => {
        if (evt.ctrlKey || evt.metaKey || evt.altKey || evt.shiftKey) return;
        if (evt.key !== "ArrowRight" && evt.key !== "ArrowLeft") return;
        if (document.querySelector(".modal-container, .menu, .prompt")) return;
        const el = document.activeElement;
        if (el && (el.tagName === "INPUT" || el.tagName === "TEXTAREA" || el.isContentEditable)) return;

        const viewer = this.getPdfViewer(true);
        if (!viewer) return;
        evt.preventDefault();
        evt.stopImmediatePropagation();
        this.turnPage(viewer, evt.key === "ArrowRight" ? 1 : -1);
      },
      { capture: true }
    );
  }

  onunload() {
    if (this.origPushScope) this.app.keymap.pushScope = this.origPushScope;
  }

  registerVim() {
    if (this.vimReady) return;
    const Vim = window.CodeMirrorAdapter?.Vim;
    if (!Vim) return;

    Vim.defineEx("dictadd", "", () => this.modifyDict("add"));
    Vim.defineEx("dictremove", "", () => this.modifyDict("remove"));
    Vim.defineEx("yankall", "", () => {
      const editor = this.app.workspace.activeEditor?.editor;
      if (!editor) return;
      navigator.clipboard.writeText(editor.getValue());
      new Notice("Copied entire note to clipboard");
    });

    Vim.map("zg", ":dictadd<CR>", "normal");
    Vim.map("zw", ":dictremove<CR>", "normal");
    Vim.map("zug", ":dictremove<CR>", "normal");
    Vim.map("zg", ":dictadd<CR>", "visual");
    Vim.map("zw", ":dictremove<CR>", "visual");
    Vim.map("zug", ":dictremove<CR>", "visual");
    Vim.map("<Space>a", ":yankall<CR>", "normal");
    this.vimReady = true;
  }

  modifyDict(action) {
    const editor = this.app.workspace.activeEditor?.editor;
    let session;
    try { session = window.require?.("electron")?.remote?.getCurrentWebContents?.()?.session; } catch {}
    if (!editor || !session) return;

    let word = editor.getSelection()?.trim();
    if (!word) {
      const { line, ch } = editor.getCursor();
      for (const m of (editor.getLine(line) || "").matchAll(/[\p{L}\p{N}]+(?:['’][\p{L}\p{N}]+)*/gu)) {
        if (ch >= m.index && ch <= m.index + m[0].length) {
          word = m[0];
          break;
        }
      }
    }
    if (!word) return new Notice("No word under cursor.");

    if (action === "add") {
      session.addWordToSpellCheckerDictionary(word);
      new Notice(`Added "${word}" to dictionary`);
    } else {
      session.removeWordFromSpellCheckerDictionary(word);
      new Notice(`Removed "${word}" from dictionary`);
    }
  }

  getPdfViewer(activeOnly = false) {
    const extract = (v) =>
      v?.getViewType?.() === "pdf" ? v.viewer?.child?.pdfViewer?.pdfViewer || v.viewer?.child?.pdfViewer : null;

    const active = extract(this.app.workspace.getActiveViewOfType(FileView));
    if (active || activeOnly) return active;

    const leaves = this.app.workspace.getLeavesOfType("pdf");
    const isVisible = (l) => Boolean(l?.containerEl?.offsetParent);
    const target =
      (leaves.includes(this.lastPdfLeaf) && isVisible(this.lastPdfLeaf) && this.lastPdfLeaf) ||
      leaves.find(isVisible) ||
      leaves[0];
    return extract(target?.view);
  }

  stepPdf(checking, delta) {
    const viewer = this.getPdfViewer(false);
    if (!viewer) return false;
    if (!checking) this.turnPage(viewer, delta);
    return true;
  }

  turnPage(viewer, delta) {
    if (delta > 0) viewer.nextPage ? viewer.nextPage() : (viewer.currentPageNumber = Math.min(viewer.pagesCount, viewer.currentPageNumber + 1));
    else viewer.previousPage ? viewer.previousPage() : (viewer.currentPageNumber = Math.max(1, viewer.currentPageNumber - 1));
  }
};
