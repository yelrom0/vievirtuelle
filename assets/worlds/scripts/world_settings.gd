"""
world_settings.gd

Handles the storage and retrieval of
settings for a world.

Settings include:
    - Start location (Vector3): Where the user will spawn in the world.
    - Movable locations (Array[Vector3]): Locations the user can move to.
    changing to another movable location will also change the start location.
    TODO: Make movable locations their own object, with additional properties.
"""

@tool
class_name WorldSettings extends Resource

const BASE_SAVE_PATH := "user://world_settings/"
var path: String

@export var start_location: Vector3 = Vector3(0, 0, 0)
@export var moveable_locations: Array[Vector3] = [start_location]

func _init(save_path: String) -> void:
    path = save_path

func save() -> void:
    ResourceSaver.save(self, path)

static func load_settings(world_name: String) -> WorldSettings:
    # init the paths and load the settings
    var save_path = BASE_SAVE_PATH + world_name + ".tres"
    var load_path = WorldLoader.BASE_DIRECTORY + world_name + "/default.tres"
    var settings: WorldSettings = load(save_path) as WorldSettings
    var default_settings: WorldSettings = load(load_path) as WorldSettings

    # if the settings don't exist, create them
    # also, if the moveable locations are different, update them
    if !settings or settings.moveable_locations != default_settings.moveable_locations:
        settings = WorldSettings.new(save_path)
        settings.start_location = default_settings.start_location
        settings.moveable_locations = default_settings.moveable_locations
        settings.save()

    return settings