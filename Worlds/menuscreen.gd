extends Node2D



func _ready():
	pass # Replace with function body.
	




#I DID NOT HAVE TIME TO ADD A SCENE THAT HAPPENS WHEN OPTIONS IS PRESSED. bUT THIS SCENE WOULD HAVE HAD A CONROLS AND MAYBE A FULLSCREEN BUTTON, MAYBE.


	


func _on_TextureButton3_pressed():
	get_tree().change_scene("res://Worlds/TitleScreen.tscn")


func _on_TextureButton_pressed():
	get_tree().change_scene_to(load("res://Worlds/WRLD_START.tscn"))
	PlayerStats.reset_everything()
	
