extends Camera2D

@export var velocity_delta: float = 120
@export var zoom_delta: float = 0.05

var velocity := Vector2.ZERO

func _process(delta: float) -> void:
	if not self.velocity.is_zero_approx():
		self.position += self.velocity * delta

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton or event is InputEventMagnifyGesture:
		self.apply_zoom(event)
	elif event is InputEventKey:
		self.apply_velocity(event)
	
func apply_zoom(event: InputEvent):
	var magnify_event := event as InputEventMagnifyGesture
	if magnify_event:
		self.zoom *= magnify_event.factor
	elif event is InputEventMouseButton:
		if event.is_action_pressed("zoom_in"):
			self.zoom *= (1.0 + self.zoom_delta)
		elif event.is_action_pressed("zoom_out"):
			self.zoom *= (1.0 - self.zoom_delta)

func apply_velocity(event: InputEventKey):
	if event.is_action_pressed("go_up"):
		self.velocity.y -= self.velocity_delta
	elif event.is_action_released("go_up"):
		self.velocity.y = 0
	elif event.is_action_pressed("go_down"):
		self.velocity.y += self.velocity_delta
	elif event.is_action_released("go_down"):
		self.velocity.y = 0
	elif event.is_action_pressed("go_left"):
		self.velocity.x -= self.velocity_delta
	elif event.is_action_released("go_left"):
		self.velocity.x = 0
	elif event.is_action_pressed("go_right"):
		self.velocity.x += self.velocity_delta
	elif event.is_action_released("go_right"):
		self.velocity.x = 0
