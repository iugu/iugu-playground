class IuguUI.DatasetRecord extends IuguUI.Base
  layout: "components/iugu-ui-dataset-record"

  initialize: ->
    super

  events:
    'click' : 'onClick'
    'mouseenter' : 'onHover'

  context: ->
    item: @model
    options: @options

  onClick: (e) ->
    e.preventDefault()
    @root().trigger( @identifier() + 'record:click', @, @model )

  onHover: (e) ->
    e.preventDefault()
    @root().trigger( @identifier() + 'record:hover', @, @model )

@IuguUI.DatasetRecord = IuguUI.DatasetRecord
