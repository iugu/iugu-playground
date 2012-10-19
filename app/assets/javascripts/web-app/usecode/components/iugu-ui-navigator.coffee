class IuguUI.Navigator extends IuguUI.Base

  layout: "components/iugu-ui-navigator"

  events:
    'click a.next': ->
      @collection.gotoNext()
      false
    'click a.previous': ->
      @collection.gotoPrevious()
      false
    'change input.page': 'changedPage'

  changedPage: (e) ->
    e.preventDefault()
    old_page = @collection.currentPage
    page = $(e.target).val()
    page = old_page if page == ''
    if @collection.information.lastPage+1 > page
      @collection.goTo( page )
      @lastChanged = true
      true
    else
      $(e.target).val( old_page )
      $(e.target).select()
      false

  initialize: ->
    super
    @collection.on('all', @render, this)
    @collection.on('all', @setFocus, this)

  context: ->
    return {
      collection: @collection.info()
    }

  setFocus: ->
    @$('input.page').focus() if @lastChanged
    @lastChanged = false

@IuguUI.Navigator = IuguUI.Navigator
