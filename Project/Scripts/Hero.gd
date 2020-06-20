extends KinematicBody2D

export (float) var speed := 40.0

export (bool) var isShadow := false

var intendedDirection := Vector2.ZERO
var direction := Vector2.ZERO
var velocity := Vector2.ZERO

var grounded := false
var jumping := false

var gravity := Vector2(0.0, 98.0 * 4.0)

func _ready():
	if isShadow:
		var material: ShaderMaterial = $AnimatedSprite.get_material()
		material = material.duplicate(true)
		material.set_shader_param("invert", isShadow)
		$AnimatedSprite.set_material(material)
		

func _process(delta: float) -> void:
	intendedDirection.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	intendedDirection.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if isShadow:
		intendedDirection.x *= -1.0
	
	if intendedDirection.x < 0.0:
		$AnimatedSprite.animation = "WalkLeft"
	elif intendedDirection.x > 0.0:
		$AnimatedSprite.animation = "WalkRight"
	
	direction.x = intendedDirection.x
	direction.y = 0.0
	
	if grounded:
		if direction.x != 0.0:
			$AnimatedSprite.playing = true
		else:
			$AnimatedSprite.playing = false
			$AnimatedSprite.frame = 2
		
		if Input.get_action_strength("ui_accept"):
			jumping = true
	
	if not grounded or jumping:
		$AnimatedSprite.playing = false
		$AnimatedSprite.frame = 0

func _physics_process(delta: float) -> void:
	if direction.x != 0.0:
		velocity.x = direction.x * speed * 100.0 * delta
	else:
		velocity.x = 0.0
	
	if grounded and jumping:
		velocity.y = -1.0 * 64.0 * 2.0
	
	velocity += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	grounded = is_on_floor()
	if grounded:
		jumping = false
