extends CharacterBody2D
class_name Bat

var speed = 20
var player: Node2D = null
var player_in_area = false

func _ready():
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]
	else:
		print("No player found in group!")

func _physics_process(delta: float) -> void:
	if player and player_in_area:
		var direction = (player.position - position).normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func _on_DetectionArea_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_area = true
		print("Player entered detection area.")

func _on_DetectionArea_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_area = false
		print("Player exited detection area.")
