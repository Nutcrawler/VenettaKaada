extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$SpotLight3D.visible = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func switch():
	$SpotLight3D.visible = 1
