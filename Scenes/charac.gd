
extends CharacterBody2D
@onready var area_2d: Area2D = $Area2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var floatmeter = 100
const floatspeed = 400
var floaton = 0
var grounded = false 


func _physics_process(delta: float) -> void:
	
	if area_2d.get_overlapping_bodies() == null:
		grounded = false
	else:
		grounded = true
	
	# Add the gravity.
	if floaton == 0:
		if grounded == false:
			velocity += get_gravity() * delta
		else:
			velocity.y = velocity.y - 0.1 * velocity.y
		
		
	if Input.is_action_pressed("floatup") and ((grounded == true) or (floaton == 1)):
		velocity.y -= floatspeed * delta
	elif Input.is_action_pressed("floatdown"):
		velocity.y += floatspeed * delta
	else:
		velocity.y = velocity.y - 0.1 * velocity.y

	if Input.is_action_pressed("floaton") and floatmeter != 0:
		floaton = 1
	else:
		floaton = 0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
