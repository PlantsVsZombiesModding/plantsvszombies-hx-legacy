package com.popcap.flash.framework
;
   import com.XMLC;

   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   
    class BaseAppPlugin implements IAppPlugin
   {
       
      
      var mContext:BaseAppPluginContext;
      
      var mLoader:Loader;
      
      var mProperties:XMLC;
      
      var mLoaded:Bool = false;
      
      var mApp:AppBase;
      
      var mActivator:IAppPluginActivator;
      
      public function new(param1:AppBase, param2:XMLC)
      {
         //super();
         this.mApp = param1;
         this.mLoader = new Loader();
         var _loc3_= this.mLoader.contentLoaderInfo;
         _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.handleLoadFailure);
         _loc3_.addEventListener(Event.COMPLETE,this.handleLoadSuccess);
         this.mProperties = param2;
      }
      
      public function load() 
      {
         //var _loc1_:URLRequest = new URLRequest(this.mProperties.@source);
         //this.mLoader.load(_loc1_);
      }
      
      public function getProperties() : XMLC
      {
         return this.mProperties;
      }
      
      function handleLoadSuccess(param1:Event) 
      {
         var _loc2_= ASCompat.dynamicAs(param1.target , LoaderInfo);
         this.mContext = new BaseAppPluginContext(this.mApp,this);
         this.mActivator = ASCompat.reinterpretAs(_loc2_.content , IAppPluginActivator);
         this.mActivator.start(this.mContext);
         this.mLoaded = true;
      }
      
      public function isLoaded() : Bool
      {
         return this.mLoaded;
      }
      
      function handleLoadFailure(param1:IOErrorEvent) 
      {
         this.mLoaded = true;
      }
   }

