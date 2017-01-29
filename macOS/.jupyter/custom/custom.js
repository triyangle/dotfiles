IPython.CodeCell.options_default.cm_config.autoCloseBrackets = false;

require([
  'nbextensions/vim_binding/vim_binding',   // depends your installation
], function() {
  // Swap j/k and gj/gk (Note that <Plug> mappings)
  CodeMirror.Vim.map("j", "<Plug>(vim-binding-gj)", "normal");
  CodeMirror.Vim.map("k", "<Plug>(vim-binding-gk)", "normal");
  CodeMirror.Vim.map("gj", "<Plug>(vim-binding-j)", "normal");
  CodeMirror.Vim.map("gk", "<Plug>(vim-binding-k)", "normal");
});

require([
  'nbextensions/vim_binding/vim_binding',
], function() {
  // Emacs like binding
  CodeMirror.Vim.map("<C-a>", "<Esc>^i", "insert");
  CodeMirror.Vim.map("<C-e>", "<Esc>$a", "insert");
  //CodeMirror.Vim.map("<C-f>", "<Esc>lwi", "insert"); // This seems more likely to M-f (move forward one word)
  //CodeMirror.Vim.map("<C-b>", "<Esc>lbi", "insert"); // This seems more likely to M-b (move backward one word)
  CodeMirror.Vim.map("<C-f>", "<Esc>2li", "insert");
  CodeMirror.Vim.map("<C-b>", "<Esc>i", "insert");
  CodeMirror.Vim.map("<C-d>", "<Esc>lxi", "insert");
  CodeMirror.Vim.map("<C-h>", "<Esc>xi", "insert");
});

require([
  'nbextensions/vim_binding/vim_binding',
], function() {
  // Use Ctrl-h/l/j/k to move around in Insert mode
  CodeMirror.Vim.defineAction('[i]<C-h>', function(cm) {
    var head = cm.getCursor();
    CodeMirror.Vim.handleKey(cm, '<Esc>');
    if (head.ch <= 1) {
      CodeMirror.Vim.handleKey(cm, 'i');
    } else {
      CodeMirror.Vim.handleKey(cm, 'h');
      CodeMirror.Vim.handleKey(cm, 'a');
    }
  });
  CodeMirror.Vim.defineAction('[i]<C-l>', function(cm) {
    var head = cm.getCursor();
    CodeMirror.Vim.handleKey(cm, '<Esc>');
    if (head.ch === 0) {
      CodeMirror.Vim.handleKey(cm, 'a');
    } else {
      CodeMirror.Vim.handleKey(cm, 'l');
      CodeMirror.Vim.handleKey(cm, 'a');
    }
  });
  CodeMirror.Vim.mapCommand("<C-h>", "action", "[i]<C-h>", {}, { "context": "insert" });
  CodeMirror.Vim.mapCommand("<C-l>", "action", "[i]<C-l>", {}, { "context": "insert" });
  CodeMirror.Vim.map("<C-j>", "<Esc>ja", "insert");
  CodeMirror.Vim.map("<C-k>", "<Esc>ka", "insert");

  // Use Ctrl-h/l/j/k to move around in Normal mode
  // otherwise it would trigger browser shortcuts
  CodeMirror.Vim.map("<C-h>", "h", "normal");
  CodeMirror.Vim.map("<C-l>", "l", "normal");
  // Updated for v2.0.0
  // While jupyter-vim-binding use <C-j>/<C-k> to move around cell
  // The following key mappings should not be defined
  //CodeMirror.Vim.map("<C-j>", "j", "normal");
  //CodeMirror.Vim.map("<C-k>", "k", "normal");
});

require([
  'nbextensions/vim_binding/vim_binding',
], function() {
   CodeMirror.Vim.map("<C-a>", "ggVG", "normal");
});

// enable the 'Ctrl-C' mapping
// change the code mirror configuration
var cm_config = require("notebook/js/cell").Cell.options_default.cm_config;
delete cm_config.extraKeys['Ctrl-C'];
// change settings for existing cells
Jupyter.notebook.get_cells().map(function(cell) {
    var cm = cell.code_mirror;
    if (cm) {
        delete cm.getOption('extraKeys')['Ctrl-C'];
    }
});
// map the keys
CodeMirror.Vim.map("<C-c>", "<Esc>", "insert");

// override two relevant actions by inserting a scroll-cell-top action
Jupyter.keyboard_manager.actions.register({
    'help': 'run selected cells',
    'handler': function(env, event) {
        env.notebook.command_mode();
        var actions = Jupyter.keyboard_manager.actions;
        actions.call('jupyter-notebook:run-cell', event, env);
        actions.call('jupyter-notebook:scroll-cell-top', event, env);
        env.notebook.edit_mode();
    }
}, 'run-cell', 'vim-binding');

Jupyter.keyboard_manager.actions.register({
    'help': 'run selected cells',
    'handler': function(env, event) {
        env.notebook.command_mode();
        var actions = Jupyter.keyboard_manager.actions;
        actions.call('jupyter-notebook:run-cell', event, env);
        actions.call('jupyter-notebook:scroll-cell-top', event, env);
        actions.call('jupyter-notebook:select-next-cell', event, env);
        env.notebook.edit_mode();
    }
}, 'run-cell-and-select-next', 'vim-binding');

// custom.js
require([
  'base/js/namespace',
  'notebook/js/cell',
  'codemirror/addon/edit/trailingspace'
], function(ns, cell) {
  var cm_config = cell.Cell.options_default.cm_config;
  cm_config.showTrailingSpace = true;

  ns.notebook.get_cells().map(function(cell) {
    var cm = cell.code_mirror;
    if (cm) {
      cm.setOption('showTrailingSpace', true);
    }
  });
});

// custom operator for commenting
// (similar to commentary by Tim Pope)
// this woks with visual selection ('vipgc') and with motions ('gcip')
require(['nbextensions/vim_binding/vim_binding'], function() {
    CodeMirror.Vim.defineOperator("comment_op", function(cm) {
        cm.toggleComment();
    });
    CodeMirror.Vim.mapCommand("gc", "operator", "comment_op", {});
});
