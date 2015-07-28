
rangePart = function(id, label,from=NULL, to=NULL, from.lab="from",to.lab="to",...) {
  restore.point("rangePart")

  shinyPart(
    id=id,
    fields = list(label=label, from=from, to=to, from.lab=from.lab, to.lab=to.lab),
    ui.funs = list(
      main = main.ui
    )
  )
}


main.ui = function(pa) {
  ui = list(
    textInput(pa.id(pa,"from"),label=pa$from.lab,value=pa$from),
    textInput(pa.id(pa,"to"),label=pa$to.lab,value=pa$to)
  )
  ui
}


