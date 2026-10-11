extends RigidBody2D

signal hurted

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func TakeDamage(damage):
	hurted.emit(damage)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
