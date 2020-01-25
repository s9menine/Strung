extends Node

export var volume_range: float = -3.0

var rng = RandomNumberGenerator.new()
#var art_ext_last: bool = false
var sus_base_playing := []
var sus_ext_playing := []
var release_pitch := []

func _ready() -> void:
	rng.randomize()

func play_note_atk(note_pitch, bus = "Attack"):
	if note_pitch == 0: return
	var stream: Resource = $NoteAtk.notes_array[note_pitch]
#	print_filename(stream)
	var _player := AudioStreamPlayer.new()
	add_child(_player)
	_player.stream = stream
	_player.volume_db = rng.randf_range(volume_range, 0)
	_player.set_bus(bus)
	_player.play()
	yield(_player, "finished")
	_player.queue_free()

func play_note_sus(note_pitch: int, bus = "Sustain"):
	if note_pitch == 0: return
	var stream_base: Resource = $NoteSusBase.notes_array[note_pitch]
	var player_base := AudioStreamPlayer.new()
	add_child(player_base)
	player_base.stream = stream_base
	player_base.volume_db = rng.randf_range(volume_range, 0)
#	player_base.pitch_scale = rng.randf_range(0.99, 1.01) # nope, causes phasing
	player_base.set_bus(bus)
	player_base.play()
	sus_base_playing.append(player_base)
	release_pitch.append(note_pitch)
	yield(player_base, "finished")
	player_base.queue_free()
	
#	if art_ext:
#		art_ext_last = true
#		var stream_ext: Resource = $NoteSusExt.notes_array[note_pitch]
#		var player_ext := AudioStreamPlayer.new()
#		add_child(player_ext)
#		player_ext.stream = stream_ext
#		player_ext.volume_db = rng.randf_range(volume_range, 0)
#		player_ext.set_bus(bus)
#		player_ext.play()
#		sus_ext_playing.append(player_ext)
#		yield(player_ext, "finished")
#		player_ext.queue_free()

func stop_note_sus(performer: String):
	if sus_base_playing == []:
		return
	else:
		var bus: String
		if performer == "Player": bus = "Release"
		elif performer == "Computer": bus = "Computer"
		play_note_rel(release_pitch.pop_front(), bus)
		var fade := Tween.new()
		add_child(fade)		
		var player_base = sus_base_playing.pop_front()
#		fade.interpolate_property(player_base, NodePath(str(player_base.get_path()) + ":volume_db"), null, -80.0, 0.382, Tween.TRANS_SINE, Tween.EASE_OUT)
#		yield(fade, "tween_completed")
		player_base.stop() # TODO: Change stop to rapid fadeout using tween, and also play releas sample
		player_base.queue_free()
#		if art_ext_last == true:
#			var player_ext = sus_ext_playing.pop_front()
#			player_ext.stop()
#			player_ext.queue_free()
#			art_ext_last = false
			
#	if art_ext:
#		$NoteSusBase.notes_array[note_pitch]
#		$NoteSusExt.notes_array[note_pitch]
#	else:
#		$NoteSusBase.notes_array[note_pitch]
#	play_note_rel(notes_playing.pop_front())
	
func play_note_rel(note_pitch: int, bus: String):
	var stream: Resource = $NoteRelBase.notes_array[note_pitch]
#	print_filename(stream)
	var _player_base := AudioStreamPlayer.new()
	add_child(_player_base)
	_player_base.stream = stream
	_player_base.volume_db = rng.randf_range(volume_range, 0)
	_player_base.set_bus(bus)
	_player_base.play()
	yield(_player_base, "finished")
	_player_base.queue_free()
#	$NoteRelExt.notes_array[note_pitch]

func play_sound_handling(sound: String, bus: String = "Handling"):
	# Determine which handling sound to play
	var stream: Resource
	if sound == "key_press" :
		stream = $Handling.key_press
	elif sound == "key_release" : 
		stream = $Handling.key_release
	elif sound == "hammer_press" :
		stream = $Handling.hammer_press
	elif sound == "hammer_release" :
		stream = $Handling.hammer_release
	elif sound == "hammer_strike" :
		stream = $Handling.hammer_strike() # this function alternates between the two strike samples
	
	# Create AudioStreamPlayer node, add it to SceneTree, play it, destroy it
	var _player := AudioStreamPlayer.new()
	add_child(_player)
	_player.stream = stream
	_player.pitch_scale = rng.randf_range(0.81, 1.19) # +- 3 semitones
	_player.volume_db = rng.randf_range(volume_range, 0)
#	bus adds panning for Keys 1-4
	_player.set_bus(bus) 
	_player.play()
	yield(_player, "finished") # "finished" is name of signal emitted by AudioStreamPlayer
	_player.queue_free()


func print_filename(file: Resource):
	print("File played is: " + file.resource_path)
