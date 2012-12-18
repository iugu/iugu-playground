class window.app.Person extends window.app.BaseResource
  urlRoot: '/api/v1/people'

  virtual_attributes: ['account_id', 'id', 'created_at', 'updated_at', 'undo_event']

  collection: window.app.People

  validation:
    name:
      required: true
    age:
      range: [1, 150]

  undo: ->
    @configureAjax()

    uri = @appendLocaleInfo @urlRoot + '/' + @id + '/undo'

    @trigger "undo"

    model = @

    Backbone.ajax(uri,
      type: "POST"
      success: (data) ->
        model.set(data)
        model.trigger "undo:success", model
      error: (data) ->
        model.trigger "undo:error", data, model
    )


window.app.People = Backbone.Paginator.requestPager.extend
  model: window.app.Person

  paginator_core:
    #url: '/api/v1/people?&'
    url: ->
      '/api/v1/people/s/j*?&'
    dataType: 'json'

  paginator_ui:
    firstPage: 1
    currentPage: 1
    perPage: 30

  server_api:
    'limit': ->
      return @perPage

    'start': ->
      return (@currentPage - 1) * @perPage

    'api_token': ->
      return api_token

  parse: (response) ->
    @totalRecords = response.totalItems
    @totalPages = Math.ceil(@totalRecords / @perPage)
    return response.items

  buildChangedPageEventOptions: ->
    success: ( ( collection, response ) ->
      @trigger 'changed-page:success'
    ).bind @
    error: ( ( collection, response ) ->
      @trigger 'changed-page:error'
    ).bind @

  gotoFirst: ->
    @goTo @information.firstPage, @buildChangedPageEventOptions()

  gotoLast: ->
    @goTo @information.lastPage, @buildChangedPageEventOptions()

  gotoPage: ( page ) ->
    @goTo page, @buildChangedPageEventOptions()

  gotoNext: ->
    if @information.currentPage < @information.lastPage
      @requestNextPage @buildChangedPageEventOptions()

  gotoPrevious: ->
    if @information.currentPage > 1
      @requestPreviousPage @buildChangedPageEventOptions()
