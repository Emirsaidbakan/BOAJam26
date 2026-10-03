extends Node2D

var deadmanDialogue = preload("res://Dialogue/Annie_investigation.dialogue")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not SceneManager.flags["deadmanFound"]:
		SceneManager.flags["deadmanFound"] = true
		DialogueManager.show_dialogue_balloon(deadmanDialogue, "bodyFound")
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
