# This function handles copying address fields from existing addresses.
copyAddress = ->
  selected_address_id = +$(this)[0].value
  match = null
  address_fields = $(this).closest('div.address-fields')
  addresses = address_fields.find('div.applicant-addresses').data('applicant-addresses')
  for address in addresses
    if +address.id == +selected_address_id
      match = address
      break
  unless match
    return
  address_fields.find('select[id$=state]').val(match.state)
  address_fields.find('input[id$=street]').val(match.street)
  address_fields.find('input[id$=city]').val(match.city)
  address_fields.find('input[id$=apt]').val(match.apt)
  address_fields.find('input[id$=zip]').val(match.zip)

$ ->
  dropdown = $('div.address-fields div.address-selector select')
  dropdown.change(copyAddress)
