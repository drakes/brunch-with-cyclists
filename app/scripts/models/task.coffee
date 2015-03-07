xs = require('xstream').default
extend = require 'extend'

stateReducer = (allProps, newProp) ->
	allProps = extend on, {}, allProps, newProp

module.exports =
	TaskModel = (action$, sources) ->
		content$ = xs.of(sources.props).map ({payload}) ->
			content: payload

		status$ = action$.filter ({type}) ->
			type is 'taskStatus'

		completed$ = status$.map ({payload}) ->
			completed: payload

		destroy$ = action$.filter ({type}) ->
			type is 'destroyTask'

		merged$ = xs.merge content$, completed$
		start = content: '', completed: no
		state$ = merged$.fold stateReducer, start

		state: state$
		remove: destroy$
