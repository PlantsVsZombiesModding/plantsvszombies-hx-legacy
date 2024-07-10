package com.popcap.flash.framework
;
   import com.XMLC;

   import flash.events.Event;
   
    class BaseAppPluginContext implements IAppPluginContext
   {
       
      
      var mPlugin:BaseAppPlugin;
      
      var mApp:AppBase;
      
      public function new(param1:AppBase, param2:BaseAppPlugin)
      {
         //super();
         this.mApp = param1;
         this.mPlugin = param2;
      }
      
      public function willTrigger(param1:String) : Bool
      {
         return this.mApp.willTrigger(param1);
      }
      
      public function removeEventListener(param1:String, param2:ASFunction, param3:Bool = false) 
      {
         this.mApp.removeEventListener(param1,param2,param3);
      }
      
      public function getService(param1:IAppServiceReference) : ASObject
      {
         return this.mApp.getService(param1);
      }
      
      public function registerService(param1:Vector<String>, param2:ASObject, param3:XMLC) : IAppServiceRegistration
      {
         return this.mApp.registerService(this.mPlugin,param1,param2,param3);
      }
      
      public function addEventListener(param1:String, param2:ASFunction, param3:Bool = false, param4:Int = 0, param5:Bool = false) 
      {
         this.mApp.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function ungetService(param1:IAppServiceReference) 
      {
         this.mApp.ungetService(param1);
      }
      
      public function dispatchEvent(param1:Event) : Bool
      {
         return this.mApp.dispatchEvent(param1);
      }
      
      public function getServiceReferences(param1:String) : Vector<IAppServiceReference>
      {
         return this.mApp.getServiceReferences(param1);
      }
      
      public function getPlugin() : IAppPlugin
      {
         return this.mPlugin;
      }
      
      public function getPlugins() : Vector<IAppPlugin>
      {
         return this.mApp.getPlugins();
      }
      
      public function hasEventListener(param1:String) : Bool
      {
         return this.mApp.hasEventListener(param1);
      }
   }

