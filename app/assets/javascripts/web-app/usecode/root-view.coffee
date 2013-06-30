# PLATFORM APP MAIN ENTRY POINT
#
# This method is responsible for creating the view frame. All views are then insert in that frame

@app.main = () ->
  app.rootWindow = new IuguUI.ResponsiveBox
    el: "#app"
    sidebar: new SidebarController

  if app.rootLoader
    app.rootLoader.remove()

  app.rootWindow.render()

createLoader = () ->
  loaderDiv = $('<div/>')
  loaderDiv.html "CARREGANDO"
  loaderDiv.css "position", "absolute"
  loaderDiv.css "width", "100px"
  loaderDiv.css "height", "100px"
  loaderDiv.css "background", "#333333"
  loaderDiv.css "left", "50%"
  loaderDiv.css "top", "50%"
  loaderDiv.css "margin-left", "-50px"
  loaderDiv.css "margin-top", "-50px"
  loaderDiv.css "color", " #ffffff"
  loaderDiv.css "text-align", "center"
  loaderDiv.css "font-size", "12px"
  loaderDiv.css "line-height", "100px"
  loaderDiv.css "z-index", "100"
  $(document.body).append loaderDiv
  loaderDiv
