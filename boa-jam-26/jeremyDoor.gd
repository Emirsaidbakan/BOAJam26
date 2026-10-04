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
	
	if one_time_only and SceneManager.flags.get(interactionId, false):
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		prompt.show()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		prompt.hide()
		
func disable() -> void:
	hide()
	set_deferred("monitoring", false)
	set_process_unhandled_input(false)
	
func enable() -> void:
	show()
	prompt.hide()
	set_deferred("monitoring", true)
	set_process_unhandled_input(true)

func _unhandled_input(event: InputEvent) -> void:
	if player_in_range and event.is_action_pressed("interact"):
		get_tree().get_first_node_in_group("player").freeze()
		if SceneManager.flags["day"] == 3:
			DialogueManager.show_dialogue_balloon(dialogue_resource, "mom_fred_overheard", [self])
		else:
			DialogueManager.show_dialogue_balloon(dialogue_resource, "jeremy_door", [self])
		
func removeInteractable() -> void:
	queue_free()
