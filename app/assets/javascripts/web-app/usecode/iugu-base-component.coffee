class IuguBaseComponent extends Backbone.View
  templatePath: ""

  initialize: ->

  render: ->
    $(@el).html JST[this.options.templatePath]

@IuguBaseComponent = IuguBaseComponent    
