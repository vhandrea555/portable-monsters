import flash.display.Bitmap;
import flash.display.BitmapData;




class TileSheet extends BitmapData
{
        public function new()
        {
             super(256,256);
        }
}

class BattleSprites extends BitmapData
{
        public function new()
        {
             super(512,512);
        }
}


class Menu extends BitmapData
{
        public function new()
        {
             super(640,426);
        }
}

class Background extends BitmapData
{
        public function new()
        {
             super(640,426);
        }
}
class CardboardBackground extends BitmapData
{
        public function new()
        {
             super(640,512);
        }
}


class TextBackground extends BitmapData
{
        public function new()
        {
             super(540,175);
        }
}


//Buttons
class StartGame extends BitmapData
{
        public function new()
        {
                super(250,49);
        }
}

class ContinueGame extends BitmapData
{
        public function new()
        {
                super(250,49);
        }
}
class XButton extends BitmapData
{
        public function new()
        {
                super(25,25);
        }
}
class Options extends BitmapData
{
        public function new()
        {
                super(250,49);
        }
}

class Bubble extends BitmapData
{
        public function new()
        {
                super(250,213);
        }
}
class ResetSavedData extends BitmapData
{
        public function new()
        {
                super(250,49);
        }
}

class Instructions extends BitmapData
{
        public function new()
        {
                super(250,49);
        }
}

class MainMenu extends BitmapData
{
        public function new()
        {
                super(250,49);
        }
}

class BackImage extends BitmapData
{
        public function new()
        {
                super(125,49);
        }
}
class GenericButton extends BitmapData{
        public function new()
        {
                super(709,140);
        }
}
class Prev extends BitmapData
{
        public function new()
        {
                super(60,113);
        }
}


class Next extends BitmapData
{
        public function new()
        {
                super(60,113);
        }
}


class Volume extends BitmapData
{
        public function new()
        {
                super(113,113);
        }
}

class VolumeMuted extends BitmapData
{
        public function new()
        {
                super(113,113);
        }
}

class SoundEffects extends BitmapData
{
        public function new()
        {
                super(99,63);
        }
}


class SoundEffectsMuted extends BitmapData
{
        public function new()
        {
                super(99,63);
        }
}

class RightClick extends BitmapData
{
    public function new()
    {
	    super(200,200);
    }
}

class Keys extends BitmapData
{
    public function new()
    {
	    super(172,116);
    }
}