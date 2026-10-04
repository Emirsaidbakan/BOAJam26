extends Node2D
@export var dialogue_resource: DialogueResource

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if SceneManager.flags["badEnding"]:
		DialogueManager.show_dialogue_balloon(dialogue_resource, "bad_cutscene")
	elif SceneManager.flags["goodEnding"]:
		DialogueManager.show_dialogue_balloon(dialogue_resource, "good_cutscene")
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
