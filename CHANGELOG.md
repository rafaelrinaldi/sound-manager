# sound-manager Changelog #



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