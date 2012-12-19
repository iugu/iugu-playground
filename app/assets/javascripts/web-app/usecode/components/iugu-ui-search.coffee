class IuguUI.Search extends IuguUI.Base

  layout: "components/iugu-ui-search"

  events:
    'keypress input.search': 'searchCollection'

  searchCollection: (e) ->
    if e.keyCode == 13
      e.preventDefault()
      query = $(e.target).val()

      @collection.configureFilter 'query', $(e.target).val()
      @collection.fetch()

  initialize: ->
    _.bindAll @, 'searchCollection'
    super
    @

  render: ->
    super

@IuguUI.Search = IuguUI.Search
