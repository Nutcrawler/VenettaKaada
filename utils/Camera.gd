extends Camera3D

@export var turn_speed = 60
@export var follow_dist = 5
@export var follow = false
@export var follow_speed = 2
#@export var track = true #TODO later
@export var reset_on_exit = false
#@export var y_rot_amount = 0
@export var y_minus = 0
@export var y_plus = 0
#@export var x_rot_amount = 0
@export var x_minus = 0
@export var x_plus = 0
@export var fine_tracking= false
@export var debug = false

@onready var initial_transform 

var target = null

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_transform = global_transform


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if debug:
		print(global_rotation_degrees)
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
	var horizontal_nudge_amt = turn_speed * -r_dot * delta
	var vertical_nudge_amt = turn_speed * u_dot * delta
	
	match fine_tracking:
		true:
			var new_hRot = rotation_degrees.y + horizontal_nudge_amt
			var new_vRot = rotation_degrees.x + vertical_nudge_amt
			print("new H: ", new_hRot)
			print("new V: ", new_vRot)
			if (new_hRot > y_minus && new_hRot < y_plus):
				rotation_degrees.y += horizontal_nudge_amt
			if (new_vRot > x_minus && new_vRot < x_plus):
				rotation_degrees.x += vertical_nudge_amt
		false:
			rotation_degrees.y += horizontal_nudge_amt
			rotation_degrees.x += vertical_nudge_amt

func set_target(t):
	target = t

func reset_transform():
	if reset_on_exit == true:
		global_transform = initial_transform
	else:
		pass
