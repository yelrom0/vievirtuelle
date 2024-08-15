"""
main_menu.gd

This script is attached to the main
menu node in the main scene.

Currently, this performs three functions:
	- Adds a debug tab to the main menu (if in debug mode)
	- Checks if the user has triggered the action to toggle
	the visibility of the main menu, in which case it will do so.
	- Checks if the user is triggering the action to move the main menu,
	(with the initial action also pointing at the menu). In which case 
	velocity will be added to the main menu node in the direction
	of the controller, higher velocity the further the controller is from
	the menu, then decelarate when caught up or the controller is no longer
	triggering the action.
"""
class_name MainMenu extends TabContainer

func _ready():
	if OS.is_debug_build():
		_add_debug_tab()

func _add_debug_tab():
	var scene = load("res://assets/ui/main_menu/scenes/tabs/debug_tab.tscn")
	var debug_tab = scene.instance()
	debug_tab.name = "Debug"
	add_child(debug_tab)
