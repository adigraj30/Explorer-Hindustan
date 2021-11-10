extends Node2D

func _ready():
	UserInterface.hidemenu()


func _on_TextureButton1_pressed():
	get_tree().change_scene("res://Worlds/WRLD_START.tscn")
	PlayerStats.reset_everything()
	
	





func _on_TextureButton2_pressed():
	get_tree().change_scene("res://Worlds/TitleScreen.tscn")
