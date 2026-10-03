extends Node

# Holds the name of the Marker2D node the player should spawn at
var spawnDestination: String = ""

func change_room(scene_path: String, spawn_id: String) -> void:
	spawnDestination = spawn_id
	get_tree().change_scene_to_file(scene_path)
