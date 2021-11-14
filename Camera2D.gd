extends Camera2D

#THIS WAS CANCELLED, i found a better way to make the camera work, by integrating it into the player code###


onready var player = get_node("root/MainScene/Player")
# Called when the node enters the scene tree for the first time.
func _process(delta):
	position.x = player.position.x
	
#NOT WORKING!!!!!!!!!!
