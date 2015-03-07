{KEY_CODES} = require 'helpers/constants'

trimValue = (event) ->
	rawContent = event.target.value
	String(rawContent).trim()

module.exports =
	TaskListIntent = (domSource) ->
		newFieldKey$ = domSource.select('.new-task').events 'keydown'
		nonEmptyEnter$ = newFieldKey$.filter (event) ->
			content = trimValue event
			event.keyCode is KEY_CODES.ENTER and content

		content$ = nonEmptyEnter$.map trimValue

		insert$ = content$.map (content) ->
			type: 'insertTask'
			payload: content
