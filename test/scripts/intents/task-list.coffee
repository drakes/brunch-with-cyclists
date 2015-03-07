{mockDOMSource} = require '@cycle/dom'
{mockTimeSource} = require '@cycle/time'

TaskListIntent = require 'intents/task-list'
{KEY_CODES} = require 'helpers/constants'

describe 'TaskListIntent', ->
	Time = null

	beforeEach ->
		Time = mockTimeSource()

	it 'interprets Enter as a task insert action when field has non-whitespace characters', (done) ->
		keyDiagram =            '-s-i-a-v-|'
		expectedInsertDiagram = '-------i-|'
		keyEvents$ = Time.diagram keyDiagram,
			a:
				keyCode: KEY_CODES.A
				target:
					value: ' a'
			i:
				keyCode: KEY_CODES.ENTER
				target:
					value: ' '
			s:
				keyCode: KEY_CODES.SPACE
				target:
					value: ' '
			v:
				keyCode: KEY_CODES.ENTER
				target:
					value: ' a'

		DOM = mockDOMSource '.new-task': keydown: keyEvents$
		insert$ = TaskListIntent DOM

		expectedInsert$ = Time.diagram expectedInsertDiagram,
			i:
				type: 'insertTask'
				payload: 'a' # trimmed

		Time.assertEqual insert$, expectedInsert$
		Time.run done
