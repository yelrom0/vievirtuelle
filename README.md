# Vie Virtuelle
Your virtual life.

## Description

Initially this program is to hopefully be used to solve the shortcomings of watching videos on the Quest 3.

That is:

- No Netflix
- No Twitch
- Multiple apps for different content (Skybox or Wolvic for YouTube (but the former doesn't support login), Skybox for passthrough TV/films, I like the environment and UI of Pigasus the best.)
- No multi-channel support (Pigasus has DTS if you build a custom LibVLC, but it's a pain to do so, and it's prone to bugs)

Once that is done, I will add more features to make it a more complete virtual life experience such as social, browser and (hopefully/possibly) app surfaces within the space where anyone in the space can see what you're doing and join in.

I want to be able to work, play, and socialise in VR, and I want to be able to do it all in one place.

## Note for GStreamer Integration

To integrate GStreamer with Godot Engine on Android, you'll need to leverage the VideoStreamPlayer class in Godot and GStreamer's Android integration. Here's a step-by-step guide:

1. Ensure you have the necessary GStreamer plugins installed on your system, including the Android plugin (`gstreamer-libgstandroid`). You can obtain these plugins from the GStreamer download page.

2.  In your Godot project, add the GStreamer plugin as a dependency in your `build.gradle` file (for Android) or `CMakeLists.txt` file (for desktop platforms):

    ```
    // Android (build.gradle)
    android {
        externalNativeBuild {
            ndkBuild {
                path 'jni/Android.mk'
            }
        }
        dependencies {
            implementation 'org.freedesktop.gstreamer:gstreamer-libgstandroid:1.20.0'
        }
    }

    // Desktop (CMakeLists.txt)
    findpackage(GStreamer REQUIRED)
    ```
    

3.  In your Godot script, create a GStreamer pipeline and set it as the source for the VideoStreamPlayer. You can use the `gstelementfactorymake()` function to create GStreamer elements, as demonstrated in the GStreamer documentation.

    ```gdscript
    extends VideoStreamPlayer

    var gstpipeline = null
    var videosink = null

    func ready():
        # Create GStreamer pipeline
        gstpipeline = GstPipeline.new()
        videosink = gstelementfactorymake('gstmpegtsmux', 'tsmux')
        gstpipeline.add(videosink)

        # Add other elements as needed (e.g., source, decoder, filter)

        # Set pipeline as the VideoStreamPlayer's source
        setvideosource(gstpipeline)

    func process(delta):
        # Run the GStreamer pipeline
        if gstpipeline != null:
            gstpipeline.setstate(Gst.State.PLAYING)
    ```

4.  To output the video to a GTK+ window (specific to the provided search results), you'll need to integrate GStreamer with GTK+ in your Godot project. Unfortunately, this is not directly applicable, as Godot uses its own rendering engine and not GTK+. Instead, you can output the video to a Godot Texture or Sprite, which you can then display in your scene.

    ```gdscript
    # Assuming you're using a Texture to display the video
    var videotexture = Texture.new()

    func process(delta):
        # Run the GStreamer pipeline
        if gstpipeline != null:
            gstpipeline.setstate(Gst.State.PLAYING)

        # Get the video frame from the pipeline
        var videoframe = ...
        videotexture.fromimage(videoframe)

        # Update the Texture in the scene
        $VideoDisplay.texture = video_texture
    ```

Please note that this is a simplified example and might require additional error handling, thread safety considerations, and optimization depending on your specific use case. For more information on integrating GStreamer with Godot Engine, refer to the Godot documentation and GStreamer tutorials.