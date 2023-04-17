extends RefCounted

class_name Task

signal completed(result)

var _action: Callable
var _is_done := false

var is_done: bool:
	get:
		return _is_done

func _init(action: Callable) -> void:
	self._action = action
	completed.emit(1000)


static func make(action: Callable) -> Task:
	return Task.new(action)


func _finish_deferred(result) -> void:
	_finish.call_deferred(result)


func _finish(result) -> void:
	_is_done = true
	completed.emit(result)
