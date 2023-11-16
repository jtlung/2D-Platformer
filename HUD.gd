extends Control

func _ready():
	updateLives()
	updateScore()
	updateTime()
	
	
func updateLives():
	var lives = Global.lives
	var life = 1
	for heart in $Lives.get_children():
		if life <= lives:
			heart.show()
		else:
			heart.hide()
		life+=1
		
func updateTime():
	if not get_tree().paused:
		Global.updateTime(-1)
		$Time.text = "TIME: "+str(Global.time)

func updateScore():
	$Score.text = "Score: "+str(Global.score)

func _on_timer_timeout():
	updateTime()
