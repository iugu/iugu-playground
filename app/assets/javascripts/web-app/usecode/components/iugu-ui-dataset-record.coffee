class IuguUI.DatasetRecord extends IuguUI.Base
  layout: "components/iugu-ui-dataset-record"

  defaults:
    fields: ""

  initialize: ->
    super

  context: ->
    return {
      item: @model
      options: @options
    }

@IuguUI.DatasetRecord = IuguUI.DatasetRecord
