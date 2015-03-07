{run} = require '@cycle/run'
{makeDOMDriver} = require '@cycle/dom'

TaskList = require './components/task-list'

drivers =
	DOM: makeDOMDriver '#listContainer'

run TaskList, drivers
