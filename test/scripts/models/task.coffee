{mockDOMSource} = require '@cycle/dom'
{mockTimeSource} = require '@cycle/time'
xs = require('xstream').default

TaskModel = require 'models/task'

describe 'TaskModel', ->
	Time = null

	beforeEach ->
		Time = mockTimeSource()

	it 'combines content and completed status into state', (done) ->
		actionDiagram = '-----c-i-c-|'
		stateDiagram =  '(st)-c-i-c-|'

		action$ = Time.diagram actionDiagram,
			c:
				type: 'taskStatus'
				payload: yes
			i:
				type: 'taskStatus'
				payload: no

		expectedState$ = Time.diagram stateDiagram,
			c:
				completed: yes
				content: 'test models!'
			i:
				completed: no
				content: 'test models!'
			s:
				completed: no
				content: ''
			t:
				completed: no
				content: 'test models!'

		sources =
			props:
				type: 'insertTask'
				payload: 'test models!'

		state$ = TaskModel(action$, sources).state

		Time.assertEqual state$, expectedState$
		Time.run done

	it 'models only destroy action as removal', (done) ->
		actionDiagram = '-c-i-d-|'
		removeDiagram = '-----d-|'

		action$ = Time.diagram actionDiagram,
			c:
				type: 'taskStatus'
				payload: yes
			d:
				type: 'destroyTask'
			i:
				type: 'taskStatus'
				payload: no

		expectedRemove$ = Time.diagram removeDiagram,
			d:
				type: 'destroyTask'

		sources = props: {}
		remove$ = TaskModel(action$, sources).remove

		Time.assertEqual remove$, expectedRemove$
		Time.run done
