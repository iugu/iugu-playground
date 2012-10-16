class IuguDatasetRowComponent extends IuguBaseComponent
  tagName: "tr"

  templatePath: "web-app/presenters/components/iugu-dataset-row-component"

  initialize: ->
    _.bindAll @, 'render'

  render: ->
    $(@el).html JST[this.options.templatePath] item: @model

    @

@IuguDatasetRowComponent = IuguDatasetRowComponent
