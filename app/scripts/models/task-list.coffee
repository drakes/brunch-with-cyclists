Collection = require('@cycle/collection').default
xs = require('xstream').default

Task = require 'components/task'
startingTasks = require 'helpers/starting-tasks'

module.exports =
	TaskListModel = (action$, sources) ->
		insert$ = action$.filter (event) ->
			# TODO: validate type string against a list of known types
			# to reduce errors from typos
			event.type is 'insertTask'

		startingTask$ = xs.fromArray(startingTasks).map (content) ->
			type: 'insertTask'
			payload: content

		combinedInitialAndNewInsert$ = xs.merge insert$, startingTask$
		insertAsProps$ = combinedInitialAndNewInsert$.map (insert) ->
			props: insert

		removeSelector = (task) ->
			task.remove

		tasks$ = Collection Task, sources, insertAsProps$, removeSelector
