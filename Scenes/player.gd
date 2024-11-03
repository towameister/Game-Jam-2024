extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 24

# Downward acceleration when in the air, in meters per second squared
@export var fall_acceleration = 75
@export var mouse_delta = Vector2()
@export var sens = 0.01
@export var jump_impulse = 1.5
@export var dash_impulse = 3
@onready var camera_pivot = $CameraPivot
var dashCount = 0
var maxDashes = 3


var target_velocity = Vector3.ZERO


func _physics_process(delta):
	var direction = Vector3.ZERO
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
		
	if is_on_floor() and Input.is_action_pressed("jump"):
		target_velocity.y = jump_impulse * speed
		
	var orientation = Vector3()
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		orientation = (transform.basis.z * direction.z + transform.basis.x * direction.x)	 #how
		
	if is_on_floor():
		target_velocity.x = orientation.x * speed
		target_velocity.z = orientation.z * speed
		dashCount = 0
	if not is_on_floor() and Input.is_action_just_pressed("jump") and Input.is_action_pressed("move_forward") and dashCount < maxDashes:
		target_velocity.z = orientation.z * speed * dash_impulse 
		dashCount += 1
		
	if not is_on_floor() and Input.is_action_just_pressed("jump") and Input.is_action_pressed("move_left") and dashCount < maxDashes:
		target_velocity.x = orientation.x * speed * dash_impulse 
		dashCount += 1
		
	if not is_on_floor() and Input.is_action_just_pressed("jump") and Input.is_action_pressed("move_back") and dashCount < maxDashes:
		target_velocity.z = orientation.z * speed * dash_impulse 
		dashCount += 1
		
	if not is_on_floor() and Input.is_action_just_pressed("jump") and Input.is_action_pressed("move_right") and dashCount < maxDashes:
		target_velocity.x = orientation.x * speed * dash_impulse 
		dashCount += 1
	
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
