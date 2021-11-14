extends Node

var health #making variables for all the important thigs i will need.
var health_max

var lives
var lives_max


func reset():
	health = health_max
	
	
func reset_everything():
	health = health_max
	lives = lives_max
	
	
	

func player_reset():
	
	health = 100
	change_lives(-1)
	get_tree().reload_current_scene()
	
	
func _ready():
	health = 100 #the player starts with 100 health
	health_max = 100 #if i had more time, i could have made max helath like 200 and added helath kits throughout the levels
	
	lives = 3 #the player starts with 3 lives
	lives_max = 3 #if i had more time, i could have made max lives like 5, and added hearts to collect throughout the game.
	

func change_health(amount):
	health += amount 
	health = clamp(health, 0, health_max) #this allows the health to change, which i used in the player code to change the health when coming in touch with enemies or the deathbar or spikes.
	
func get_health():
	return health
	
	
	
func change_lives(amount):
	lives += amount
	lives = clamp(lives, 0, lives_max)
	
	
func get_lives():
	return str(lives)
