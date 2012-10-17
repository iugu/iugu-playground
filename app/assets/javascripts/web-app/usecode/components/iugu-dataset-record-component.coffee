class IuguDatasetRecordComponent extends IuguBaseComponent
  tagName: "tr"

  defaults:
    presenterName: "iugu-dataset-record-component"
    baseURL: ""
    fields: ""

  initialize: ->
    super
    _.bindAll @, 'render'

  render: ->
    $(@el).html JST[@presenterFile()] item: @model, options: @options

    @

@IuguDatasetRecordComponent = IuguDatasetRecordComponent
