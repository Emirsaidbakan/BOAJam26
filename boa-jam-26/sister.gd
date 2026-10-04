extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_title: String = "start"
@export var interactionId: String = ""
@export var one_time_only: bool = true

var triggered = false

func _ready() -> void:
	if one_time_only and interactionId != "" and SceneManager.flags.get(interactionId, false):
		queue_free()
		return
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if triggered or not body.is_in_group("player"):
		return
	triggered = true
	body.freeze()
	DialogueManager.show_dialogue_balloon(dialogue_resource, dialogue_title, [self])
	await DialogueManager.dialogue_ended
	removeInteractable()

func disable() -> void:
	hide()
	$Character.hide()
	set_deferred("monitoring", false)
	set_process_unhandled_input(false)
	
func enable() -> void:
	show()
	$Character.show()
	set_deferred("monitoring", true)
	set_process_unhandled_input(true)

func removeInteractable() -> void:
	if one_time_only:
		if interactionId != "":
			SceneManager.markDone(interactionId)
		queue_free()
