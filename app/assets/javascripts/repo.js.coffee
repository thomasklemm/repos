# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
	# make each .tag_input a tagit ...
	# bug: currently only one input field transformed
	# little fix: initializing every element when it gets focus (it's been click upon)
	# do: 'click to edit feature'
	# note: maintainer of repo passive, lot's of open pull requests for several months right now
	$(".tag_input").tagit
		caseSensitive: false
		allowSpaces: true
		placeholderText: "Add a tag"

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