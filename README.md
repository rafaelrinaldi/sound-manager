> # Deprecation notice :rotating_light:
> This project is no longer being maintened by me. If you want to take ownership over it, just [ping me](https://github.com/rafaelrinaldi/contact).

[license]: https://github.com/rafaelrinaldi/sound-manager/raw/master/license.txt
[list]: https://github.com/rafaelrinaldi/list
[fdt]: http://fdt.powerflasher.com

# sound-manager
Keep sound management intuitive and organized. Using [list][list] as base, offer a way to control sound organizing by groups or individual items.

---
### Available callbacks

 - `onPlay` - Fired when sound is started.
 - `onPause` - Fired when sound is paused.
 - `onStop` - Fired when sound is stopped.
 - `onCancel` - Fired when delay timeout is canceled.
 - `onMute` - Fired when sound is muted.
 - `onUnMute` - Fired when sound is unmuted.
 - `onComplete` - Fired when sound is completed.
 - `onError` - Fired when something goes wrong with the sound.
 - `onLoad` - Fired when stream is loaded.
 - `onID3` - Fired when ID3 is received.
 - `onIOError` - Fired when something goes wrong on loading the stream.
 - `onOpen` - Fired when stream is opened.
 - `onProgress` - Fired when stream is being loaded.
 - `onSampleData` - Fired when sample data is received.

---
### Usage

	// You can add a sound instance.
	sound().add("lorem", new SoundLorem);
	
	// You can add a sound class.
	sound().add("ipsum", SoundIpsum);
	
	// You can add a sound class definition (make sure the class is instantiated before you add).
	sound().add("dolor", "my.pkg.SoundDolor");
	
	// Controling sound items by group.
	sound().group("effects").add("explosion", new SoundExplosion);
	sound().group("effects").add("shoot", new SoundShoot);
	sound().group("effects").add("glow", new SoundGlow);
	
	// Playing once all items inside group "effects" at the same time.
	sound().group("effects").play();
	
	// Playing item "explosion" in loop.
	sound().group("effects").item("explosion").play(-1);
	
	// Playing item "shoot" three times after five seconds of delay.
	sound().group("effects").item("shoot").play(3, 5);
	
	// Playing item "glow" and when completed shows a message.
	sound().group("effects").item("glow").play().onComplete = function() : void { trace("Just finished playing 'glow'!") };
	
	// Start playing a stream.
	sound().add("sit").load("http://domain/folder/1.mp3").play();

	// Start playing a stream in a single line. (idea sent via @hankpillow)
	sound().add("consectetur").load("http://domain/folder/3.mp3").onProgress(progress).onLoad(load).onPlay(play).onStop(stop).play();
	
	function progress( event : ProgressEvent ) : void {
		trace("Loading sound file:" + event.bytesLoaded + " - " + event.bytesTotal);
	}
	
	function load( event : Event ) : void {
		trace("File was loaded!", event);
	}
	
	function play() : void {
		trace("Playing!");
	}
	
	function stop() : void {
		trace("Stopping!");
	}
	
	// Managing global sound (SoundMixer). Stopping all existing sounds, including files who aren't being managed by SoundManager. 
	sound().global().stop();
	
	// Adding a simple mute/unmute control to context menu.
	sound().addContextMenu(this);

For a complete code reference, check the documentation at `/asdoc`.

---
### License
[WTFPL][license]

---
<small>Made with ♥ using [FDT][fdt].</small>
