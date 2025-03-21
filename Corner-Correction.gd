var Corner_Correction_Pixels : int = 8

func _Apply_Corner_Correction(delta: float) -> void:
	var move_vec = Vector2(0, velocity.y * delta)
	
	if velocity.y >= 0 or not test_move(global_transform, move_vec):
		return
	
	for i in range(1, Corner_Correction_Pixels + 1):
		var offset_x = i / 2.0
		for dir in [-1, 1]:
			var offset = Vector2(offset_x * dir, 0)
			if not test_move(global_transform.translated(offset), move_vec):
				translate(offset)
				if velocity.x * dir < 0:
					velocity.x = 0
				return
