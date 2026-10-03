extends Area2D

@export_file("*.tscn") var target_scene: String

func _ready() -> void:
	# Automatically connects the body_entered signal when the scene starts
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if target_scene != "":
			get_tree().change_scene_to_file(target_scene)
		else:
			print("Warning: Target scene not set on this door!")
