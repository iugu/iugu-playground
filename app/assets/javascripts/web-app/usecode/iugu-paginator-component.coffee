class IuguPaginatorComponent extends IuguBaseComponent
  tagName: "div"
  className: "iugu-paginator"

  templatePath: "web-app/presenters/components/iugu-paginator-component"

  events:
    'click a.servernext': 'nextResultPage'
    'click a.serverprevious': 'previousResultPage'
    'click a.serverlast': 'gotoLast'
    'click a.page': 'gotoPage'
    'click a.serverfirst': 'gotoFirst'
    'click a.serverpage': 'gotoPage'
    'click a.serverhowmany': 'changeCount'

  initialize: ->
    _.bindAll @, 'render'
    @collection.on('reset', @render, this)
    @collection.on('change', @render, this)

  render: ->
    $(@el).html JST[@options.templatePath] collection: @collection.info()

    @

  nextResultPage: (e) ->
    e.preventDefault
    if @collection.information.currentPage < @collection.information.lastPage
      @collection.requestNextPage()

  previousResultPage: (e) ->
    e.preventDefault
    if @collection.information.currentPage > @collection.information.firstPage
      @collection.requestPreviousPage()

  gotoFirst: (e) ->
    e.preventDefault
    @collection.goTo(@collection.information.firstPage)

  gotoLast: (e) ->
    e.preventDefault
    @collection.goTo(@collection.information.lastPage)

  gotoPage: (e) ->
    e.preventDefault
    page = $(e.target).text()
    @collection.goTo(page)

  changeCount: (e) ->
    e.preventDefault
    per = $(e.target).text()
    @collection.howManyPer(per)

@IuguPaginatorComponent = IuguPaginatorComponent
