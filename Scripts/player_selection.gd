extends Node2D

var player_no = Level.player
var level_no = Level.level
var fish = false
var cat = false
var capybara = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(level_no)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fish == true:
		player_no = 1
		if level_no == 0:
			get_tree().change_scene_to_file("res://Scenes/tutorial.tscn")
		if level_no == 4:
			get_tree().change_scene_to_file("res://Scenes/final_level.tscn")

func _on_fish_pressed() -> void:
	fish = true
	

func _on_cat_pressed() -> void:
	player_no = 2
	if level_no == 0:
		get_tree().change_scene_to_file("res://Scenes/tutorial.tscn")
	if level_no == 4:
		get_tree().change_scene_to_file("res://Scenes/final_level.tscn")

func _on_capybara_pressed() -> void:
	player_no = 3
	if level_no == 0:
		get_tree().change_scene_to_file("res://Scenes/tutorial.tscn")
	if level_no == 4:
		get_tree().change_scene_to_file("res://Scenes/final_level.tscn")
