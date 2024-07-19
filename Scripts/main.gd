extends Node2D

# Configuration de la grille et de la taille de la fenêtre
const gridWidth : int = 20
const gridHeight : int = 15
const cellSize : int = 32
const windowSize : Vector2i = Vector2i(gridWidth*cellSize,gridHeight*cellSize)

const apple = preload("res://Scenes/apple.tscn")
var currentApple: Node2D = null

func _ready():
	# Défini la taille de la fenêtre
	DisplayServer.window_set_size(windowSize)
	Eventbus.hit.connect(placeApple)
	placeApple()
	
	# Centre la fenêtre sur l'écran
	var screenSize = DisplayServer.screen_get_size()
	var windowPosition = (screenSize - windowSize) / 2
	DisplayServer.window_set_position(windowPosition)

func placeApple():
	if currentApple != null:
		currentApple.queue_free()
	var x = randi() % gridWidth
	var y = randi() % gridHeight
	currentApple = apple.instantiate()
	currentApple.position = Vector2(x*cellSize, y*cellSize)
	add_child(currentApple)
