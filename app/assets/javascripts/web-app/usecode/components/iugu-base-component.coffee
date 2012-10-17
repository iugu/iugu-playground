class IuguBaseComponent extends Backbone.View
  defaults:
    presenterName: ""
    baseURL: ""

  initialize: ->
    @options = _.extend @defaults, @options

  render: ->
    $(@el).html JST[this.options.templatePath]

  presenterFile: ->
    "web-app/presenters/components/" + @options.presenterName

  historyNavigate: (url) ->
    Backbone.history.navigate @options.baseURL + '/' + url

@IuguBaseComponent = IuguBaseComponent    
