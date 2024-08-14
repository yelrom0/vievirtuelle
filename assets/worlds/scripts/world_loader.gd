"""
world_loader.gd

Handles the dynamic loading of "worlds".
Worlds are 3D models that represent the environment,
with additional properties.
These are each stored in their own folders in 
the chosen base directory.


"""

@tool
class_name WorldLoader extends Resource

const BASE_DIRECTORY: String = "res://assets/worlds/data/"

var worlds: Array[World] = []

var paths: Array[String] = []:
    get:
        var res: Array = []
        for world in worlds:
            res.append(BASE_DIRECTORY + world.name + "/")
        return res

func _init() -> void:
    var dir: DirAccess = DirAccess.open(BASE_DIRECTORY)

    if dir:
        dir.list_dir_begin()
        var file_name: String = dir.get_next()

        while file_name != "":
            if dir.current_is_dir():
                var world_name := file_name.to_lower()
                var world_settings := WorldSettings.load_settings(world_name)
                
                worlds.append(World.new(world_settings))

        if worlds.is_empty():
            _load_from_remote("No environments found in directory: " + BASE_DIRECTORY)

    else:
        _load_from_remote("Could not open directory: " + BASE_DIRECTORY)


func _load_from_remote(msg: String = "") -> void:
    """
    Downloads default environments from remote.

    Args:
        msg (String): Optional message to print to console.
    """

    # TODO: Add remote asset downloading from remote.
    if msg:
        print(msg)