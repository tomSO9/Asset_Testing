extends Area2D
@onready var dummy_animation: AnimatedSprite2D = $"../dummy_animation"
@onready var hurt_effect: AnimatedSprite2D = $"../hurt_effect"
@onready var timer: Timer = $"../Timer"

func _ready() -> void:
	dummy_animation.play("idle")


func take_dmg():
	timer.start()
	#if dummy_animation.animation_finished:
		#dummy_animation.play("idle")
	



func _on_area_entered(area: Area2D) -> void:
	take_dmg()


func _on_timer_timeout() -> void:
	dummy_animation.play('hurt')
