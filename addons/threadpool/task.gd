extends RefCounted

class_name Task

signal completed(result)

var _action: Callable
var is_running := false
var is_done := false
var result = null


static func wait_all(tasks: Array) -> Array:
	var results = []
	for task in tasks:
		var unwrapped_task := task as Task
		if !unwrapped_task.is_done:
			await unwrapped_task.completed
		results.append(unwrapped_task.result)
	return results


func _init(action: Callable) -> void:
	self._action = action


static func make(action: Callable) -> Task:
	return Task.new(action)


func run() -> void:
	if _action.is_valid() and not is_running:
		is_running = true
		var result = _action.call()
		_finish_deferred(result)


func _finish_deferred(result) -> void:
	_finish.call_deferred(result)


func _finish(result) -> void:
	is_done = true
	is_running = false
	self.result = result
	completed.emit(result)
