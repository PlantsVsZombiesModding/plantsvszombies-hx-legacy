package com.popcap.flash.framework.resources.foley
;
    class FoleyType
   {
       
      
      var mPitchRange:Float = Math.NaN;
      
      var mFlags:FoleyFlags;
      
      var mVariations:Array<ASAny>;
      
      public function new(pitchRange:Float, variations:Array<ASAny>, flags:FoleyFlags)
      {
         //super();
         this.mPitchRange = pitchRange;
         this.mVariations = variations;
         this.mFlags = flags;
      }
      
      @:flash.property @:isVar public var variations(get,never):Array<ASAny>;
public function  get_variations() : Array<ASAny>
      {
         return this.mVariations;
      }
      
      @:flash.property @:isVar public var flags(get,never):FoleyFlags;
public function  get_flags() : FoleyFlags
      {
         return this.mFlags;
      }
      
      @:flash.property @:isVar public var pitchRange(get,never):Float;
public function  get_pitchRange() : Float
      {
         return this.mPitchRange;
      }
   }

