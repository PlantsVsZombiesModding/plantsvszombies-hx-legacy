package mx.core;

import flash.display.BitmapData;

// use namespace mx_internal;
class BitmapAsset extends FlexBitmap implements IFlexAsset implements IFlexDisplayObject {
	// mx_internal static const VERSION:String = "3.3.0.4852";
	public function new(param1:BitmapData = null, param2:String = "auto", param3:Bool = false) {
		super(param1, param2, param3);
	}

	@:flash.property @:isVar public var measuredWidth(get, never):Float;

	public function get_measuredWidth():Float {
		if (bitmapData != null) {
			return bitmapData.width;
		}
		return 0;
	}

	@:flash.property @:isVar public var measuredHeight(get, never):Float;

	public function get_measuredHeight():Float {
		if (bitmapData != null) {
			return bitmapData.height;
		}

		return 0;
	}

	public function setActualSize(param1:Float, param2:Float) {
		width = param1;

		height = param2;
	}

	public function move(param1:Float, param2:Float) {
		this.x = param1;
		this.y = param2;
	}
}
