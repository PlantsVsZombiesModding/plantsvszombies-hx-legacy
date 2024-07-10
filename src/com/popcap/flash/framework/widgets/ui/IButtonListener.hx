package com.popcap.flash.framework.widgets.ui
;
    interface IButtonListener
   {
       
      
      function buttonPress(param1:Float) : Void;
      
      function buttonMouseMove(param1:Float, param2:Float, param3:Float) : Void;
      
      function buttonMouseEnter(param1:Float) : Void;
      
      function buttonDownTick(param1:Float) : Void;
      
      function buttonMouseLeave(param1:Float) : Void;
      
      function buttonRelease(param1:Float) : Void;
   }

