extends Node

var in_dialogue := false

func _ready() -> void:
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_dialogue_started(_resource = null) -> void:
	in_dialogue = true

func _on_dialogue_ended(_resource = null) -> void:
	in_dialogue = false

func can_move() -> bool:
	return not in_dialogue and not SceneManager.isChangingRoom
