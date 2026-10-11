
extends CharacterBody2D
@onready var Floating_Hitbox: Area2D = $"Floating Hitbox"
@onready var fish: AnimatedSprite2D = $"Fish Texture"
@onready var Attack_Hitbox: Area2D = $"Fish Texture/Attack Hitbox"
@onready var Damage_Hitbox: Area2D = $"Damage Hitbox"
@onready var Damage_Timer: Timer = $"Damage Timer"




const baseAttack = 1
const SPEED = 300.0
const JUMP_VELOCITY = -550.0
const floatspeed = 400
var floaton = 0
var grounded = false 
var jumped = false


func _ready() -> void:
	pass
	#hide()

func hurted(damage):
	Level.FishHP -= damage
	print(Level.FishHP, "owie")
	if Level.FishHP <= 0:
		dead()

func dead():
	print("you dead") #integrate with game over screen
	queue_free()


func _physics_process(delta: float) -> void:
	if Damage_Hitbox.get_overlapping_bodies() != [] and Damage_Timer.time_left == 0:
		hurted(1)
		Damage_Timer.start()
	
	
	if Input.is_action_just_pressed("attack"):
		print("attack")
		for body in Attack_Hitbox.get_overlapping_bodies():
			print(body)
			if body.has_method("TakeDamage"):
				print("hurt")
				body.TakeDamage(baseAttack)
	
	if Floating_Hitbox.get_overlapping_bodies() == []:
		grounded = false
	else:
		grounded = true
		jumped = false
	
	# Add the gravity.
	if floaton == 0:
		if grounded == false:
			velocity += get_gravity() * delta
		elif Input.is_action_just_pressed("jump") and grounded == true and jumped == false:
			velocity.y = JUMP_VELOCITY
			jumped = true
		elif jumped == false:
			velocity.y = velocity.y - 0.1 * velocity.y

	if (grounded == true) or (floaton == 1):
		if Input.is_action_pressed("floatup"):
			velocity.y -= floatspeed * delta
		elif Input.is_action_pressed("floatdown"):
			velocity.y += floatspeed * delta
		else:
			velocity.y = velocity.y - 0.1 * velocity.y

	if Input.is_action_pressed("floaton") and Level.Fishfloatmeter != 0:
		floaton = 1
		Level.Fishfloatmeter -= Level.FishConsumemeter
		print(Level.Fishfloatmeter)
		set_collision_mask_value(1, false)
	else:
		floaton = 0
		set_collision_mask_value(1, true)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if velocity.x != 0:
		fish.play()
	else:
		fish.stop()
		fish.frame = 0
		
	if velocity.x > 0 and fish.scale.x < 0:
		fish.scale.x = -fish.scale.x
	elif velocity.x < 0  and fish.scale.x > 0:
		fish.scale.x = -fish.scale.x
	move_and_slide()
	
