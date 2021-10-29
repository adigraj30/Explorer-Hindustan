extends Node2D



func _ready():
	pass # Replace with function body.
	







	


func _on_TextureButton3_pressed():
	get_tree().change_scene("res://Worlds/TitleScreen.tscn")


func _on_TextureButton_pressed():
	get_tree().change_scene_to(load("res://Worlds/WRLD_START.tscn"))
	PlayerStats.reset_everything()
	
