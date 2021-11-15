extends KinematicBody2D

export (int) var speed  = 120
export (int) var jump_speed = -180
export (int) var gravity = 400

export (int) var health := 1000

var check_roof = false

var velocity = Vector2.ZERO

export (float,0,1,0) var friction = 10
export (float,0,1,0) var acceleration = 25

enum state {IDLE, RUNNING, SLIDING, JUMP, FALL, ATTACK, DEATH, SLIDE_END} #this is a state machine, this makes the coding process a lot easier as it allows the amount of code to be significanbtly reduced, while coding for the same thing. This not only makes the code look nicer, it is easierin the end process especialluy for when double checking the code and checking for bugs.

var player_state = state.IDLE

func get_input():
	var dir = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if dir != 0:
		velocity.x = move_toward(velocity.x, dir * speed, acceleration)
		
		
	else:
		
		velocity.x = move_toward(velocity.x, 0, friction)
		#this is the simple movement code for the player,  one of the first things I actually coded for. It uses the godot code like "ui_left" which means that left arrow key, which means that player will move left when the key is pressed. 

func update_animation(): #This code is very important as it essentially controls all the player animation, which are very important for the game. 
	
	if velocity.x < 0 :
		$Sprite.flip_h = true
		$Sprite/SwordAttack/CollisionShape2D.position.x = -16  #This makes sure the player spirte flips when its moving in the direction it is moving in.
		
	if velocity.x > 0 :
		$Sprite.flip_h = false
		$Sprite/SwordAttack/CollisionShape2D.position.x = 16
	match(player_state): #This code shows how I used the "state machine".
		state.IDLE:
			$AnimationPlayer.play("Idle")
		state.RUNNING:
			$AnimationPlayer.play("Running")		
		state.SLIDING:
			check_roof = false
			$AnimationPlayer.play("Sliding")
			yield(get_tree().create_timer(.5),"timeout")
			check_roof = true
			#player_state = state.IDLE
		state.SLIDE_END:
			$AnimationPlayer.play("SlideEnd")
			yield($AnimationPlayer,"animation_finished")
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
	#This code fixes a large bug where the player will get stuck if the s;lide animation ends while under a low block. The code adds a ray cast which looks for a "roof". This means that teh slide animation had to be seperated into two animation, the slide and slide_end. So when the raycast sees roof, only the slide animation will play, but when it notices that there is not roof, the slide_end animation will play, and the player will go back to the idle state, so the player wont get stuck.
	if player_state == state.SLIDING and check_roof:
		if not $RoofChecker.is_colliding():
			print("safe")
			player_state = state.SLIDE_END
	if player_state != state.SLIDING and player_state != state.ATTACK:
		get_input()
		

		
		if velocity.x == 0:
			velocity.x = 0
			player_state = state.IDLE
		elif velocity.x != 0 and Input.is_action_just_pressed("ui_down"):
			player_state = state.SLIDING	
			velocity.x *= 2 #this code increases the velocity of the player when sliding. This is obvious inspiraion from other platformers and real life, becasue you do go faster when you are sliding
		elif velocity.x != 0:
			player_state = state.RUNNING
		
		if is_on_floor() and player_state != state.SLIDING:
			if Input.is_action_just_pressed("ui_up"):
				velocity.y = jump_speed
				player_state = state.JUMP
				
			if Input.is_action_just_pressed("attack"):
				player_state = state.ATTACK 
		
				
	if not is_on_floor():
		if velocity.y < 0:
			player_state = state.JUMP
		else:
			player_state = state.FALL
			
	
	
	if player_state == state.ATTACK:
		velocity.x = move_toward(velocity.x, 0, friction)	
	
	if Input.is_action_just_released("attack"):
		player_state = state.IDLE
		$Sprite/SwordAttack/CollisionShape2D.disabled = true # this makes sure the collision shape is disabled once attack is not pressed. I though of this myself, as it would be unfair (to the UI enemies) if the attack hit box was only abled, even if the player did not press the attack key. Also this disables when the sword is not in the "hitzone" like especially when player spins for the full attack.

	velocity.y += gravity * delta #this adds gravity
	velocity = move_and_slide(velocity, Vector2.UP)
	
	update_animation()
		
		

func _process(delta):
	
	
	if PlayerStats.health <=0:
		dead()
		PlayerStats.reset()

		
		
	


#func _on_Area2D_body_entered(body):
#	if body.is_in_group("Monkey"):
#		$AnimationPlayer.play("Dead")
#THE ABOVE CODE is something which i tried, and it failed. This is a clear showcase of trying different things!!


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
		PlayerStats.change_health(-20) #this decreases the health of the player when it comes in contacr with the enemy
		
	if body.is_in_group("DeathBar"):
		dead() #same as above
		
		#dead()
		
	
		


func _on_DeathZone_area_entered(area):
	
	if area.is_in_group("SpikeTrap"):
		dead()
	
	
	elif area.is_in_group("DeathBar"):
		dead()
			#these make the player completely lose their health which makes the level reset.
