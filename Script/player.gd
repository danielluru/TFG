extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0 


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var dir: Vector2 = Input.get_vector("izquierda", "derecha", "arriba", "abajo")	
	if dir:
		if dir.x != 0:
			if dir.x > 0:
				$AnimatedSprite2D.play("run_derecha")
				pass
			else:
				$AnimatedSprite2D.play("run_izquierda")
				pass
			pass
		pass
	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.play("idle")
		pass
		
	velocity = dir * SPEED
	move_and_slide()


func apply_knockback(force: Vector2):
	position += force * 0.08  # Empuje suave
	$AnimatedSprite2D.play("death")
