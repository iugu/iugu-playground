class IuguBaseComponent extends Backbone.View
  presenterName: ""

  initialize: ->

  render: ->
    $(@el).html JST[this.options.templatePath]

  presenterFile: ->
    "web-app/presenters/components/" + @presenterName

@IuguBaseComponent = IuguBaseComponent    
