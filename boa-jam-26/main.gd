extends Node2D

var time = 4.5
var inspected_papers = false

var clue_count = 0
var loop_number = 1
var dialogueFile = preload("res://Dialogue/Annie_investigation.dialogue")


func _ready() -> void:
	if SceneManager.flags["day"] == 1:
		DialogueManager.show_dialogue_balloon(dialogueFile, "begin")
	elif SceneManager.flags["day"] == 2:
		DialogueManager.show_dialogue_balloon(dialogueFile, "dayTwo")
	elif SceneManager.flags["day"] == 3: 
		DialogueManager.show_dialogue_balloon(dialogueFile, "dayTwo")

func get_time_text() -> String:
	var hour = int(time)
	return str(hour) + ":30 AM"


func inspect_papers() -> void:
	inspected_papers = true
	print("PAPERS INSPECTED")


func investigate_clue() -> void:
	clue_count += 1
	print("CLUES INVESTIGATED: ", clue_count)

	if clue_count >= 3:
		start_sleep()
		
func start_sleep() -> void:
	print("9:00 PM")
	print("ANNIE GOES TO SLEEP")
	
	await get_tree().create_timer(2.0).timeout
	
	show_suspect_choice()

func show_suspect_choice() -> void:
	print("WHO DOES ANNIE SUSPECT?")

func wrong_guess() -> void:
	loop_number += 1
	clue_count = 0
	if time > 2.5:
		time -= 1.0
		print("WRONG GUESS")
		print("ANNIE WAKES UP AT ", get_time_text())
	else:
		time = 1.5
		print("FINAL LOOP")
		print("ANNIE WAKES UP AT 1:30 AM")
		# later: trigger final death sequence

func correct_guess() -> void:
	time = 1.5
	clue_count = 0
	print("CORRECT GUESS")
	print("ANNIE WAKES UP AT 1:30 AM")
	# later: trigger save-John sequence
