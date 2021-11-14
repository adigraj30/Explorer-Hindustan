extends Node2D




func _ready():
	UserInterface.hidemenu() #This hides the user interface. helath and lives, when the player not in the "game levels". This makes the game more professional.
	

	
	
		
	
	
func _physics_process(delta):
	pass
	



func _on_TextureButton_pressed():
	get_tree().change_scene("res://Worlds/menuscreen.tscn")

	
