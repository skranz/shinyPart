
rchunkPart = function(id, code, num.lines=NROW(code), height = NULL, hotkkeys=NULL, ...) {
  restore.point("rchunkPart")
  if (is.null(height)) {
    height = max((fontSize * 1.5) * code.lines,30)
  }

  if (is.null(hotkeys)) {
    hotkeys = list(runLineKey="Ctrl-Enter", helpKey="F1", runKey="Ctrl-R|Ctrl-Shift-Enter", hintKey="Ctrl-H", checkKey = "Ctrl-Alt-R|Ctrl-T")
  }

  shinyPart(
    id=id,
    fields = list(code=code, num.lines=num.lines, height=height, kotkeys=hotkeys),
    ui.funs = list(
      main = main.ui
    )
  )
}


rchunk.ui = function(pa) {
  restore.point("rchunk.ui")

  button.row = list(
    bsButton(cid(pa,"runChunkBtn"), "run",size="extra-small")
  )
  edit.row = list(
    aceEditor(cid(pa,"codeEdit"), code, mode="r",theme=theme, height=height, fontSize=13,hotkeys = keys, wordWrap=TRUE, debounce=10),
    aceEditor(cid(pa,"consoleEdit"), "", mode="r",theme="clouds", height=height, fontSize=13,hotkeys = NULL, wordWrap=TRUE, debounce=10, showLineNumbers=FALSE,highlightActiveLine=FALSE)
  )
  chunk.fluidRow(
    button.row,
    bsAlert(cid(pa,"alertOut")),
    edit.row
  )
}
