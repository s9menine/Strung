extends Node

export(float, 0.0, 3.0) var time: float
export(int, -1, 30, 1) var current_lesson := 0
var pitches_index := 0
var rhythms_index := 1
var target_pitches := []
var target_rhythms := []
var player_pitches := []
var is_player_playing := false
var is_computer_busy := false

signal acknowledged
signal teaching_started
signal teaching_finished

func _ready() -> void:
	pitches_index = current_lesson * 2
	rhythms_index = current_lesson * 2 + 1
#	advance()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		repeat()
	if event.is_action_pressed("skip"): 
		is_computer_busy == true
		$AudioStreamPlayer.stream = $Course.ACKNOWLEDGE
		$AudioStreamPlayer.play()
		advance()

# increments current_lesson and indicies
func advance():
	player_pitches.clear()
	current_lesson += 1
	print("Now moving to lesson: " + str(current_lesson))
	pitches_index = current_lesson * 2
	rhythms_index = current_lesson * 2 + 1
	yield(get_tree().create_timer(rhythm2secs(5)), "timeout")
	if is_computer_busy == false:
		teach()
	else:
		is_computer_busy == false

# fetches note sequences via indicies then plays the notes
func teach():
	if is_computer_busy == true: return
#	print("Current indicies are: " + str(pitches_index) + ", " + str(rhythms_index))
	if pitches_index >= $Course.LESSONS.size():
		graduate()
		return
	emit_signal("teaching_started")
	target_pitches = $Course.LESSONS[pitches_index]
	target_rhythms = $Course.LESSONS[rhythms_index]
	print("Current teacher sequence is: " + str(target_pitches))
	var i := 0
	while i <= target_pitches.size() - 1:
		var _note_pitch = target_pitches[i]
		$Instrument.play_note_atk(_note_pitch, "Computer")
		$Instrument.play_note_sus(_note_pitch, "Computer")
		var _rhythm:float = rhythm2secs(target_rhythms[i])
		yield(get_tree().create_timer(_rhythm),"timeout")
		$Instrument.stop_note_sus("Computer")
		yield(get_tree().create_timer(rhythm2secs(1)),"timeout")
		i += 1
	emit_signal("teaching_finished")

func _on_Player_note_played(note_pitch):
	is_player_playing = true
	# count too short taps as mistakes
	yield(get_tree().create_timer(rhythm2secs(0)),"timeout")
	if is_player_playing == false: 
		player_pitches.clear() 
		return
	else:
		player_pitches.append(note_pitch)
		player_pitches.invert()
		player_pitches.resize(target_pitches.size())
		player_pitches.invert()
		print("Current player sequence is: " + str(player_pitches))
	if player_pitches == target_pitches and player_pitches != [] and is_computer_busy == false:
		yield(get_parent().get_node("Player"), "note_released")
		acknowledge()
		advance()

func _on_Player_note_released() -> void:
	is_player_playing = false
#	yield(get_tree().create_timer(rhythm2secs(2)), "timeout")

func acknowledge():
	print("Acknowledged!")
	emit_signal("acknowledged")
	yield(get_tree().create_timer(rhythm2secs(2)), "timeout")
	$AudioStreamPlayer.stream = $Course.ACKNOWLEDGE
	$AudioStreamPlayer.play()

func graduate():
	print("Graduated!")
	target_pitches = [99] # an impossible note to play
	$AudioStreamPlayer.stream = $Course.GRADUATE
	$AudioStreamPlayer.play()
	
func repeat():
	player_pitches.clear()
	teach()
	
func rhythm2secs(rhythm: int) -> float:
	var secs: float
	match rhythm:
		6:
			secs = time * 1.618 * 1.618 * 1.618
		5:
			secs = time * 1.618 * 1.618
		4:
			secs = time * 1.618
		3:
			secs = time
		2:
			secs = time * 0.618
		1:
			secs = time * 0.618 * 0.618
		0:
			secs = time * 0.618 * 0.618 * 0.618
		_: # fallback, same value as "3"
			secs = time
	return secs
	
# TODOs
#
# play handling sounds before notes as hints
#
# redesign levels
#
# play assistant voicelines
#

func _on_Computer_teaching_started() -> void:
	is_computer_busy = true

func _on_Computer_teaching_finished() -> void:
	is_computer_busy = false
