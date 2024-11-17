extends Node2D

@export var bezierCuts:Array[float] = [1]
@export var bezierPoints:Array[Vector2] = []

func _bezierLerp(points:Array, t):
	if(len(points) > 2):
		var newPoints = []
		for i in range(len(points)-1):
			newPoints.append(lerp(points[i], points[i+1], t))
		return _bezierLerp(newPoints, t)
	else:
		return lerp(points[0], points[1], t)

func _process(delta: float) -> void:
	var bezierIndex = 0
	for i in range(len(bezierCuts)):
		if(bezierCuts[i]>=GlobalSlider.value):
			bezierIndex = i
			break
	var limits
	if(bezierIndex == 0):
		limits = [0.0, bezierCuts[bezierIndex]]
	else:
		limits = [bezierCuts[bezierIndex-1], bezierCuts[bezierIndex]]

	position = _bezierLerp(bezierPoints.slice(bezierIndex*4,bezierIndex*4+4), inverse_lerp(limits[0], limits[1],GlobalSlider.value))