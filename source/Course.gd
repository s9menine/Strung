extends Node

# even entries (top of a pair) are pitches, 1 ~ 15 (low to high)
# odd entries (bottom of a pair) are rhythms, 1 ~ 6 (short to long, 0 is used as shortest length to detect a valid note)
const LESSONS = [
#	lesson 0, introduce 2: F
	[2], 
	[4],
#	lesson 1
	[2, 2], 
	[3, 3],
	
#	lesson 2, introduce 4: D
	[4, 4], 
	[3, 2],
#	lesson 3
	[2, 2, 4, 4], 
	[4, 2, 4, 2],
#	lesson 4
	[4, 2, 4, 2, 4],
	[3, 2, 3, 2, 3],
	
#	introduce S
#	[8, 8],
#	[3, 3],
#
#	[8, 4, 2, 8, 2, 4],
#	[3, 2, 2, 3, 2, 3],
#
#	[8, 4, 8, 2, 8, 2, 4],
#	[3, 2, 3, 2, 3, 2, 3],

#	lesson 5, introduce 1: A
	[1, 1],
	[4, 3],
#	lesson 6
	[1, 2, 4, 4, 2, 1],
	[3, 2, 3, 3, 2, 3],
#	lesson 7
	[1, 1, 4, 2, 4],
	[3, 2, 3, 3, 3],

#	lesson 8, introduce 3: combining A & F
	[1, 2, 1, 2, 3],
	[2, 2, 2, 2, 3],
#	lesson 9
	[3, 2, 3, 3, 2, 1],
	[2, 2, 3, 2, 2, 3],
#	lesson 10
	[1, 2, 3, 4, 4, 3, 2, 1],
	[2, 2, 2, 3, 2, 2, 2, 3],
#	lesson 11
	[4, 3, 2, 1, 2, 3, 1, 2],
	[4, 2, 4, 2, 2, 2, 2, 3],
	
#	lesson 12, introduce 6: combining D & F
	[2, 4, 2, 4, 6],
	[2, 2, 2, 2, 3],
#	lesson 13
	[2, 4, 6, 2, 4, 6],
	[2, 2, 3, 2, 2 ,3],
#	lesson 14
	[6, 2, 6, 3, 6, 4],
	[2, 3, 2, 3, 2, 3],
#	lesson 15
	[1, 2, 3, 4, 6, 6, 4, 3, 2, 1],
	[3, 3, 3, 3, 4, 3, 3, 3, 3, 4],
#	lesson 16
	[2, 3, 4, 6, 2, 3, 4, 6, 2, 3, 6, 4],
	[2, 2, 3, 4, 2, 2, 3, 4, 2, 2, 3, 4],
	
#	lesson 17, introduce 5 and 7
	[4, 5, 6, 7],
	[3, 4, 3, 4],
#	lesson 18, this actually sounds good
	[5, 6, 5, 4, 5, 7, 6],
	[3, 3, 4, 2, 3, 3, 4],
	
#	lesson 19, introduce 8
	[8, 8],
	[4, 3],
	
	[5, 6, 7, 8, 5, 6, 7, 8],
	[3, 3, 3, 4, 3, 3, 3, 4],
		
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
	
	# this actually sounds good
	[5, 10, 5, 10, 12, 12, 5, 10, 5, 10, 3, 3],
	[2, 2, 2, 2, 3, 3, 2, 2, 2, 2, 3, 3],
	
]

const ACKNOWLEDGE = preload("res://assets/computer/system_acknowledge.wav")
const GRADUATE = preload("res://assets/computer/system_acknowledge.wav")
