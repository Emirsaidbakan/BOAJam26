extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_title: String = "start"
@export var interactionId: String = ""
@export var one_time_only: bool = false

@onready var prompt = $Sprite2D 

var player_in_range = false

func _ready() -> void:
	prompt.hide()
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if one_time_only and SceneManager.flags.get(interactionId, false):
		return
	if body.is_in_group("player"):
		player_in_range = true
		prompt.show()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		prompt.hide()

func _unhandled_input(event: InputEvent) -> void:
	if not player_in_range or not event.is_action_pressed("interact"):
		return
	if one_time_only and SceneManager.flags.get(interactionId, false):
		return
	if player_in_range and event.is_action_pressed("interact"):
		SceneManager.interacted.emit(interactionId)
		DialogueManager.show_dialogue_balloon(dialogue_resource, dialogue_title)
