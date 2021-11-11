extends CanvasLayer


func _ready():
	$UserInterface/HealthBar.max_value = PlayerStats.health_max
	

func _process(delta):
	$UserInterface/HealthBar.value = PlayerStats.get_health()
	$UserInterface/LifeCounter.text = PlayerStats.get_lives()


func hidemenu():
	$UserInterface.hide()
	
func showmenu():
	$UserInterface.show()

