package com.popcap.flash.framework.resources.reanimator
;
   import com.popcap.flash.framework.AppBase;
   import com.popcap.flash.framework.graphics.Color;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.images.ImageData;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.reanimator.looptypes.ReanimLoopAlways;
   import com.popcap.flash.framework.resources.reanimator.looptypes.ReanimLoopOnceAndDie;
   import com.popcap.flash.framework.resources.reanimator.looptypes.ReanimLoopOnceAndHold;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
    class Reanimation
   {
      
      public static final LOOP_TYPE_ONCE_AND_DIE:ReanimLoopType = new ReanimLoopOnceAndDie();
      
      public static final LOOP_TYPE_ONCE_AND_HOLD:ReanimLoopType = new ReanimLoopOnceAndHold();
      
      public static final SECONDS_PER_UPDATE:Float = 1 / 100;
      
      public static final LOOP_TYPE_ALWAYS:ReanimLoopType = new ReanimLoopAlways();
      
      static var scratchMatrix:Matrix = new Matrix();
      
      static final identityMatrix:Matrix = new Matrix();
       
      
      var locatorY:Float = Math.NaN;
      
      var locatorX:Float = Math.NaN;
      
      var mX:Float = 0;
      
      var mY:Float = 0;
      
      var childTrack:String;
      
      var mAnimTime:Float = 0;
      
      public var overrideColor:Color;
      
      var mLoopType:ReanimLoopType;
      
      public var useColor:Bool = false;
      
      var mAnimRate:Float = 0;
      
      var mDefinition:ReanimDefinition = null;
      
      var child:Reanimation;
      
      public var additiveColor:Color;
      
      var mLastAnimTime:Float = 0;
      
      var mVisibleMap:ASDictionary<ASAny,ASAny>;
      
      var mCurrentTrack:String = null;
      
      var mFrameTime:ReanimFrameTime;
      
      var mFrameCount:Float = 0;
      
      var mChildOffsetX:Float = 0;
      
      var mChildOffsetY:Float = 0;
      
      var mStartFrame:Float = 0;
      
      public var mIsDead:Bool = false;
      
      public function new(definition:ReanimDefinition)
      {
         this.mFrameTime = new ReanimFrameTime();
         this.mLoopType = LOOP_TYPE_ALWAYS;
         this.mVisibleMap = new ASDictionary<ASAny,ASAny>();
         //super();
         this.mDefinition = definition;
         this.overrideColor = Color.ARGB(1,1,1,1);
         this.additiveColor = Color.ARGB(1,0,0,0);
         this.useColor = false;
      }
      
            
      @:flash.property @:isVar public var loopType(get,set):ReanimLoopType;
public function  get_loopType() : ReanimLoopType
      {
         return this.mLoopType;
      }
      
      public function overrideImage(trackName:String, image:ImageInst) 
      {
         var aTrans:ReanimTransform = null;
         var aTrack= this.getTrack(trackName);
         var aNumTransforms= Std.int(aTrack.numTransforms);
         for(i in 0...aNumTransforms)
         {
            aTrans = aTrack.transforms[i];
            if(aTrans.image != null)
            {
               aTrans.image = image;
            }
         }
      }
      
      public function shouldTriggerTimedEvent(time:Float) : Bool
      {
         if(this.mFrameCount == 0)
         {
            return false;
         }
         if(this.mLastAnimTime < 0)
         {
            return false;
         }
         if(this.mAnimRate <= 0)
         {
            return false;
         }
         if(this.mAnimTime >= this.mLastAnimTime)
         {
            if(time >= this.mLastAnimTime && time < this.mAnimTime)
            {
               return true;
            }
         }
         else if(time >= this.mLastAnimTime || time < this.mAnimTime)
         {
            return true;
         }
         return false;
      }
      
      function drawTrackLerp(g:Graphics2D, track:ReanimTrack, alpha:Float) 
      {
         var init:Matrix = null;
         if(this.mVisibleMap[track.name] == false)
         {
            return;
         }
         var a:ReanimTransform = track.transforms[Std.int(this.mFrameTime.mFrameBefore)];
         var b:ReanimTransform = track.transforms[Std.int(this.mFrameTime.mFrameAfter)];
         var t= this.mFrameTime.mFraction;
         if(a.frame < 0)
         {
            return;
         }
         if(b.frame < 0)
         {
            b = a;
         }
         var kX= this.lerp(a.kX,b.kX,t);
         var kY= this.lerp(a.kY,b.kY,t);
         var sX= this.lerp(a.sX,b.sX,t);
         var sY= this.lerp(a.sY,b.sY,t);
         var tX= this.lerp(a.tX,b.tX,t);
         var tY= this.lerp(a.tY,b.tY,t);
         var tA= this.lerp(a.alpha,b.alpha,t);
         var matrix= scratchMatrix;
         matrix.a = Math.cos(kX) * sX;
         matrix.b = -Math.sin(kX) * sX;
         matrix.c = Math.sin(kY) * sY;
         matrix.d = Math.cos(kY) * sY;
         matrix.tx = tX;
         matrix.ty = tY;
         if(track.name == this.childTrack)
         {
            init = track.transforms[Std.int(this.mStartFrame)].matrix;
            this.locatorX = this.mX + (matrix.tx - init.tx);
            this.locatorY = this.mY + (matrix.ty - init.ty);
         }
         var img= a.image;
         if(img == null)
         {
            return;
         }
         img.useColor = true;
         img.setColor(alpha * tA,this.overrideColor.red + this.additiveColor.red,this.overrideColor.green + this.additiveColor.green,this.overrideColor.blue + this.additiveColor.blue);
         g.pushState();
         g.transform(matrix);
         g.drawImage(img,this.mX,this.mY);
         g.popState();
      }
      
            
      @:flash.property @:isVar public var animRate(get,set):Float;
public function  get_animRate() : Float
      {
         return this.mAnimRate;
      }
function  set_loopType(value:ReanimLoopType) :ReanimLoopType      {
         return this.mLoopType = value;
      }
      
      function getTrack(trackName:String) : ReanimTrack
      {
         var aTrack:ReanimTrack = this.mDefinition.trackNameMap[trackName];
         if(aTrack == null)
         {
            throw new Error("Track \'" + trackName + "\' does not exist!");
         }
         return aTrack;
      }
      
      public function getTrackVelocity(trackName:String, allFrames:Bool = false) : Float
      {
         var aTransBefore:ReanimTransform = null;
         var aTransAfter:ReanimTransform = null;
         var velo= Math.NaN;
         var aTrack= this.getTrack(trackName);
         var aList= aTrack.transforms;
         if(!allFrames)
         {
            aTransBefore = aList[Std.int(this.mFrameTime.mFrameBefore)];
            aTransAfter = aList[Std.int(this.mFrameTime.mFrameAfter)];
         }
         else
         {
            aTransBefore = aList[Std.int(this.mStartFrame)];
            aTransAfter = aList[Std.int(this.mStartFrame + this.mFrameCount - 1)];
         }
         if(aTransAfter == null)
         {
            aTransAfter = aTransBefore;
         }
         var aMatrixBefore= aTransBefore.matrix;
         var aMatrixAfter= aTransAfter.matrix;
         var aXBefore= aMatrixBefore.tx;
         var aXAfter= aMatrixAfter.tx;
         if(!allFrames)
         {
            velo = (aXAfter - aXBefore) * SECONDS_PER_UPDATE * this.mAnimRate;
         }
         else
         {
            velo = aXAfter - aXBefore;
         }
         return velo;
      }
      
      @:flash.property @:isVar public var frameCount(get,never):Float;
public function  get_frameCount() : Float
      {
         return this.mFrameCount;
      }
      
      public function getBoundsForFrame() : Rectangle
      {
         var track:ReanimTrack = null;
         var numTransforms= 0;
         var j= 0;
         var transform:ReanimTransform = null;
         var matrix:Matrix = null;
         var img:ImageInst = null;
         var src:BitmapData = null;
         var p0:Point = null;
         var p1:Point = null;
         var p2:Point = null;
         var p3:Point = null;
         var aBounds= new Rectangle();
         var left:Float = ASCompat.MAX_FLOAT;
         var right:Float = ASCompat.MIN_FLOAT;
         var top:Float = ASCompat.MAX_FLOAT;
         var bottom:Float = ASCompat.MIN_FLOAT;
         var tracks= this.mDefinition.tracks;
         var aNumTracks= tracks.length;
         for(i in 0...aNumTracks)
         {
            track = tracks[i];
            numTransforms = Std.int(track.numTransforms);
            for(_tmp_ in 0...numTransforms)
            {
j = _tmp_;
               transform = track.transforms[j];
               matrix = transform.matrix;
               img = transform.image;
               if(img != null)
               {
                  src = img.pixels;
                  p0 = new Point(0,0);
                  p1 = new Point(src.width,0);
                  p2 = new Point(src.width,src.height);
                  p3 = new Point(0,src.height);
                  p0 = matrix.transformPoint(p0);
                  p1 = matrix.transformPoint(p1);
                  p2 = matrix.transformPoint(p2);
                  p3 = matrix.transformPoint(p3);
                  left = Math.min(left,Math.ffloor(Math.min(Math.min(p0.x,p1.x),Math.min(p2.x,p3.x))));
                  right = Math.max(right,Math.fceil(Math.max(Math.max(p0.x,p1.x),Math.max(p2.x,p3.x))));
                  top = Math.min(top,Math.ffloor(Math.min(Math.min(p0.y,p1.y),Math.min(p2.y,p3.y))));
                  bottom = Math.max(bottom,Math.fceil(Math.max(Math.max(p0.y,p1.y),Math.max(p2.y,p3.y))));
               }
            }
         }
         aBounds.left = left;
         aBounds.right = right;
         aBounds.top = top;
         aBounds.bottom = bottom;
         return aBounds;
      }
function  set_animRate(value:Float) :Float      {
         return this.mAnimRate = value;
      }
      
            
      @:flash.property @:isVar public var currentTrack(get,set):String;
public function  set_currentTrack(value:String) :String      {
         this.playTrack(value);
         return this.mCurrentTrack = value;
      }
      
      public function attachReanimation(child:Reanimation, trackName:String, offsetX:Float = 0, offsetY:Float = 0) 
      {
         this.child = child;
         this.child.x = this.mX;
         this.child.y = this.mY;
         this.mChildOffsetX = offsetX;
         this.mChildOffsetY = offsetY;
         this.childTrack = trackName;
      }
      
      public function setTrackVisible(trackName:String, isVisible:Bool) 
      {
         this.mVisibleMap[trackName] = isVisible;
      }
      
      function playTrack(trackName:String) 
      {
         var trans:ReanimTransform = null;
         var anim:ReanimTrack = this.mDefinition.trackNameMap[trackName];
         if(anim == null)
         {
            throw new Error("Track \'" + trackName + "\' does not exist!");
         }
         this.mCurrentTrack = trackName;
         this.mAnimTime = 0;
         var i= 0;
         var startFrame:Float = -1;
         var endFrame:Float = -1;
         var transforms= anim.transforms;
         var numTransforms= transforms.length;
         var i :ASAny= 0;while(i < numTransforms)
         {
            trans = transforms[i];
            if(trans.frame >= 0)
            {
               startFrame = i;
               break;
            }
i++;
         }
         while(i < numTransforms)
         {
            trans = transforms[i];
            if(trans.frame >= 0)
            {
               endFrame = i;
            }
            i++;
         }
         this.mStartFrame = startFrame;
         this.mFrameCount = endFrame - startFrame;
      }
      
      public function draw(g:Graphics2D) 
      {
         var track:ReanimTrack = null;
         if(this.mIsDead)
         {
            return;
         }
         if(!AppBase.LOW_QUALITY)
         {
            this.drawLerp(g,identityMatrix);
            return;
         }
         var tracks= this.mDefinition.tracks;
         var aNumTracks= tracks.length;
         for(i in 0...aNumTracks)
         {
            track = tracks[i];
            this.drawTrack(g,track);
         }
         if(this.child != null)
         {
            this.child.useColor = this.useColor;
            this.child.additiveColor.copy(this.additiveColor);
            this.child.overrideColor.copy(this.overrideColor);
            this.child.x = this.locatorX + this.mChildOffsetX;
            this.child.y = this.locatorY + this.mChildOffsetY;
            this.child.draw(g);
         }
      }
      
      public function update() 
      {
         if(this.mCurrentTrack == null)
         {
            return;
         }
         if(this.mFrameCount == 0)
         {
            return;
         }
         if(this.mIsDead)
         {
            return;
         }
         this.mLastAnimTime = this.mAnimTime;
         this.mAnimTime += SECONDS_PER_UPDATE * this.mAnimRate / this.mFrameCount;
         if(this.mAnimRate > 0)
         {
            this.mLoopType.updatePositive(this);
         }
         else
         {
            this.mLoopType.updateNegative(this);
         }
         this.mFrameTime.update(this.mAnimTime,this.mStartFrame,this.mFrameCount,this.mLoopType.doHold());
         if(this.child != null)
         {
            this.child.update();
         }
      }
      
      function lerp(zero:Float, one:Float, time:Float) : Float
      {
         return zero + (one - zero) * time;
      }
function  get_currentTrack() : String
      {
         return this.mCurrentTrack;
      }
      
      @:flash.property @:isVar public var definition(get,never):ReanimDefinition;
public function  get_definition() : ReanimDefinition
      {
         return this.mDefinition;
      }
      
      public function drawLerp(g:Graphics2D, transform:Matrix = null, alpha:Float = 1) 
      {
         var track:ReanimTrack = null;
         if(this.mIsDead)
         {
            return;
         }
         g.pushState();
         if(transform != null)
         {
            g.transform(transform);
         }
         var tracks= this.mDefinition.tracks;
         var aNumTracks= tracks.length;
         for(i in 0...aNumTracks)
         {
            track = tracks[i];
            this.drawTrackLerp(g,track,alpha);
            if(track.name == this.childTrack && this.child != null)
            {
               this.child.useColor = this.useColor;
               this.child.additiveColor.copy(this.additiveColor);
               this.child.overrideColor.copy(this.overrideColor);
               this.child.x = this.locatorX + this.mChildOffsetX;
               this.child.y = this.locatorY + this.mChildOffsetY;
               this.child.drawLerp(g,transform,alpha);
            }
         }
         g.popState();
      }
      
      public function getTrackPosition(trackName:String) : Point
      {
         var aTrack= this.getTrack(trackName);
         var aTrans:ReanimTransform = aTrack.transforms[Std.int(this.mFrameTime.mFrameBefore)];
         return new Point(aTrans.kX,aTrans.kY);
      }
      
      function drawTrack(g:Graphics2D, track:ReanimTrack) 
      {
         var init:Matrix = null;
         if(this.mVisibleMap[track.name] == false)
         {
            return;
         }
         var transform:ReanimTransform = track.transforms[Std.int(this.mFrameTime.mFrameBefore)];
         if(transform.frame < 0)
         {
            return;
         }
         var matrix= transform.matrix;
         if(track.name == this.childTrack)
         {
            init = track.transforms[Std.int(this.mStartFrame)].matrix;
            this.locatorX = this.mX + (matrix.tx - init.tx);
            this.locatorY = this.mY + (matrix.ty - init.ty) + 1;
         }
         var cache= transform.cache;
         if(cache != null)
         {
            cache.useColor = this.useColor;
            if(cache.useColor)
            {
               cache.setColor(this.overrideColor.alpha + this.additiveColor.alpha,this.overrideColor.red + this.additiveColor.red,this.overrideColor.green + this.additiveColor.green,this.overrideColor.blue + this.additiveColor.blue);
            }
            g.blitImage(cache,this.mX,this.mY);
            return;
         }
         var img= transform.image;
         if(img == null)
         {
            return;
         }
         var src= img.pixels;
         var p0= new Point(0,0);
         var p1= new Point(src.width,0);
         var p2= new Point(src.width,src.height);
         var p3= new Point(0,src.height);
         p0 = matrix.transformPoint(p0);
         p1 = matrix.transformPoint(p1);
         p2 = matrix.transformPoint(p2);
         p3 = matrix.transformPoint(p3);
         var left= Math.ffloor(Math.min(Math.min(p0.x,p1.x),Math.min(p2.x,p3.x)));
         var right= Math.fceil(Math.max(Math.max(p0.x,p1.x),Math.max(p2.x,p3.x)));
         var top= Math.ffloor(Math.min(Math.min(p0.y,p1.y),Math.min(p2.y,p3.y)));
         var bottom= Math.fceil(Math.max(Math.max(p0.y,p1.y),Math.max(p2.y,p3.y)));
         matrix.translate(-left,-top);
         var aData= new BitmapData(Std.int(right - left),Std.int(bottom - top),true,0);
         var aCache= new ImageInst(new ImageData(aData));
         aCache.destPt.x = left;
         aCache.destPt.y = top;
         aData.draw(src,matrix,null,null,null,true);
         transform.cache = aCache;
         this.drawTrack(g,track);
      }
      
      @:flash.property @:isVar public var y(never,set):Float;
public function  set_y(value:Float) :Float      {
         return this.mY = value;
      }
      
            
      @:flash.property @:isVar public var animTime(get,set):Float;
public function  set_animTime(value:Float) :Float      {
         return this.mAnimTime = value;
      }
function  get_animTime() : Float
      {
         return this.mAnimTime;
      }
      
      @:flash.property @:isVar public var x(never,set):Float;
public function  set_x(value:Float) :Float      {
         return this.mX = value;
      }
   }

