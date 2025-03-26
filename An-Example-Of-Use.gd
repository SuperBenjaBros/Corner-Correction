extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

@export var Corner_Correction_Pixels: int = 20

func _Apply_Corner_Correction(delta: float) -> void:
    var move_vec = Vector2(0, velocity.y * delta)

    if velocity.y >= 0 or not test_move(global_transform, move_vec):
        return

    for i in range(1, Corner_Correction_Pixels):
        for dir in [-1, 1]:
            if not test_move(global_transform.translated(Vector2(i / 2.0 * dir, 0)), move_vec):
                translate(Vector2(i / 2.0 * dir, 0))
                if velocity.x * dir < 0:
                    velocity.x = 0
                return

func _physics_process(delta: float) -> void:
    if Input.is_action_just_pressed("ui_accept") and is_on_floor():
        velocity.y = JUMP_VELOCITY

    var direction := Input.get_axis("ui_left", "ui_right")
    if direction:
        velocity.x = direction * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)

    _Apply_Corner_Correction(delta)
    velocity += get_gravity() * delta
    move_and_slide()
