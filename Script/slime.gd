extends CharacterBody2D
class_name Slime

var speed = 20
var player: Node2D = null
var player_in_area = false
var can_push = true

func _ready():
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]
	else:
		print("No player found!")

func _physics_process(delta: float) -> void:
	if player and player_in_area:
		var to_player = player.position - position
		var distance = to_player.length()
		
		# Si colisiona, empuja una vez y se detiene temporalmente
		if distance <= 16 and can_push:
			apply_knockback()
			can_push = false
			await get_tree().create_timer(0.5).timeout
			can_push = true
			velocity = Vector2.ZERO
		elif distance > 16:
			velocity = to_player.normalized() * speed
		else:
			velocity = Vector2.ZERO
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func _on_DetectionArea_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_area = true

func _on_DetectionArea_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_area = false

func apply_knockback():
	if player and player.has_method("apply_knockback"):
		var push_vector = (player.position - position).normalized() * 100
		player.apply_knockback(push_vector)
