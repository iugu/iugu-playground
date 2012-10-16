class IuguDatasetComponent extends IuguBaseComponent
  templatePath: "web-app/presenters/components/iugu-dataset-component"
  itemTemplatePath: "web-app/presenters/components/iugu-dataset-row-component"

  initialize: ->
    _.bindAll @, 'render', 'addRow'
    @collection.on('all', @render)
    @

  addRow: (item) ->
    debug item
    @els.push (
      new IuguDatasetRowComponent
        model: item
        templatePath: @options.itemTemplatePath
    ).render().el

  render: ->
    $(@el).html JST[@options.templatePath]

    @els = []
    @collection.each @addRow
    @$('tbody').append(@els)

    @

@IuguDatasetComponent = IuguDatasetComponent
