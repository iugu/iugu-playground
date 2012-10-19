class IuguUI.Table extends IuguUI.Dataset
  layout: "components/iugu-ui-table"

  defaults:
    itemLayout: "components/iugu-ui-table-row"

  initialize: ->
    super

    debug @options.itemLayout

@IuguUI.Table = IuguUI.Table
