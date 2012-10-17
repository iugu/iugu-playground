class IuguNavigatorComponent extends IuguBaseComponent
  templatePath: "web-app/presenters/components/iugu-navigator-component"

  events:
    'click a.servernext': ->
      @collection.gotoNext()
      false
    'click a.serverprevious': ->
      @collection.gotoPrevious()
      false
    'change input.gotopage': 'changedPage'

  changedPage: (e) ->
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
    _.bindAll @
    @collection.on('all', @render, this)

  render: ->
    $(@el).html JST[@templatePath] collection: @collection.information

    @$('input.gotopage').focus() if @lastChanged
    @lastChanged = false

    @

@IuguNavigatorComponent = IuguNavigatorComponent
