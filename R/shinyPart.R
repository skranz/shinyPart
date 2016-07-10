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

#' Create an id
#' @export
cid = function(id,pa) {
  restore.point("cid")
  paste0(pa$id,"__",id)
}

#' Get an id
#' @export
gid = function(id,pa) {
  restore.point("gid")
  paste0(pa$id,"__",id)
}

#' Get UI of a shinyPart
#' @export
partUI = function(pa, ui.id=1) {
  if (is.character(ui.id)) {
    name = ui.id
    ui.id = which(names(pa$.ui.list) == ui.id)
    if (length(ui.id)==0)
      stop("ui.id '",name,"' is not defined.")
  }
  if (ui.id <= length(pa$.ui.funs)) {
    pa$.ui.list[[ui.id]] = pa$.ui.funs[[ui.id]](pa)
  }
  pa$.ui.list[[ui.id]]
}

#' Create a new shinyPart
#' @export
shinyPart = function(id, fields, ui.funs, container.id=NULL, static.ui = NULL) {
  restore.point("shinyPart")

  pa = c(
    list(
      id = id,
      .ui.funs = ui.funs,
      .ui.list = c(vector("list", length(ui.funs)), static.ui),
      .container.id = container.id
    ),
    fields)
  names(pa$.ui.list)[seq_along(ui.funs)] = names(ui.funs)
  pa = as.environment(pa)
  pa
}

#' Show a shinyPart in an uiOutput with id container.id
#' @export
showPart =function(pa,container.id=pa$.container.id, ui.id=1,app=getApp()) {
  ui = partUI(pa, ui.id)

  if (is.null(pa$.container.id))
    pa$.container.id = container.id
  setUI(container.id, ui)
}

#' Get an input value of a shinyPart
#' @export
partValue = function(id="",pa, app=getApp()) {
  full.id = gid(id,pa)
  getInputValue(full.id,app = app)
}

#' Register a buttonHandler for a shinyPart
#' @export
partButtonHandler = function(id, pa,fun,..., app = getApp(),if.handler.exists = c("replace","add","skip")[1], session=getAppSession(app)) {
  full.id = gid(id,pa)

  buttonHandler(full.id,fun,..., app=app, if.handler.exists=if.handler.exists, session=session)
}

#' Register a changeHandler for a shinyPart
#' @export
partChangeHandler = function(id, pa,fun,..., app = getApp(),if.handler.exists = c("replace","add","skip")[1], session=getAppSession(app)) {
  full.id = gid(id,pa)

  changeHandler(full.id,fun,..., app=app, if.handler.exists=if.handler.exists, session=session)
}

#' Register a plot clickHandler for a shinyPart
#' @export
partClickHandler = function(id, pa,fun,..., app = getApp(),if.handler.exists = c("replace","add","skip")[1], session=getAppSession(app)) {
  full.id = gid(id,pa)

  clickHandler(full.id,fun,..., app=app, if.handler.exists=if.handler.exists, session=session)
}

#' Register a aceEdit hotkey handler for a shinyPart
#' @export
partAceHotkeyHandler = function(id, pa,fun,..., app = getApp(),if.handler.exists = c("replace","add","skip")[1], session=getAppSession(app)) {
  full.id = gid(id,pa)

  partAceHotkeyHandler(full.id,fun,..., app=app, if.handler.exists=if.handler.exists, session=session)
}

