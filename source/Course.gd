extends Node

# each lesson consists of a pair of entries in the LESSONS array
# each entry is also an array of its own
# array-ception
# pros would write all this in an external json file that's easier to edit
# and also allows for modding
# but as you can see i am not a pro
#
# even entries (top of a pair) are tones/pitches
# valid values are 0 ~ 15, from low to high
# 0 is an empty click
# rules are detailed in the _get_note_pitch() function in Player.gd
#
# odd entries (bottom of a pair) are timings/rhythms
# 1 ~ 6 from short to long, 0 is used as shortest length to detect a valid note
# calculated by the rhythm2secs() function in Computer.gd

const ACKNOWLEDGE = preload("res://assets/computer/system_acknowledge.wav")
const CHIRP = preload("res://assets/computer/system_chirp.wav")
const DENY = preload("res://assets/computer/system_deny.wav")
const LESSONS = [
#	!Assistant speaks here!
#	lesson 0, introduce 2
	[2], 
	[4],
#	lesson 1
	[2, 2], 
	[3, 3],
	
#	lesson 2, introduce 4
	[4, 4], 
	[3, 2],
#	lesson 3
	[2, 2, 4, 4], 
	[3, 2, 3, 2],
#	lesson 4
	[4, 2, 4, 2, 4],
	[3, 2, 3, 2, 3],
	
#	lesson 5, introduce 1
	[1, 1],
	[4, 3],
#	lesson 6
	[1, 2, 4, 2, 1],
	[3, 2, 3, 2, 3],
#	lesson 7
	[1, 1, 4, 2, 4, 2, 1],
	[3, 2, 3, 2, 3, 2 ,3],

#	!Assistant speaks here!
#	lesson 8, introduce 3, the first multi-key tone
	[1, 2, 1, 2, 3],
	[3, 3, 3, 3, 4],
#	lesson 9
	[1, 2, 3, 4, 4, 3, 2, 1],
	[2, 2, 2, 3, 2, 2, 2, 3],
#	lesson 10
	[4, 3, 2, 4, 3, 2, 1],
	[3, 2, 3, 2, 3, 2, 3],
	
#	lesson 11, introduce 6
	[2, 4, 2, 4, 6],
	[2, 2, 2, 2, 3],
#	lesson 12
	[2, 3, 4, 6, 4, 6],
	[3, 3, 3, 3, 3 ,4],
#	lesson 13
	[1, 2, 3, 4, 6, 3, 2, 3, 6, 4],
	[3, 3, 3, 3, 4, 3, 3, 3, 3, 4],
	
#	lesson 14, introduce 5
	[1, 4, 5, 1, 5, 4],
	[3, 3, 4, 3, 3, 4],
#	lesson 15
	[4, 5, 6, 2, 3, 3, 4, 3, 4, 5, 6, 6],
	[2, 2, 2, 2, 3, 3, 2, 2, 2, 2, 3, 3],

#	!Assistant speaks here!
#	lesson 16, introduce 7
	[1, 6, 7, 6, 7],
	[3, 3, 3, 3, 3],
#	lesson 17
	[5, 6, 7, 5, 6],
	[3 ,3 ,3, 3, 3],
#	lesson 18
	[1, 4, 7, 5, 6, 5, 4],
	[3, 3, 4, 2, 4, 2, 4],
#	lesson 19, actually sounds good
	[5, 6, 5, 4, 5, 7, 6],
	[3, 3, 4, 2, 3, 3, 4],
#	lesson 20, scale recap
	[1, 2, 3, 4, 5, 6, 7],
	[3, 3, 3, 3, 3 ,3 ,3],
	
#	lesson 21, introduce 8, reverse scale. 8 almost always leads down to 7 or 6.
	[8, 7, 6, 5, 4, 3, 2, 1],
	[4, 2, 2, 2, 2, 2, 2, 2],
#	lesson 22
	[5, 6, 8, 7, 5, 6, 3, 4],
	[2, 2, 2, 4, 2, 2, 2, 4],
#	lesson 23, actually sounds good
	[2, 4, 6, 5, 8, 7, 6, 4],
	[2, 2, 2, 4, 2, 4, 2, 4],

#	!Assistant speaks here!
#	lesson 24, final building crescendo for jam version
	[1, 2, 4, 5, 7, 8],
	[2, 4, 2, 4, 2, 4],
#	lesson 25, introduce empty strike
	[1, 2, 4, 5, 7, 8, 7, 5, 6, 0],
	[2, 4, 2, 4, 2, 4, 2, 2, 3, 2],
#	lesson 26
	[1, 2, 4, 5, 7, 8, 7, 5, 6, 0, 4, 3, 6, 3],
	[2, 4, 2, 4, 2, 4, 2, 2, 3, 2, 2, 4, 2, 4],
#	lesson 27
	[1, 2, 4, 5, 7, 8, 7, 5, 6, 0, 4, 3, 6, 3, 2, 3, 5, 7, 6, 0],
	[2, 4, 2, 4, 2, 4, 2, 2, 3, 2, 2, 4, 2, 4, 2, 2, 2, 2, 3, 2],
#	lesson 28, introduce 9
	[
		1, 2, 4, 5, 7, 8, 7, 5, 6, 0, 4, 3, 6, 3, 2, 3, 5, 7, 6, 0,
		1, 2, 4, 5, 7, 8, 9, 8, 6, 0
	],
	[
		2, 4, 2, 4, 2, 4, 2, 2, 3, 2, 2, 4, 2, 4, 2, 2, 2, 2, 3, 2,
		2, 4, 2, 4, 2, 4, 2, 2, 4, 2
	],
#	lesson 28.5, test empty strikes
#	[0, 0, 0],
#	[3, 3, 3],
#	lesson 29, final boss
	[
		1, 2, 4, 5, 7, 8, 7, 5, 6, 0, 4, 3, 6, 3, 2, 3, 5, 7, 6, 0,
		1, 2, 4, 5, 7, 8, 9, 8, 6, 0, 4, 3, 6, 3, 2, 3, 6, 4, 3
	],
	[
		2, 4, 2, 4, 2, 4, 2, 2, 3, 2, 2, 4, 2, 4, 2, 2, 2, 2, 3, 2,
		2, 4, 2, 4, 2, 4, 2, 2, 3, 2, 2, 4, 2, 4, 2, 2, 4, 2, 4
	],

#	!Assistant speaks here!
#	lesson 30, graduated


#	actually sounds good
#	[5, 10, 5, 10, 12, 12, 5, 10, 5, 10, 3, 3],
#	[2, 2, 2, 2, 4, 4, 2, 2, 2, 2, 4, 4],
	
#	[1, 3, 2, 4, 6, 1, 3, 2, 6, 4],
#	[2, 2, 2, 2, 4, 2, 2, 2, 2, 4],
#	[1, 6, 2, 6, 3, 6, 4],
#	[3, 2, 3, 2, 3, 2, 3],
		
#	[3, 7, 10, 3, 7, 10],
#	[3, 3, 3, 3, 3, 3],
#
#	[2, 3, 4, 10, 2, 3, 6, 9],
#	[2, 2, 2, 3, 2, 2, 2, 3],
#
#	[1, 3, 5, 7, 9],
#	[3, 3, 3, 3, 4],
#
#	[2, 4, 6, 8, 10],
#	[3, 3, 3, 3, 4],
#
#	[1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
#	[3, 2, 3, 2, 3, 2, 3, 2, 3, 4],
]
