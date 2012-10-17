class IuguDatasetComponent extends IuguBaseComponent
  defaults:
    presenterName: "iugu-dataset-component"
    baseURL: ""

  initialize: ->
    super
    _.bindAll @, 'render', 'addRow'
    @collection.on('all', @render)
    @

  addRow: (item) ->
    @els.push (
      new IuguDatasetRowComponent
        model: item
        baseURL: @options.baseURL
    ).render().el

  render: ->
    $(@el).html JST[@presenterFile()] dataset: @collection

    @els = []
    @collection.each @addRow
    @$('tbody').append(@els)

    @

@IuguDatasetComponent = IuguDatasetComponent
