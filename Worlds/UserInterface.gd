extends Control


func _ready():
	
	$CanvasLayer/HealthBar.max_value = PlayerStats.health_max
	

func _process(delta):
	$CanvasLayer/HealthBar.value = PlayerStats.get_health()
	$CanvasLayer/LifeCounter.text = PlayerStats.get_lives()


func hidemenu():
	hide()
	
func showmenu():
	show()

