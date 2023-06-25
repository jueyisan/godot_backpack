extends PopupPanel

var backpack = preload("res://backpack.tres")
var sliver = preload("res://Item/Data/sliver.tres")

@onready var container = $VBoxContainer/GridContainer

func _input(event):
	if event.is_action_pressed("backpack"):
		hide()
		
func _ready():
	backpack.make_item_unique()
	backpack.connect("item_changed",on_item_changed)
	for index in backpack.items.size():
		update_slot(index)
	
func update_slot(index):
	var slot = container.get_child(index)
	var item = backpack.items[index]
	slot.update_item(item)
	
func on_item_changed(indexes):
	for index in indexes:
		update_slot(index)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			if backpack.drag_data is Dictionary:
				backpack.set_item(backpack.drag_data.index,backpack.drag_data.item)
				
func _on_add_pressed():
	for index in backpack.items.size():
		if backpack.items[index] == null:
			backpack.set_item(index,sliver)
			break

func _on_tidy_pressed():
	var item_map = {}
	for index in backpack.items.size():
		var item = backpack.remove_item(index)
		if item != null:
			if item_map.has(item.name):
				item_map[item.name].amount += item.amount
			else:
				item_map[item.name] = item
	var cur_index = 0
	for key in item_map:
		backpack.set_item(cur_index,item_map[key])
		cur_index += 1
					
	
	

func _on_clear_pressed():
	for index in backpack.items.size():
		if backpack.items[index] != null:
			backpack.remove_item(index)
