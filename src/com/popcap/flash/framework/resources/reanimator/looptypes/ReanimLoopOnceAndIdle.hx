package com.popcap.flash.framework.resources.reanimator.looptypes;

import com.popcap.flash.framework.resources.reanimator.ReanimLoopType;
import com.popcap.flash.framework.resources.reanimator.Reanimation;

class ReanimLoopOnceAndIdle extends ReanimLoopType {
	var mIdleRate:Float = 0;

	var mIdleTrack:String;

	public function new(idleTrack:String, idleRate:Float) {
		super();
		// super();
		this.mIdleTrack = idleTrack;
		this.mIdleRate = idleRate;
	}

	override public function updatePositive(reanim:Reanimation) {
		if (reanim.animTime > 1) {
			reanim.animTime = 0;
			reanim.currentTrack = this.mIdleTrack;
			reanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
			reanim.animRate = this.mIdleRate;
		}
	}

	override public function doHold():Bool {
		return true;
	}

	override public function updateNegative(reanim:Reanimation) {
		if (reanim.animTime < 0) {
			reanim.animTime = 1;
			reanim.currentTrack = this.mIdleTrack;
			reanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
			reanim.animRate = this.mIdleRate;
		}
	}
}
