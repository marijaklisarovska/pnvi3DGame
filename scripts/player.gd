extends CharacterBody3D

const SPEED = 7.5
const JUMP_VELOCITY = 4.5
const ROLL_MULTIPLIER = 3.0  
const BALL_RADIUS = 0.5 

@onready var mesh = $MeshInstance3D
@onready var spring_arm = $SpringArm3D  


var coin_count = 0  

func _ready():
	for coin in get_tree().get_nodes_in_group("coin"):
		coin.connect("coin_collected", _on_coin_collected)

func _on_coin_collected():
	coin_count += 1
	print("Coins collected: ", coin_count) 
	

func _process(delta: float):
	spring_arm.rotation.y = lerp_angle(spring_arm.rotation.y, rotation.y, 5.0 * delta)  
   

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, -input_dir.y)).normalized()
	direction.x = -direction.x  

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		var angular_velocity = SPEED / BALL_RADIUS  
		var roll_axis = Vector3(direction.z, 0, -direction.x) 
		mesh.rotate(roll_axis.normalized(), angular_velocity * delta * ROLL_MULTIPLIER)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
