extends Node2D

@export var HP = 20
@export var speed = 20

@onready var chinchilla_main: RigidBody2D = $"Entrance/PathFollow2D/Chinchilla Main"
@onready var boss_animation: AnimatedSprite2D = $"Entrance/PathFollow2D/Chinchilla Main/Boss Animation"
@onready var path_follow_2d: PathFollow2D = $Entrance/PathFollow2D

var walking = false

var walk = null
var stand = null
var attacking = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	StageChange(1)

func StageChange(stage):
	if stage == 1:
		walk = "St1 Walk"
		stand = "St1 Stand"
		attacking = "St1 Fireball"
	elif stage == 2:
		stand = "St2 Stand"
		attacking = "St2 Fireball"
		boss_animation.scale = boss_animation.scale / 3
		boss_animation.transform.x = Vector2(-20, -20)
	elif stage == 3:
		stand = "St2 Stand"
		attacking = "St2 Fireball"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if path_follow_2d.get_progress_ratio() != 0:
		path_follow_2d.set_progress(path_follow_2d.get_progress() - speed * delta)
	
	if path_follow_2d.get_progress_ratio() != 0 and walking == false:
		print("walkies time")
		walking = true
		boss_animation.play(walk)
	elif path_follow_2d.get_progress_ratio() == 0 and walking == true:
		print("im standing now, yay...")
		walking = false
		boss_animation.play(stand)
	

func Die():
	print("OH NO IM DEAD.. AND IM THE BOSS????")
	queue_free() # integrate with game win


func _on_chinchilla_main_hurted(damage) -> void:
	HP -= damage
	print(HP)
	if HP <= 0:
		Die()
