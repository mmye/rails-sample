$(document).on 'ready page:load', ->
  $('#tags').tagit
    fieldName: 'beer[tag_list]'
    singleField: true

