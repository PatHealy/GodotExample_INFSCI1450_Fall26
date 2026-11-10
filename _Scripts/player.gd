extends CharacterBody2D

@export var speed = 300.0
@export var jump_velocity = -400.0
@export var acceleration = 100

@export var projectile : PackedScene

var hasReset: bool = false

func _ready() -> void:
	$AnimatedSprite2D.play()

func restart_level() -> void:
	if hasReset:
		return
	hasReset=true
	get_tree().reload_current_scene()

func launch_projectile() -> void:
	var new_proj:Node = projectile.instantiate()
	new_proj.position = position
	if $AnimatedSprite2D.flip_h:
		#we are moving left
		new_proj.position.x -= 70
		new_proj.speed = -new_proj.speed
	else:
		#we are moving right
		new_proj.position.x += 70
	get_parent().add_child(new_proj)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move_right"):
		velocity.x = move_toward(velocity.x, speed, delta*acceleration)
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = false
	elif Input.is_action_pressed("move_left"):
		velocity.x = move_toward(velocity.x, -speed, delta*acceleration)
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = true
	else:
		velocity.x = 0
		$AnimatedSprite2D.animation = "idle"
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_velocity
	if not is_on_floor():
		velocity += get_gravity() * delta
		$AnimatedSprite2D.animation = "jump"
	
	if Input.is_action_just_pressed("fire"):
		launch_projectile()
		
	if position.y > 800:
		restart_level()
		
	var number_of_collisions = get_slide_collision_count()
	for i in number_of_collisions:
		var collision_info = get_slide_collision(i)
		var collider = collision_info.get_collider()
		if collider.is_in_group("Hazard"):
			restart_level()
	
	move_and_slide()
