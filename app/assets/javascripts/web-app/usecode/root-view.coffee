RootView = Backbone.View.extend
  el: "#app"
  initialize: ->
    _.bindAll @, 'render'

  render: ->
    $(@el).html JST["web-app/presenters/main-view"]

    $('#cap').html $('html').attr('class') + ' ' + navigator.oscpu + ' ' + navigator.platform + navigator.userAgent

    @

@RootView = RootView
