extends Node

# even entries (top of a pair) are pitches, 1 ~ 15 (low to high)
# odd entries (bottom of a pair) are rhythms, 1 ~ 6 (short to long, 0 is used as shortest length to detect a valid note)
const LESSONS = [
	# introduce F
	[2], 
	[4],

	[2, 2], 
	[3, 3],

	# introduce D

	[4, 4], 
	[3, 2],

	[2, 2, 4, 4], 
	[4, 2, 4, 2],

	[4, 2, 4, 2, 4],
	[3, 2, 3, 2, 3],

	# introduce S

	[8, 8],
	[3, 3],

	[8, 4, 2, 8, 2, 4],
	[3, 2, 2, 3, 2, 3],

	[8, 4, 8, 2, 8, 2, 4],
	[3, 2, 3, 2, 3, 2, 3],

	# introduce A
	[1, 1, 1],
	[4, 2, 3],

	[1, 1, 8, 2, 4],
	[3, 2, 3, 2, 3],

	[1, 2, 4, 8, 1, 2],
	[3, 2, 3, 3, 3, 2],

	[8, 4, 2, 1, 8, 4, 2, 1, 4],
	[3, 3, 2, 4, 3, 3, 2, 4, 3],

	# introduce 3: combining A & F

	[1, 2, 1, 2, 3],
	[3, 2, 3, 2, 4],

	[3, 3, 2, 1, 3, 1],
	[3, 2, 3, 2, 3, 2],
	
	#introduce 6: combining D & F
	
	[2, 4, 2, 6, 6],
	[2, 3, 2, 3, 3],
	
	[2, 3, 4, 6, 3, 2, 4],
	[3, 3, 2, 3, 3, 2, 3],
	
	[6, 2, 6, 3, 6, 4, 6, 4],
	[2, 3, 2, 3, 2, 3, 2, 3],
		
	[2, 4, 6, 8, 2, 4, 6, 8, 2],
	[2, 2, 2, 3, 3, 2 ,2, 3, 3],
	
	[1, 2, 3, 4, 6, 3, 2, 4, 6, 3, 2],
	[1, 1, 1, 2, 2, 3, 3, 2, 2, 3, 3],
	
	#introduce 5 and 7
	
	[5, 7, 5],
	[3, 3, 3],
	
	[5, 6, 5, 4, 5, 7, 6],
	[3, 3, 4, 2, 3, 3, 4],
	
	#introduce 9 and 10
	
	[10, 9, 10],
	[3, 3, 3],
	
	[2, 3, 4, 10, 2, 3, 6, 9],
	[2, 2, 2, 3, 2, 2, 2, 3],
	
	
	[1, 3, 5, 7, 9],
	[3, 3, 3, 3, 4],
	
	[2, 4, 6, 8, 10],
	[3, 3, 3, 3, 4],
	
	[1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
	[3, 2, 3, 2, 3, 2, 3, 2, 3, 4],

]

const ACKNOWLEDGE = preload("res://assets/computer/system_acknowledge.wav")
const GRADUATE = preload("res://assets/computer/system_acknowledge.wav")
