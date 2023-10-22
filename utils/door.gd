extends Node3D

@onready var interaction_area: InteractionArea = $InteractionArea
@export var locked: bool = false
@export var disabled: bool = false
@export var mat_over: StandardMaterial3D = null

var open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	if mat_over:
		$Rotator/MeshInstance3D.set_surface_override_material(0, mat_over)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_interact():
	if disabled:
#		print($Rotator/MeshInstance3D.get_surface_override_material(0))
		return
	if locked:
		$Locked.play()
		return
	if not open:
		$AnimationPlayer.play("open")
		open = true
		print("door open")
	else:
		$AnimationPlayer.play("close")
		open = false
		print("door close")
	
func switch():
	locked = false
	$Unlocked.play()
