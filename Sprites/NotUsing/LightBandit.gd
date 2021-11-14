extends KinematicBody2D

###THIS WAS CANCELLED###



export var SPEED = 300
var moving = false
var attack = false
var move_vector = Vector2.ZERO

var player_state = "idle"

func move(xspeed, yspeed, delta):
	position.x += xspeed * delta
	position.y += yspeed * delta
	player_state = "moving"


func update_animation():
	match(player_state):
		
		"idle":
			$AnimationPlayer.play("Idle")
		"moving":
			$AnimationPlayer.play("Run")
		"attacking":
			$AnimationPlayer.play("Attack")
			set_process(false)
			yield($AnimationPlayer,"animation_finished")
			set_process(true)

func update_player():
	match(player_state):
		"idle":
			pass
		"moving":
			print("moving")
		"attacking":
			pass
					
func _process(delta):
	moving = false
	move_vector.x = Input.get_action_strength("ui_right")- Input.get_action_strength("ui_left")
	if move_vector == Vector2.ZERO:
		player_state = "idle"
	else:
		player_state = "moving"
		#move(-SPEED,0,delta)
		#$Sprite.flip_h = false #flips the sprite if it goes to the left
	if Input.is_action_just_pressed("Attack"):
		player_state = "attacking"
		
	
	update_player()	
	update_animation()
		
		

	
	
		
		
		
		

	
		


