xs = require('xstream').default

module.exports =
	TaskIntent = (domSource) ->
		checkboxChange$ = domSource.select('input[type=checkbox]').events 'change'
		toggle$ = checkboxChange$.map (event) ->
			event.target.checked

		status$ = toggle$.map (completed) ->
			type: 'taskStatus'
			payload: completed

		destroy$ = domSource.select('button').events('click').mapTo type: 'destroyTask'

		merged$ = xs.merge status$, destroy$
