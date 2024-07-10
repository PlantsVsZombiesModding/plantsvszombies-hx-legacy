package mx.utils;

import openfl.display.DisplayObject;
import Globals.flash_utils_getQualifiedClassName as getQualifiedClassName;
import mx.core.IRepeaterClient;

// import mx.core.mx_internal;
// use namespace mx_internal;
class NameUtil {
	// mx_internal static const VERSION:String = "3.3.0.4852";
	static var counter:Int = 0;

	public function new() {
		// super();
	}

	public static function displayObjectToString(param1:DisplayObject):String {
		var result:String = null;
		var o:DisplayObject = null;
		var s:String = null;
		var indices:Array<ASAny> = null;
		var displayObject = param1;
		try {
			o = displayObject;
			while (o != null) {
				if (o.parent != null && o.stage != null && o.parent == o.stage) {
					break;
				}
				s = o.name;
				if (Std.isOfType(o, IRepeaterClient)) {
					indices = cast(o, IRepeaterClient).instanceIndices;
					if (indices != null) {
						s += "[" + indices.join("][") + "]";
					}
				}
				result = result == null ? s : s + "." + result;
				o = o.parent;
			}
		} catch (e:SecurityError) {}
		return result;
	}

	public static function createUniqueName(param1:ASObject):String {
		if (!param1) {
			return null;
		}
		var _loc2_:ASAny = getQualifiedClassName(param1);
		var _loc3_:Int = _loc2_.indexOf("::");
		if (_loc3_ != -1) {
			_loc2_ = _loc2_.substr(_loc3_ + 2);
		}
		var _loc4_:Int;
		if ((_loc4_ = _loc2_.charCodeAt(_loc2_.length - 1)) >= 48 && _loc4_ <= 57) {
			_loc2_ += "_";
		}
		return _loc2_ + counter++;
	}
}
