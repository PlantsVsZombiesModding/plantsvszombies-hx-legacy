package com.popcap.flash.framework.resources.images;

import com.popcap.flash.framework.graphics.Graphics2D;
import flash.display.BitmapData;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.geom.Rectangle;

class ImageInst {
	var mFrame:Float = Math.NaN;

	public var destPt:Point;

	var mColorTransform:ColorTransform;

	var mGraphics:Graphics2D;

	public var doAdditiveBlend:Bool = false;

	public var useColor:Bool = false;

	public var doSmoothing:Bool = true;

	var mData:ImageData;

	var mPixels:BitmapData;

	var mSrcRect:Rectangle;

	public function new(param1:ImageData) {
		// super();
		this.destPt = new Point();
		this.mData = param1;
		this.mFrame = 0;
		this.mColorTransform = new ColorTransform();
	}

	@:flash.property @:isVar public var x(get, set):Float;

	public function set_x(param1:Float):Float {
		return this.destPt.x = param1;
	}

	@:flash.property @:isVar public var green(get, never):Float;

	public function get_green():Float {
		return this.mColorTransform.greenMultiplier;
	}

	@:flash.property @:isVar public var graphics(get, never):Graphics2D;

	public function get_graphics():Graphics2D {
		if (this.mGraphics == null) {
			this.mGraphics = new Graphics2D(this.pixels);
		}
		return this.mGraphics;
	}

	@:flash.property @:isVar public var width(get, never):Float;

	public function get_width():Float {
		return this.pixels.width;
	}

	public function setColor(param1:Float, param2:Float, param3:Float, param4:Float) {
		this.mColorTransform.alphaMultiplier = param1;

		this.mColorTransform.redMultiplier = param2;
		this.mColorTransform.greenMultiplier = param3;
		this.mColorTransform.blueMultiplier = param4;
	}

	@:flash.property @:isVar public var red(get, never):Float;

	public function get_red():Float {
		return this.mColorTransform.redMultiplier;
	}

	@:flash.property @:isVar public var alpha(get, never):Float;

	public function get_alpha():Float {
		return this.mColorTransform.alphaMultiplier;
	}

	@:flash.property @:isVar public var blue(get, never):Float;

	public function get_blue():Float {
		return this.mColorTransform.blueMultiplier;
	}

	@:flash.property @:isVar public var height(get, never):Float;

	public function get_height():Float {
		return this.pixels.height;
	}

	@:flash.property @:isVar public var srcRect(get, never):Rectangle;

	public function get_srcRect():Rectangle {
		var _loc1_:BitmapData = null;
		if (this.mSrcRect == null) {
			_loc1_ = this.pixels;
			this.mSrcRect = new Rectangle(0, 0, _loc1_.width, _loc1_.height);
		}
		return this.mSrcRect;
	}

	public function setFrame(param1:Int, param2:Int, param3:Int) {
		var _loc4_ = Std.int(param1 + param2 + param3 * this.mData.cols);
		var _loc5_ = this.mData.cels.length;
		_loc4_ = (_loc4_ = _loc4_ < 0 ? 0 : _loc4_) >= _loc5_ ? _loc5_ - 1 : _loc4_;
		this.mFrame = _loc4_;
		this.mPixels = this.mData.cels[_loc4_];
		this.mSrcRect = null;
	}

	@:flash.property @:isVar public var pixels(get, never):BitmapData;

	public function get_pixels():BitmapData {
		if (this.mPixels == null) {
			this.mPixels = this.mData.cels[0];
		}
		return this.mPixels;
	}

	@:flash.property @:isVar public var y(get, set):Float;

	public function set_y(param1:Float):Float {
		return this.destPt.y = param1;
	}

	function get_y():Float {
		return this.destPt.y;
	}

	@:flash.property @:isVar public var frame(never, set):Float;

	public function set_frame(param1:Float):Float {
		if (param1 < 0 || param1 >= this.mData.cels.length) {
			throw new Error("Frame \'" + param1 + "\' is out of range [0, " + (this.mData.cels.length - 1) + "]");
		}
		if (this.mFrame == param1) {
			return param1;
		}
		this.mFrame = param1;
		this.mPixels = this.mData.cels[Std.int(param1)];
		this.mSrcRect = null;
		return param1;
	}

	function get_x():Float {
		return this.destPt.x;
	}
}
