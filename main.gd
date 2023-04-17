extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var task := GlobalThreadPool.start(func (): return 6969)
	task.completed.connect(test)
	var result = await task.completed
	print("Got result %s" % result)


func test(result) -> void:
	print(result)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
