extends Node

var key_press: Resource = preload("res://assets/instrument/key_press.wav")
var key_release: Resource = preload("res://assets/instrument/key_release.wav")
var hammer_press: Resource = preload("res://assets/instrument/hammer_press.wav")
var hammer_release: Resource = preload("res://assets/instrument/hammer_release.wav")
var hammer_strike_001: Resource = preload("res://assets/instrument/hammer_strike-001.wav")
var hammer_strike_002: Resource = preload("res://assets/instrument/hammer_strike-002.wav")

var strike_last
var strike_next := hammer_strike_001

# Alternate between two strike samples
func hammer_strike() -> Resource:
	if strike_last == hammer_strike_001 :
		strike_next = hammer_strike_002
	if strike_last == hammer_strike_002 :
		strike_next = hammer_strike_001
	strike_last = strike_next
#	print("File played is: " + strike_next.resource_path)
	return strike_next
