extends Node2D

var time = 4.5
var investigation_target = ""

func _ready() -> void:
	print("ANNIE WAKES UP AT 4.30 AM")
	
func next_loop() -> void:
	time -= 1.0
	print("NEXT LOOP: ", get_time_text())
	
func get_time_text() -> String:
	var hour = int(time)
	var minutes = 30
	return str(hour) + ":30 AM"

func wrong_guess() -> void:
	if time > 2.5:
		time -= 1.0
		print("WRONG GUESS")
		print("ANNIE WAKES UP AT", get_time_text())
	else:
		print("OOPS!")
		
func correct_guess() -> void:
	time = 1.5
	print("CORRECT GUESS")
	print("ANNIE WAKES UP AT", get_time_text())
	print("ANNIE SAVES HER HUSBAND")
