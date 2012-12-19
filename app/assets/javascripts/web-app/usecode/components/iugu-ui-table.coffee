class IuguUI.Table extends IuguUI.Dataset
  layout: "components/iugu-ui-table"

  defaults:
    itemLayout: "components/iugu-ui-table-row"
    itemTagName: "tr"
    itemClassName: "table-row"

  events:
    'click a.sort-button' : 'sortByColumn'

  context: ->
    sortableBy: @options.sortableBy
    fields: @options.fields
    sortBy: @sortBy

  initialize: ->
    super
    @sortBy = {}

  sortByColumn: (e) ->
    btn = $(e.currentTarget)
    icon = btn.find('i')

    name = btn.attr('id')

    if icon.hasClass "icon-chevron-up"
      icon.removeClass "icon-chevron-up"
      @sortBy[name] = ""
    else if icon.hasClass "icon-chevron-down"
      icon.removeClass "icon-chevron-down"
      icon.addClass "icon-chevron-up"
      @sortBy[name] = "asc"
    else
      icon.addClass "icon-chevron-down"
      @sortBy[name] = "desc"

    @collection.configureFilter 'sortBy', @sortBy
    @collection.fetch()

@IuguUI.Table = IuguUI.Table
