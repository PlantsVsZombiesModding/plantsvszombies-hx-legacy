package com.popcap.flash.framework.graphics;

class Color {
	public var green:Float = 0;

	public var red:Float = 0;

	public var blue:Float = 0;

	public var alpha:Float = 0;

	public function new() {
		// super();
	}

	public static function add(param1:Color, param2:Color):Color {
		var _loc3_ = param1.alpha + param2.alpha;
		var _loc4_ = param1.red + param2.red;
		var _loc5_ = param1.green + param2.green;
		var _loc6_ = param1.blue + param2.blue;
		return ARGB(_loc3_ > 1 ? 1 : _loc3_, _loc4_ > 1 ? 1 : _loc4_, _loc5_ > 1 ? 1 : _loc5_, _loc6_ > 1 ? 1 : _loc6_);
	}

	public static function Gray(param1:Float):Color {
		return ARGB(1, param1, param1, param1);
	}

	public static function RGB(param1:Float, param2:Float, param3:Float):Color {
		return ARGB(1, param1, param2, param3);
	}

	public static function fromInt(param1:Int):Color {
		return ARGB(((param1 & 4278190080) >> 24 & 255) / 255, ((param1 & 16711680) >> 16 & 255) / 255, ((param1 & 65280) >> 8 & 255) / 255,
			((param1 & 255) >> 0 & 255) / 255);
	}

	public static function ARGB(param1:Float, param2:Float, param3:Float, param4:Float):Color {
		if (param1 < 0 || param1 > 1) {
			throw new ArgumentError("Alpha channel must be in the range [0.0, 1.0], was " + param1);
		}
		if (param2 < 0 || param2 > 1) {
			throw new ArgumentError("Red channel must be in the range [0.0, 1.0], was " + param2);
		}
		if (param3 < 0 || param3 > 1) {
			throw new ArgumentError("Green channel must be in the range [0.0, 1.0], was " + param3);
		}
		if (param4 < 0 || param4 > 1) {
			throw new ArgumentError("Blue channel must be in the range [0.0, 1.0], was " + param4);
		}
		var _loc5_:Color;
		(_loc5_ = new Color()).alpha = param1;
		_loc5_.red = param2;
		_loc5_.green = param3;
		_loc5_.blue = param4;
		return _loc5_;
	}

	public function toString():String {
		return "[" + this.alpha + ", " + this.red + ", " + this.green + ", " + this.blue + "]";
	}

	public function copy(param1:Color) {
		this.alpha = param1.alpha;
		this.red = param1.red;
		this.green = param1.green;
		this.blue = param1.blue;
	}

	public function toInt():Int {
		return (Std.int(this.alpha) & 255) << 24 | (Std.int(this.red) & 255) << 16 | (Std.int(this.green) & 255) << 8 | (Std.int(this.blue) & 255) << 0;
	}
}
