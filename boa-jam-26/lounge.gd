extends Node2D


func _ready() -> void:
	if not SceneManager.flags["deadmanFound"]:
		$Chef.disable()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
