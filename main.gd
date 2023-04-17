extends Node3D


func _ready() -> void:
	var task := GlobalThreadPool.start(func (): return 6969)
	task.completed.connect(test)
	var result = await task.completed
	print("Got result %s" % result)

	var samples := [1, 2, 3, 4]
	var tasks = samples.map(func(val): return GlobalThreadPool.start(func (): return val)) as Array[Task]
	var results = await Task.wait_all(tasks)
	print(results)


func test(result) -> void:
	print(result)

