extends CharacterBody2D
@export var speed = 200
var screenSize

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screenSize = get_viewport_rect().size
	add_to_group("player")
	
	# Check if SceneManager received a marker name from the door
	if SceneManager.spawnDestination != "":
		# Look for a Marker2D node with that exact name in the new room
		var marker = get_tree().current_scene.find_child(SceneManager.spawnDestination, true, false)
		if marker:
			global_position = marker.global_position
		else:
			print("Warning: Could not find marker named '", SceneManager.spawnDestination, "' in this room!")
		
		# Reset the variable so future room loads don't accidentally re-trigger it
		SceneManager.spawnDestination = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
		
func _physics_process(delta: float) -> void:
	var inputDirection = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	velocity = inputDirection * speed
	move_and_slide()
	
	if velocity.length() > 0:
		$AnimatedSprite2D.play()
		
		if velocity.x != 0:
			$AnimatedSprite2D.animation = "walk"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = velocity.x < 0
		elif velocity.y > 0:
			$AnimatedSprite2D.animation = "down"
		elif velocity.y < 0:
			$AnimatedSprite2D.animation = "up"
	else:
		$AnimatedSprite2D.stop()
	if Input.is_action_just_pressed("interact"):
		print("E PRESSED")
