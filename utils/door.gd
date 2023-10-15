extends Node3D

@onready var interaction_area: InteractionArea = $InteractionArea

var open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_interact():
	if not open:
		$AnimationPlayer.play("open")
		open = true
		print("door open")
	else:
		$AnimationPlayer.play("close")
		open = false
		print("door close")
	
