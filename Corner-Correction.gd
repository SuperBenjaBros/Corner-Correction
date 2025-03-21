var Corner_Correction_Pixels : int = 8

func _Apply_Corner_Correction(delta: float) -> void:
	if velocity.y < 0 and test_move(global_transform, Vector2(0, velocity.y * delta)):
		for i in range(1, Corner_Correction_Pixels * 2 + 1):
			for dir in [-1.0, 1.0]:
				var offset = Vector2((i * dir) / 2, 0)
				if not test_move(global_transform.translated(offset), Vector2(0, velocity.y * delta)):
					translate(offset)
					if velocity.x * dir < 0:
						velocity.x = 0
					return
