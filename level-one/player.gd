extends CharacterBody2D

@export var acceleration = 1
@export var friction = 1
@onready var sprite = $Sprite2D
var speedX = 0
var speedY = 0
var direction = 0

const FORWARD_KEY = "forward"
const REVERSE_KEY = "reverse"
const TURN_LEFT_KEY = "turn-left"
const TURN_RIGHT_KEY = "turn-right"
const TURN_SLIGHT_LEFT_KEY = "turn-slight-left"
const TURN_SLIGHT_RIGHT_KEY = "turn-slight-right"
const FLIP_KEY = "flip"

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed(TURN_LEFT_KEY):
		direction -= 90
	elif Input.is_action_just_pressed(TURN_RIGHT_KEY):
		direction += 90
	elif Input.is_action_just_pressed(TURN_SLIGHT_RIGHT_KEY):
		direction += 45
	elif Input.is_action_just_pressed(TURN_SLIGHT_LEFT_KEY):
		direction -= 45
	elif Input.is_action_just_pressed(FLIP_KEY):
		direction += 180
	
	if direction <= -180:
		direction += 360
	elif direction > 180:
		direction -= 360
	
	match direction:
		0:
			sprite.frame = 0
		45:
			sprite.frame = 1
		90:
			sprite.frame = 2
		135: 
			sprite.frame = 3
		180:
			sprite.frame = 4
		-135:
			sprite.frame = 5
		-90:
			sprite.frame = 6
		-45:
			sprite.frame = 7
	
	if Input.is_action_pressed(FORWARD_KEY):
		if direction == 0 or direction == 180:
			speedY = speedY - (acceleration * friction) if direction == 0 else speedY + (acceleration * friction)
			if speedX > 0:
				speedX -= friction
				if speedX < 0:
					speedX = 0
			elif speedX < 0:
				speedX += friction
				if speedX > 0:
					speedX = 0
					
		elif direction == -90 or direction == 90:
			speedX = speedX - (acceleration * friction) if direction == -90 else speedX + (acceleration * friction)
			if speedY > 0:
				speedY -= friction
				if speedY < 0:
					speedY = 0
			elif speedY < 0:
				speedY += friction
				if speedY > 0:
					speedY = 0
	else:
		if speedX > 0:
			speedX -= friction
		elif speedX < 0:
			speedX += friction
		if speedY > 0:
			speedY -= friction
		elif speedY < 0:
			speedY += friction
		
	velocity = Vector2(speedX, speedY) * Vector2(1,0.5)
	
	move_and_slide()
	
