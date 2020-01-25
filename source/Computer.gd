extends Node

export(float, 0.618, 2.618) var time: float
var current_lesson := 0
var pitches_index := 0
var rhythms_index := 1
var target_pitches := []
var target_rhythms := []
var player_pitches := []
var is_player_playing := false

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"): teach()

func advance():
	player_pitches.clear()
	current_lesson += 1
	print("Now moving to lesson: " + str(current_lesson))
	pitches_index = current_lesson * 2
	rhythms_index = current_lesson * 2 + 1
	yield(get_tree().create_timer(rhythm2secs(5)), "timeout")
	teach()

func teach():
	print("Current indicies are: " + str(pitches_index) + ", " + str(rhythms_index))
	if pitches_index >= $Course.LESSONS.size():
		graduate()
		return
	target_pitches = $Course.LESSONS[pitches_index]
	target_rhythms = $Course.LESSONS[rhythms_index]
	print("Current teacher sequence is: " + str(target_pitches))
	var i := 0
	while i <= target_pitches.size() - 1:
		var _note_pitch = target_pitches[i]
		$Instrument.play_note_atk(_note_pitch)
		$Instrument.play_note_sus(_note_pitch)
		var _rhythm:float = rhythm2secs(target_rhythms[i])
		yield(get_tree().create_timer(_rhythm),"timeout")
		$Instrument.stop_note_sus()
		yield(get_tree().create_timer(rhythm2secs(1)),"timeout")
		i += 1

func _on_Player_note_played(note_pitch):
	is_player_playing = true
	yield(get_tree().create_timer(rhythm2secs(1)),"timeout")
	if is_player_playing == false: return
	player_pitches.append(note_pitch)
	player_pitches.invert()
	player_pitches.resize(target_pitches.size())
	player_pitches.invert()
	print("Current player sequence is: " + str(player_pitches))
	if target_pitches == player_pitches:
		yield(get_parent().get_node("Player"), "note_released")
		acknowledge()
		advance()

func _on_Player_note_released() -> void:
	is_player_playing = false
#	yield(get_tree().create_timer(rhythm2secs(2)), "timeout")
		
func acknowledge():
	print("Acknowledged!")
	yield(get_tree().create_timer(rhythm2secs(2)), "timeout")
	$AudioStreamPlayer.stream = $Course.VOCALS[0]
	$AudioStreamPlayer.play()
	yield(get_tree().create_timer(rhythm2secs(2)), "timeout")
	$AudioStreamPlayer.play()
	yield(get_tree().create_timer(rhythm2secs(2)), "timeout")

func graduate():
	print("Graduated!")
	target_pitches = [16]
	$AudioStreamPlayer.stream = $Course.VOCALS[0]
	$AudioStreamPlayer.play()
	yield(get_tree().create_timer(rhythm2secs(1)), "timeout")
	$AudioStreamPlayer.play()
	yield(get_tree().create_timer(rhythm2secs(1)), "timeout")
	$AudioStreamPlayer.play()
	yield(get_tree().create_timer(rhythm2secs(1)), "timeout")
	$AudioStreamPlayer.play()
	yield(get_tree().create_timer(rhythm2secs(1)), "timeout")
	
func rhythm2secs(rhythm: int) -> float:
	var secs: float
	match rhythm:
		6:
			secs = time
		5:
			secs = time * 0.618
		4:
			secs = time * 0.618 * 0.618
		3:
			secs = time * 0.618 * 0.618 * 0.618
		2:
			secs = time * 0.618 * 0.618 * 0.618 * 0.618
		1:
			secs = time * 0.618 * 0.618 * 0.618 * 0.618 * 0.618
		_: # fallback, same value as "3"
			secs = time * 0.618 * 0.618 * 0.618
	return secs
	
#TODOs
#
#access Instrument and play notes, with pitch and duration
#rhythm: use timers between calling play_note_atk/sus and play_note_stop
#
#
#play assistant voicelines
#
#
#


