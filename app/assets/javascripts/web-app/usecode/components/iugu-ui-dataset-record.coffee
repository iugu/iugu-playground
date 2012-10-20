class IuguUI.DatasetRecord extends IuguUI.Base
  layout: "components/iugu-ui-dataset-record"

  initialize: ->
    super

  events:
    'click' : 'onClick'

  context: ->
    item: @model
    options: @options

  onClick: (e) ->
    e.preventDefault()
    @root().trigger( @identifier() + 'record:click', @, @model )

@IuguUI.DatasetRecord = IuguUI.DatasetRecord
