# sound-manager Changelog #

## v0.4 (2011/11/08) ##

### API Changes ###

 - `position` now is a read-write property so now you're able to seek.
 - `positionPercent` can seek the sound based on percent value (from 0 to 1).
 - Added `togglePlay()` method to toggle between play/pause without checking values manually.

## v0.3 (2011/08/31) ##

### API Changes ###

 - Added `toggleMute()` method.
 - Improved chain structure a lot. Now you're able to do everything in a single line.

### Fixes ###

 - Fixed a problem when getting channel sound position.

### Others ###

 - Code refactoring.
 - Lots of tests.
 - Updated SWC.
 - Updated ASDoc.


## v0.2 (2011/08/30) ##

### API Changes ###

 - Added `load()` method to `SoundItem`.
 - Added `onLoad` callback to `SoundItem`.
 - Added `onID3` callback to `SoundItem`.
 - Added `onIOError` callback to `SoundItem`.
 - Added `onOpen` callback to `SoundItem`.
 - Added `onProgress` callback to `SoundItem`.
 - Added `onSampleData` callback to `SoundItem`.
 - Added `url` property to `SoundItem`.
 - Value for `add()` method on `SoundManager` now is optional.

### Fixes ###

 - Fixed `IDisposable` import on `SoundManager`.



## v0.1 (2011/08/10) ##

 - First release.