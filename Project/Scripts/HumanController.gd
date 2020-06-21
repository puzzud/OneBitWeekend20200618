extends Controller
class_name HumanController

func _ready():
	pass

func _process(delta: float) -> void:
	intendedDirection.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	intendedDirection.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	intendedJump = (Input.get_action_strength("ui_accept") != 0.0)
