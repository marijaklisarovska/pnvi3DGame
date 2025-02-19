extends Node3D

@onready var music_player = $AudioStreamPlayer3D  

func _ready():
	music_player.play() 
