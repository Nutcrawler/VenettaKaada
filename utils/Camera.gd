extends Camera3D

@export var turn_speed = 60
@export var follow_dist = 5
@export var follow = false
@export var follow_speed = 2
#@export var track = true #TODO later
@export var reset_on_exit = false

@onready var initial_transform 

var target = null

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_transform = global_transform


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target == null:
		return
	
	var to_target = target.global_transform.origin - global_transform.origin
	var distance = to_target.length()
	var move_vec = to_target
	move_vec.y = 0 
	to_target = to_target.normalized()
	
	if follow:
		var accel = distance - follow_dist
		global_transform.origin += accel * move_vec * follow_speed * delta
	
	var up = global_transform.basis.y
	var right = global_transform.basis.x
	
	var r_dot = to_target.dot(right)
	var u_dot = to_target.dot(up)
	
	rotation_degrees.y += turn_speed * -r_dot * delta
	rotation_degrees.x += turn_speed * u_dot * delta

func set_target(t):
	target = t

func reset_transform():
	if reset_on_exit == true:
		global_transform = initial_transform
	else:
		pass
