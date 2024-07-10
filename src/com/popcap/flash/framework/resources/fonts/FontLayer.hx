package com.popcap.flash.framework.resources.fonts;

import com.popcap.flash.framework.resources.images.ImageInst;
import flash.geom.Point;

class FontLayer {
	public var mPointSize:Float = Math.NaN;

	public var mColorMult:Int = 0;

	public var mColorAdd:Int = 0;

	public var mLayerName:String;

	public var mBaseOrder:Float = Math.NaN;

	public var mMinPointSize:Float = Math.NaN;

	public var mDefaultHeight:Float = Math.NaN;

	public var mSpacing:Float = Math.NaN;

	public var mOffset:Point;

	public var mAscent:Float = Math.NaN;

	public var mImageId:String;

	public var mAscentPadding:Float = Math.NaN;

	public var mCharData:Array<ASAny>;

	public var mImage:ImageInst;

	public var mLineSpacingOffset:Float = Math.NaN;

	public var mMaxPointSize:Float = Math.NaN;

	public var mHeight:Float = Math.NaN;

	public function new() {
		// super();
		this.mCharData = new Array<ASAny>();
		this.mOffset = new Point();
		this.mSpacing = 0;
		this.mPointSize = 0;
		this.mAscent = 0;
		this.mAscentPadding = 0;
		this.mMinPointSize = -1;
		this.mMaxPointSize = -1;
		this.mHeight = 0;
		this.mDefaultHeight = 0;
		this.mColorMult = 4294967295;
		this.mColorAdd = 0;
		this.mLineSpacingOffset = 0;
		this.mBaseOrder = 0;
	}

	public function getCharData(param1:Int):CharData {
		var _loc2_:CharData = this.mCharData[param1];
		if (_loc2_ == null) {
			_loc2_ = new CharData();
			_loc2_.mCharCode = param1;
			this.mCharData[param1] = _loc2_;
		}
		return _loc2_;
	}

	@:flash.property @:isVar public var height(get, never):Float;

	public function get_height():Float {
		if (this.mHeight == 0) {
			this.mHeight = this.mImage.height;
		}
		return this.mHeight;
	}
}
