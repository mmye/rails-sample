$(document).on 'ready page:load', ->
  $('#tags').tagit
    fieldName: 'beer[tag_list]'
    singleField: true
		availableTags: gon.available_tags

  if gon.beer_tags?
    for tag in gon.beer_tags
      $('#tags').tagit 'createTag', tag
