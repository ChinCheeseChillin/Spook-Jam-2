extends Node2D

var fish = false
var cat = false
var capybara = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Level.player = 0
	print(Level.level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fish == true:
		Level.player = 1
		print("fish selected")
		if Level.level == 0:
			get_tree().change_scene_to_file("res://Scenes/tutorial.tscn")
		if Level.level == 4:
			get_tree().change_scene_to_file("res://Scenes/final_level.tscn")

func _on_fish_pressed() -> void:
	fish = true
	

func _on_cat_pressed() -> void:
	Level.player = 2
	if Level.level == 0:
		get_tree().change_scene_to_file("res://Scenes/tutorial.tscn")
	if Level.level == 4:
		get_tree().change_scene_to_file("res://Scenes/final_level.tscn")

func _on_capybara_pressed() -> void:
	Level.player = 3
	if Level.level == 0:
		get_tree().change_scene_to_file("res://Scenes/tutorial.tscn")
	if Level.level == 4:
		get_tree().change_scene_to_file("res://Scenes/final_level.tscn")
