extends CharacterBody2D

@onready var cat: AnimatedSprite2D = $"Cat Texture"
@onready var Damage_Hitbox: Area2D = $"Damage Hitbox"
@onready var Attack_Hitbox: Area2D = $"Cat Texture/Attack Hitbox"
@onready var Damage_Timer: Timer = $"Cat Texture/Attack Hitbox/Damage Timer"
@onready var attack_animation: AnimatedSprite2D = $"Cat Texture/Attack Hitbox/Attack Animation"


const SPEED = 350.0
const JUMP_VELOCITY = -600.0

var boost = 0
const baseAttack = 1


func _ready() -> void:
	pass
	#hide()

func hurted(damage):
	Level.CatHP -= damage
	print(Level.CatHP, "owie")
	if Level.CatHP <= 0:
		dead()

func dead():
	print("you dead") #integrate with game over screen
	queue_free()

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("floaton") and Level.Catdoublemeter > 0 and boost == 0:
		boost = 1
		Level.Catdoublemeter -= Level.CatConsumemeter
		print(Level.Catdoublemeter)

	if Input.is_action_just_pressed("attack") and attack_animation.is_playing() == false:
		print("attack")
		attack_animation.play()
		for body in Attack_Hitbox.get_overlapping_bodies():
			print(body)
			if body.has_method("TakeDamage"):
				print("hurt")
				if boost == 0:
					body.TakeDamage(baseAttack)
				else:
					boost = 0
					print("boost consumed ", boost)
					body.TakeDamage(2 * baseAttack)

	
	
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
		cat.play()
	else:
		cat.stop()
		cat.frame = 0
		
	if velocity.x > 0 and cat.scale.x < 0:
		cat.scale.x = -cat.scale.x
	elif velocity.x < 0  and cat.scale.x > 0:
		cat.scale.x = -cat.scale.x
	move_and_slide()
