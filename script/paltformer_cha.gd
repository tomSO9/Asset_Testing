extends CharacterBody2D
## movement + gravity
## animation
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

var speed = 150
var friction = 20
var jump_power = -1000
var gravity = 100
var max_jump = 2
var current_jump = 0



func _ready() -> void:
	animation.play("idle")

func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("left","right")
	if direction:
		velocity.x = direction * speed
		animation.play("run")
		##flip
		animation.flip_h = direction <0
	else:
		velocity.x = velocity.move_toward(Vector2.ZERO, friction).x 
		animation.play("idle")
	jump()
	move_and_slide()
	
func jump():
	if Input.is_action_just_pressed("jump"):
		if current_jump < max_jump:
			velocity.y = jump_power
			animation.play("jump")
			current_jump = current_jump + 1
	else :
		velocity.y += gravity
		#animation.play("fall")
		if is_on_floor():
			current_jump = 0
		
