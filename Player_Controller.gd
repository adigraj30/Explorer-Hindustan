extends KinematicBody2D

export (int) var speed  = 120
export (int) var jump_speed = -180
export (int) var gravity = 400

export (int) var health := 1000


var velocity = Vector2.ZERO

export (float,0,1,0) var friction = 10
export (float,0,1,0) var acceleration = 25

enum state {IDLE, RUNNING, SLIDING, JUMP, FALL, ATTACK, DEATH}

var player_state = state.IDLE

func get_input():
	var dir = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if dir != 0:
		velocity.x = move_toward(velocity.x, dir * speed, acceleration)
		
		
	else:
		
		velocity.x = move_toward(velocity.x, 0, friction)
		

func update_animation():
	if velocity.x < 0 :
		$Sprite.flip_h = true
		$Sprite/SwordAttack/CollisionShape2D.position.x = -16
		
	if velocity.x > 0 :
		$Sprite.flip_h = false
		$Sprite/SwordAttack/CollisionShape2D.position.x = 16
	match(player_state):
		state.IDLE:
			$AnimationPlayer.play("Idle")
		state.RUNNING:
			$AnimationPlayer.play("Running")		
		state.SLIDING:
			$AnimationPlayer.play("Sliding")
			yield($AnimationPlayer, "animation_finished")
			player_state = state.IDLE	
		state.JUMP:
			$AnimationPlayer.play("Jump")
		state.FALL:
			$AnimationPlayer.play("Fall")
		state.ATTACK:
			$AnimationPlayer.play("Attack")
			yield($AnimationPlayer, "animation_finished")
			player_state = state.IDLE	
			


		
func _physics_process(delta):
	if player_state != state.SLIDING and player_state != state.ATTACK:
		get_input()
		

		
		if velocity.x == 0:
			velocity.x = 0
			player_state = state.IDLE
		elif velocity.x != 0 and Input.is_action_just_pressed("ui_down"):
			player_state = state.SLIDING	
			velocity.x *= 2 
		elif velocity.x != 0:
			player_state = state.RUNNING
		
		if is_on_floor() and player_state != state.SLIDING:
			if Input.is_action_just_pressed("ui_up"):
				velocity.y = jump_speed
				player_state = state.JUMP
				
			if Input.is_action_just_pressed("attack"):
				player_state = state.ATTACK 
		
				###
				#ADD ATTACK
				####
				
	if not is_on_floor():
		if velocity.y < 0:
			player_state = state.JUMP
		else:
			player_state = state.FALL
			
	
	
	if player_state == state.ATTACK:
		velocity.x = move_toward(velocity.x, 0, friction)	
	
	if Input.is_action_just_released("attack"):
		player_state = state.IDLE
		$Sprite/SwordAttack/CollisionShape2D.disabled = true # this makes sure the collision shape is disabled once attack is not pressed.
	#if Input.is_action_pressed("attack"):
		#player_state = state.IDLE
	
	velocity.y += gravity * delta #adds gravity
	velocity = move_and_slide(velocity, Vector2.UP)
	
	update_animation()
		
		

func _process(delta):
	
	
	if PlayerStats.health <=0:
		dead()
		PlayerStats.reset()

		
		
	


#func _on_Area2D_body_entered(body):
#	if body.is_in_group("Monkey"):
#		$AnimationPlayer.play("Dead")


func _on_SwordAttack_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_damage()
		
	
	



#func _on_DeathZone_area_entered(area):
	#if area.is_in_group("Deadly"):
		

func dead():
	if $AnimationPlayer.current_animation == "Death": #this makes sure that death does not happen twice if landed on two spikes
		return
	print("you are dead...")
	set_physics_process(false)
	$AnimationPlayer.play("Death")
	yield($AnimationPlayer,"animation_finished") 
	
	if PlayerStats.lives <=1:
		get_tree().change_scene("res://Worlds/GameOver.tscn")
		
		
	else:
		PlayerStats.player_reset()
	

func _on_DeathZone_body_entered(body):
	
	if body.is_in_group("Monkey"):
		PlayerStats.change_health(-20)
		
	if body.is_in_group("DeathBar"):
		dead()
		
		#dead()
		
	
		


func _on_DeathZone_area_entered(area):
	
	if area.is_in_group("SpikeTrap"):
		dead()
	
	
	elif area.is_in_group("DeathBar"):
		dead()

