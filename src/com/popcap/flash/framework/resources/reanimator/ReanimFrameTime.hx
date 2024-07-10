package com.popcap.flash.framework.resources.reanimator;

class ReanimFrameTime {
	public var mFraction:Float = 0;

	public var mFrameAfter:Float = 0;

	public var mFrameBefore:Float = 0;

	public function new() {
		// super();
	}

	public function update(animTime:Float, startFrame:Float, frameCount:Float, hold:Bool = false) {
		var aFrameCount = frameCount;
		var aAnimPosition = startFrame + aFrameCount * animTime;
		var aAnimFrameBefore:Float = Std.int(aAnimPosition);
		var aLastFrame = startFrame + frameCount - 1;
		this.mFraction = aAnimPosition - aAnimFrameBefore;
		this.mFrameBefore = aAnimFrameBefore;
		this.mFrameAfter = this.mFrameBefore + 1;
		if (hold && animTime == 1) {
			this.mFrameBefore = aLastFrame;
			this.mFrameAfter = aLastFrame;
		}
	}
}
