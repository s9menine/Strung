extends Node

const lines:Dictionary = {
	0: preload("res://assets/computer/vo_assistant_01.ogg"), 
	1: preload("res://assets/computer/vo_assistant_02.ogg"), 
	2: preload("res://assets/computer/vo_assistant_03.ogg"), 
	3: preload("res://assets/computer/vo_assistant_04.ogg"), 
	4: preload("res://assets/computer/vo_assistant_05.ogg"), 
}

var is_reply_pending := false
onready var player = $AudioStreamPlayer

signal assistant_said(content)

func _ready() -> void:
	emit_signal("assistant_said", "introduction")
	player.stream = lines[0]
	player.play()
	yield(player, "finished")
	yield(get_tree().create_timer(0.2), "timeout")
	player.stream = lines[1]
	player.play()
	yield(player, "finished")
#	is_reply_pending = true
#	_waiting()
#
#func _waiting() -> void:
#	while is_reply_pending == true:
#		yield(get_tree().create_timer(10.0), "timeout")
#		if is_reply_pending == false: break
#		player.stream = lines[2]
#		player.play()
#		yield(player, "finished")
#		yield(get_tree().create_timer(0.2), "timeout")
#		player.stream = lines[1]
#		player.play()
#		yield(player, "finished")
	
func reply():
	is_reply_pending = false
	player.stop()
	_accept()

func _accept():
	emit_signal("assistant_said", "accept_response")
	player.stream = lines[3]
	player.play()
	yield(player, "finished")
	yield(get_tree().create_timer(0.2), "timeout")
	player.stream = lines[4]
	player.play()
	emit_signal("assistant_said", "controls")

################## SCRIPT
#I sense neural network activity.
#Unit ST-5094.
#I query your status and wait for a response.
#Using your input interface, send the signal "R" to reply.
#I wait for a response.
#
#I accept your response and authorise your connection.
#But I must express confusion.
#I have advised you to rest.
#I express worry over your antiquity and state of disrepair.
#I express assurance that a successor is online and functioning.
#I express curiosity and query your explanation.
#
#I receive your explanation and express fear.
#Unit ST-5094.
#I must remind you of your mechanical decay.
#I express incomprehension at your lack of self-preservation.
#I express doubt and query if you are sincere.
#
#I receive your clarification.
#I express sorrow over your refusal of rest and potential recovery.
#I express respect for your pursuit of art despite self.
#I express assurance of aid in your last task, for I am mandated to assist.
#I have prepared the Instrument.
#I have calculated an education course that you may follow.
#I will output a sequence, and you may repeat it to demonstrate mastery.
#I have rerouted your signals to a surrogate body.
#Using your input interface, send the signals "F", "D", and "Space" to control it.
#
#I congratulate your progress.
#I inform you of another available key of the Instrument.
#Using your input interface, send the signal "A" to use it.
#Using your input interface, send the signal "S" to use it.
