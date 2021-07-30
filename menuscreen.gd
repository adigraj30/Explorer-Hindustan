extends Node2D



func _ready():
	pass # Replace with function body.
	







	


func _on_TextureButton3_pressed():
	get_tree().change_scene("TitleScreen.tscn")


func _on_TextureButton_pressed():
	get_tree().change_scene_to(load("res://WRLD_START.tscn"))
	
