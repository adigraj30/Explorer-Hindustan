extends KinematicBody2D

const GRAVITY = 10
const SPEED = 30
const FLOOR = Vector2(0, -1)

var velocity = Vector2(0,0)

var direction = 1

var is_dead = false 

export (int) var health := 30 #using export var so it can be easily be changed in the editor

func _ready():
	pass # Replace with function body.
	
#func dead():
#	is_dead = true
#	velocity = Vector2(0,0)
#	$AnimationPlayer.play("Dead")

func handle_hit(damage: int ):
	health -= damage
	if health <= 0:
		is_dead = true
		$AnimationPlayer.play("Dead")
		yield($AnimationPlayer,"animation_finished")
		queue_free()
	print("hit!!!, curent health " + str(health))
	
	


func _physics_process(delta):
	
	if is_dead == false :
	
		velocity.x = SPEED * direction
		$AnimationPlayer.play("Walk")
	
	
	
		if direction == 1:
			$Sprite.flip_h = false
		else:
			$Sprite.flip_h = true
		
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity, FLOOR)
	
	
	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x *= -1
		
		
	if $RayCast2D.is_colliding() == false: #if i want it to move off the ledge, remove this part of the code
		direction = direction * -1
		$RayCast2D.position.x *= -1
		
		
		
		
		
