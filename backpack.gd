extends Resource

class_name Backpack

@export var items : Array[Resource]
var drag_data

signal item_changed(indexes)

func set_item(index,item):
	var cur_item = items[index]
	items[index] = item
	emit_signal("item_changed",[index])
	return cur_item
	
	
func remove_item(index):
	var cur_item = items[index]
	items[index] = null
	emit_signal("item_changed",[index])
	return cur_item
	
func swap_item(src_index,dst_index):
	var src_item = items[src_index]
	var dst_item = items[dst_index]
	items[src_index] = dst_item
	items[dst_index] = src_item
	emit_signal("item_changed",[src_index,dst_index])
	
func make_item_unique():
	var unique_item :Array[Resource]
	for item in items:
		if item is Item:
			unique_item.append(item.duplicate())
		else:
			unique_item.append(null)
	items = unique_item
