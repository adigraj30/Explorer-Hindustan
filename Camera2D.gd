extends Camera2D


onready var player = get_node("root/MainScene/Player")
# Called when the node enters the scene tree for the first time.
func _process(delta):
	position.x = player.position.x
	
