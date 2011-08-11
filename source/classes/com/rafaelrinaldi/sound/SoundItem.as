package com.rafaelrinaldi.sound
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
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
		
		/** @param p_sound Sound instance. **/
		public function SoundItem( p_sound : Sound )
		{
			sound = p_sound;
			lastPosition = 0;
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
		protected function playHandler() : void
		{
			try {
				
				channel = sound.play(lastPosition, loops);
				channel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
				
				if(onPlay != null) onPlay();
				
			} catch( error : Error ) {
				
				trace("[SoundItem] There was a problem playing", this);
				
				if(onError != null) onError();
				
			}
		}

		/** @private **/
		protected function soundCompleteHandler( event : Event ) : void
		{
			isPlaying = false;
			lastPosition = 0;
			
			if(onComplete != null) onComplete();
		}

		/** Clear from memory. **/
		override public function dispose() : void
		{
			cancel();
			
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
