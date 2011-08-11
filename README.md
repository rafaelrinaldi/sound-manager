[asdoc]: http://rafaelrinaldi.github.com/sound-manager/asdoc
[license]: https://github.com/rafaelrinaldi/sound-manager/raw/master/license.txt
[list]: https://github.com/rafaelrinaldi/list
[fdt]: http://fdt.powerflasher.com

# sound-manager
Keep sound management intuitive and organized. Using [list][list] as base, offer a way to control sound organizing by groups or individual items.

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
	
	// Managing global sound (SoundMixer). Stopping all existing sounds, including files who aren't being managed by SoundManager. 
	sound().global().stop();
	
	// Adding a simple mute/unmute control to context menu.
	sound().addContextMenu(this);

For a complete code reference, check the [documentation][asdoc].

---
### License
[WTFPL][license]

---
<small>Made with ♥ using [FDT][fdt].</small>