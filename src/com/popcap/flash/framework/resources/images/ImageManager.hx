package com.popcap.flash.framework.resources.images
;
   import com.popcap.flash.framework.AppBase;
   
    class ImageManager
   {
       
      
      var mApp:AppBase;
      
      public function new(param1:AppBase)
      {
         //super();
         this.mApp = param1;
      }
      
      public function getImageInst(param1:String) : ImageInst
      {
         var _loc2_:ASObject = this.mApp.resourceManager.getResource(param1);
         var _loc3_= ASCompat.dynamicAs(_loc2_ , ImageDescriptor);
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.createData();
            this.mApp.resourceManager.setResource(param1,_loc2_);
         }
         var _loc4_:ImageData;
         if((_loc4_ = ASCompat.dynamicAs(_loc2_ , ImageData)) == null)
         {
            throw new Error("Image \'" + param1 + "\' is not loaded.");
         }
         return new ImageInst(_loc4_);
      }
      
      public function addDescriptor(param1:String, param2:ImageDescriptor) 
      {
         this.mApp.resourceManager.setResource(param1,param2);
      }
   }

