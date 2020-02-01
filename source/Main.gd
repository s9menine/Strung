extends Node

var esc_progress: float = 0.0
var is_quitting: bool = false
var os_name: String = ""

func _ready() -> void:
	os_name = OS.get_name()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("exit") and os_name != "HTML5":
		quit_start()
	if Input.is_action_just_released("exit") and os_name != "HTML5":
		quit_interrupt()

func _on_Assistant_assistant_said(content: int) -> void:
	match content:
		0:
			$Interface/AnimationPlayer.play("fade_in_key_basics")
			$Computer.teach()
		1:
			$Interface/AnimationPlayer.play("fade_in_key_a")
		2:
			$Interface/AnimationPlayer.play("fade_in_key_s")
		3:
			$Interface/AnimationPlayer.play("fade_in_arts")

func quit_start():
	is_quitting = true
	# just in case was previously in quitting attempt
	$Interface/AnimationPlayer.stop(false)
	# start dimming screen
	$Interface/AnimationPlayer.play("fade_out", -1, 1.0, false) 
	yield($Interface/AnimationPlayer, "animation_finished")
	if is_quitting == true: quit()

func quit_interrupt():
	is_quitting = false
	# stop fadeout animation but retain position
	$Interface/AnimationPlayer.stop(false) 
	# revert to full brightness at 8x speed
	$Interface/AnimationPlayer.play("fade_out", -1, -8.0, true) 
	yield($Interface/AnimationPlayer, "animation_finished")
	# reset fadeout animation
	$Interface/AnimationPlayer.stop(true) 
	$Interface/AnimationPlayer.play("reset")

func quit():
	get_tree().quit()
#	following code resets game instead of quitting
#	var reset_scene: PackedScene = load("res://source/Main.tscn")
#	get_tree().change_scene_to(reset_scene)
