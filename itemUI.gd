extends TextureRect

var backpack = preload("res://backpack.tres")
var item_data

@onready var amount = $Amount

func _get_drag_data(at_position):
	var index = get_parent().get_index()
	var item = backpack.remove_item(index)
	if item is Item:
		var data = {}
		data.item = item
		data.index = index
		var drag_preview = TextureRect.new()
		drag_preview.texture = texture
		drag_preview.custom_minimum_size = custom_minimum_size
		set_drag_preview(drag_preview)
		backpack.drag_data = data
		return data
		
func update_amount():
	if item_data.amount > 1:
		amount.text = str(item_data.amount)
	else:
		amount.text = ""
		
func _ready():
	update_amount()
