# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
	$('input').tagit
		caseSensitive: false
		allowSpaces: true
		placeholderText: "Add a language"
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