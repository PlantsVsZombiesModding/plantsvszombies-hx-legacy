package com.popcap.flash.framework.states
;
   import com.popcap.flash.framework.graphics.Graphics2D;
   
    interface IState
   {
       
      
      function update() : Void;
      
      function onPop() : Void;
      
      function draw(param1:Graphics2D) : Void;
      
      function onPush() : Void;
      
      function onEnter() : Void;
      
      function onExit() : Void;
   }

