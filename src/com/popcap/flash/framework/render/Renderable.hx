package com.popcap.flash.framework.render
;
   import com.popcap.flash.framework.graphics.Graphics2D;
   
    interface Renderable
   {
       
      
      function getIsDisposable() : Bool;
      
      function getIsVisible() : Bool;
      
      function draw(param1:Graphics2D) : Void;
      
      function update() : Void;
      
      function getDepth() : Float;
   }

