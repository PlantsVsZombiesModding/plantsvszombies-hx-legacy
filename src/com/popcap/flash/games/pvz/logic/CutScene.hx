package com.popcap.flash.games.pvz.logic;

import com.popcap.flash.framework.resources.reanimator.Reanimation;
import com.popcap.flash.games.pvz.PVZApp;

class CutScene {
	public var mCrazyDaveLastTalkIndex:Int = 0;

	public var mZombiesWonReanim:Reanimation;

	public var mPreloaded:Bool = false;

	public var mCutsceneTime:Int = 0;

	public var mSodTime:Int = 0;

	public var mSeedChoosing:Bool = false;

	public var mUpsellHideBoard:Bool = false;

	public var mLawnMowerTime:Int = 0;

	public var mPreUpdatingBoard:Bool = false;

	public var mCrazyDaveCountDown:Int = 0;

	public var mGraveStoneTime:Int = 0;

	public var mCrazyDaveTime:Int = 0;

	public var mPlacedZombies:Bool = false;

	public var mBossTime:Int = 0;

	public var mCrazyDaveDialogStart:Int = 0;

	public var mReadySetPlantTime:Int = 0;

	public var mPlacedLawnItems:Bool = false;

	public var mBoard:Board;

	public var mApp:PVZApp;

	public var mFogTime:Int = 0;

	public function new(app:PVZApp, theBoard:Board) {
		// super();
		this.mApp = app;
		this.mBoard = theBoard;
		this.mCutsceneTime = 0;
		this.mSodTime = 0;
		this.mFogTime = 0;
		this.mBossTime = 0;
		this.mCrazyDaveTime = 0;
		this.mGraveStoneTime = 0;
		this.mReadySetPlantTime = 0;
		this.mLawnMowerTime = 0;
		this.mCrazyDaveDialogStart = -1;
		this.mSeedChoosing = false;
		this.mZombiesWonReanim = null;
		this.mPreloaded = false;
		this.mPlacedZombies = false;
		this.mPlacedLawnItems = false;
		this.mCrazyDaveCountDown = 0;
		this.mCrazyDaveLastTalkIndex = -1;
		this.mUpsellHideBoard = false;
		this.mPreUpdatingBoard = false;
	}
}
