extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not SceneManager.flags["deadmanFound"]:
		$MotherRoom.disable()
		$SisterRoom.disable()
	if not SceneManager.flags["deadmanFound"] or SceneManager.flags["day"] == 3:
		$Driver.disable()
	if not SceneManager.flags["day"] == 3:
		$Jeremy.disable()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
