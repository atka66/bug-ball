extends RigidBody2D

const FLOOR_POSITION = 350
var thrust = Vector2.ZERO

var ctrl = {}

func is_on_floor():
	return $Pos1.global_position.y > FLOOR_POSITION \
		or $Pos2.global_position.y > FLOOR_POSITION \
		or $Pos3.global_position.y > FLOOR_POSITION \
		or $Pos4.global_position.y > FLOOR_POSITION \
		or $Pos5.global_position.y > FLOOR_POSITION

func isBluePlayer():
	return 'player_blue' in get_groups()

func _ready():
	if !isBluePlayer():
		ctrl = {'right': KEY_RIGHT, 'left': KEY_LEFT, 'up': KEY_UP}
		$Sprite.set_frame(0)
	else :
		ctrl = {'right': KEY_D, 'left': KEY_A, 'up': KEY_W}
		$Sprite.set_frame(1)

func _process(delta):
	thrust = Vector2.ZERO
	if abs(linear_velocity.x) < 300:
		if Input.is_key_pressed(ctrl['right']):
			thrust = Vector2(20, -8)
		if Input.is_key_pressed(ctrl['left']):
			thrust = Vector2(-20, -8)
	if is_on_floor():
		if Input.is_key_pressed(ctrl['up']):
			thrust = Vector2(0, -120)

func _physics_process(delta):
	apply_central_impulse(thrust)
