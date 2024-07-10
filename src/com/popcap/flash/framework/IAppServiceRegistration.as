package com.popcap.flash.framework
{
   import com.XMLC;

   public interface IAppServiceRegistration
   {
       
      
      function unregister() : void;
      
      function setProperties(param1:XMLC) : void;
      
      function getReference() : IAppServiceReference;
   }
}
