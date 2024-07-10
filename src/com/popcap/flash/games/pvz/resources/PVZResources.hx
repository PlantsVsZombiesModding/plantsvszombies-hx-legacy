package com.popcap.flash.games.pvz.resources;

import com.popcap.flash.framework.resources.ResourceLibrary;
import openfl.display.Sprite;

class PVZResources extends Sprite implements ResourceLibrary {
	var mResources:ASDictionary<ASAny, ASAny>;

	public function new() {
		super();
		// super();
		this.init();
	}

	function init() {
		this.mResources = new ASDictionary<ASAny, ASAny>();
		PVZImageLoader.init(this.mResources);
		PVZSoundLoader.init(this.mResources);
		PVZFontLoader.init(this.mResources);
		PVZReanimLoader.init(this.mResources);
		PVZParticleLoader.init(this.mResources);
	}

	public function getResource(param1:String):ASObject {
		var _loc2_:String = null;
		if (this.mResources[param1] == null) {
			for (_tmp_ in this.mResources.keys()) {
				_loc2_ = _tmp_;
				trace(_loc2_ + "\n");
			}
		}
		return this.mResources[param1];
	}
}
