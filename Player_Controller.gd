extends KinematicBody2D

export (int) var speed  = 120
export (int) var jump_speed = -180
export (int) var gravity = 400

var velocity = Vector2.ZERO

export (float,0,1,0) var friction = 0.1
export (float,0,1,0) var acceleration = 0.25

enum state {IDLE, RUNNING, SLIDING, JUMP, FALL, ATTACK}

var player_state = state.IDLE

func get_input():
	var dir = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
		

func update_animation():
	if velocity.x < 0 :
		$Sprite.flip_h = true
	if velocity.x > 0 :
		$Sprite.flip_h = false
	match(player_state):
		state.IDLE:
			$AnimationPlayer.play("Idle")
		state.RUNNING:
			$AnimationPlayer.play("Running")
			yield($AnimationPlayer, "animation_finished")
			player_state = state.IDLE
		state.SLIDING:
			$AnimationPlayer.play("Sliding")
		state.JUMP:
			$AnimationPlayer.play("Jump")
		state.FALL:
			$AnimationPlayer.play("Fall")


		
func _physics_process(delta):
	if player_state != state.SLIDING and player_state != state.ATTACK:
		get_input()
		
		print(velocity)
		
		if -20 <= velocity.x and velocity.x <= 20:
			velocity.x = 0
			player_state = state.IDLE
		elif velocity.x != 0 and Input.is_action_just_pressed("ui_down"):
			player_state = state.SLIDING	
		elif velocity.x != 0:
			player_state = state.RUNNING
		
		if is_on_floor() and player_state != state.SLIDING:
			if Input.is_action_just_pressed("ui_up"):
				velocity.y = jump_speed
				player_state = state.JUMP
				
				###
				#ADD ATTACK
				####
				
	if not is_on_floor():
		if velocity.y < 0:
			player_state = state.JUMP
		else:
			player_state = state.FALL
			
			
	
	velocity.y += gravity * delta #adds gravity
	velocity = move_and_slide(velocity, Vector2.UP)
	
	update_animation()
		
		
	
		
		
	
