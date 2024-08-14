"""
world.gd

This extends the WorldEnvironment class,
adding the 3d model, and additional properties
such as locations for movement.
"""


class_name World extends WorldEnvironment

@export var settings: WorldSettings

func _init(loaded_settings: WorldSettings) -> void:
    settings = loaded_settings