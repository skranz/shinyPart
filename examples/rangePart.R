examples.shinyPart <- function() {
  app = eventsApp()

  pa = rangePart(
    id = "myrange",
    label = "x range",
    from.lab = "min",
    to.lab = "max",
    from = 0,
    to = 100
  )

  ui = fluidPage(
    uiOutput("myui"),
    actionButton("btn","Show from")
  )

  buttonHandler("btn",pa=pa, function(pa,...) {
    from = partValue("from",pa)
    restore.point("btn_click")
    cat("\nfrom: ", from)
  })
  app$ui = ui
  showPart(pa,"myui")

  runEventsApp(app, launch.browser = rstudio::viewer)
}


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
    textInput(cid(pa,"from"),label=pa$from.lab,value=pa$from),
    textInput(cid(pa,"to"),label=pa$to.lab,value=pa$to)
  )
  ui
}


