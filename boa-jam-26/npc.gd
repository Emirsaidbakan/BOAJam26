extends Area2D

var talkable = false
var setDay = 2

@export var dialogue = preload("res://Dialogue/Annie_Investigation.dialogue")
@export var dialogue_title: String = "start"
@onready var prompt = $E

var player_in_range = false

func _ready() -> void:
	if SceneManager.flags["day"] == setDay:
		talkable = true
	prompt.hide()
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

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
		DialogueManager.show_dialogue_balloon(dialogue, dialogue_title, [self])
	
