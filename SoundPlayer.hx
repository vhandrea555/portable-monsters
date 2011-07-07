   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;

    class SoundPlayer
    {
	private var currentSound:Int;
        private var sound:Sound;
	private var sound1:Sound;
	private var sound2:Sound;
	private var sound3:Sound;
        private var ch:SoundChannel;
        private var isSoundPlaying:Bool;

        public function new (inSound1:Sound,inSound2:Sound,inSound3:Sound)
        {
	    currentSound = 1;
            sound = inSound1;
	    sound1 = inSound1;
	    sound2 = inSound2;
	    sound3 = inSound3;
            isSoundPlaying = false;
        } 

        public function getPosition():Float
        {
          return ch.position;
        }

        public function play(inPosition:Float)
        {
            if(!isSoundPlaying)
            {
                ch = sound.play(inPosition);
                ch.addEventListener(
                    Event.SOUND_COMPLETE,
                    handleSoundComplete);
                isSoundPlaying = true;
            }
        }

        public function stop()
        {
            if(isSoundPlaying)
            {
	    ch.removeEventListener(
                    Event.SOUND_COMPLETE,
                    handleSoundComplete);
                ch.stop();
                isSoundPlaying = false;
            }
        }

	public function getPrevTrack()
	{
	  stop();
	  if(currentSound <= 1)
	    {currentSound = 3;}
	  else
	    {currentSound--;}

	  assignCurrentSound();
	  play(0);
	}

	public function getNextTrack()
	{
	  stop();
	  if(currentSound >= 3)
	    {currentSound =1;}
	  else
	    {currentSound++;}
	  assignCurrentSound();
	  play(0);
	}

	public function assignCurrentSound()
	{
	  if(currentSound == 1)
	    {sound = sound1;}
          else if(currentSound == 2)
	    {sound = sound2;}
	  else
	    {sound = sound3;}
	}

        private function handleSoundComplete(ev:Event)
        {
	    ch.removeEventListener(
                    Event.SOUND_COMPLETE,
                    handleSoundComplete);
            isSoundPlaying = false;
	    getNextTrack();
	    //play(0);
        }
    }
