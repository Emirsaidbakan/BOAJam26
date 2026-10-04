extends Node2D
@export var dialogue = preload("res://Dialogue/Annie_investigation.dialogue")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sister.disable()
	
	if SceneManager.flags["secretDoorFirstTime"]:
		SceneManager.flags["secretDoorFirstTime"] = false
		DialogueManager.show_dialogue_balloon(dialogue, "passage")
	if SceneManager.flags["day"] == 3:
		$Sister.enable();
		$Diary.disable();
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
