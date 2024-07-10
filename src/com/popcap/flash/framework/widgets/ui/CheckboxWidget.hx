package com.popcap.flash.framework.widgets.ui
;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.widgets.CWidget;
   
    class CheckboxWidget extends CWidget
   {
       
      
      var mCheckedImage:ImageInst;
      
      var mListener:ICheckboxListener;
      
      var mChecked:Bool = false;
      
      var mId:Float = Math.NaN;
      
      var mUncheckedImage:ImageInst;
      
      public function new(id:Float, checkedImage:ImageInst, uncheckedImage:ImageInst, listener:ICheckboxListener)
      {
         super();
         //super();
         this.mId = id;
         this.mCheckedImage = checkedImage;
         this.mUncheckedImage = uncheckedImage;
         this.mListener = listener;
         doFinger = true;
      }
      
      override public function draw(g:Graphics2D) 
      {
         super.draw(g);
         if(this.mChecked)
         {
            g.drawImage(this.mCheckedImage,0,0);
         }
         else
         {
            g.drawImage(this.mUncheckedImage,0,0);
         }
      }
      
      public function setChecked(checked:Bool, tellListener:Bool) 
      {
         this.mChecked = checked;
         if(tellListener && this.mListener != null)
         {
            this.mListener.checkboxChecked(this.mId,this.mChecked);
         }
         markDirty();
      }
      
      override public function onMouseDown(x:Float, y:Float) 
      {
         super.onMouseDown(x,y);
         this.mChecked = !this.mChecked;
         if(this.mListener != null)
         {
            this.mListener.checkboxChecked(this.mId,this.mChecked);
         }
         markDirty();
      }
      
      public function isChecked() : Bool
      {
         return this.mChecked;
      }
   }

