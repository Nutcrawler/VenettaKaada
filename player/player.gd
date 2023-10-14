extends CharacterBody3D


const MOVE_SPEED = 1 
const TURN_SPEED = 135
const JUMP_VELOCITY = 2
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
const MAX_FALL_SPEED = 30
@onready var anim = $Avatar/AnimationPlayer
var y_vel = 0
var grounded = false
var sprinting = false
var sprint_modifier = 1
var aiming = false


func _physics_process(delta):
	var move_dir = 0
	var turn_dir = 0
	if Input.is_action_pressed("move_forwards"):
		move_dir += 1
	if Input.is_action_pressed("move_backwards"):
		move_dir -= 1
	if Input.is_action_pressed("turn_left"):
		turn_dir += 1
	if Input.is_action_pressed("turn_right"):
		turn_dir -= 1
	
	if Input.is_action_pressed("sprint"):
		sprinting = true
		sprint_modifier = 5
	if Input.is_action_just_released("sprint"):
		sprinting = false
		sprint_modifier = 1
	
	if Input.is_action_pressed("aim"):
		aiming = true
	else:
		aiming = false
	
	rotation_degrees.y += turn_dir * TURN_SPEED * delta
	velocity = global_transform.basis.z * MOVE_SPEED * sprint_modifier * move_dir
	velocity.y = y_vel
	move_and_slide()
	
	var was_grounded = grounded
	grounded = is_on_floor()
	y_vel -= gravity * delta
	if grounded:
		y_vel = -0.1
	if y_vel < -MAX_FALL_SPEED:
		y_vel = -MAX_FALL_SPEED
	
	if not grounded and was_grounded:
		play_anim("fall_down")
	if grounded:
		if velocity.x == 0 and velocity.z == 0:
			play_anim("idle")
			if aiming:
				play_anim("aim_pistol")
		else:
			if move_dir < 0:
				play_anim("walk_backward")
			else:
				if sprinting:
					play_anim("run_forward")
				else:
					play_anim("walk_forward")

func play_anim(name):
	if anim.current_animation == name:
		return
	anim.play(name)

func enable_camera():
	pass
