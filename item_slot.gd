extends TextureRect

const ItemNode = preload("res://item.tscn")
var backpack = preload("res://backpack.tres")

func update_item(item):
	if item is Item:
		var item_node = ItemNode.instantiate()
		item_node.texture = item.texture
		item_node.item_data = item
		add_child(item_node)
		modulate = Color(1,1,1,1)
	else:
		for cur_item in get_children():
			cur_item.queue_free()
		modulate = Color(1,1,1,0.5)

func _can_drop_data(at_position, data):
	return data is Dictionary and data.has("item")
	
func _drop_data(at_position, data):
	var my_item_index = get_index()
	var my_item = backpack.items[my_item_index]
	if my_item is Item and my_item.name == data.item.name:
		my_item.amount += data.item.amount
		get_child(0).update_amount()
	else:
		backpack.swap_item(my_item_index,data.index)
		backpack.set_item(my_item_index,data.item)
	backpack.drag_data = null
