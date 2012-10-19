class IuguUI.Dataset extends IuguUI.Base
  layout: "components/iugu-ui-dataset"

  defaults:
    itemLayout: "components/iugu-ui-dataset-record"
    fields: ""

  initialize: ->
    super
    _.bindAll @, 'renderItems', 'addRecord'
    @collection.on('all', @render)
    @collection.on('all', @renderItems)

    @

  addRecord: (item) ->
    @els.push (
      new IuguUI.DatasetRecord
        model: item
        baseURL: @options.baseURL
        layout: @options.itemLayout
        fields: @options.fields
    )

  context: ->
    return {
      dataset: @collection
      options: @options
    }

  renderItems: ->
    @els = []
    @collection.each @addRecord

    @delegateChild (
      '.records'  : @els[0]
    )

    @

@IuguUI.Dataset = IuguUI.Dataset
