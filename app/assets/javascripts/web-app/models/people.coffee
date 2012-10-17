class window.app.Person extends window.app.BaseResource
  urlRoot: 'api/v1/people'
  virtual_attributes: ['account_id', 'id', 'created_at', 'updated_at']
  collection: window.app.People

window.app.People = Backbone.Paginator.requestPager.extend
  model: window.app.Person

  paginator_core:
    url: 'api/v1/people?&'
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

  gotoFirst: ->
    @goTo @information.firstPage

  gotoLast: ->
    @goTo @information.lastPage

  gotoNext: ->
    if @information.currentPage < @information.lastPage
      @requestNextPage()

  gotoPrevious: ->
    if @information.currentPage > 1
      @requestPreviousPage()
