""" 
user_preferences.gd

This script is used to control the storage and retrieval of user preferences.

It inherits from the Resource class, as we're going to be saving and loading.

Current preferences include:
    - Current world (World)
    - User height (for setting camera height relative to the xr source)
"""


class_name UserPreferences extends Resource

const PATH := "user://user_preferences.tres"

@export var user_height: float = 2.0

func save() -> void:
    ResourceSaver.save(self, PATH)

static func load_preferences() -> UserPreferences:
    var res: UserPreferences = load(PATH) as UserPreferences

    if !res:
        res = UserPreferences.new()
        res.save()

    return res