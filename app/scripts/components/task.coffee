TaskIntent = require 'intents/task'
TaskModel = require 'models/task'
TaskView = require 'views/task'

module.exports =
	Task = (sources) ->
		taskAction$ = TaskIntent sources.DOM
		taskModel = TaskModel taskAction$, sources
		taskState$ = taskModel.state
		taskRemove$ = taskModel.remove
		taskVdom$ = TaskView taskState$

		DOM: taskVdom$
		remove: taskRemove$
