extends Node2D
class_name Game

func _ready():
	Global.game = self
	
	#$ColorRect.visible = true
	pass

func getHero() -> Hero:
	return $Hero as Hero
