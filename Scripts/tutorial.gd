extends Node2D

var player_no = Level.player

@onready var capybara: CharacterBody2D = $Capybara
@onready var cat: CharacterBody2D = $Cat
@onready var fish: CharacterBody2D = $Fish


#var fish = preload("res://Scripts/Fish Script.gd")
var level_to_load = Level.level

func add_myNode_to_my_game(): 
	if player_no == 0:
		print("wtf there is no player WHAT DID YOU DO")
	
	if player_no == 1:
		capybara.queue_free()
		cat.queue_free()
		
	if player_no == 2:
		fish.queue_free()
		capybara.queue_free()
		
	if player_no == 3:
		fish.queue_free()
		cat.queue_free()
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_to_load = 4
	Level.level = level_to_load
	print(player_no, "wat")
	add_myNode_to_my_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/player_selection.tscn")
