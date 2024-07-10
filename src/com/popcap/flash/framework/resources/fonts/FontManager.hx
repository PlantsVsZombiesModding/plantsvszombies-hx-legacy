package com.popcap.flash.framework.resources.fonts
;
   import com.popcap.flash.framework.AppBase;
   
    class FontManager
   {
       
      
      var mApp:AppBase;
      
      var mFontDataMap:ASDictionary<ASAny,ASAny>;
      
      var mFontTypeMap:ASDictionary<ASAny,ASAny>;
      
      public function new(param1:AppBase)
      {
         //super();
         this.mApp = param1;
         this.mFontTypeMap = new ASDictionary<ASAny,ASAny>();
         this.mFontDataMap = new ASDictionary<ASAny,ASAny>();
      }
      
      public function addDescriptor(param1:String, param2:FontDescriptor) 
      {
         this.mApp.resourceManager.setResource(param1,param2);
      }
      
      public function getFontInst(param1:String) : FontInst
      {
         var _loc2_:ASObject = this.mApp.resourceManager.getResource(param1);
         var _loc3_= ASCompat.dynamicAs(_loc2_ , FontDescriptor);
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.createFontData(this.mApp);
            this.mApp.resourceManager.setResource(param1,_loc2_);
         }
         var _loc4_:FontData;
         if((_loc4_ = ASCompat.dynamicAs(_loc2_ , FontData)) == null)
         {
            throw new Error("Font \'" + param1 + "\' is not loaded.");
         }
         return new FontInst(_loc4_);
      }
   }

