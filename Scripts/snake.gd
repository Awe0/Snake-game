extends Node2D

@export var speed : float = 150.0
@export var rotationSpeed = 1.5
var screenSize : Vector2i
var segment = preload("res://Scenes/segment.tscn")
var direction : Vector2 = Vector2.RIGHT 
var moveDirection : Vector2 = Vector2.ZERO
var snakeSegments : Array = []
var rotationDirection = 0

const cellSize : int = 32

func _ready():
	screenSize = get_viewport_rect().size
	Eventbus.hit.connect(addSegment)


func _process(delta):
	movements(delta)
	rotation += rotationDirection * rotationSpeed * delta

func movements(delta):
	if Input.is_action_pressed("right"):
		moveDirection = Vector2.RIGHT
	if Input.is_action_pressed("left"):
		moveDirection = Vector2.LEFT
	if Input.is_action_pressed("down"):
		moveDirection = Vector2.DOWN
	if Input.is_action_pressed("up"):
		moveDirection = Vector2.UP
		
	rotationDirection = Input.get_axis("left", "right")
	moveDirection = transform.x * Input.get_axis("down", "up") * speed
	position += moveDirection * delta
	position = position.clamp(Vector2.ZERO, screenSize)

func addSegment():
	var newSegment = segment.instantiate()
	if snakeSegments.is_empty():
		newSegment.position = Vector2(-cellSize,0)
	else:
		var lastSegment = snakeSegments[-1]
		newSegment.position = lastSegment.position - direction * cellSize
	add_child(newSegment)
	snakeSegments.append(newSegment)

