extends Node2D
@export var dialogue_resource: DialogueResource
@export var dialogue_title: String = "start"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.show_dialogue_balloon(dialogue_resource, "save_john")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
