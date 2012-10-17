class IuguDatasetComponent extends IuguBaseComponent
  defaults:
    presenterName: "iugu-dataset-component"
    itemPresenterName: "iugu-dataset-record-component"
    baseURL: ""
    fields: ""

  initialize: ->
    super
    _.bindAll @, 'render', 'addRecord'
    @collection.on('all', @render)

    @

  addRecord: (item) ->
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
    @collection.each @addRecord
    @$('.records').append(@els)

    @

@IuguDatasetComponent = IuguDatasetComponent
