extends Node2D




func _on_TextureButton1_pressed():
	get_tree().change_scene("res://Worlds/WRLD_START.tscn")
	PlayerStats.reset()
	
	





func _on_TextureButton2_pressed():
	get_tree().change_scene("res://Worlds/TitleScreen.tscn")
