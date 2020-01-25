extends Node

# even entries (left of a pair) are pitches, 1 ~ 15 (low to high)
# odd entries (right of a pair) are rhythms, 1 ~ 6 (short to long)
const LESSONS = [
	[2], 
	[3],
	
	[2, 2], 
	[3, 3],
	
	[4], 
	[4],
	
	[2, 4, 2], 
	[3, 4, 3],
	
	[6, 6],
	[2, 2],
	
	[2, 4, 6, 6],
	[3, 4, 2, 2],
	
	[6, 4, 6, 2, 4, 6],
	[2, 4, 2, 4, 2, 4],
	
	[8],
	[3],
]

const ACKNOWLEDGE = preload("res://assets/instrument/atk/note_atk_15.wav")
const GRADUATE = preload("res://assets/instrument/atk/note_atk_15.wav")
