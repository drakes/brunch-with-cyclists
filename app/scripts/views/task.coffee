Collection = require('@cycle/collection').default
{h} = require '@cycle/dom'

module.exports =
	TaskView = (state$) ->
		state$.map ({completed, content}) ->
			h 'li', [
				h 'label', [
					h 'input',
						props:
							checked: completed
							type: 'checkbox'
					h 'span', {class: done: completed}, content
				]
				h 'button.delete', 'Delete'
			]
