extends Area2D

@export_file("*.tscn") var target_scene: String
@export var spawnDestination: String

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if target_scene != "":
			SceneManager.change_room(target_scene, spawnDestination)
		else:
			print("Warning: Target scene not set on this door!")
