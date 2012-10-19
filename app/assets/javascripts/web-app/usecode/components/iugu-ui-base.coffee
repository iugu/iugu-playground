class IuguUI.Base extends Backbone.View

  defaults:
    baseURL: ""

  initialize: ->
    _.bindAll @, 'render', 'root'
    @options = _.extend {}, @defaults, @options

    @layout = @options.layout if @options.layout
    @parent = @options.parent if @options.parent
    
    @identifier = ( -> @options.identifier + ':' ) if @options.identifier

    @

  render: ->
    $(@el).html @getLayout() @context()

    @

  getLayout: ->
    JST[ "web-app/presenters/" + @layout ]

  context: ->
    return { }

  historyNavigate: (url) ->
    Backbone.history.navigate @options.baseURL + '/' + url

  root: ->
    _.result(@parent,'root') or @

  identifier: ->
    _.result(@parent,'identifier') or ''

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
