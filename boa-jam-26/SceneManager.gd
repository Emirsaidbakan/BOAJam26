extends Node

var flags: Dictionary = {
	"cluesFound": 0,
	"deadmanFound": false,
	"inspectedPapers": false
	
}

# Holds the name of the Marker2D node the player should spawn at
var spawnDestination: String = ""

func incrementCluesFound():
	flags["cluesFound"] += 1

func change_room(scene_path: String, spawn_id: String) -> void:
	spawnDestination = spawn_id
	get_tree().change_scene_to_file(scene_path)
