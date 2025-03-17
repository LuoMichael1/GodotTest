extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		print("hi")
		take_damage(10)
		print("hello")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func damagehealbuttons():
	if Input.is_action_just_pressed("ui_end"):
		take_damage(10)
		print("hello")
	
	if Input.is_action_just_pressed("ui_home"):
		heal(10)


# Player's max health and current health
var max_health = 100
var current_health = 100

# Reference to the ProgressBar node
@onready var health_bar = $/root/Node2D/HealthBar

func _ready():
	# Initialize the health bar
	health_bar.max_value = max_health
	health_bar.value = current_health

func take_damage(damage_amount):
	# Reduce health by the damage amount
	current_health -= damage_amount
	
	# Ensure health doesn't go below 0
	current_health = max(current_health, 0)
	
	# Update the health bar
	health_bar.value = current_health

func heal(heal_amount):
	# Increase health by the heal amount
	current_health += heal_amount
	
	# Ensure health doesn't exceed max health
	current_health = min(current_health, max_health)
	
	# Update the health bar
	health_bar.value = current_health
