package;

import openfl.display.Sprite;
import openfl.events.Event;
import com.popcap.flash.games.pvz.PVZFlash;

class Main extends PVZFlash 
{
    public function Main() 
    {
        if (stage) 
        {
            startup();
            super();
        }
        else 
            addEventListener(Event.ADDED_TO_STAGE, init);
    }
    
    private function startup(e:Event = null):Void 
    {
        removeEventListener(Event.ADDED_TO_STAGE, init);
    }
    
}