extends Node2D

var deadmanDialogue = preload("res://Dialogue/Annie_investigation.dialogue")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not SceneManager.flags["deadmanFound"]:
		SceneManager.flags["deadmanFound"] = true
		DialogueManager.show_dialogue_balloon(deadmanDialogue, "bodyFound")
		get_tree().get_first_node_in_group("player").freeze()
		
	if not SceneManager.flags["dirtFound"]:
		$SecretDoor.hide()
		$SecretDoor.set_deferred("monitoring", false)
		$SecretDoor.set_process_unhandled_input(false)
	else:
		SceneManager.openSecretPassage()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
