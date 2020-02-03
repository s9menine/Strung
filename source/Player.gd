extends Node

signal note_played # Tells Computer which notes player plays, to compare sequences
signal note_released # If note released too fast, tells Computer to clear sequence
#signal key_pressed
#signal key_released
#signal hammer_pressed
#signal hammer_released

export(float, 0.0, 1.0, 0.050) var strike_cooldown := 0.1
#var art_ext := false
var art_damp := false
#var art_stac := false
#var art_trem := false
var is_strike_cooldown := false

func _input(event) -> void:
#	Play handling sounds
	if Input.is_action_just_pressed("key_1"):
		$Instrument.play_sound_handling("key_press", "Key 1")
	if Input.is_action_just_pressed("key_2"):
		$Instrument.play_sound_handling("key_press", "Key 2")
	if Input.is_action_just_pressed("key_3"):
		$Instrument.play_sound_handling("key_press", "Key 3")
	if Input.is_action_just_pressed("key_4"):
		$Instrument.play_sound_handling("key_press", "Key 4")
	if Input.is_action_just_released("key_1"):
		$Instrument.play_sound_handling("key_release", "Key 1")
	if Input.is_action_just_released("key_2"):
		$Instrument.play_sound_handling("key_release", "Key 2")
	if Input.is_action_just_released("key_3"):
		$Instrument.play_sound_handling("key_release", "Key 3")
	if Input.is_action_just_released("key_4"):
		$Instrument.play_sound_handling("key_release", "Key 4")
	if Input.is_action_just_pressed("hammer"):
		$Instrument.play_sound_handling("hammer_press")
	if Input.is_action_just_released("hammer"):
		$Instrument.play_sound_handling("hammer_release")
	
#	Detect articulation keys
#	if Input.is_action_just_pressed("art_up"):
#		art_ext = true
#	if Input.is_action_just_released("art_up"):
#		art_ext = false
		
	if Input.is_action_just_pressed("art_down"):
		$Instrument.dampen()
		art_damp = true
	if Input.is_action_just_released("art_down"):
		$Instrument.undampen()
		art_damp = false

#	if Input.is_action_just_pressed("art_left"):
#		art_stac = true
#	if Input.is_action_just_released("art_left"):
#		art_stac = false
#
#	if Input.is_action_just_pressed("art_right"):
#		art_trem = true
#	if Input.is_action_just_released("art_right"):
#		art_trem = false

#	Play notes on hammer
#	TODO: fix bug where pressing multiple buttons along with spacebar simultaneously
#	causes multiple notes to sound
	if Input.is_action_just_pressed("hammer"):
		if is_strike_cooldown:
			print("Strike on cooldown!")
			return 
		var note_pitch = _get_note_pitch()
		emit_signal("note_played", note_pitch) # Computer receives this signal
		if note_pitch == 0:
			$Instrument.play_sound_handling("hammer_strike")
			_cooldown()
			return
		else:
			$Instrument.play_sound_handling("hammer_strike")
			$Instrument.play_note_sus(note_pitch)
			_cooldown()
			if art_damp == false: # if not dampened, also play attack sample
				$Instrument.play_note_atk(note_pitch)

#	Fade out Sustain sounds and play Release sounds
	if Input.is_action_just_released("hammer"): # and $Instrument.sus_base_playing != []
		emit_signal("note_released") # Computer receives this signal
		$Instrument.stop_note_sus("Player")


#	TODO Harmonic extensions


#	TODO Staccato


#	TODO Vibrato


func _cooldown():
	is_strike_cooldown = true
	yield(get_tree().create_timer(strike_cooldown), "timeout")
	is_strike_cooldown = false


# Determines which note pitch to play from keys held, basically binary
# Fingering to play scale from lowest to highest:
# A, F, AF, D, AD, DF, ADF, S, AS, SF, ASF, SD, ASD, SDF, ASDF
func _get_note_pitch() -> int:
	var key_1: = int(Input.is_action_pressed("key_1")) # A +1
	var key_2: = int(Input.is_action_pressed("key_2")) # S +8
	var key_3: = int(Input.is_action_pressed("key_3")) # D +4
	var key_4: = int(Input.is_action_pressed("key_4")) # F +2
	var note_pitch: int = key_1 + key_2 * 8 + key_3 * 4 + key_4 * 2
	print("Note pitch is: " + str(note_pitch))
	return note_pitch
