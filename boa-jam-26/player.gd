extends CharacterBody2D
@export var speed = 400
var screenSize

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screenSize = get_viewport_rect().size


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
