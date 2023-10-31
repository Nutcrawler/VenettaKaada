extends Area3D

@onready var player = get_tree().get_first_node_in_group("player")
@export var depth: float = -500


# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape3D.position.y = depth
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body == player:
		GameInstance.player_death("fall")
