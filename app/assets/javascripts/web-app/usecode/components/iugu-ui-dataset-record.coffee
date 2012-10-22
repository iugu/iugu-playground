class IuguUI.DatasetRecord extends IuguUI.Base
  layout: "components/iugu-ui-dataset-record"

  initialize: ->
    _.bindAll @, 'handleEvent'
    super

  events:
    'click' : 'handleEvent'
    'mouseenter' : 'handleEvent'
    'mouseleave' : 'handleEvent'

  context: ->
    item: @model
    options: @options

@IuguUI.DatasetRecord = IuguUI.DatasetRecord
