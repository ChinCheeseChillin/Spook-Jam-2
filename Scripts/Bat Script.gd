extends Node2D


@export var speed = 300.0
@export var x = 10.0
@export var y = 0
@export var HP = 1.0
@export var Stationary = false

var dir = 1

@onready var path_2d: Path2D = $Path2D
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var animated_sprite_2d: AnimatedSprite2D = $Path2D/PathFollow2D/Bat/AnimatedSprite2D
@onready var BatMain: Node2D = $"."
@onready var bat: RigidBody2D = $Path2D/PathFollow2D/Bat




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	path_2d.curve.add_point(Vector2(x, y))
	path_2d.curve.add_point(Vector2(0, 0))
	animated_sprite_2d.play()
	


func Die():
	print("OH NO IM DEAD")
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Stationary == false:
		path_follow_2d.set_progress(path_follow_2d.get_progress() + speed * delta)
		if path_follow_2d.get_progress_ratio() >= 0.5:
			animated_sprite_2d.flip_h = false
		elif path_follow_2d.get_progress_ratio() <= 0.5:
			animated_sprite_2d.flip_h = true






func _on_bat_hurted(damage) -> void:
	HP -= damage
	print(HP)
	if HP <= 0:
		Die()
