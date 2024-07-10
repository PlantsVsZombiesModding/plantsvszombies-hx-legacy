package com.popcap.flash.framework.resources.foley;

import com.popcap.flash.framework.AppBase;

class FoleyManager {
	public static inline final MAX_FOLEY_INSTANCES:Float = 8;

	var mFoleyMap:ASDictionary<ASAny, ASAny>;

	var mApp:AppBase;

	public function new(app:AppBase) {
		// super();
		this.mApp = app;
		this.mFoleyMap = new ASDictionary<ASAny, ASAny>();
	}

	public function loadFoley(type:FoleyType) {
		var aData = new FoleyTypeData(type);
		this.mFoleyMap[type] = aData;
	}

	public function playFoley(type:FoleyType) {
		var aData:FoleyTypeData = this.mFoleyMap[type];
		if (aData == null) {
			throw new Error("FoleyType \'" + type + "\' not loaded.");
		}
		var aType = aData.mType;
		var aPitch:Float = 0;
		if (aType.pitchRange != 0) {
			aPitch = Math.random() * aType.pitchRange;
		}
		this.playFoleyPitch(aData, aPitch);
	}

	function playFoleyPitch(data:FoleyTypeData, pitch:Float) {
		var aType = data.mType;
		var aTimeNow = flash.Lib.getTimer();
		if (aTimeNow - data.mLastPlayed < 100) {
			return;
		}
		if (aType.flags.hasFlags(FoleyFlags.ONE_AT_A_TIME)) {}
		var aVariations = new Array<ASAny>();
		var aVariationCount = aType.variations.length;
		for (i in 0...aVariationCount) {
			if (!(aType.flags.hasFlags(FoleyFlags.DONT_REPEAT) && data.mLastVariationPlayed == i)) {
				aVariations.push(aType.variations[i]);
			}
		}
		var aNumChoices = aVariations.length;
		var aChosen = Math.floor(Math.random() * aNumChoices);
		data.mLastVariationPlayed = aChosen;
		var aSoundId = ASCompat.toString(aType.variations[aChosen]);
		var aNumPlaying = this.mApp.soundManager.getNumPlaying(aSoundId);
		if (aNumPlaying >= MAX_FOLEY_INSTANCES) {
			return;
		}
		if (aType.flags.hasFlags(FoleyFlags.USES_MUSIC_VOLUME)) {}
		var isLooping = aType.flags.hasFlags(FoleyFlags.LOOP);
		data.mLastPlayed = flash.Lib.getTimer();
		this.mApp.soundManager.playSound(aSoundId);
	}
}
