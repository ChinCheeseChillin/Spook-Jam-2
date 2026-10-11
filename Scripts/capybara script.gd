extends CharacterBody2D


const SPEED = 275.0
const JUMP_VELOCITY = -400.0

@onready var capybara: AnimatedSprite2D = $"Capybara Texture"
@onready var Damage_Hitbox: Area2D = $"Damage Hitbox"
@onready var Attack_Hitbox: Area2D = $"Capybara Texture/Attack Hitbox"
@onready var Damage_Timer: Timer = $"Damage Timer"


@export var HP = 5

func _ready() -> void:
	pass
	#hide()

func hurted(damage):
	HP -= damage
	print(HP, "owie")
	if HP <= 0:
		dead()

func dead():
	print("you dead") #integrate with game over screen
	queue_free()


func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("attack"):
		print("attack")
		for body in Attack_Hitbox.get_overlapping_bodies():
			print(body)
			if body.has_method("TakeDamage"):
				print("hurt")
				body.TakeDamage(1)

	if Damage_Hitbox.get_overlapping_bodies() != [] and Damage_Timer.time_left == 0:
		hurted(1)
		Damage_Timer.start()
	

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if velocity.x != 0:
		capybara.play()
	else:
		capybara.stop()
		capybara.frame = 0
		
	if velocity.x > 0 and capybara.scale.x < 0:
		capybara.scale.x = -capybara.scale.x
	elif velocity.x < 0  and capybara.scale.x > 0:
		capybara.scale.x = -capybara.scale.x
	move_and_slide()
