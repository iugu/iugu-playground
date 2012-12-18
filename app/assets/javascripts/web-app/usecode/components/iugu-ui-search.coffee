class IuguUI.Search extends IuguUI.Base

  layout: "components/iugu-ui-search"

  events:
    'keypress input.search': 'searchCollection'

  searchCollection: (e) ->
    if e.keyCode == 13
      e.preventDefault()
      query = $(e.target).val()

      if query == ""
        @collection.server_api = _.omit @collection.server_api, 'query'
      else
        _.extend @collection.server_api,
          query: '*' + $(e.target).val() + '*'
      @collection.fetch()

  initialize: ->
    _.bindAll @, 'searchCollection'
    super
    @

  render: ->
    super

@IuguUI.Search = IuguUI.Search
