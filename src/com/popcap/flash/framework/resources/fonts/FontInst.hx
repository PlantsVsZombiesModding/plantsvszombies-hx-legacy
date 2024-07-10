package com.popcap.flash.framework.resources.fonts;

import com.popcap.flash.framework.graphics.Color;
import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.resources.images.ImageInst;
import openfl.geom.ColorTransform;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;

class FontInst {
	var mColorTransform:ColorTransform;

	var mData:FontData;

	var mScale:Float = Math.NaN;

	public function new(param1:FontData) {
		this.mColorTransform = new ColorTransform();
		// super();
		this.mData = param1;
		this.mScale = 1;
	}

	public function getAscentPadding():Float {
		return this.mData.getAscentPadding() * this.mScale;
	}

	public function stringImageWidth(param1:String):Float {
		return this.mData.stringImageWidth(param1) * this.mScale;
	}

	public function getDescent():Float {
		return this.mData.getDescent() * this.mScale;
	}

	public function setColor(param1:Float, param2:Float, param3:Float, param4:Float) {
		this.mColorTransform.alphaMultiplier = param1;
		this.mColorTransform.redMultiplier = param2;
		this.mColorTransform.greenMultiplier = param3;
		this.mColorTransform.blueMultiplier = param4;
	}

	@:flash.property @:isVar public var scale(get, set):Float;

	public function get_scale():Float {
		return this.mScale;
	}

	public function draw(param1:Graphics2D, param2:Float, param3:Float, param4:String, param5:Rectangle) {
		var _loc11_:FontLayer = null;
		var _loc12_ = Math.NaN;
		var _loc13_ = 0;
		var _loc14_ = 0;
		var _loc15_ = Math.NaN;
		var _loc16_:CharData = null;
		var _loc17_ = Math.NaN;
		var _loc18_ = Math.NaN;
		var _loc19_ = Math.NaN;
		var _loc20_ = Math.NaN;
		var _loc21_ = Math.NaN;
		var _loc22_ = Math.NaN;
		var _loc23_:Color = null;
		var _loc24_:ImageInst = null;
		var _loc6_:FontLayer = this.mData.layerList[0];
		var _loc7_ = param1.getTransform();
		var _loc8_ = new Matrix();
		param1.identity();
		var _loc9_ = this.mData.layerList.length;
		var _loc10_ = 0;
		while (_loc10_ < _loc9_) {
			_loc11_ = this.mData.layerList[_loc10_];
			_loc12_ = 0;
			_loc13_ = param4.length;
			_loc14_ = 0;
			while (_loc14_ < _loc13_) {
				_loc15_ = param4.charCodeAt(_loc14_);
				_loc16_ = _loc11_.getCharData(Std.int(_loc15_));
				_loc17_ = _loc12_;
				_loc18_ = _loc12_;
				_loc19_ = 0;
				_loc20_ = _loc16_.mWidth;
				_loc21_ = _loc18_ + _loc6_.mOffset.x + _loc16_.mOffset.x;
				_loc22_ = -(_loc11_.mAscent - _loc11_.mOffset.y - _loc16_.mOffset.y);
				if (_loc16_.mImage != null) {
					_loc23_ = Color.fromInt(_loc11_.mColorMult);
					(_loc24_ = _loc16_.mImage).setColor(this.mColorTransform.alphaMultiplier * _loc23_.alpha,
						this.mColorTransform.redMultiplier * _loc23_.red, this.mColorTransform.greenMultiplier * _loc23_.green,
						this.mColorTransform.blueMultiplier * _loc23_.blue);
					_loc24_.useColor = true;
					_loc8_.identity();
					_loc8_.translate(_loc21_, 0);
					_loc8_.scale(this.mScale, this.mScale);
					_loc8_.concat(_loc7_);
					param1.setTransform(_loc8_);
					param1.drawImage(_loc16_.mImage, param2, param3);
				}
				if ((_loc18_ += _loc20_ + _loc19_) > _loc17_) {
					_loc17_ = _loc18_;
				}
				_loc12_ = _loc17_;
				_loc14_++;
			}
			_loc10_++;
		}
		param1.setTransform(_loc7_);
	}

	public function getAscent():Float {
		return this.mData.getAscent() * this.mScale;
	}

	function set_scale(param1:Float):Float {
		return this.mScale = param1;
	}

	public function getHeight():Float {
		return this.mData.getHeight() * this.mScale;
	}

	public function getLineSpacing():Float {
		return this.mData.getLineSpacing() * this.mScale;
	}

	public function getLineSpacingOffset():Float {
		return this.mData.getLineSpacingOffset() * this.mScale;
	}

	public function stringWidth(param1:String):Float {
		return this.mData.stringWidth(param1) * this.mScale;
	}
}
