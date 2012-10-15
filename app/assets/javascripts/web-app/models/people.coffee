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
    firstPage: 0
    currentPage: 0
    perPage: 30

  server_api:
    'limit': ->
      return this.perPage

    'start': ->
      return this.currentPage * this.perPage

    'api_token': ->
      return api_token

  parse: (response) ->
    this.totalItems = response.totalItems
    this.totalPages = Math.ceil(this.totalItems / this.perPage)
    return response.items
