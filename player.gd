extends Area2D
signal hit	# For collision purpose

# Variable definition
@export var speed = 400	# speed in px/s, the @export make the value setable in the Inspector
var screen_size 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size # Getting the screen size
	hide()	# Hide the player at the start

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	## Detection of Inputs and processing
	var velocity = Vector2.ZERO # Player's movement vector (0.0) by default.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	## Animations
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed # Nomalised the speed to avoid fast diagonal movement.
		$AnimatedSprite2D.play() # Equivalent to get_node("AnimatedSprite2D").play()
	else:
		$AnimatedSprite2D.stop()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)	# Prevent from leaving the screen
	
	$AnimatedSprite2D.flip_v = velocity.y > 0
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_body_entered(_body):
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
	
	
