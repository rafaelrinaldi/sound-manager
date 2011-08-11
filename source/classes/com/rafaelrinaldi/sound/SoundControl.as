package com.rafaelrinaldi.sound
{
	import com.rafaelrinaldi.abstract.IDispose;

	/**
	 * 
	 * Available sound controls.
	 *
	 * @author Rafael Rinaldi (rafaelrinaldi.com)
	 * @since Aug 1, 2011
	 *
	 */
	public class SoundControl implements IDispose
	{
		/** Sound volume before is muted. **/	
		protected var originalVolume : int;
		
		/** Is sound playing? **/
		public var isPlaying : Boolean;
		
		/** Fired when sound is started. **/
		public var onPlay : Function;
		
		/** Fired when sound is paused. **/
		public var onPause : Function;
		
		/** Fired when sound is stopped. **/
		public var onStop : Function;
		
		/** Fired when delay timeout is canceled. **/
		public var onCancel : Function;
		
		/** Fired when sound is muted. **/
		public var onMute : Function;
		
		/** Fired when delay timeout is unmuted. **/
		public var onUnMute : Function;
		
		/** Fired when sound is completed. **/
		public var onComplete : Function;
		
		/** Fired when something goes wrong. **/
		public var onError : Function;
		
		/**
		 * Play list items.
		 * @param p_loops Loops. Use <strong>-1</strong> to loop forever (<strong>0</strong> by default).
		 * @param p_delay Delay (<strong>0</strong> by default).
		 */
		public function play( p_loops : int = 0, p_delay : int = 0 ) : SoundControl
		{
			isPlaying = true;
			return this;
		}

		/** Pause sound. **/
		public function pause() : SoundControl
		{
			isPlaying = false;
			
			if(onPause != null) onPause();
			
			return this;
		}

		/** Stop sound. **/
		public function stop() : SoundControl
		{
			isPlaying = false;
			
			if(onStop != null) onStop();
			
			return this;
		}

		/** Mute sound. **/
		public function mute() : SoundControl
		{
			originalVolume = volume;
			volume = 0;
			
			if(onMute != null) onMute();
			
			return this;
		}
		
		/** Unmute sound. **/
		public function unmute() : SoundControl
		{
			volume = originalVolume || 1;
			
			if(onUnMute != null) onUnMute();
			
			return this;
		}

		/** Volume getter. **/
		public function get volume() : int
		{
			return 0;
		}
		
		/** Volume setter. **/
		public function set volume( value : int ) : void
		{
		}
		
		/** Pan getter. **/
		public function get pan() : int
		{
			return 0;
		}
		
		/** Pan setter. **/
		public function set pan( value : int ) : void
		{
		}

		/** Clear from memory. **/
		public function dispose() : void
		{
			onPlay = null;
			onPause = null;
			onStop = null;
			onCancel = null;
			onMute = null;
			onUnMute = null;
			onComplete = null;
			onError = null;
		}

	}
}