Collection = require('@cycle/collection').default
{h} = require '@cycle/dom'

module.exports =
	TaskListView = (tasks$) ->
		tasksVdom$ = Collection.pluck tasks$, (task) ->
			task.DOM

		tasksVdom$.map (tasksVdom) ->
			h 'main', [
				h 'ul', tasksVdom
				h 'p', [
					h 'input.new-task',
						hook:
							update: (_oldVNode, vNode) ->
								vNode.elm.value = ''
						props:
							type: 'text'
							autofocus: on
							placeholder: 'Type, Enter to add task'
				]
			]
