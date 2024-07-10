package com.popcap.flash.framework
;
   import com.XMLC;
    class BaseAppServiceReference implements IAppServiceReference
   {
       
      
      var mPlugin:BaseAppPlugin;
      
      var mRegistration:BaseAppServiceRegistration;
      
      public function new(param1:BaseAppPlugin, param2:BaseAppServiceRegistration)
      {
         //super();
         this.mPlugin = param1;
         this.mRegistration = param2;
      }
      
      public function getProperties() : XMLC
      {
         return this.mRegistration.getProperties();
      }
      
      public function getUsingPlugins() : Vector<IAppPlugin>
      {
         throw new Error("Unimplemented stub method.");
      }
      
      public function getPlugin() : IAppPlugin
      {
         return this.mPlugin;
      }
   }

