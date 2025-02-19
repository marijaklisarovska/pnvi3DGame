extends Label

var coins = 0
var total_coins = 0
@export var time_limit: float = 45.0  
var time_left: float
var timer_label: Label  

func _ready():
	var coins_count = get_tree().get_nodes_in_group("coins").size()
	var treasures_count = get_tree().get_nodes_in_group("treasures").size()
	total_coins = coins_count + (treasures_count * 3)
	coins = 0
	time_left = time_limit
	
	text = str(coins)

	timer_label = get_parent().get_node("TimerLabel")  
	timer_label.text = "Time: %d" % time_left  
	var countdown_timer = Timer.new()
	countdown_timer.wait_time = 1.0  
	countdown_timer.timeout.connect(_on_timer_tick)
	add_child(countdown_timer)
	countdown_timer.start()

func _on_timer_tick():
	time_left -= 1
	timer_label.text = "Time: %d" % time_left 

	if time_left <= 0:
		_on_time_up()

func _on_coin_coin_collected() -> void:
	coins += 1
	text = str(coins)
	_check_win_condition()
		
func _on_sketchfab_scene_treasure_collected() -> void:
	coins += 3
	text = str(coins)
	_check_win_condition()
	
func _check_win_condition():
	if coins >= total_coins:
		_go_to_win_scene()

func _on_time_up():
	if coins < total_coins:
		_go_to_game_over_scene()

func _go_to_win_scene():
	await get_tree().create_timer(0.5).timeout  
	get_tree().change_scene_to_file("res://youwin.tscn")

func _go_to_game_over_scene():
	await get_tree().create_timer(0.5).timeout  
	get_tree().change_scene_to_file("res://gameover.tscn")
