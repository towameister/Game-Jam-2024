extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 24

# Downward acceleration when in the air, in meters per second squared
@export var fall_acceleration = 75
@export var mouse_delta = Vector2()
@export var sens = 0.01
@export var jump_impulse = 40
@onready var camera_pivot = $CameraPivot
@export var rot_x = 0
@export var rot_y = 0

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	var input = Vector3()
	if Input.is_action_pressed("move_right"):
		input.x += 1
	if Input.is_action_pressed("move_left"):
		input.x -= 1
	if Input.is_action_pressed("move_back"):
		input.z += 1
	if Input.is_action_pressed("move_forward"):
		input.z -= 1
		
	if is_on_floor() and Input.is_action_pressed("jump"):
		target_velocity.y = jump_impulse
	var direction = Vector3()
	if input != Vector3.ZERO:
		input = input.normalized()
		direction = (transform.basis.z * input.z + transform.basis.x * input.x)	 #how
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
			
	velocity = target_velocity
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_delta = event.relative
		rotate_y(-event.relative.x * sens)
		camera_pivot.rotate_x(-event.relative.y * sens)
		camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, deg_to_rad(-90), deg_to_rad(15))
		
func _process(delta) -> void:
	pass
