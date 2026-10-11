extends CharacterBody2D


const SPEED = 275.0
const JUMP_VELOCITY = -400.0
const baseAttack = 1
var peace = 0

@onready var capybara: AnimatedSprite2D = $"Capybara Texture"
@onready var Damage_Hitbox: Area2D = $"Damage Hitbox"
@onready var Attack_Hitbox: Area2D = $"Capybara Texture/Attack Hitbox"
@onready var Damage_Timer: Timer = $"Damage Timer"
@onready var follow_path = get_parent()

var autoplay = false

func _ready() -> void:
	pass
	#hide()

func hurted(damage):
	Level.CapyHP -= damage
	print(Level.CapyHP, "owie")
	if Level.CapyHP <= 0:
		dead()

func dead():
	print("you dead") #integrate with game over screen
	queue_free()


func _physics_process(delta: float) -> void:
	if autoplay == true:
		movement(delta)
	if Input.is_action_pressed("floaton") and Level.Capypeacemeter > 0:
		peace = 1
		Level.Capypeacemeter -= Level.CapyConsumemeter
		print(Level.Capypeacemeter)
	else:
		peace = 0
	
	if Input.is_action_just_pressed("attack"):
		print("attack")
		for body in Attack_Hitbox.get_overlapping_bodies():
			print(body)
			if body.has_method("TakeDamage"):
				print("hurt")
				body.TakeDamage(baseAttack)

	if Damage_Hitbox.get_overlapping_bodies() != [] and Damage_Timer.time_left == 0 and peace == 0:
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
func movement(delta):
	follow_path.set_progress(follow_path.get_progress() + SPEED * delta)
