class IuguUI.Base extends Backbone.View

  defaults:
    baseURL: ""

  initialize: ->
    _.bindAll @, 'render', 'root', 'identifier', 'delegateChild', 'mapDOMEvent', 'handleEvent', 'unload'

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

  mapDOMEvent: (type) ->
    switch type
      when 'click' then return 'click'
      when 'mouseover' then return 'mouseover'
      when 'mouseout' then return 'mouseout'
      else return type

  handleEvent: (e) ->
    e.preventDefault()
    triggerType = @mapDOMEvent e.type
    @root().trigger( @identifier() + 'record:' + triggerType, @ )

  trigger: (events) ->
    if app.debug_events
      debug 'Triggered Event: ' + arguments[0]
    super

  unload: () ->
    debug 'Unloading View'
    # TODO: Add Memory Clean Routines

@IuguUI.Base = IuguUI.Base
