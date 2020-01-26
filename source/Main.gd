extends Node

var esc_progress: float = 0.0
var is_quitting: bool = false
var os_name: String = ""

func _ready() -> void:
	os_name = OS.get_name()
	$Interface/Curtains/AnimationPlayer.play("reset")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("exit") and os_name != "HTML5":
		quit_start()
	if Input.is_action_just_released("exit") and os_name != "HTML5":
		quit_interrupt()

func quit_start():
	is_quitting = true
	# just in case was previously in quitting attempt
	$Interface/Curtains/AnimationPlayer.stop(false)
	# start dimming screen
	$Interface/Curtains/AnimationPlayer.play("fade_out", -1, 1.0, false) 
	yield($Interface/Curtains/AnimationPlayer, "animation_finished")
	if is_quitting == true: quit()

func quit_interrupt():
	is_quitting = false
	# stop fadeout animation but retain position
	$Interface/Curtains/AnimationPlayer.stop(false) 
	# revert to full brightness at 8x speed
	$Interface/Curtains/AnimationPlayer.play("fade_out", -1, -8.0, true) 
	yield($Interface/Curtains/AnimationPlayer, "animation_finished")
	# reset fadeout animation
	$Interface/Curtains/AnimationPlayer.stop(true) 
	$Interface/Curtains/AnimationPlayer.play("reset")
		
func quit():
	get_tree().quit()
#	following code resets game instead of quitting
#	var reset_scene: PackedScene = load("res://source/Main.tscn")
#	get_tree().change_scene_to(reset_scene)
