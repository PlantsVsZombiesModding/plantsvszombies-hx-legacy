package com.popcap.flash.framework
;
   import com.XMLC;

    interface IAppServiceRegistration
   {
       
      
      function unregister() : Void;
      
      function setProperties(param1:XMLC) : Void;
      
      function getReference() : IAppServiceReference;
   }

