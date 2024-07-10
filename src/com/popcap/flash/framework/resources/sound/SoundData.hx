package com.popcap.flash.framework.resources.sound;

import openfl.media.Sound;

class SoundData {
	public var mSource:Sound;

	public var mRefCount:Float = 0;

	public function new(param1:Sound = null) {
		// super();
		this.mSource = param1;
	}
}
