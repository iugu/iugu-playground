class IuguUI.Alert extends IuguUI.Base
  layout: "components/iugu-ui-alert"

  defaults:
    headerText: "HEADER TEXT"
    bodyText: "BODY TEXT"
    buttonText: "BUTTON TEXT"

  events:
    'click a.alertButton': 'handleEvent'

  initialize: ->
    _.bindAll @, 'handleEvent'
    super

  context: ->
    headerText: @options.headerText
    bodyText: @options.bodyText
    buttonText: @options.buttonText

@IuguUI.Alert = IuguUI.Alert
