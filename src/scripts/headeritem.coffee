class ContentTools.Tools.HeaderItem extends ContentTools.Tool
  ContentTools.ToolShelf.stow(@, 'headeritem')

  @label = 'Header Item'
  @icon = 'headeritem'

  @canApply: (element, selection) ->
# Return true if the tool can be applied to the current
# element/selection.
    return element.content

  @apply: (element, selection, callback) ->
# Apply the tool to the current element

# Dispatch `apply` event
    toolDetail = {
      'tool': this,
      'element': element,
      'selection': selection
    }
    if not @dispatchEditorEvent('tool-apply', toolDetail)
      return

    # Insert a BR at the current in index
    cursor = selection.get()[0] + 1

    modal = new ContentTools.ModalUI()

    # Dialog
    dialog = new ContentTools.HeaderItemDialog()

    # Support cancelling the dialog
    dialog.addEventListener 'cancel', () =>

      modal.hide()
      dialog.hide()

      if element.restoreState
        element.restoreState()

      callback(false)

    # Support saving the dialog
    dialog.addEventListener 'save', (ev) =>
      itemname = ev.detail().itemname

      keepFocus = true

    tip = element.content.substring(0, selection.get()[0])
    tail = element.content.substring(selection.get()[1])
    br = new HTMLString.String('<br>', element.content.preserveWhitespace())
    anchor = new HTMLString.String('<a class="anchor" id="' + itemname.replace(" ", "").toLowerCase() + '" data-name="' + itemname + '"></a>');
    element.content = tip.concat(anchor, tail)
    element.updateInnerHTML()
    element.taint()

    # Restore the selection
    selection.set(cursor, cursor)
    element.selection(selection)

    callback(true)

    # Dispatch `applied` event
    @dispatchEditorEvent('tool-applied', toolDetail)

ContentTools.DEFAULT_TOOLS[0].push('headeritem')