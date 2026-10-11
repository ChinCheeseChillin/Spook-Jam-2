extends Node2D

@onready var final_scene = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	final_scene.play("default")
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
