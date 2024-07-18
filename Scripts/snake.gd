extends Node2D

@export var speed : float = 200.0
var screenSize : Vector2i
var segment = preload("res://Scenes/segment.tscn")
const cellSize : int = 32

func _ready():
	screenSize = get_viewport_rect().size
	Eventbus.hit.connect(addSegment)


func _process(delta):
	movements(delta)

func movements(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screenSize)

var snakeSegments: Array = []
var direction: Vector2 = Vector2.UP  # Direction initiale du serpent

func addSegment():
	var newSegment = segment.instantiate()
	if snakeSegments.is_empty():
		# Si c'est le premier segment (tête), placez-le au centre ou à une position de départ
		newSegment.position = Vector2(0, cellSize)
	else:
		# Obtenir la position du dernier segment
		var lastSegment = snakeSegments[-1]
		# Calculer la nouvelle position basée sur la position du dernier segment
		# et l'opposé de la direction actuelle
		newSegment.position = lastSegment.position - direction * cellSize

	# Ajouter le nouveau segment à la scène et à la liste des segments
	add_child(newSegment)
	snakeSegments.append(newSegment)
