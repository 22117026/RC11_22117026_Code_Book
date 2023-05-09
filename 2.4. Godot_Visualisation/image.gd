extends Area2D

var width
var height
var folder_id

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func initialise(path, folder):
	set_image(path)
	self.input_event.connect(_on_image_pressed)
	folder_id = folder
	
func _on_image_pressed(viewport: Object, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		for i in range(len(get_parent().image_list)):
			if get_parent().image_list[i].folder_id == folder_id:
				get_parent().image_list[i].hide()
			else:
				get_parent().image_list[i].show()


func set_image(path):
	$Sprite2D.load_image(path)
	var shape = RectangleShape2D.new()
	width = $Sprite2D.texture.get_width()
	height = $Sprite2D.texture.get_height()
	shape.set_size(Vector2(width, height))
	$CollisionShape2D.set_shape(shape)
