package com.popcap.flash.framework
;
   import flash.events.IEventDispatcher;
   import com.XMLC;

   
    interface IAppPluginContext extends IEventDispatcher
   {
       
      
      function registerService(param1:Vector<String>, param2:ASObject, param3:XMLC) : IAppServiceRegistration;
      
      function getServiceReferences(param1:String) : Vector<IAppServiceReference>;
      
      function ungetService(param1:IAppServiceReference) : Void;
      
      function getPlugin() : IAppPlugin;
      
      function getPlugins() : Vector<IAppPlugin>;
      
      function getService(param1:IAppServiceReference) : ASObject;
   }

