# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->

	###
		Section: tag-it (tag inputs)
	###

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
		Section: filtrify.js
	###
	
	ft = $.filtrify("ft_container", "ft_placeholder")

	###
	ft = $.filtrify("filtrifyContainer", "filtrifyPlaceHolder")


	contexts = ["languages", "frameworks", "solutions"]
	for context in contexts
		for tag, count of ft._fields[context]
			$("#tags_" + context).append(
				"<span class='tag tag_unselected' data-context='#{context}' data-tag='#{tag}'>#{tag}</span>"
				)

	query = 
		languages: []
		frameworks: []
		solutions: []

	$('.tag_unselected').live "click", ->
		tag = $(this).attr('data-tag')
		# needs to be read new, somehow otherwise stuck to the last item in contexts
		context = $(this).attr('data-context')
		$(this).removeClass("tag_unselected")
		$(this).addClass("tag_selected")
		# add tag to query
		query[context].push tag
		console.log query
		# trigger filtrify query
		ft.trigger query

	$(".tag_selected").live "click", ->
		tag = $(this).attr('data-tag')
		context = $(this).attr('data-context')
		$(this).removeClass("tag_selected")
		$(this).addClass("tag_unselected")
		tag_index = query[context].indexOf tag
		test = query[context].splice(tag_index, tag_index + 1)
		ft.trigger query

	$('#ft_reset').live "click", ->
		$('.tag_selected').trigger("click")
		ft.reset()
	###


	###
		Section: list.js
	###

	list_options =
		valueNames: ['owner', 'name', 'description', 'watchers', 'forks', 'wiki_text', 'languages', 'frameworks', 'tags']

	repoList = new List('repos_list', list_options)

	###
	filter_list =
		"languages": ["js", "ruby"]
		"frameworks": []
		"tags": []

	for context, tag_list of filter_list
		do (context, tag_list) ->
			for tag in tag_list
				do (tag) ->
					repoList.filter (item) ->
	
						unless item[context].indexOf(tag) is -1
							return true
						else
							return false
	###
	return true
