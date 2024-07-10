package com.popcap.flash.games.pvz.logic;

import com.popcap.flash.framework.graphics.Color;

class TodCommon {
	public static inline final CURVE_WEAK_FAST_IN_OUT = 8;

	public static inline final CURVE_SIN_WAVE = 12;

	public static inline final CURVE_BOUNCE_FAST_MIDDLE = 10;

	public static inline final CURVE_CONSTANT = 0;

	public static inline final CURVE_LINEAR = 1;

	public static inline final CURVE_EASE_IN_OUT = 4;

	public static inline final CURVE_EASE_IN = 2;

	public static inline final SECONDS_PER_UPDATE:Float = 0.01;

	public static inline final EPSILON:Float = 0.000001;

	public static inline final CURVE_EASE_OUT = 3;

	public static inline final CURVE_FAST_IN_OUT_WEAK = 7;

	public static inline final CURVE_BOUNCE_SLOW_MIDDLE = 11;

	public static inline final CURVE_EASE_SIN_WAVE = 13;

	public static inline final CURVE_EASE_IN_OUT_WEAK = 5;

	public static inline final CURVE_FAST_IN_OUT = 6;

	static var gFlashingColor:Color = new Color();

	public static inline final CURVE_BOUNCE = 9;

	public static inline final PI:Float = 3.141592653;

	public static final CIRCLE_HALF:Float = PI;

	public static final CIRCLE_FULL:Float = PI * 2;

	public static final CIRCLE_QUARTER:Float = PI * 0.5;

	public static final CIRCLE_SIXTH:Float = PI * 0.333333333;

	public static final CIRCLE_EIGHTH:Float = PI * 0.25;

	public static inline final TICKS_PER_SECOND:Float = 100;

	public function new() {
		// super();
	}

	public static function ClampFloat(num:Float, minNum:Float, maxNum:Float):Float {
		if (num <= minNum) {
			return minNum;
		}
		if (num >= maxNum) {
			return maxNum;
		}
		return num;
	}

	public static function TodPickFromArray(theArray:Array<ASAny>, theCount:Int):Int {
		var aPick = Std.int(Math.random() * theCount);
		return theArray[aPick];
	}

	public static function TodCurveEvaluate(theTime:Float, thePositionStart:Float, thePositionEnd:Float, theCurve:Int):Float {
		var aWarpedTime = Math.NaN;
		switch (theCurve) {
			case CURVE_CONSTANT:
				aWarpedTime = 0;

			case CURVE_LINEAR:
				aWarpedTime = theTime;

			case CURVE_EASE_IN:
				aWarpedTime = TodCurveQuad(theTime);

			case CURVE_EASE_OUT:
				aWarpedTime = TodCurveInvQuad(theTime);

			case CURVE_EASE_IN_OUT:
				aWarpedTime = TodCurveS(TodCurveS(theTime));

			case CURVE_EASE_IN_OUT_WEAK:
				aWarpedTime = TodCurveS(theTime);

			case CURVE_FAST_IN_OUT:
				aWarpedTime = TodCurveInvQuadS(TodCurveInvQuadS(theTime));

			case CURVE_FAST_IN_OUT_WEAK:
				aWarpedTime = TodCurveInvQuadS(theTime);

			case CURVE_BOUNCE:
				aWarpedTime = TodCurveBounce(theTime);

			case CURVE_BOUNCE_FAST_MIDDLE:
				aWarpedTime = TodCurveQuad(TodCurveBounce(theTime));

			case CURVE_BOUNCE_SLOW_MIDDLE:
				aWarpedTime = TodCurveInvQuad(TodCurveBounce(theTime));

			case CURVE_SIN_WAVE:
				aWarpedTime = Math.sin(theTime * CIRCLE_FULL);

			case CURVE_EASE_SIN_WAVE:
				aWarpedTime = Math.sin(TodCurveS(theTime) * CIRCLE_FULL);

			default:
				aWarpedTime = 0;
		}
		return FloatLerp(thePositionStart, thePositionEnd, aWarpedTime);
	}

	public static function TodCalcSmoothWeight(aWeight:Float, aLastPicked:Float, aSecondLastPicked:Float):Float {
		if (aWeight < EPSILON) {
			return 0;
		}
		var aSmoothFactor:Float = 2;
		var aExpectedLength1 = 1 / aWeight;
		var aExpectedLength2 = aExpectedLength1 * 2;
		var aDelta1 = aLastPicked + 1 - aExpectedLength1;
		var aDelta2 = aSecondLastPicked + 1 - aExpectedLength2;
		var aFactor1 = 1 + aDelta1 / aExpectedLength1 * aSmoothFactor;
		var aFactor2 = 1 + aDelta2 / aExpectedLength2 * aSmoothFactor;
		var aFactorFinal = TodCommon.ClampFloat(aFactor1 * 0.75 + aFactor2 * 0.25, 0.01, 100);
		return aWeight * aFactorFinal;
	}

	public static function TodPickFromWeightedGridArray(theArray:Array<ASAny>, theCount:Int):WeightedGridArray {
		var aTotalWeight = 0;
		for (i in 0...theCount) {
			aTotalWeight += theArray[i].mWeight;
		}
		var aPick = Std.int(Math.random() * aTotalWeight);
		var aAcculumatedWeight = 0;
		var i:ASAny = 0;
		while (i < theCount) {
			aAcculumatedWeight += theArray[i].mWeight;
			if (aPick < aAcculumatedWeight) {
				return theArray[i];
			}
			i++;
		}
		return theArray[0];
	}

	public static function TodCurveQuad(theTime:Float):Float {
		return theTime * theTime;
	}

	public static function TodPickFromWeightedArray(theArray:Array<ASAny>, theCount:Int):Int {
		var aArrayItem = TodPickArrayItemFromWeightedArray(theArray, theCount);
		return aArrayItem.mItem;
	}

	public static function TodCurveInvQuad(theTime:Float):Float {
		return 2 * theTime - theTime * theTime;
	}

	public static function TodCurveEvaluateClamped(theTime:Float, thePositionStart:Float, thePositionEnd:Float, theCurve:Int):Float {
		if (theTime <= 0) {
			return thePositionStart;
		}
		if (theTime >= 1) {
			if (theCurve == CURVE_BOUNCE
				|| theCurve == CURVE_BOUNCE_SLOW_MIDDLE
				|| theCurve == CURVE_BOUNCE_FAST_MIDDLE
				|| theCurve == CURVE_SIN_WAVE
				|| theCurve == CURVE_EASE_SIN_WAVE) {
				return thePositionStart;
			}
			return thePositionEnd;
		}
		return TodCurveEvaluate(theTime, thePositionStart, thePositionEnd, theCurve);
	}

	public static function TodAnimateCurveFloat(theTimeStart:Int, theTimeEnd:Int, theTimeAge:Int, thePositionStart:Float, thePositionEnd:Float,
			theCurve:Int):Float {
		var aElapse = theTimeAge - theTimeStart;
		var aMoveTime = theTimeEnd - theTimeStart;
		var aTime = aElapse / aMoveTime;
		return TodCurveEvaluateClamped(aTime, thePositionStart, thePositionEnd, theCurve);
	}

	public static function TodCurveQuadS(theTime:Float):Float {
		if (theTime <= 0.5) {
			return TodCurveQuad(theTime * 2) * 0.5;
		}
		return TodCurveInvQuad((theTime - 0 * 2) * 0.5 + 0.5);
	}

	public static function RandRangeFloat(theMin:Float, theMax:Float):Float {
		return theMin + Math.random() * (theMax - theMin);
	}

	public static function RandRangeInt(theMin:Int, theMax:Int):Int {
		return Std.int(theMin + Math.random() * (theMax - theMin + 1));
	}

	public static function TodUpdateSmoothArrayPick(theArray:Array<ASAny>, theCount:Int, thePickIndex:Int) {
		for (i in 0...theCount) {
			if (theArray[i].mWeight > 0) {
				++theArray[i].mLastPicked;
				++theArray[i].mSecondLastPicked;
			}
		}
		theArray[thePickIndex].mSecondLastPicked = theArray[thePickIndex].mLastPicked;
		theArray[thePickIndex].mLastPicked = 0;
	}

	public static function ClampInt(num:Int, minNum:Int, maxNum:Int):Int {
		if (num <= minNum) {
			return minNum;
		}
		if (num >= maxNum) {
			return maxNum;
		}
		return num;
	}

	public static function TodCurveS(theTime:Float):Float {
		return 3 * theTime * theTime - 2 * theTime * theTime * theTime;
	}

	public static function TodPickArrayItemFromWeightedArray(theArray:Array<ASAny>, theCount:Int):WeightedArray {
		var aTotalWeight = 0;
		for (i in 0...theCount) {
			aTotalWeight += theArray[i].mWeight;
		}
		var aPick = Std.int(Math.random() * aTotalWeight);
		var aAcculumatedWeight = 0;
		var i:ASAny = 0;
		while (i < theCount) {
			aAcculumatedWeight += theArray[i].mWeight;
			if (aPick < aAcculumatedWeight) {
				return theArray[i];
			}
			i++;
		}

		return theArray[0];
	}

	public static function TodAnimateCurve(theTimeStart:Int, theTimeEnd:Int, theTimeAge:Int, thePositionStart:Int, thePositionEnd:Int, theCurve:Int):Int {
		return Math.round(TodAnimateCurveFloat(theTimeStart, theTimeEnd, theTimeAge, thePositionStart, thePositionEnd, theCurve));
	}

	public static function TodCurveInvQuadS(theTime:Float):Float {
		if (theTime <= 0.5) {
			return TodCurveInvQuad(theTime * 2) * 0.5;
		}

		return TodCurveQuad((theTime - 0.5) * 2) * 0.5 + 0.5;
	}

	public static function FloatLerp(theZeroValue:Float, theOneValue:Float, theTime:Float):Float {
		var value = Math.NaN;

		return theZeroValue + (theOneValue - theZeroValue) * theTime;
	}

	public static function TodCurveBounce(theTime:Float):Float {
		return 1 - Math.abs(1 - theTime * 2);
	}

	public static function TodPickFromSmoothArray(theArray:Array<ASAny>, theCount:Int):Int {
		var aPickIndex = 0;
		var aItem:SmoothArray = null;
		var aTotalWeight:Float = 0;
		for (i in 0...theCount) {
			aTotalWeight += theArray[i].mWeight;
		}
		var aNormalizeFactor = 1 / aTotalWeight;
		var aTotalAdjustedWeight:Float = 0;
		var i:ASAny = 0;
		while (i < theCount) {
			aTotalAdjustedWeight += TodCalcSmoothWeight(theArray[i].mWeight * aNormalizeFactor, theArray[i].mLastPicked, theArray[i].mSecondLastPicked);
			i++;
		}
		var aRandWeight = Math.random() * aTotalAdjustedWeight;
		var aAcculumatedWeight:Float = 0;
		aPickIndex = 0;
		while (aPickIndex < theCount - 1) {
			aItem = theArray[aPickIndex];
			aAcculumatedWeight += TodCalcSmoothWeight(aItem.mWeight * aNormalizeFactor, aItem.mLastPicked, aItem.mSecondLastPicked);
			if (aRandWeight <= aAcculumatedWeight) {
				break;
			}
			aPickIndex++;
		}
		var i:ASAny = 0;
		while (i < theCount) {
			if (theArray[i].mWeight > 0) {
				++theArray[i].mLastPicked;
				++theArray[i].mSecondLastPicked;
			}
			i++;
		}

		theArray[aPickIndex].mSecondLastPicked = theArray[aPickIndex].mLastPicked;
		theArray[aPickIndex].mLastPicked = 0;
		TodUpdateSmoothArrayPick(theArray, theCount, aPickIndex);
		return theArray[aPickIndex].mItem;
	}

	public static function GetFlashingColor(theCounter:Int, theFlashTime:Int):Color {
		var aFlash = theCounter % theFlashTime;
		var aHalfFlashTime:ASAny = theFlashTime >> 1;
		var aGrayColor = ClampInt(Std.int(55 + Math.abs(aHalfFlashTime - aFlash) * 200 / aHalfFlashTime), 0, 255);
		gFlashingColor.alpha = 1;
		gFlashingColor.red = aGrayColor / 255;

		gFlashingColor.green = aGrayColor / 255;

		gFlashingColor.blue = aGrayColor / 255;
		return gFlashingColor;
	}
}
