package mx.core
;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import mx.utils.NameUtil;
   
   //use namespace mx_internal;
   
    class FlexBitmap extends Bitmap
   {
      
      //mx_internal static const VERSION:String = "3.3.0.4852";
       
      
      public function new(param1:BitmapData = null, param2:String = "auto", param3:Bool = false)
      {
         var bitmapData= param1;
         var pixelSnapping= param2;
         var smoothing= param3;
         super(bitmapData,pixelSnapping,smoothing);
         try
         {
            name = NameUtil.createUniqueName(this);
         }
         catch(e:Error)
         {
         }
      }
      
      override public function toString() : String
      {
         return NameUtil.displayObjectToString(this);
      }
   }

