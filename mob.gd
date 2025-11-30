extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names()) # Array with all 3 types of animation
	$AnimatedSprite2D.animation = mob_types.pick_random()	# Choose randomly 
	$AnimatedSprite2D.play() # Play the annimation
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() # Deletes, the node at the end of the frame.
