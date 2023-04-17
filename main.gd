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

	var samples2 := [GlobalThreadPool.start(func (): return 1),
	GlobalThreadPool.start(func (): return 2),
	GlobalThreadPool.start(func (): return 3)] as Array[Task]

	results = await Task.wait_all(samples2)
	print(results)


func test(result) -> void:
	print(result)

