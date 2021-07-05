extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var audio_enabled = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(audio_enabled)


func _on_TextureButton_pressed():
	audio_enabled = not audio_enabled
	if not audio_enabled:
		$HBoxContainer/TextureButton.texture_normal = load("res://Sprites/Options buttons/pthesource/Using/Reziedoptions/Audio Square Button cross.png.png")
	else:
		$HBoxContainer/TextureButton.texture_normal = load("res://Sprites/Options buttons/pthesource/Using/Reziedoptions/Audio Square Button clone-1.png.png")
