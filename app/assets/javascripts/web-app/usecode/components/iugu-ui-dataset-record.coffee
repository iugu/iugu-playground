class IuguUI.DatasetRecord extends IuguUI.Base
  layout: "components/iugu-ui-dataset-record"

  initialize: ->
    super

  context: ->
    item: @model
    options: @options

@IuguUI.DatasetRecord = IuguUI.DatasetRecord
