package com.popcap.flash.framework.resources.reanimator.looptypes;

import com.popcap.flash.framework.resources.reanimator.ReanimLoopType;
import com.popcap.flash.framework.resources.reanimator.Reanimation;

class ReanimLoopAlways extends ReanimLoopType {
	public function new() {
		super();
		// super();
	}

	override public function updatePositive(reanim:Reanimation) {
		var aFinalTime = reanim.animTime;
		while (aFinalTime >= 1) {
			aFinalTime--;
		}
		reanim.animTime = aFinalTime;
	}

	override public function updateNegative(reanim:Reanimation) {
		var aFinalTime = reanim.animTime;
		while (aFinalTime < 0) {
			aFinalTime += 1;
		}
		reanim.animTime = aFinalTime;
	}
}
