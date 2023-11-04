extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $Label

const BASE_TEXT = "Press to "

var active_areas = []
var can_interact = true

func register_area(area: InteractionArea):
	active_areas.push_back(area)

func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1: #If <area> exists in <active_areas>
		active_areas.remove_at(index)

func _sort_by_distance_to_player(area1, area2):
	var area1ToPlayer = player.global_position.distance_to(area1.global_position)
	var area2ToPlayer = player.global_position.distance_to(area2.global_position)
#	print_debug(area1ToPlayer < area2ToPlayer)
	return area1ToPlayer < area2ToPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	label.hide()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	print(active_areas)
#	label.show()
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		label.text = BASE_TEXT + active_areas[0].action_name
		var middle_x = get_window().get_visible_rect().size.x / 2 - (label.size.x / 2)
		var middle_y = get_window().get_visible_rect().size.y / 2 - (label.size.y / 2)
		label.set_global_position(Vector2(middle_x, middle_y))
#		label.show() cant get it to go away lmao
	else:
		label.hide()

func _input(event):
	if event.is_action_pressed("interact"):
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			
			await active_areas[0].interact.call()
			
			can_interact = true
