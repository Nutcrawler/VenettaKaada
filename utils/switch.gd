extends Node3D

@onready var interaction_area: InteractionArea = $InteractionArea

@export var effected: Node3D
@export var on_material: StandardMaterial3D
@export var method = "_on_interact"
@export var switchback = false

var used = false

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, str(method))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_interact():
	if used == false:
		$MeshInstance3D.set_surface_override_material(0, on_material)
		used = true
		print("switch used")
		effected.switch()
	else:
		if switchback:
			effected.switch_back()
			used = false
			return
		print("switch has already been used")

func _flip():
	effected.switch_back()
