class IuguDatasetRecordComponent extends IuguBaseComponent
  tagName: "li"
  className: "span4"

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
