class IuguUI.Base extends Backbone.View

  defaults:
    baseURL: ""

  initialize: ->
    _.bindAll @, 'render'
    @options = _.extend @defaults, @options

  render: ->
    $(@el).html @getLayout() @context()

  getLayout: ->
    JST[ "web-app/presenters/" + @layout ]

  context: ->
    return { }

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

@IuguUI.Base = IuguUI.Base
