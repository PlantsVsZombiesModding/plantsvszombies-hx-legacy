package com.popcap.flash.framework.resources.particles;

import com.popcap.flash.framework.utils.CEnum;

class CurveType extends CEnum {
	public static final EASE_IN_OUT:CurveType = new CurveType();

	public static final BOUNCE:CurveType = new CurveType();

	public static final EASE_IN:CurveType = new CurveType();

	public static final FAST_IN_OUT:CurveType = new CurveType();

	public static final EASE_SIN_WAVE:CurveType = new CurveType();

	public static final BOUNCE_SLOW_MIDDLE:CurveType = new CurveType();

	public static final EASE_OUT:CurveType = new CurveType();

	public static final FAST_IN_OUT_WEAK:CurveType = new CurveType();

	public static final BOUNCE_FAST_MIDDLE:CurveType = new CurveType();

	public static final CONSTANT:CurveType = new CurveType();

	public static final LINEAR:CurveType = new CurveType();

	public static final SIN_WAVE:CurveType = new CurveType();

	public static final EASE_IN_OUT_WEAK:CurveType = new CurveType();

	public function new() {
		super();
		// super();
	}

	public static function fromUInt(param1:UInt):CurveType {
		switch (param1) {
			case 0:
				return CONSTANT;
			case 1:
				return LINEAR;
			case 2:
				return EASE_IN;
			case 3:
				return EASE_OUT;
			case 4:
				return EASE_IN_OUT;
			case 5:
				return EASE_IN_OUT_WEAK;
			case 6:
				return FAST_IN_OUT;
			case 7:
				return FAST_IN_OUT_WEAK;
			case 8:
				return BOUNCE;
			case 9:
				return BOUNCE_FAST_MIDDLE;
			case 10:
				return BOUNCE_SLOW_MIDDLE;
			case 11:
				return SIN_WAVE;
			case 12:
				return EASE_SIN_WAVE;
			default:
				throw new haxe.Exception ("Value does not map to a CurveType");
		}
	}

	public static function toUInt(param1:CurveType):UInt {
		if (param1 == CONSTANT) {
			return 0;
		}
		if (param1 == LINEAR) {
			return 1;
		}
		if (param1 == EASE_IN) {
			return 2;
		}
		if (param1 == EASE_OUT) {
			return 3;
		}
		if (param1 == EASE_IN_OUT) {
			return 4;
		}
		if (param1 == EASE_IN_OUT_WEAK) {
			return 5;
		}
		if (param1 == FAST_IN_OUT) {
			return 6;
		}
		if (param1 == FAST_IN_OUT_WEAK) {
			return 7;
		}
		if (param1 == BOUNCE) {
			return 8;
		}
		if (param1 == BOUNCE_FAST_MIDDLE) {
			return 9;
		}
		if (param1 == BOUNCE_SLOW_MIDDLE) {
			return 10;
		}
		if (param1 == SIN_WAVE) {
			return 11;
		}
		if (param1 == EASE_SIN_WAVE) {
			return 12;
		}
		throw new Error("How did I get here?");
	}

	public function toString():String {
		return name;
	}

	static final ___init = {
		{
			CEnum.InitEnumConstants(CurveType);
		}
		null;
	};
}
