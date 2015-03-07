Collection = require('@cycle/collection').default
{mockDOMSource} = require '@cycle/dom'
{mockTimeSource} = require '@cycle/time'
xs = require('xstream').default

TaskListModel = require 'models/task-list'
Task = require 'components/task'
startingTasks = require 'helpers/starting-tasks'

describe 'TaskListModel', ->
	Time = null

	beforeEach ->
		Time = mockTimeSource()

	it 'produces a Task stream from inserts', (done) ->
		# Collection stream doesn't produce stream-end event
		# when insert stream ends
		marbleDiagram = '-----------i-i-i'

		action$ = Time.diagram marbleDiagram,
			i:
				type: 'insertTask'
				payload: 'test models!'

		DOM = mockDOMSource {}
		sources = {DOM}

		tasks$ = TaskListModel action$, sources

		startingTask$ = xs.fromArray startingTasks
		combinedInitialAndNewInserts$ = xs.merge action$, startingTask$

		expectedTasksList$ = combinedInitialAndNewInserts$.fold((accumulate, insert) ->
			accumulate.concat insert
		, [])

		# for the purposes of simple comparison
		# not necessary to replicate TaskListModel Collection code here
		tasksAsOnes$ = tasks$.map (tasks) ->
			tasks.map -> 1
		expectedTasksAsOnes$ = expectedTasksList$.map (tasks) ->
			tasks.map -> 1

		Time.assertEqual tasksAsOnes$, expectedTasksAsOnes$
		Time.run done
