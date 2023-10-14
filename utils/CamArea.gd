extends Area3D

#signal enable_camera

func _ready():
	connect("body_entered", enable_camera)
	
func enable_camera(body):
	print(body)
	if body.name != "Player":
		return
	if has_node("Camera"):
		var cam = get_node("Camera")
		cam.make_current()
		if cam.has_method("set_target"):
			cam.set_target(body)
