class IuguBaseComponent extends Backbone.View
  presenterName: ""

  initialize: ->
    @options.presenterName = @presenterName if @options.presenterName == undefined

  render: ->
    $(@el).html JST[this.options.templatePath]

  presenterFile: ->
    "web-app/presenters/components/" + @options.presenterName

@IuguBaseComponent = IuguBaseComponent    
