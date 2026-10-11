extends Node2D

var level_to_load = Level.level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_to_load = 0
	Level.level = level_to_load


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/beginning_scene.tscn")
