class IuguUI.Alert extends IuguUI.Base

  className: "alert alert-block alert-success fade in"
  layout: "components/iugu-ui-alert"

  defaults:
    headerText: "HEADER TEXT"
    bodyText: "BODY TEXT"
    buttonText: "BUTTON TEXT"

  events:
    'click a.alertButton': 'handleEvent'

  initialize: ->
    _bindAll @, 'handleEvent'
    super

  context: ->
    headerText: @options.headerText
    bodyText: @options.bodyText
    buttonText: @options.buttonText

@IuguUI.Alert = IuguUI.Alert
