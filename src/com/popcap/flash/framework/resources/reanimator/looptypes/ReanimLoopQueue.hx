package com.popcap.flash.framework.resources.reanimator.looptypes;

import com.popcap.flash.framework.resources.reanimator.ReanimLoopType;
import com.popcap.flash.framework.resources.reanimator.Reanimation;

class ReanimLoopQueue extends ReanimLoopType {
	var mTracks:Array<ASAny>;

	public function new(tracks:Array<ASAny>) {
		super();
		// super();
		this.mTracks = tracks;
	}

	override public function updatePositive(reanim:Reanimation) {
		var aNewTrack:String = null;
		if (reanim.animTime >= 1) {
			aNewTrack = this.mTracks.shift();
			if (aNewTrack == null) {
				reanim.animTime = 0;
				reanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
			} else {
				reanim.animTime = 0;
				reanim.currentTrack = aNewTrack;
			}
		}
	}

	override public function updateNegative(reanim:Reanimation) {
		var aNewTrack:String = null;
		if (reanim.animTime <= 0) {
			aNewTrack = this.mTracks.shift();
			if (aNewTrack == null) {
				reanim.animTime = 1;
				reanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
			} else {
				reanim.animTime = 1;
				reanim.currentTrack = aNewTrack;
			}
		}
	}
}
