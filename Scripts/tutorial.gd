extends Node2D

var player_no = Level.player

var fish = preload("res://Scripts/charac.gd")
var level_to_load = Level.level

func add_myNode_to_my_game(): 
	if player_no == 1:
		get_tree().get_root().add_child(fish)
		fish._set_global_position(0,0)
	if player_no == 2:
		var myNode_instance =  fish.instance()
		get_tree().get_root().add_child(myNode_instance)
		myNode_instance.global_transform = global_transform
	if player_no == 3:
		var myNode_instance =  fish.instance()
		get_tree().get_root().add_child(myNode_instance)
		myNode_instance.set_global_position = Vector2(0, 0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_to_load = 4
	Level.level = level_to_load
	add_myNode_to_my_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/player_selection.tscn")
