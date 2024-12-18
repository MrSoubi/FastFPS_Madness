extends CharacterBody3D

# Player nodes
@onready var standing_collision_shape: CollisionShape3D = $StandingCollisionShape
@onready var sliding_collision_shape: CollisionShape3D = $SlidingCollisionShape
@onready var head: Node3D = $Head
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var slide_timer: Timer = $SlideTimer

var current_speed = 5.0
@export var walking_speed : float = 5.0

@onready var label_slide_energy: Label = $Control/VBoxContainer/LabelSlideEnergy
@onready var label_velocity: Label = $Control/VBoxContainer/LabelVelocity

# Mouse
@export var mouse_sensitivity : float = 0.2

var lerp_speed : float
@export var lerp_speed_on_ground : float = 10
@export var lerp_speed_on_air : float = 5

@export var jump_velocity = 4.5
var direction : Vector3 = Vector3.ZERO

var can_slide : bool = true
var is_sliding : bool = false

# Slide
@export var slide_speed : float = 8.0
@export var slide_depth : float = -0.6
@export var max_slide_energy : float = 3
var slide_energy : float = 3


signal on_attack

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	slide_energy = max_slide_energy
	lerp_speed = lerp_speed_on_ground

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
	if slide_energy <= 0:
		can_slide = false
		is_sliding = false
		slide_timer.start()
	if Input.is_action_just_pressed("slide") and can_slide:
		is_sliding = true
	if Input.is_action_just_released("slide"):
		is_sliding = false
	
	if is_sliding:
		slide_energy = slide_energy - delta
		sliding_collision_shape.disabled = false
		standing_collision_shape.disabled = true
		current_speed = walking_speed + slide_speed * slide_energy / 3
		head.position.y = lerp(head.position.y, 1.8 + slide_depth, delta * lerp_speed)
	elif not ray_cast_3d.is_colliding():
		slide_energy = clamp(slide_energy + delta, 0, 3)
		sliding_collision_shape.disabled = true
		standing_collision_shape.disabled = false
		head.position.y = lerp(head.position.y, 1.8, delta * lerp_speed)
		current_speed = walking_speed
		
	if is_on_floor():
		lerp_speed = lerp_speed_on_ground
	else:
		lerp_speed = lerp_speed_on_air
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

func _process(delta: float) -> void:
	label_slide_energy.text = "slide energy: " + str(slide_energy)
	label_velocity.text = "velocity: " + str(velocity.length())

func _on_slide_timer_timeout() -> void:
	can_slide = true
	slide_energy = 3
