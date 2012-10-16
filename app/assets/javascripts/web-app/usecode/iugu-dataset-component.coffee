class IuguDatasetComponent extends IuguBaseComponent
  tagName: "div"
  className: "iugu-dataset"

  templatePath: "web-app/presenters/components/iugu-dataset-component"
  itemTemplatePath: "web-app/presenters/components/iugu-dataset-row-component"

  initialize: ->
    _.bindAll @
    this.collection.on('add', @addOne)
    this.collection.on('reset', @addAll)
    this.collection.on('all', @render)

  addOne: (item) ->
    view = new IuguDatasetRowComponent({model: item, templatePath: @options.itemTemplatePath})
    $(@el).append(view.render().el)

  addAll: ->
    $(@el).empty()
    @collection.each(@addOne)

  render: ->
    $(@el).html JST[@options.templatePath]

    @

@IuguDatasetComponent = IuguDatasetComponent
