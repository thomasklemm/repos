# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->

	# Overall goal: show the tagit input field on click on edit

	# click on tag_edit brings up tagit input field
	$('.tag_edit').live "click",  ->
		# hide edit
		$(this).toggle()
		# show cancel and save
		$(this).parent().find('.tag_cancel').toggle()
		$(this).parent().find('.tag_save').toggle()
		# Focus the input field (will be shown as well)
		$(this).parent().find('input').focus()

	# click on tag_save saves tags
	$('.tag_save').live "click", ->
		# hide save and cancel
		$(this).toggle()
		$(this).parent().find('.tag_cancel').toggle()
		# show edit
		$(this).parent().find('.tag_edit').toggle()
		# Submit the form
		$(this).parent().parent().submit()
		# do later: submit via ajax

	# click on tag_cancel reloads browser without saving anything
	$('.tag_cancel').live "click", ->
		# force a browser reload
		# cross browser compatible?
		# window.location.reload(true)
		# the cross browser compatible way (add a querystring that is not parsed by server)
		# via http://alexkehayias.tumblr.com/post/13137771486/javascript-page-reload
		window.location.href = location.href + "?" + Date.parse(new Date())


	# tag-it input field
	# transform input field with focus into tagit input field
	$('.tag_input').focus ->
		tagit = $(this).tagit
			caseSensitive: false
			allowSpaces: true
			placeholderText: "Add a tag"
		# do later: autocomplete major languages and frameworks and solutions
		# tagit.focus()
		# set cursor somehow / set focus
		# make textfield autogrow


###
	$(".tag_input").tagit
		caseSensitive: false
		allowSpaces: true
		placeholderText: "Add a tag"
###
###
	$('#tags_frameworks').tagit
		caseSensitive: false
		allowSpaces: true
		placeholderText: "Add a framework"

	$('#tags_solutions').tagit
		caseSensitive: false
		allowSpaces: true
		placeholderText: "Add a solution"

	return
###