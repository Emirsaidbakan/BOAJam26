
extends Node
signal interacted(id: String)

var flags: Dictionary = {
	"cluesFound": 0,
	"deadmanFound": false,
	"inspectedPapers": false,
	"dirtFound": false,
	"inspectedSecretDoor": false
	
}

# Holds the name of the Marker2D node the player should spawn at
var spawnDestination: String = ""

func _ready() -> void:
	interacted.connect(_on_interacted)

func _on_interacted(id: String) -> void:
	match id:
		"deadmanFound":
			if not flags["deadmanFound"]:
				flags["deadmanFound"] = true
				print("Found the body")
		"papers":
			flags["inspectedPapers"] = true
		"dirt":
			flags["dirtFound"] = true
		"secretDoorFirstTime":
			flags["inspectedSecretDoor"] = true
		_:
			print("Unknown interactable: ", id)

func incrementCluesFound():
	flags["cluesFound"] += 1

func change_room(scene_path: String, spawn_id: String) -> void:
	spawnDestination = spawn_id
	get_tree().change_scene_to_file(scene_path)
