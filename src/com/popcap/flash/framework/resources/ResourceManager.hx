package com.popcap.flash.framework.resources;

import com.popcap.flash.framework.AppBase;
import openfl.display.Loader;
import openfl.events.Event;
import openfl.net.URLRequest;

class ResourceManager {
	var mIsLoading:Bool = false;

	var mLoader:Loader;

	var mLibrary:ResourceLibrary;

	var mApp:AppBase;

	var mResources:ASDictionary<ASAny, ASAny>;

	public function new(param1:AppBase) {
		// super();
		this.mApp = param1;
		this.init();
	}

	public function getResource(param1:String):ASObject {
		if (this.mLibrary == null) {
			return this.mResources[param1];
		}
		if (this.mResources[param1] != null) {
			return this.mResources[param1];
		}
		return this.mLibrary.getResource(param1);
	}

	public function isLoading():Bool {
		return this.mIsLoading;
	}

	public function getPercentageLoaded():Float {
		if (!this.mIsLoading) {
			return 1;
		}
		var _loc1_:Float = this.mLoader.contentLoaderInfo.bytesLoaded;
		var _loc2_:Float = this.mLoader.contentLoaderInfo.bytesTotal + 1;
		var _loc3_ = _loc1_ / _loc2_;
		if (Math.isNaN(_loc3_)) {
			return 0;
		}
		return _loc3_;
	}

	public function loadResourceLibrary(param1:String) {
		if (this.mIsLoading) {
			throw new Error("Only one library may be loaded at a time.");
		}
		this.mIsLoading = true;
		var _loc2_ = new URLRequest(param1);
		this.mLoader.load(_loc2_);
	}

	function init() {
		this.mResources = new ASDictionary<ASAny, ASAny>();
		this.mIsLoading = false;
		this.mLoader = new Loader();
		var _loc1_ = this.mLoader.contentLoaderInfo;
		_loc1_.addEventListener(Event.COMPLETE, this.handleLibrary);
	}

	function handleLibrary(param1:Event) {
		this.mLibrary = ASCompat.reinterpretAs(this.mLoader.content, ResourceLibrary);
		this.mIsLoading = false;
	}

	public function setResource(param1:String, param2:ASObject) {
		this.mResources[param1] = param2;
	}
}
