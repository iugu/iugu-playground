class IuguUI.Dataset extends IuguUI.Base
  layout: "components/iugu-ui-dataset"

  defaults:
    itemLayout: "components/iugu-ui-dataset-record"

  initialize: ->
    super
    _.bindAll @, 'renderItems', 'addRecord'
    @collection.on('all', @render)

    @

  addRecord: (item) ->
    @els.push (
      new IuguUI.DatasetRecord
        model: item
        baseURL: @options.baseURL
        layout: @options.itemLayout
        fields: @options.fields
    ).render().el

  context: ->
    dataset: @collection
    options: @options

  render: ->
    super
    @renderItems()

    @

  renderItems: ->
    @els = []
    @collection.each @addRecord

    @$('.records').append @els

    @

@IuguUI.Dataset = IuguUI.Dataset
