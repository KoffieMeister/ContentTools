class HeaderItemDialog extends ContentTools.DialogUI

  # An anchored dialog to support inserting/modifying a <time> tag

  mount: () ->
    super()

    # Update the name and placeholder for the input field provided by the
    # link dialog.
    @_domInput.setAttribute('name', 'Header Item name')
    @_domInput.setAttribute('placeholder', 'Enter a name to be displayed in the header')

    # Remove the new window target DOM element
    @_domElement.removeChild(@_domTargetButton);

  save: () ->
# Save the datetime.
    detail = {
      itemname: @_domInput.value.trim()
    }
    @dispatchEvent(@createEvent('save', detail))