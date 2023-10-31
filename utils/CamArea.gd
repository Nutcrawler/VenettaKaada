extends Area3D

#signal enable_camera

func _ready():
	connect("body_entered", enable_camera)
	
func enable_camera(body):
#	print(body)
	if body.name != "Player":
		return
	if has_node("Camera"):
		var cam = get_node("Camera")
		var current_cam = GameInstance.current_cam
		if cam == current_cam: #prevent issue of re-entering same cam area with reset transform
#			print_debug("cam == current_cam == ", str(current_cam))
			return
		else:
#			print_debug("old cam: ", str(current_cam))
			cam.make_current()
			GameInstance.current_cam = cam
			print_debug("Current cam: ", current_cam)
			if cam.has_method("set_target"):
				if cam.has_method("reset_transform"):
					cam.reset_transform()
				cam.set_target(body)
