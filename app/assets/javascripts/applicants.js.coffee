$ ->
  $('.applicants').DataTable({
    dom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
    pagingType: "simple_numbers",
    language: {
      search: "", 
      searchPlaceholder: "Search"
    },
    "columnDefs": [
      {
        "orderable": false,
        "targets": [2,3,4]
      },
      {
        "searchable": false,
        "targets": [2,3,4]
      }
    ],
    "dom": '<"wrapper"ftpr>'
  });