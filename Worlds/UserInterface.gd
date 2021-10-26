extends Control


func _ready():
	$HealthBar.max_value = PlayerStats.health_max
	

func _process(delta):
	$HealthBar.value = PlayerStats.get_health()
	$LifeCounter.text = PlayerStats.get_lives()
