extends Controller
class_name HeroMirrorController

func _ready():
	pass

func _process(delta: float) -> void:
	var heroHumanController: Controller = Global.game.getHero().getController()
	intendedDirection = heroHumanController.intendedDirection
	intendedJump = heroHumanController.intendedJump
	
	intendedDirection.x *= -1.0
