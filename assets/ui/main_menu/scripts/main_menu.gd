extends TabContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.is_debug_build():
		_add_debug_tab()

func _add_debug_tab():
	var scene = load("res://assets/ui/main_menu/scenes/tabs/debug_tab.tscn")
	var debug_tab = scene.instance()
	debug_tab.name = "Debug"
	add_child(debug_tab)
