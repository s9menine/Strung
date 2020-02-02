extends Node

signal assistant_said(content)
# tells Main to show interface buttons
# tells Computer to progress teaching

const lines:Dictionary = {
	"introduction": preload("res://assets/computer/vo_assistant_01.ogg"), 
	"request_response": preload("res://assets/computer/vo_assistant_02.ogg"), 
	"waiting": preload("res://assets/computer/vo_assistant_03.ogg"), 
	"accept_response": preload("res://assets/computer/vo_assistant_04.ogg"), 
	"controls": preload("res://assets/computer/vo_assistant_05.ogg"), 
	"progress_multikey": preload("res://assets/computer/vo_assistant_06.ogg"), 
	"progress_halfway": preload("res://assets/computer/vo_assistant_07.ogg"), 
	"progress_challenge": preload("res://assets/computer/vo_assistant_08.ogg"), 
	"progress_graduate": preload("res://assets/computer/vo_assistant_09.ogg"), 
}

onready var player = $AudioStreamPlayer
var is_reply_pending := true
var has_emitted_request := false


func _ready() -> void:
	emit_signal("assistant_said", "introduction")
	yield(get_tree().create_timer(1.0), "timeout")
	player.stream = lines["introduction"]
	player.play()
	yield(player, "finished")
	yield(get_tree().create_timer(0.2), "timeout")
	if is_reply_pending: # in case player skips
		player.stream = lines["request_response"]
		player.play()
		emit_signal("assistant_said", "request_response")
		has_emitted_request = true
		yield(player, "finished")
		_waiting()


func _waiting() -> void:
	while is_reply_pending:
		if is_reply_pending == false: return
		yield(get_tree().create_timer(10.0), "timeout")
		if is_reply_pending == false: return
		player.stream = lines["waiting"]
		player.play()
		yield(player, "finished")
		if is_reply_pending == false: return
		yield(get_tree().create_timer(0.2), "timeout")
		player.stream = lines["request_response"]
		player.play()
		yield(player, "finished")


func reply():
	is_reply_pending = false
	print(is_reply_pending)
	player.stop()
	_accept()


func _accept():
	emit_signal("assistant_said", "accept_response")
	player.stream = lines["accept_response"]
	player.play()
	yield(player, "finished")
	emit_signal("assistant_said", "teaching")


func controls():
	if not has_emitted_request:
		emit_signal("assistant_said", "request_response")
	emit_signal("assistant_said", "controls")
	yield(get_tree().create_timer(0.2), "timeout")
	player.stream = lines["controls"]
	player.play()


func progress(stage: String) -> void:
	yield(get_tree().create_timer(0.2), "timeout")
	print("Assistant says: ", stage)
	match stage:
		"progress_multikey":
			player.stream = lines["progress_multikey"]
			player.play()
			yield(player, "finished")
			emit_signal("assistant_said", "progress")
		"progress_halfway":
			player.stream = lines["progress_halfway"]
			player.play()
			yield(player, "finished")
			emit_signal("assistant_said", "progress")
		"progress_challenge":
			player.stream = lines["progress_challenge"]
			player.play()
			yield(player, "finished")
			emit_signal("assistant_said", "progress")
		"progress_graduate":
			player.stream = lines["progress_graduate"]
			player.play()
			yield(player, "finished")
			emit_signal("assistant_said", "progress")


func arts():
	emit_signal("assistant_said", "arts")


func skip():
	is_reply_pending = false
	player.stop()
	queue_free()


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
#
#
#
#
#I commend your understanding of the basics.
#I advise you to try holding down multiple keys to sound the tones required for the following lessons.
#
#I announce that you are now halfway through this course.
#I admit that it is the easier half, in jest.
#I remind you that this does not invalidate your journey.
#
#I congratulate you for progressing thus far.
#I invite you to savour your newfound skills.
#I have prepared for you a final challenge.
#I wish you good luck.
#
#I am in awe over your mastery of the Instrument.
#Well done.
#I have nothing more to teach you.
#Thank you.
