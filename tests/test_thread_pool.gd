extends GutTest

func test_run_simple_task() -> void:
	var scene := get_tree().current_scene
	var task := GlobalThreadPool.start(func (): return 6969)
	var result = await task.completed
	assert_eq(result, 6969)


func test_wait_all_tasks_any() -> void:
	var samples := [1, 2, 3, 4]
	var tasks = samples.map(func(val): return GlobalThreadPool.start(func (): return val))
	var results = await Task.wait_all(tasks)
	assert_eq_deep(results, samples)


func test_wait_all_tasks() -> void:
	var samples := [GlobalThreadPool.start(func (): return 1),
	GlobalThreadPool.start(func (): return 2),
	GlobalThreadPool.start(func (): return 3)] as Array[Task]
	var results = await Task.wait_all(samples)
	assert_eq_deep(results, [1, 2, 3])
