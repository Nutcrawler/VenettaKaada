extends Node2D

var current_scene = null
@export var starting_scene = "res://levels/a-1/a_1.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	print_debug(current_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
	
	
	print_debug(current_scene)

func player_death(reason):
	match reason:
		1, 2, 3:
			print("It's 1 - 3")
		"foo", "bar", "spam":
			print("Yep, you've taken damage")
		"fall":
			print("Splat!")
	# TODO - respawn player
