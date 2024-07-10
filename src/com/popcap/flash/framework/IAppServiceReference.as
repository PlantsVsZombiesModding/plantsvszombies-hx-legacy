package com.popcap.flash.framework
{
   import com.XMLC;
   public interface IAppServiceReference
   {
       
      
      function getProperties() : XMLC;
      
      function getPlugin() : IAppPlugin;
      
      function getUsingPlugins() : Vector.<IAppPlugin>;
   }
}
