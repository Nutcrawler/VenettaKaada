extends Area3D
class_name InteractionArea

@export var action_name: String = "interact"

var interact: Callable = func():
	#InteractionArea.unregister_area(self)
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	InteractionManager.register_area(self)


func _on_body_exited(body):
	InteractionManager.unregister_area(self)
