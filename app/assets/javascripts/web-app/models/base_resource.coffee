class window.app.BaseResource extends Backbone.Model
  virtual_attributes: []

  sync: (method, model, options) ->
    $.ajaxSetup
      headers:
        Authorization: $.base64.encode api_token
    Backbone.sync method, model, options

  toJSON: (options) ->
    _.omit( _.clone( @attributes ), @virtual_attributes )

  url: ->
    base = super
    base + (if base.indexOf('?') then '?' else '&') + 'hl=' + encodeURIComponent( i18n.locale )
