# Script for autoload to handle score
# Keeps track of score and emits a signal when changed

extends Node

signal score_changed

var score_array:Array[int] = [0,0,0]
var total_score = 0

enum SCORES {
	BAD = 0,
	GOOD = 1,
	PERFECT = 2
}

# function to increment the score at a given index
func increment(index):
	score_array[index] += 1
	total_score += index
	score_changed.emit()

