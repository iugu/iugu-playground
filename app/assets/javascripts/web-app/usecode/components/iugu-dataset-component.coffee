class IuguDatasetComponent extends IuguBaseComponent
  defaults:
    presenterName: "iugu-dataset-component"
    itemPresenterName: "iugu-dataset-record-component"
    baseURL: ""
    fields: ""

  initialize: ->
    super
    _.bindAll @, 'render', 'addRow'
    @collection.on('all', @render)

    @

  addRow: (item) ->
    @els.push (
      new IuguDatasetRecordComponent
        model: item
        baseURL: @options.baseURL
        presenterName: @options.itemPresenterName
        fields: @options.fields
    ).render().el

  render: ->
    $(@el).html JST[@presenterFile()] dataset: @collection, options: @options

    @els = []
    @collection.each @addRow
    @$('.records').append(@els)

    @

@IuguDatasetComponent = IuguDatasetComponent
