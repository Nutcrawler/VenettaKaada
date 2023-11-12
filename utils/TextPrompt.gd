extends Node3D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("player")

@export_multiline var text: String = "Lorem Ipsum"
#@export var timer: int = 0

@onready var label = $Control/Label
@onready var bgsq = $Control/Label/ColorRect

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	label.text = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_interact():
	label.text = text
	label.visible
	print_debug(label.size)
	$Timer.start()
	$bgTimer.start() #literally need just one frame for label size to update
	bgsq.set_size(label.size)
	

func _on_timer_timeout():
	label.text = ""
	bgsq.set_size(Vector2(0,0))

func _update_bgsq():
	bgsq.set_size(label.size) #TODO - something that doesnt require this
