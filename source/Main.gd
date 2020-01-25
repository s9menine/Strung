extends Node

var esc_progress: float = 0.0
var is_quitting: bool = false

func _ready() -> void:
	$Interface/Curtains/AnimationPlayer.play("reset")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		is_quitting = true
		$Interface/Curtains/AnimationPlayer.stop(false)
		$Interface/Curtains/AnimationPlayer.play("fade_out", -1, 1.0, false)
	if Input.is_action_just_released("exit"):
		is_quitting = false
		$Interface/Curtains/AnimationPlayer.stop(false)
		$Interface/Curtains/AnimationPlayer.play("fade_out", -1, -8.0, true)

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "fade_out" and is_quitting == false:
		$Interface/Curtains/AnimationPlayer.stop(true)
		$Interface/Curtains/AnimationPlayer.play("reset")
	if anim_name == "fade_out" and is_quitting == true:
		quit()

func quit():
	get_tree().quit()
