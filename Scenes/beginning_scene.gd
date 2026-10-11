extends Node2D

@onready var play_fish = $Path2D/PathFollow2D/Fish
@onready var play_cat = $Path2D2/PathFollow2D/Cat
@onready var play_capybara = $Path2D3/PathFollow2D/Capybara

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	play_fish.autoplay = true
	play_cat.autoplay = true
	play_capybara.autoplay = true
	if play_cat.done == true:
		get_tree().change_scene_to_file("res://Scenes/player_selection.tscn")
