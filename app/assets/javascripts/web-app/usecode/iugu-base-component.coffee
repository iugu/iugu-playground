class IuguBaseComponent extends Backbone.View

  initialize: ->
    @options = _.extend @defaults, @options

  render: ->
    $(@el).html JST[this.options.templatePath]

  presenterFile: ->
    "web-app/presenters/components/" + @options.presenterName

@IuguBaseComponent = IuguBaseComponent    
