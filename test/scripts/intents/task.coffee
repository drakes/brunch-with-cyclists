{mockDOMSource} = require '@cycle/dom'
{mockTimeSource} = require '@cycle/time'

TaskIntent = require 'intents/task'

describe 'TaskIntent', ->
	Time = null

	beforeEach ->
		Time = mockTimeSource()

	it 'interprets checkbox toggles as completed status changes', (done) ->
		# source and sink streams could use separate diagrams
		# in this case the same diagram can be reused
		marbleDiagram = '-c-i-c-i-|'
		checkboxEvent$ = Time.diagram marbleDiagram,
			c:
				target:
					checked: yes
			i:
				target:
					checked: no

		DOM = mockDOMSource 'input[type=checkbox]': change: checkboxEvent$
		completedStatus$ = TaskIntent DOM

		expectedStatus$ = Time.diagram marbleDiagram,
			c:
				type: 'taskStatus'
				payload: yes
			i:
				type: 'taskStatus'
				payload: no

		Time.assertEqual completedStatus$, expectedStatus$
		Time.run done

	it 'interprets a button click as destruction', (done) ->
		marbleDiagram = '-d-|'
		click$ = Time.diagram marbleDiagram

		DOM = mockDOMSource 'button': click: click$
		destroy$ = TaskIntent DOM

		expectedDestroy$ = Time.diagram marbleDiagram, d: type: 'destroyTask'

		Time.assertEqual destroy$, expectedDestroy$
		Time.run done
