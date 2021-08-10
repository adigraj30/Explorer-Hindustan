extends Area2D

export (int) var damage:= 10




func _ready():
	pass 


func _on_SwordAttack_body_entered(body):
	if body.has_method("handle_hit"):
		body.handle_hit(damage)
