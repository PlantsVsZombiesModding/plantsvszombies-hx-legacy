package com.popcap.flash.framework.graphics;

import com.popcap.flash.framework.resources.fonts.FontInst;
import com.popcap.flash.framework.resources.images.ImageInst;
import openfl.display.BitmapData;
import openfl.geom.ColorTransform;
import openfl.geom.Matrix;
import openfl.geom.Point;
import openfl.geom.Rectangle;

class Graphics2D {
	static var mScratchRect:Rectangle = new Rectangle();

	static var mScratchPoint:Point = new Point();

	static var mScratchMatrix:Matrix = new Matrix();

	static var mScratchData:BitmapData;

	static var mScratchColorTransform:ColorTransform = new ColorTransform();

	var stateStack:Array<ASAny>;

	public var state:GraphicsState;

	var data:BitmapData;

	var stackPos:Int = 0;

	public function new(param1:BitmapData) {
		// super();
		this.data = param1;
		this.stateStack = new Array<ASAny>();
		this.stackPos = 0;
		this.state = new GraphicsState();
		this.state.clipRect.width = param1.width;
		this.state.clipRect.height = param1.height;
		if (mScratchData == null) {
			mScratchData = new BitmapData(param1.width, param1.height, true, 0);
		}
		this.stateStack.push(this.state);
	}

	public function popState() {
		if (this.stackPos == 0) {
			throw new Error("Unable to pop empty stack.");
		}
		this.stackPos += -1;
		this.state = this.stateStack[this.stackPos];
	}

	public function clearClipRect() {
		this.state.clipRect = new Rectangle(0, 0, this.data.width, this.data.height);
	}

	public function fillRect(param1:Float, param2:Float, param3:Float, param4:Float, param5:UInt) {
		mScratchRect.x = 0;
		mScratchRect.y = 0;
		mScratchRect.width = param3;
		mScratchRect.height = param4;
		mScratchPoint.x = param1;
		mScratchPoint.y = param2;
		mScratchData.fillRect(mScratchRect, param5);
		this.data.copyPixels(mScratchData, mScratchRect, mScratchPoint, null, null, true);
	}

	public function scale(param1:Float, param2:Float) {
		this.state.affineMatrix.scale(param1, param2);
	}

	public function clear() {
		this.fillRect(0, 0, this.data.width, this.data.height, Std.int(4278190080));
	}

	public function translate(param1:Float, param2:Float) {
		this.state.affineMatrix.translate(param1, param2);
	}

	public function reset() {
		this.stackPos = 0;
		this.state = this.stateStack[this.stackPos];
		this.state.affineMatrix.identity();
		this.state.clipRect.x = 0;
		this.state.clipRect.y = 0;
		this.state.clipRect.width = this.data.width;
		this.state.clipRect.height = this.data.height;
		this.state.font = null;
	}

	public function setFont(param1:FontInst) {
		this.state.font = param1;
	}

	public function setClipRect(param1:Float, param2:Float, param3:Float, param4:Float, param5:Bool = true) {
		var _loc6_ = new Rectangle(param1, param2, param3, param4);
		if (param5) {
			this.state.clipRect = _loc6_;
			return;
		}
		this.state.clipRect = this.state.clipRect.intersection(_loc6_);
	}

	public function pushState() {
		var _loc2_:GraphicsState = null;
		this.stackPos += 1;
		if (this.stackPos >= this.stateStack.length) {
			_loc2_ = new GraphicsState();
			this.stateStack.push(_loc2_);
		}
		var _loc1_ = this.state;
		this.state = this.stateStack[this.stackPos];
		this.state.affineMatrix.a = _loc1_.affineMatrix.a;
		this.state.affineMatrix.b = _loc1_.affineMatrix.b;
		this.state.affineMatrix.c = _loc1_.affineMatrix.c;
		this.state.affineMatrix.d = _loc1_.affineMatrix.d;
		this.state.affineMatrix.tx = _loc1_.affineMatrix.tx;
		this.state.affineMatrix.ty = _loc1_.affineMatrix.ty;
		this.state.clipRect.x = _loc1_.clipRect.x;
		this.state.clipRect.y = _loc1_.clipRect.y;
		this.state.clipRect.width = _loc1_.clipRect.width;
		this.state.clipRect.height = _loc1_.clipRect.height;
		this.state.font = _loc1_.font;
	}

	public function rotate(param1:Float) {
		this.state.affineMatrix.rotate(param1);
	}

	public function blitImage(param1:ImageInst, param2:Float = 0, param3:Float = 0) {
		var _loc4_ = param1.pixels;
		var _loc5_ = param1.srcRect;
		var _loc6_ = mScratchPoint;
		if (param1.useColor) {
			_loc6_.x = 0;
			_loc6_.y = 0;
			mScratchData.copyPixels(_loc4_, _loc5_, _loc6_);
			mScratchColorTransform.alphaMultiplier = param1.alpha;
			mScratchColorTransform.redMultiplier = param1.red;
			mScratchColorTransform.greenMultiplier = param1.green;
			mScratchColorTransform.blueMultiplier = param1.blue;
			mScratchData.colorTransform(_loc5_, mScratchColorTransform);
			_loc4_ = mScratchData;
		}
		_loc6_.x = this.state.affineMatrix.tx + param2 + param1.destPt.x;
		_loc6_.y = this.state.affineMatrix.ty + param3 + param1.destPt.y;
		this.data.copyPixels(_loc4_, _loc5_, _loc6_, null, null, true);
	}

	public function setTransform(param1:Matrix) {
		this.state.affineMatrix = param1.clone();
	}

	public function transform(param1:Matrix) {
		var _loc2_ = param1.clone();
		_loc2_.concat(this.state.affineMatrix);
		this.state.affineMatrix = _loc2_;
	}

	public function drawString(param1:String, param2:Float, param3:Float) {
		if (this.state.font == null) {
			return;
		}
		this.state.font.draw(this, param2, param3, param1, this.state.clipRect);
	}

	public function getTransform():Matrix {
		return this.state.affineMatrix.clone();
	}

	public function drawImage(param1:ImageInst, param2:Float = 0, param3:Float = 0) {
		if (param1.width == 0 || param1.height == 0) {
			return;
		}
		var _loc4_:ColorTransform = null;
		if (param1.useColor) {
			mScratchColorTransform.alphaMultiplier = param1.alpha;
			mScratchColorTransform.redMultiplier = param1.red;
			mScratchColorTransform.greenMultiplier = param1.green;
			mScratchColorTransform.blueMultiplier = param1.blue;
			_loc4_ = mScratchColorTransform;
		}
		this.state.affineMatrix.translate(param2, param3);
		this.data.draw(param1.pixels, this.state.affineMatrix, _loc4_, null, this.state.clipRect, param1.doSmoothing);
		this.state.affineMatrix.translate(-param2, -param3);
	}

	public function identity() {
		this.state.affineMatrix = new Matrix();
	}
}
