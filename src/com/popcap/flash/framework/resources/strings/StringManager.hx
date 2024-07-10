package com.popcap.flash.framework.resources.strings;

import com.popcap.flash.framework.AppBase;
import openfl.events.Event;
import openfl.events.EventDispatcher;
import openfl.events.IEventDispatcher;
import openfl.events.IOErrorEvent;
import openfl.net.URLLoader;
import openfl.net.URLRequest;

class StringManager implements IEventDispatcher {
	var mLoader:URLLoader;

	var mApp:AppBase;

	var mStrings:ASDictionary<ASAny, ASAny>;

	var mDispatcher:EventDispatcher;

	public function new(param1:AppBase) {
		// super();
		this.mApp = param1;
		this.mStrings = new ASDictionary<ASAny, ASAny>();
		this.mLoader = new URLLoader();
		this.mLoader.addEventListener(Event.COMPLETE, this.handleComplete);
		this.mLoader.addEventListener(IOErrorEvent.IO_ERROR, this.handleError);
		this.mDispatcher = new EventDispatcher(this);
	}

	function handleComplete(param1:Event) {
		var _loc8_:String = null;
		var _loc9_ = Math.NaN;
		var _loc2_:String = this.mLoader.data;
		//_loc2_ = new compat.RegExp("\\r\\n", "g").replace(_loc2_, "\n");
		//_loc2_ = new compat.RegExp("\\r", "g").replace(_loc2_, "\n");
		var _loc3_:Array<ASAny> = (cast new compat.RegExp("\\n").split(_loc2_));
		var _loc4_:String = null;
		var _loc5_:String = null;
		var _loc6_ = _loc3_.length;
		var _loc7_ = 0;
		while (_loc7_ < _loc6_) {
			if ((_loc8_ = ASCompat.toString(_loc3_[_loc7_])).length != 0) {
				if ((_loc9_ = new compat.RegExp("\\[[A-Z0-9_]+\\]").search(_loc8_)) == 0) {
					if (_loc4_ == null) {
						_loc4_ = _loc8_;
					} else {
						this.mStrings[_loc4_] = _loc5_;
						_loc4_ = _loc8_;
						_loc5_ = null;
					}
				} else if (_loc5_ == null) {
					_loc5_ = _loc8_;
				} else {
					_loc5_ = _loc5_ + "\n" + _loc8_;
				}
			}
			_loc7_++;
		}
		this.mStrings[_loc4_] = _loc5_;
		this.mDispatcher.dispatchEvent(new Event(Event.COMPLETE));
	}

	public function hasEventListener(param1:String):Bool {
		return this.mDispatcher.hasEventListener(param1);
	}

	function handleError(param1:IOErrorEvent) {}

	public function willTrigger(param1:String):Bool {
		return this.mDispatcher.willTrigger(param1);
	}

	public function addEventListener(param1:String, param2:ASFunction, param3:Bool = false, param4:Int = 0, param5:Bool = false) {
		this.mDispatcher.addEventListener(param1, param2, param3, param4, param5);
	}

	public function removeEventListener(param1:String, param2:ASFunction, param3:Bool = false) {
		this.mDispatcher.removeEventListener(param1, param2, param3);
	}

	public function dispatchEvent(param1:Event):Bool {
		return this.mDispatcher.dispatchEvent(param1);
	}

	public function loadStrings(param1:String) {
		var _loc2_ = new URLRequest(param1);
		this.mLoader.load(_loc2_);
	}

	public function translateString(param1:String):String {
		var _loc2_ = ASCompat.toString(this.mStrings[param1]);
		if (_loc2_ == null) {
			return "\'" + param1 + "\' string has not been loaded.";
		}
		return _loc2_;
	}
}
