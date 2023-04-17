extends Node

class_name ThreadPool

var _threads: Array[Thread] = []
var _task_semaphore := Semaphore.new()
var _task_mutex := Mutex.new()
var _tasks_pool: Array[Task] = []

func _enter_tree() -> void:
	var cpus := OS.get_processor_count()
	for i in cpus:
		var thread := Thread.new()
		_threads.append(thread)
		thread.start(_thread_execute.bind(i))


func _thread_execute(idx: int) -> void:
	while true:
		_task_semaphore.wait()

		var task := _pop_task()
		if task != null and task._action.is_valid():
			print("Start executing thread: %s" % idx)
			var result = task._action.call()
			task._finish_deferred(result)
			print("Finish executing thread: %s" % idx)


func _push_task(task: Task) -> void:
	_task_mutex.lock()
	_tasks_pool.push_back(task)
	_task_mutex.unlock()


func _pop_task() -> Task:
	_task_mutex.lock()
	var task: Task = _tasks_pool.pop_front()
	_task_mutex.unlock()
	return task


func start(action: Callable) -> Task:
	var task := Task.make(action)
	_push_task(task)
	_task_semaphore.post()
	return task

