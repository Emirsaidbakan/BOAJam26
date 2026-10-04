extends Node2D

@onready var dialogue = preload("res://Dialogue/Annie_Investigation.dialogue")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.show_dialogue_balloon(dialogue, "suspect_choice")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
