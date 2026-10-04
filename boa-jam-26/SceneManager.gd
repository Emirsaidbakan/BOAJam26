
extends Node
signal interacted(id: String)
var mainDialogue = preload("res://Dialogue/Annie_investigation.dialogue")
var bookshelfSound: AudioStreamPlayer
var knockSound: AudioStreamPlayer
var deathSound: AudioStreamPlayer
var flags: Dictionary = {
	"gameStart": true,
	"cluesFound": 0,
	"sleep": false,
	"deadmanFound": false,
	"inspectedPapers": false,
	"dirtFound": false,
	"secretDoorFirstTime": true,
	"day": 1,
	"talkedWithButler": false,
	"talkedWithDriver": false,
	"talkedWithMother": false,
	"talkedWithCrystal": false,
	"enteredPassage": false,
	"diaryFound": false,
	"momFredOverheard": false,
	"jeremyLeaving": false,
	"crystalPassage": false,
	"badEnding": false,
	"goodEnding": false,
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
	
	deathSound = AudioStreamPlayer.new()
	deathSound.stream = load("res://death-by-bludgeoning-et-all.wav")
	add_child(deathSound)
	
	bookshelfSound = AudioStreamPlayer.new()
	bookshelfSound.stream = load("res://audio/sfx/bookshelf_open.wav")
	add_child(bookshelfSound)
	
	knockSound = AudioStreamPlayer.new()
	knockSound.stream = load("res://door-knock-et-all.wav")
	add_child(knockSound)

	interacted.connect(_on_interacted)

func _on_interacted(id: String) -> void:
	match id:
		"deadmanFound":
			if not flags["deadmanFound"]:
				flags["deadmanFound"] = true
				print("Found the body")
		"inspectedPapers":
			if not flags["inspectedPapers"]:
				flags["inspectedPapers"] = true
		"dirtFound":
			flags["dirtFound"] = true
		"secretDoorFirstTime":
			flags["secretDoorFirstTime"] = false
		"talkedWithButler": 
			flags["talkedWithButler"] = true
		"talkedWithDriver": 
			flags["talkedWithDriver"] = true
		"talkedWithMother": 
			flags["talkedWithMother"] = true
		_:
			print("Unknown interactable: ", id)
			
			
func markDone(id: String) -> void:
	flags[id] = true
	
func setDirtFound() -> void:
	if not flags["dirtFound"]:
		flags["dirtFound"] = true
		bookshelfSound.play()
		openSecretPassage()
		
func playDeathSound() -> void:
	deathSound.play()

func showSuspects() -> void:
	var suspects: Node2D = get_tree().current_scene.find_child("Suspects")
	suspects.visible = true

func openSecretPassage() -> void:
	var DeskLayer: TileMapLayer = get_tree().current_scene.find_child("DeskLayer")
	var secretDoorLayer: TileMapLayer = get_tree().current_scene.find_child("SecretDoorLayer")
	var secretDoor: Area2D = get_tree().current_scene.find_child("SecretDoor")
	
	if DeskLayer:
		DeskLayer.global_position.x -= 20

	if secretDoorLayer:
		secretDoorLayer.show()

	if secretDoor:
		secretDoor.enable()
		
	else:
		print("WARNING: SecretDoor not found in current scene.")
	
func incrementCluesFound():
	flags["cluesFound"] += 1
	print("Clues found: ", flags["cluesFound"])

	if flags["cluesFound"] >= 3:
		flags["cluesFound"] = 0
		endDay()
			
func endDay() -> void:
	flags["day"] += 1
	await DialogueManager.dialogue_ended
	sleep()
	
func sleep() -> void:
	DialogueManager.show_dialogue_balloon(mainDialogue, "sleep")
	await DialogueManager.dialogue_ended
	change_room("res://choice.tscn", "ChoiceSpawn")
	
func wrongGuess() -> void:
	if flags["day"] == 4:
		SceneManager.flags["badEnding"] = true
		change_room("res://cutscene.tscn", "CutsceneMarker")
	else:
		change_room("res://main.tscn", "DayEnd")
		

# UI scenes		
func goodEnding() -> void:
	change_room("res://GoodEnd.tscn","GoodEndingSpawn")
	
func badEnding() -> void:
	change_room("res://BadEnd.tscn","BadEndingSpawn")

func correctGuess() -> void:
	SceneManager.flags["goodEnding"] = true
	change_room("res://cutscene.tscn", "CutsceneMarker")

func show_scene(path: String) -> void:
	var layer = CanvasLayer.new()
	layer.layer = 110  # above the dialogue balloon (100), below your fade (120)
	add_child(layer)

	var content = load(path).instantiate()
	layer.add_child(content)

	# invisible full-screen button on top, just to catch the click
	var catcher = Button.new()
	catcher.flat = true
	catcher.set_anchors_preset(Control.PRESET_FULL_RECT)
	catcher.focus_mode = Control.FOCUS_NONE
	layer.add_child(catcher)

	await catcher.pressed
	layer.queue_free()
	
func playKnockSound() -> void:
	knockSound.play()
	
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
