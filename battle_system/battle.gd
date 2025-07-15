class_name Battle
extends Resource

@export var creatures : Array[Creature] = []
@export_enum('Easy', 'Medium', 'Hard') var battle_difficulty : String = 'Easy'
@export var victory_story_variable : String
@export var defeat_story_variable : String
