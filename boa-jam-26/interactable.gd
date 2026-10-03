extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_title: String = "start"

var player_in_range = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		$Label.show()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		$Label.hide()

func _unhandled_input(event: InputEvent) -> void:
	if player_in_range and event.is_action_pressed("interact"):
		interact()

func interact() -> void:
	DialogueManager.show_dialogue_balloon(dialogue_resource, dialogue_title)
