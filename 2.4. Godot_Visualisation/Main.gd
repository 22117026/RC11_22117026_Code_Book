extends Node2D

var image_list = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var dir1 = "res://0_0/"
	var dir2 = "res://0_1/"
	var images_0_0 = load_images_in_directory(dir1)
	var images_0_1 = load_images_in_directory(dir2)

	for i in range(len(images_0_0)):
		var imPath1 = dir1 + images_0_0[i]
		var image = preload("res://image.tscn").instantiate()
		add_child(image)
		image.initialise(imPath1, 1)
		image_list.append(image)

	for i in range(len(images_0_1)):
		var imPath2 = dir2 + images_0_1[i]
		var image = preload("res://image.tscn").instantiate()
		add_child(image)
		image.initialise(imPath2, 2)
		image_list.append(image)

	shuffle_images()

func shuffle_images():
	var num_swaps = 1000
	var num_images = len(image_list)
	var rng = RandomNumberGenerator.new()
	rng.randomize()

	for i in range(num_swaps):
		var index1 = int(rng.randf_range(0, num_images))
		var index2 = int(rng.randf_range(0, num_images))
		var temp = image_list[index1]
		image_list[index1] = image_list[index2]
		image_list[index2] = temp

	for i in range(num_images):
		var image = image_list[i]
		var dim = max(image.width, image.height)
		var sf = 250.0/dim
		image.apply_scale(Vector2(sf, sf))

		var x = (i % 5) * 300 + 300
		var y = int(i/5) * 300 + 300
		image.transform.origin = Vector2(x,y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_images_in_directory(path):
	var files = []
	var dir = DirAccess.open(path)
	var count = 0
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".jpg") or file_name.ends_with(".png") or file_name.ends_with(".jpeg"):
				files.append(file_name)
				count += 1
			if count >= 100:
				break
			file_name = dir.get_next()
		dir.list_dir_end()
	return files

	
func hide_images_from_other_folder(folder_id):
	for i in range(len(image_list)):
		if image_list[i].folder_id != folder_id:
			image_list[i].hide()
