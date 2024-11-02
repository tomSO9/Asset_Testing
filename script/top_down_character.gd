extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast: RayCast2D = $RayCast2D
@onready var hit_collision: CollisionShape2D = $RayCast2D/hit_box/CollisionShape2D


var speed = 200
var push_speed = 20
var friction = 20

var dummy

var current_animation = "idle"
var is_attacking = false  # Fixed spelling here

func _ready() -> void:
	animated_sprite_2d.play("idle")
	hit_collision.disabled = true

func _physics_process(delta ):
	dummy = get_tree().get_nodes_in_group("dummy")
	if Input.is_action_just_pressed("atk") and not is_attacking:
		atk()

	var all_input = Input.get_vector("left", "right", "up", "down")

	# Only move if not attacking
	if not is_attacking:
		if all_input.length() > 0:
			velocity = velocity.move_toward(speed * all_input, push_speed)
			
			# Set animation to "walk"
			if current_animation != "walk":
				current_animation = "walk"
				animated_sprite_2d.play("walk")

			# Flip animation based on direction
			if all_input.x > 0:
				animated_sprite_2d.flip_h = false
				ray_cast.scale.x = 1
			elif all_input.x < 0:
				animated_sprite_2d.flip_h = true
				ray_cast.scale.x = -1
		else:
			# No input, set to idle
			velocity = velocity.move_toward(Vector2.ZERO, friction)
			if current_animation != "idle":
				current_animation = "idle"
				animated_sprite_2d.play("idle")

	move_and_slide()

func atk():
	velocity = Vector2.ZERO
	is_attacking = true
	animated_sprite_2d.play("atk")
	if animated_sprite_2d.animation_finished:
		if is_attacking == true:
			hit_collision.disabled = false


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "atk":
		is_attacking = false
		if is_attacking == false:
			hit_collision.disabled = true
		# Return to walk or idle based on movement
		if velocity.length() > 0:
			current_animation = "walk"
			animated_sprite_2d.play("walk")
		else:
			current_animation = "idle"
			animated_sprite_2d.play("idle")


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.has_method("take_dmg"):
		area.take_dmg()
		print("dummy take dmg")
