class IuguPaginator extends Backbone.View
  tagName: "div"
  className: "iugu-paginator"

  events:
    'click a.servernext': 'nextResultPage'
    'click a.serverprevious': 'previousResultPage'
    'click a.serverlast': 'gotoLast'
    'click a.page': 'gotoPage'
    'click a.serverfirst': 'gotoFirst'
    'click a.serverpage': 'gotoPage'
    'click .serverhowmany a': 'changeCount'

  initialize: ->
    _.bindAll @, 'render'
    this.collection.on('reset', this.render, this)
    this.collection.on('change', this.render, this)

  render: ->
    $(@el).html JST["web-app/presenters/components/iugu-paginator-component"] collection: this.collection.info()

    @

  nextResultPage: (e) ->
    e.preventDefault
    this.collection.requestNextPage()

  previousResultPage: (e) ->
    e.preventDefault
    this.collection.requestPreviousPage()

  gotoFirst: (e) ->
    e.preventDefault
    this.collection.goTo(this.collection.information.firstPage)

  gotoLast: (e) ->
    e.preventDefault
    this.collection.goTo(this.collection.information.lastPage)

  gotoPage: (e) ->
    e.preventDefault
    page = $(e.target).text
    this.collection.goTo(page)

  changeCount: (e) ->
    e.preventDefault
    per = $(e.target).text
    this.collection.howManyPer(per)

@IuguPaginator = IuguPaginator
