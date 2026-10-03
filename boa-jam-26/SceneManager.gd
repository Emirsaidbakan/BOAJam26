
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

# How long the fade to black (and back) takes, in seconds
var fadeTime: float = 0.25
# Stops a second door from triggering while we are already changing rooms
var isChangingRoom: bool = false

var fadeRect: ColorRect
var doorSound: AudioStreamPlayer

func _ready() -> void:
	# A CanvasLayer draws on top of the whole game.
	# SceneManager is global, so this black screen survives room changes.
	var layer = CanvasLayer.new()
	layer.layer = 120 # above the dialogue balloon (which is on layer 100)
	add_child(layer)

	fadeRect = ColorRect.new()
	fadeRect.color = Color(0, 0, 0, 0) # black, but fully transparent for now
	fadeRect.set_anchors_preset(Control.PRESET_FULL_RECT) # cover the whole screen
	fadeRect.mouse_filter = Control.MOUSE_FILTER_IGNORE # don't block menu buttons
	layer.add_child(fadeRect)

	doorSound = AudioStreamPlayer.new()
	if ResourceLoader.exists("res://audio/sfx/room_transition.wav"):
		doorSound.stream = load("res://audio/sfx/room_transition.wav")
	add_child(doorSound)

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
	if isChangingRoom:
		return
	isChangingRoom = true
	doorSound.play()

	# Fade to black
	var tween = create_tween()
	tween.tween_property(fadeRect, "color:a", 1.0, fadeTime)
	await tween.finished

	# Change the room while the screen is black
	spawnDestination = spawn_id
	get_tree().change_scene_to_file(scene_path)
	await get_tree().process_frame # wait one frame so the new room is loaded

	# Fade back in
	tween = create_tween()
	tween.tween_property(fadeRect, "color:a", 0.0, fadeTime)
	await tween.finished

	isChangingRoom = false
