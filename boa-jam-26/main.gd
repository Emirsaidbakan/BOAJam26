extends Node2D

var time = 4.5
var inspected_papers = false

func _ready() -> void:
	print("ANNIE WAKES UP AT 4:30 AM")


func get_time_text() -> String:
	var hour = int(time)
	return str(hour) + ":30 AM"


func wrong_guess() -> void:
	if time > 2.5:
		time -= 1.0
		print("WRONG GUESS")
		print("ANNIE WAKES UP AT ", get_time_text())
	else:
		print("FINAL WRONG GUESS")


func correct_guess() -> void:
	time = 1.5
	print("CORRECT GUESS")
	print("ANNIE WAKES UP AT ", get_time_text())
	
func inspect_papers() -> void:
	inspected_papers = true
	print("PAPERS INSPECTED")
