extends Node2D

@export var speed = 300

@onready var firebawl: RigidBody2D = $Path2D/PathFollow2D/Firebawl
@onready var area_2d: Area2D = $Path2D/PathFollow2D/Firebawl/Area2D
@onready var firebawl_ani: AnimatedSprite2D = $"Path2D/PathFollow2D/Firebawl/firebawl ani"
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D

var nowfireballing = false

var playing = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if playing == false and (Level.fireballing == true or nowfireballing == true):
		nowfireballing = true
		path_follow_2d.set_progress(path_follow_2d.get_progress() + speed * delta)
	
	if (area_2d.get_overlapping_bodies() != [firebawl] and area_2d.get_overlapping_bodies() != []) and playing == false:
		firebawl.scale = firebawl.scale * 3
		firebawl_ani.play()
		playing = true
	if firebawl_ani.frame == 2 and playing == true:
		print("my job here is done")
		playing = false
		firebawl.scale = firebawl.scale / 3
		firebawl_ani.pause()
		firebawl_ani.frame = 0
		path_follow_2d.set_progress(0)
