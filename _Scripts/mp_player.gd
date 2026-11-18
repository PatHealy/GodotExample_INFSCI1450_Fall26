extends Sprite2D

@export var player_id:int=-1
var moving_right:bool
var moving_left:bool
@export var speed:float = 100

func set_player_id(id:int):
	player_id = id

func _input(event: InputEvent) -> void:
	if event.device != player_id:
		return
	if event.is_action_pressed("move_right"):
		moving_right = true
	if event.is_action_released("move_right"):
		moving_right = false
	if event.is_action_pressed("move_left"):
		moving_left = true
	if event.is_action_released("move_left"):
		moving_left = false

func _process(delta: float) -> void:
	if moving_left:
		position.x -= speed*delta
	if moving_right:
		position.x += speed*delta
