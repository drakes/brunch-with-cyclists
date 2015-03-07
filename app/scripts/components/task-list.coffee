TaskListIntent = require 'intents/task-list'
TaskListModel = require 'models/task-list'
TaskListView = require 'views/task-list'

module.exports =
	# These component modules are for wiring up the different pieces
	# Actual work is done in the Intent/Model/View modules
	# But the high-level data flow and connections are represented here
	TaskList = (sources) ->
		taskListAction$ = TaskListIntent sources.DOM
		taskListState$ = TaskListModel taskListAction$, sources
		taskListVdom$ = TaskListView taskListState$

		DOM: taskListVdom$
