extends CharacterBody3D

# Player nodes
@onready var standing_collision_shape: CollisionShape3D = $StandingCollisionShape
@onready var dashing_collision_shape: CollisionShape3D = $DashingCollisionShape
@onready var head: Node3D = $Head
@onready var ray_cast_3d: RayCast3D = $RayCast3D

var current_speed = 5.0
@export var walking_speed : float = 5.0

# Dash
@export var dash_speed : float = 8.0
@export var dash_depth : float = -0.6

# Mouse
@export var mouse_sensitivity : float = 0.2

@export var lerp_speed : float = 10

@export var jump_velocity = 4.5
var direction : Vector3 = Vector3.ZERO

signal on_attack

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_body(event.relative)
	
	if event is InputEventMouseButton:
		if event.button_index == 1:
			on_attack.emit()

func rotate_body(relative: Vector2):
	rotate_y(deg_to_rad(-relative.x * mouse_sensitivity))
	head.rotate_x(deg_to_rad(-relative.y * mouse_sensitivity))
	head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("dash"):
		dashing_collision_shape.disabled = false
		standing_collision_shape.disabled = true
		current_speed = dash_speed
		head.position.y = lerp(head.position.y, 1.8 + dash_depth, delta * lerp_speed)
	elif not ray_cast_3d.is_colliding():
		dashing_collision_shape.disabled = true
		standing_collision_shape.disabled = false
		head.position.y = lerp(head.position.y, 1.8, delta * lerp_speed)
		current_speed = walking_speed
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	direction = lerp(direction, (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(), delta * lerp_speed)
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()
