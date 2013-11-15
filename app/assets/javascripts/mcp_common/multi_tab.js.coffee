
# Renders a dataTable based on params found in a rendered HTML table
# The partials responsible for rendering are: multi_tab/_layout, multi_tab/_tabs and multi_tab/tables

@renderTable = (table_id) ->
  #alert $(table_id).data('source')
  #alert table_id
  $(table_id).dataTable
    sPaginationType: "full_numbers" 
    bJQueryUI: true
    bProcessing: true
    bServerSide: true
    sAjaxSource: $(table_id).data('source')
    bFilter: false  # Hides the search box


jQuery -> 
  # class multi-tab-tabs is set in partial _multi_tab
  $('.multi-tab-tabs').click (event) ->
    # check if this tab has already been rendered
    # if yes, then just return
    if $(event.target).data('tab-rendered')
      return
    # otherwise, process the click
    # add the 'tab-rendered' class to the element so it is marked as already clicked
    $(event.target).data('tab-rendered', 'true')
    # get the table_id to render from the element's tab-param
    table_id = '#' + $(event.target).data('tab-param')
    # render the table
    renderTable table_id

  # render the first (CDRs) tab when the page is first requested
  # this is based on which tab is indicated as active (set in partial _multi_tab_header)
  table_id = '#' + $('#multi_tab_first_active').data('tab-param')
  renderTable table_id


