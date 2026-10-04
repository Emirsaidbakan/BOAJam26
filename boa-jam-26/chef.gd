extends Area2D
var talkable = false
var setDay = 2

func _ready() -> void:
	if SceneManager.flags["day"] == setDay:
		talkable = true
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

func _unhandled_input(event: InputEvent) -> void:
	
