package com.rafaelrinaldi.sound
{
	import flash.events.SampleDataEvent;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	/**
	 * 
	 * <code>SoundManager</code> item.
	 * 
	 * @see SoundManager
	 * @see SoundControl
	 * 
	 * @author Rafael Rinaldi (rafaelrinaldi.com)
	 * @since Aug 9, 2011
	 *
	 */
	public class SoundItem extends SoundControl
	{
		/** Sound. **/
		public var sound : Sound;
		
		/** Channel. **/
		public var channel : SoundChannel;
		
		/** Loops. **/
		public var loops : int;
		
		/** Delay. **/
		public var delay : int;
		
		/** @private **/
		protected var timeout : int;
		
		/** Last position occurrence. **/
		public var lastPosition : int;
		
		/** Stream URL. **/
		public var url : String;
		
		/** Fired when delay timeout is canceled. **/
		public var onLoad : Function;
		
		/** Fired when ID3 is received. **/
		public var onID3 : Function;
		
		/** Fired when stream is unable to load. **/
		public var onIOError : Function;
		
		/** Fired when stream is opened. **/
		public var onOpen : Function;
		
		/** Fired when stream is being loaded. **/
		public var onProgress : Function;
		
		/** Fired when stream is loaded. **/
		public var onSampleData : Function;
		
		/** @param p_sound Sound instance. **/
		public function SoundItem( p_sound : Sound )
		{
			sound = p_sound;
			lastPosition = 0;
		}
		
		/**
		 * Loads a sound stream.
		 * @param p_url Sound stream.
		 * @param p_context Loader context.
		 */
		public function load( p_url : String, p_context : SoundLoaderContext = null ) : SoundItem
		{
			try {
				
				stop();
				
				sound.removeEventListener(Event.COMPLETE, loadHandler);
				sound.removeEventListener(Event.ID3, id3Handler);
				sound.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				sound.removeEventListener(Event.OPEN, openHandler);
				sound.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
				sound.removeEventListener(SampleDataEvent.SAMPLE_DATA, sampleDataHandler);
				
				// Close the sound stream if it has one.
				sound.close();
				
			} catch( error : Error ) {
				// Nothing to close.
			}
			
			sound = new Sound;
			sound.addEventListener(Event.COMPLETE, loadHandler);
			sound.addEventListener(Event.ID3, id3Handler);
			sound.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			sound.addEventListener(Event.OPEN, openHandler);
			sound.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			sound.addEventListener(SampleDataEvent.SAMPLE_DATA, sampleDataHandler);
			sound.load(new URLRequest(url = p_url), p_context);
			
			return this;
		}

		/**
		 * Play list items.
		 * @param p_loops Loops. Use <strong>-1</strong> to loop forever (<strong>0</strong> by default).
		 * @param p_delay Delay (<strong>0</strong> by default).
		 */
		override public function play( p_loops : int = 0, p_delay : int = 0 ) : SoundControl
		{
			loops = p_loops == -1 ? int.MAX_VALUE : p_loops;
			delay = p_delay;
			
			cancel();
			
			timeout = setTimeout(playHandler, delay * 1000);
			
			return super.play();
		}

		/** Pause sound. **/
		override public function pause() : SoundControl
		{
			channel.stop();
			lastPosition = channel.position;
			
			return super.pause();
		}
		
		/** Stop sound. **/
		override public function stop() : SoundControl
		{
			lastPosition = 0;
			channel.stop();
			
			return super.stop();
		}

		/** Cancel delay timeout. **/
		public function cancel() : SoundItem
		{
			clearTimeout(timeout);
			
			if(onCancel != null) onCancel();
			
			return this;
		}
		
		/** @return Sound position. **/
		public function get position() : int
		{
			if(channel == null) return 0;
			return channel.position;
		}
		
		/** @return Sound volume. **/
		override public function get volume() : int
		{
			if(channel == null) return 0;
			return channel.soundTransform.volume;
		}

		/** Sound volume setter. **/
		override public function set volume( value : int ) : void
		{
			if(channel == null) return;
			channel.soundTransform = new SoundTransform(value, pan);
		}
		
		/** @return Sound pan. **/
		override public function get pan() : int
		{
			if(channel == null) return 0;
			return channel.soundTransform.pan;
		}
		
		/** Sound pan setter. **/
		override public function set pan( value : int ) : void
		{
			if(channel == null) return;
			channel.soundTransform = new SoundTransform(volume, value);
		}

		/** @private **/
		protected function loadHandler( event : Event ) : void
		{
			if(onLoad != null) onLoad(event);
		}

		/** @private **/
		protected function id3Handler( event : Event ) : void
		{
			if(onID3 != null) onID3(event);
		}

		/** @private **/
		protected function ioErrorHandler( event : IOErrorEvent ) : void
		{
			if(onIOError != null) onIOError(event);
		}

		/** @private **/
		protected function openHandler( event : Event ) : void
		{
			if(onOpen != null) onOpen(event);
		}
		
		/** @private **/
		protected function progressHandler( event : ProgressEvent ) : void
		{
			if(onProgress != null) onProgress(event);
		}

		/** @private **/
		protected function sampleDataHandler( event : SampleDataEvent ) : void
		{
			if(onSampleData != null) onSampleData(event);
		}
		
		/** @private **/
		protected function playHandler() : void
		{
			try {
				
				channel = sound.play(lastPosition, loops);
				channel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
				
				if(onPlay != null) onPlay();
				
			} catch( error : Error ) {
				
				trace("[SoundItem] There was a problem playing", this);
				
				if(onError != null) onError(error);
				
			}
		}

		/** @private **/
		protected function soundCompleteHandler( event : Event ) : void
		{
			isPlaying = false;
			lastPosition = 0;
			
			if(onComplete != null) onComplete(event);
		}

		/** Clear from memory. **/
		override public function dispose() : void
		{
			cancel();
			
			onLoad = null;
			onID3 = null;
			onIOError = null;
			onOpen = null;
			onProgress = null;
			onSampleData = null;
			
			if(channel != null) {
				channel.stop();
				channel = null;
			}
			
			if(sound != null) {
				
				try {
					sound.close();
				} catch( error : Error ) {
					// Problem when closing.
				}
				
				sound = null;
				
			}
			
			super.dispose();
		}

	}
}
