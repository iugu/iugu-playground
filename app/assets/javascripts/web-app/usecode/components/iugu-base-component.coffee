#TODO: Por enquanto, tudo herda de IuguBaseComponent, queremos criar um IuguViewComponent, que herda de IuguBaseComponent para outras coisas
class IuguBaseComponent extends Backbone.View

  # TODO: Ver se o melhor lugar pra ter o presenter name eh aqui tbm
  # Este "defaults/options" não ficou legal
  defaults:
    presenterName: ""
    baseURL: ""

  initialize: ->
    @options = _.extend @defaults, @options

  render: ->
    $(@el).html @layoutFile()

  # TODO: Melhorar o nome disto
  layoutFile: ->
    file = @options.presenterName or @template or @layout or @presenter
    JST[ "web-app/presenters/" + file ]

  historyNavigate: (url) ->
    Backbone.history.navigate @options.baseURL + '/' + url

  delegateChild: ( selector, view ) ->
    selectors = {}
    if _.isObject(selector)
      selectors = selector
    else
      selectors[selector] = view
    return unless selectors
    _.each( selectors, ( view, selector ) ->
      view.setElement(@$(selector)).render()
    , this )


@IuguBaseComponent = IuguBaseComponent
