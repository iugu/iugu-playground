class IuguDatasetRowComponent extends IuguBaseComponent
  tagName: "tr"

  defaults:
    presenterName: "iugu-dataset-row-component"
    baseURL: ""

  initialize: ->
    super
    _.bindAll @, 'render'

  render: ->
    $(@el).html JST[@presenterFile()] item: @model

    @

@IuguDatasetRowComponent = IuguDatasetRowComponent
