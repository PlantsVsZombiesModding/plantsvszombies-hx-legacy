package com.popcap.flash.games.pvz.logic;

import com.popcap.flash.framework.resources.images.ImageInst;
import com.popcap.flash.framework.resources.particles.ParticleSystem;
import com.popcap.flash.framework.resources.reanimator.Reanimation;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.PVZFoleyType;
import com.popcap.flash.games.pvz.logic.plants.CPlant;
import com.popcap.flash.games.pvz.logic.zombies.Zombie;
import com.popcap.flash.games.pvz.renderables.GridItemRenderable;
import com.popcap.flash.games.pvz.renderables.ParticleRenderable;
import com.popcap.flash.games.pvz.renderables.ReanimationRenderable;
import com.popcap.flash.games.pvz.resources.PVZImages;
import com.popcap.flash.games.pvz.resources.PVZParticles;

class Challenge {
	static inline final OBJECT_TYPE_PLANT = 1;

	static inline final CURSOR_TYPE_HAMMER = 4;

	public static inline final FLAG_RAISE_TIME = 100;

	public static inline final GRIDSQUARE_NONE = 0;

	public static inline final REANIM_CHERRYBOMB = 3;

	public static inline final BACKGROUND_1_DAY = 0;

	static inline final CURSOR_TYPE_NORMAL = 0;

	static inline final OBJECT_TYPE_NONE = 0;

	public static inline final ZOMBIE_DOOR = 6;

	public static inline final SCARYPOT_SUN = 3;

	static inline final SCENE_CREDIT = 6;

	static inline final COIN_NONE = "none";

	static inline final SCENE_CHALLENGE = 7;

	public static inline final PLANTROW_DIRT = 1;

	public static inline final GRIDSQUARE_GRASS = 1;

	static inline final LAWN_XMIN = 20;

	public static inline final SCARYPOT_SEED = 1;

	public static inline final MAX_ZOMBIE_WAVES = 100;

	static inline final OBJECT_TYPE_SHOVEL = 5;

	static inline final SCENE_LOADING = 0;

	public static inline final GRIDITEM_STATE_SCARY_POT_LEAF = 4;

	public static inline final GRIDITEM_STATE_SCARY_POT_QUESTION = 3;

	static inline final SEED_NONE = -1;

	static inline final SEED_CHERRYBOMB = 2;

	static inline final SCENE_LEVEL_INTRO = 2;

	public static inline final GRIDSQUARE_DIRT = 2;

	public static inline final RENDER_LAYER_GROUND = 200000;

	public static inline final PROGRESS_METER_COUNTER = 100;

	static inline final COIN_FINAL_SEED_PACKET = "finalseedpacket";

	public static final MAX_SCARY_POTS:Int = 9 * 6;

	static inline final LAWN_YMIN = 77;

	public static inline final SEED_FUMESHROOM = 10;

	static inline final SCENE_AWARD = 5;

	static inline final ZOMBIE_COUNTDOWN_MIN = 400;

	static inline final ZOMBIE_COUNTDOWN_FIRST_WAVE = 1800;

	static inline final SEED_SNOWPEA = 5;

	public static inline final ZOMBIE_INVALID = -1;

	static inline final BOARD_HEIGHT = 405;

	static inline final COIN_MOTION_COIN = "coin";

	static inline final SEED_SQUASH = 4;

	static inline final SCENE_ZOMBIES_WON = 4;

	static inline final ZOMBIE_COUNTDOWN_BEFORE_REPICK = 5500;

	public static inline final SCARYPOT_DYNAMITE = 4;

	public static inline final REANIM_PEASHOOTER = 0;

	public static inline final STATECHALLENGE_NORMAL = 0;

	public static inline final SEED_LEFTPEATER = 49;

	static inline final BOARD_WIDTH = 540;

	public static inline final ZOMBIE_POLEVAULTER = 3;

	public static inline final REANIM_WALLNUT = 1;

	static inline final GRIDSIZEX = 9;

	static inline final GRIDSIZEY = 5;

	public static inline final RENDER_LAYER_COIN_BANK = 600000;

	public static inline final SEED_GRAVEBUSTER = 11;

	public static inline final SCARYPOT_NONE = 0;

	static inline final CURSOR_TYPE_PLANT_FROM_BANK = 1;

	public static inline final SEED_PUFFSHROOM = 8;

	static inline final OBJECT_TYPE_PROJECTILE = 2;

	static inline final CURSOR_TYPE_PLANT_FROM_USABLE_COIN = 2;

	static inline final SEED_PEASHOOTER = 0;

	public static inline final REANIM_SQUASH = 4;

	public static inline final ZOMBIE_NORMAL = 0;

	public static inline final RENDER_LAYER_FOG = 500000;

	static inline final SEED_EXPLODE_O_NUT = 50;

	static inline final ZOMBIE_COUNTDOWN = 2500;

	static inline final NUM_ZOMBIE_TYPES = 8;

	static inline final SCENE_PLAYING = 3;

	static inline final LAWN_XMAX = 513;

	static inline final SEED_SUNFLOWER = 1;

	static inline final SUN_COUNTDOWN_MAX = 950;

	static inline final SEED_CHOMPER = 6;

	public static inline final ZOMBIE_PAIL = 4;

	static inline final SCENE_MENU = 1;

	static inline final ZOMBIE_COUNTDOWN_RANGE = 600;

	static inline final SUN_COUNTDOWN_RANGE = 275;

	static inline final OBJECT_TYPE_SEEDPACKET = 4;

	public static inline final ZOMBIE_FOOTBALL = 7;

	public static inline final SCARYPOT_ZOMBIE = 2;

	public static inline final GRIDITEM_STATE_PORTAL_CLOSED = 2;

	static inline final COIN_MOTION_FROM_PLANT = "from plant";

	static inline final OBJECT_TYPE_COIN = 3;

	static inline final COIN_SUN = "sun";

	static inline final PLANTING_OK = "ok";

	public static inline final MAX_ZOMBIES_IN_WAVE = 50;

	public static inline final SEED_SUNSHROOM = 9;

	static inline final SEED_WALLNUT = 3;

	static inline final SEED_REPEATER = 7;

	public static inline final PLANTROW_NORMAL = 0;

	static inline final COIN_MOTION_FROM_SKY_SLOW = "from sky slow";

	public static inline final GRIDITEM_STATE_NORMAL = 0;

	public static inline final GRIDITEM_STATE_GRAVESTONE_SPECIAL = 1;

	static inline final LAWN_YMAX = 385;

	public static inline final BOARD_SHAKE_TIME = 12;

	public static inline final ZOMBIE_NEWSPAPER = 5;

	public static inline final RENDER_LAYER_LAWN = 300000;

	public static final RENDER_LAYER_PROJECTILE:Int = RENDER_LAYER_LAWN + 5000;

	public static final RENDER_LAYER_ZOMBIE:Int = RENDER_LAYER_LAWN + 3000;

	public static final RENDER_LAYER_GRAVE_STONE:Int = RENDER_LAYER_LAWN + 1000;

	public static final RENDER_LAYER_LAWN_MOWER:Int = RENDER_LAYER_LAWN + 6000;

	public static final RENDER_LAYER_PLANT:Int = RENDER_LAYER_LAWN + 2000;

	static inline final PLANTING_NOT_HERE = "not here";

	static inline final COIN_MOTION_FROM_SKY = "from sky";

	static inline final ZOMBIE_COUNTDOWN_BEFORE_FLAG = 4500;

	public static inline final RENDER_LAYER_ABOVE_UI = 800000;

	public static inline final STATECHALLENGE_SCARY_POTTER_MALLETING = 1;

	public static final RENDER_LAYER_PARTICLE:Int = RENDER_LAYER_LAWN + 7000;

	static inline final COIN_USABLE_SEED_PACKET = "usableseedpacket";

	static inline final SUN_COUNTDOWN = 425;

	public static inline final GRIDITEM_STATE_SCARY_POT_ZOMBIE = 5;

	public static inline final REANIM_SUNFLOWER = 2;

	public static inline final ZOMBIE_TRAFFIC_CONE = 2;

	public static inline final REANIM_NONE = -1;

	public static inline final RENDER_LAYER_TOP = 400000;

	static inline final CURSOR_TYPE_SHOVEL = 3;

	public static inline final RENDER_LAYER_UI_TOP = 700000;

	public static inline final ZOMBIE_FLAG = 1;

	public static inline final RENDER_LAYER_SCREEN_FADE = 900000;

	public static inline final RENDER_LAYER_UI_BOTTOM = 100000;

	public var mConveyorBeltCounter:Int = 0;

	var mBoard:Board;

	public var mScaryPotterPots:Int = 0;

	var app:PVZApp;

	public var mChallengeState:Int = 0;

	public var mChallengeScore:Int = 0;

	public var mChallengeStateCounter:Int = 0;

	public var mShowBowlingLine:Bool = false;

	public var mSurvivalStage:Int = 0;

	public var mMalletReanim:Reanimation;

	public var mLastConveyorSeedType:Int = 0;

	public var mChallengeGridX:Int = 0;

	public var mChallengeGridY:Int = 0;

	public function new(app:PVZApp, theBoard:Board) {
		// super();
		this.app = app;
		this.mBoard = theBoard;
		this.mChallengeStateCounter = 0;
		this.mConveyorBeltCounter = 0;
		this.mChallengeScore = 0;
		this.mShowBowlingLine = false;
		this.mLastConveyorSeedType = SEED_NONE;
		this.mSurvivalStage = 0;
		this.mChallengeGridX = 0;
		this.mChallengeGridY = 0;
		this.mScaryPotterPots = 0;
	}

	public function GetScaryPotAt(theGridX:Int, theGridY:Int):GridItem {
		var aGridItem:GridItem = null;
		for (_tmp_ in this.mBoard.mGridItems) {
			aGridItem = _tmp_;
			if (!(aGridItem.mGridX != theGridX || aGridItem.mGridY != theGridY)) {
				return aGridItem;
			}
		}
		return null;
	}

	public function MouseUp(x:Int, y:Int):Bool {
		return false;
	}

	public function ScaryPotterCountPots():Int {
		var aGridItem:GridItem = null;
		var aPots = 0;
		for (_tmp_ in this.mBoard.mGridItems) {
			aGridItem = _tmp_;
			if (aGridItem.mGridItemType == GridItem.GRIDITEM_SCARY_POT) {
				aPots++;
			}
		}

		return aPots;
	}

	public function GraveDangerSpawnRandomGrave() {
		var y = 0;
		var aWeightedGridArray:WeightedGridArray = null;
		var aPlant:CPlant = null;
		var aPicks = new Array<ASAny>();
		var aPickCount = 0;
		for (x in 4...GRIDSIZEX) {
			for (_tmp_ in 0...GRIDSIZEY) {
				y = _tmp_;
				aWeightedGridArray = new WeightedGridArray();
				aPicks[aPickCount] = aWeightedGridArray;
				if (this.mBoard.CanAddGraveStoneAt(x, y)) {
					aPlant = this.mBoard.GetPlantsOnLawn(x, y);
					if (aPlant != null) {
						aPicks[aPickCount].mWeight = 1;
					} else {
						aPicks[aPickCount].mWeight = 100000;
					}
					aPicks[aPickCount].mX = x;
					aPicks[aPickCount].mY = y;
					aPickCount++;
				}
			}
		}
		if (aPickCount == 0) {
			return;
		}

		var aResultItem = TodCommon.TodPickFromWeightedGridArray(aPicks, aPickCount);
		this.GraveDangerSpawnGraveAt(aResultItem.mX, aResultItem.mY);
	}

	public function UpdateZombieSpawning():Bool {
		if (this.app.IsScaryPotterLevel()) {
			return true;
		}
		return false;
	}

	public function PuzzlePhaseComplete(theGridX:Int, theGridY:Int) {
		if (this.app.mGameMode == PVZApp.GAMEMODE_SCARY_POTTER_ENDLESS) {
			if (this.mSurvivalStage + 1 == 15) {}
		}
		this.mBoard.FadeOutLevel();
	}

	public function ScaryPotterJackExplode(aPosX:Int, aPosY:Int) {
		var aGridItem:GridItem = null;
		var aGridX = this.mBoard.PixelToGridX(aPosX, aPosY);
		var aGridY = this.mBoard.PixelToGridY(aPosX, aPosY);
		for (_tmp_ in this.mBoard.mGridItems) {
			aGridItem = _tmp_;
			if (aGridItem.mGridItemType == GridItem.GRIDITEM_SCARY_POT) {
				if (!(aGridItem.mGridX < aGridX - 1 || aGridItem.mGridX > aGridX + 1 || aGridItem.mGridY < aGridY - 1 || aGridItem.mGridY > aGridY + 1)) {
					this.ScaryPotterOpenPot(aGridItem);
				}
			}
		}
	}

	public function InitZombieWavesSurvival() {
		var aZombieType = 0;
		this.mBoard.mZombieAllowed[ZOMBIE_NORMAL] = true;
		var aEasyZombieRand = Std.int(Math.random() * 5);
		if (aEasyZombieRand == 0) {
			this.mBoard.mZombieAllowed[ZOMBIE_NEWSPAPER] = true;
		} else {
			this.mBoard.mZombieAllowed[ZOMBIE_TRAFFIC_CONE] = true;
		}
		var aNumZombieTypes = Std.int(Math.min(this.mSurvivalStage + 1, 5));
		while (aNumZombieTypes > 0) {
			aZombieType = Std.int(Math.random() * NUM_ZOMBIE_TYPES);
			if (!this.mBoard.mZombieAllowed[aZombieType]) {
				this.mBoard.mZombieAllowed[aZombieType] = true;

				aNumZombieTypes--;
			}
		}
	}

	public function GraveDangerSpawnGraveAt(x:Int, y:Int) {
		var aPlant:CPlant = null;
		var aGraveStone:GridItem = null;
		for (_tmp_ in this.mBoard.mPlants) {
			aPlant = _tmp_;
			if (aPlant.mPlantCol == x && aPlant.mRow == y) {
				aPlant.Die();
			}
		}
		this.mBoard.mEnableGraveStones = true;
		aGraveStone = this.mBoard.AddAGraveStone(x, y);
		aGraveStone.AddGraveStoneParticles();
	}

	public function ScaryPotterDontPlaceInCol(theCol:Int, theGridArray:Array<ASAny>, theGridArrayCount:Int) {
		for (i in 0...theGridArrayCount) {
			if (theGridArray[i].mX == theCol) {
				theGridArray[i].mWeight = 0;
			}
		}
	}

	public function ScaryPotterUpdate() {
		var aGridItem:GridItem = null;
		if (this.mChallengeState == STATECHALLENGE_SCARY_POTTER_MALLETING) {
			if (this.mMalletReanim.mIsDead) {
				aGridItem = this.GetScaryPotAt(this.mChallengeGridX, this.mChallengeGridY);
				if (aGridItem != null) {
					this.ScaryPotterOpenPot(aGridItem);
				}
				this.mChallengeGridX = 0;
				this.mChallengeGridY = 0;
				this.mMalletReanim.mIsDead = true;

				this.mMalletReanim = null;
				this.mChallengeState = STATECHALLENGE_NORMAL;
			}
		}
	}

	public function ScaryPotterMalletPot(theScaryPot:GridItem) {
		this.mChallengeGridX = theScaryPot.mGridX;
		this.mChallengeGridY = theScaryPot.mGridY;
		var aXPos = this.mBoard.GridToPixelX(theScaryPot.mGridX, theScaryPot.mGridY);
		var aYPos = this.mBoard.GridToPixelY(theScaryPot.mGridX, theScaryPot.mGridY);
		this.mMalletReanim = this.app.reanimator.createReanimation("REANIM_HAMMER");
		this.mMalletReanim.x = aXPos;
		this.mMalletReanim.y = aYPos;
		this.mMalletReanim.currentTrack = "anim_open_pot";
		this.mMalletReanim.animRate = 40;

		this.mMalletReanim.loopType = Reanimation.LOOP_TYPE_ONCE_AND_DIE;
		this.mBoard.mRenderManager.add(new ReanimationRenderable(this.mMalletReanim, Board.RENDER_LAYER_ABOVE_UI));
		this.mChallengeState = STATECHALLENGE_SCARY_POTTER_MALLETING;
		this.app.foleyManager.playFoley(PVZFoleyType.SWING);
	}

	public function ScaryPotterPlacePot(theScaryPotType:Int, theZombieType:Int, theSeedType:Int, theCount:Int, theGridArray:Array<ASAny>,
			theGridArrayCount:Int) {
		var aResult:WeightedGridArray = null;
		var aGridItem:GridItem = null;
		for (i in 0...theCount) {
			aResult = TodCommon.TodPickFromWeightedGridArray(theGridArray, theGridArrayCount);
			aResult.mWeight = 0;
			aGridItem = new GridItem(this.app, this.mBoard);
			aGridItem.mGridItemType = GridItem.GRIDITEM_SCARY_POT;
			aGridItem.mGridItemState = GridItem.GRIDITEM_STATE_SCARY_POT_QUESTION;
			aGridItem.mGridX = aResult.mX;
			aGridItem.mGridY = aResult.mY;
			aGridItem.mSeedType = theSeedType;
			aGridItem.mZombieType = theZombieType;
			aGridItem.mScaryPotType = theScaryPotType;
			this.mBoard.mGridItems.push(aGridItem);
			this.mBoard.mRenderManager.add(new GridItemRenderable(aGridItem, RENDER_LAYER_PLANT));
			if (theScaryPotType == SCARYPOT_SUN) {
				aGridItem.mSunCount = TodCommon.RandRangeInt(1, 3);
			}
		}
	}

	public function InitLevel() {
		if (this.mBoard.mLevel == 5) {
			this.mBoard.NewPlant(5, 1, SEED_PEASHOOTER);
			this.mBoard.NewPlant(7, 2, SEED_PEASHOOTER);
			this.mBoard.NewPlant(6, 3, SEED_PEASHOOTER);
		}

		if (this.app.IsScaryPotterLevel()) {
			this.ScaryPotterPopulate();
		}
	}

	public function PuzzleNextStageClear() {
		var aZombie:Zombie = null;
		var aPlant:CPlant = null;
		var aCoin:Coin = null;
		var aGridItem:GridItem = null;
		var anEffect:ParticleSystem = null;
		this.app.foleyManager.playFoley(PVZFoleyType.HUGEWAVE);
		this.mBoard.mNextSurvivalStageCounter = 0;
		this.mBoard.mProgressMeterWidth = 0;
		for (_tmp_ in this.mBoard.mZombies) {
			aZombie = _tmp_;
			if (aZombie.IsOnBoard()) {
				aZombie.DieNoLoot();
			}
		}
		for (_tmp_ in this.mBoard.mPlants) {
			aPlant = _tmp_;
			if (aPlant.IsOnBoard()) {
				aPlant.Die();
			}
		}
		this.mBoard.RefreshSeedPacketFromCursor();
		for (_tmp_ in this.mBoard.mCoins) {
			aCoin = _tmp_;
			if (aCoin.mType == COIN_USABLE_SEED_PACKET) {
				aCoin.Die();
			}
		}
		for (_tmp_ in this.mBoard.mGridItems) {
			aGridItem = _tmp_;

			aGridItem.GridItemDie();
		}
		++this.mSurvivalStage;
		this.mBoard.ClearAdviceImmediately();
		this.mBoard.mLevelAwardSpawned = false;
		anEffect = this.app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_SCREENFLASH);
		anEffect.setPosition(0, 0);
		this.mBoard.mRenderManager.add(new ParticleRenderable(anEffect, Board.RENDER_LAYER_SCREEN_FADE));
	}

	public function InitZombieWaves() {
		var aZombieList:Array<ASAny> = null;
		if (this.app.IsSurvivalMode()) {
			if (this.mSurvivalStage == 0) {
				aZombieList = [ZOMBIE_NORMAL, ZOMBIE_TRAFFIC_CONE, ZOMBIE_PAIL];
				this.InitZombieWavesFromList(aZombieList, aZombieList.length);
			} else {
				this.InitZombieWavesSurvival();
			}
		}
	}

	public function MouseDown(x:Int, y:Int, theHitResult:HitResult):Bool {
		if (this.mBoard.mGameScene != SCENE_PLAYING) {
			return false;
		}
		if (theHitResult.mObjectType == OBJECT_TYPE_COIN) {
			return false;
		}
		if (this.app.IsScaryPotterLevel() && theHitResult.mObjectType == Board.OBJECT_TYPE_SCARY_POT) {
			this.ScaryPotterMalletPot(cast(theHitResult.mObject, GridItem));
			this.mBoard.ClearCursor();
			return true;
		}
		return false;
	}

	public function InitZombieWavesFromList(theZombieList:Array<ASAny>, theListLength:Int) {
		var aZombieType = 0;
		for (i in 0...theListLength) {
			aZombieType = ASCompat.toInt(theZombieList[i]);
			this.mBoard.mZombieAllowed[aZombieType] = true;
		}
	}

	public function ScaryPotterPopulate() {
		var y = 0;
		var aGridItem:WeightedGridArray = null;
		var aNumExtraGargantuars = 0;
		var aGridArray = new Array<ASAny>();
		var aGridArrayCount = 0;
		for (x in 0...9) {
			for (_tmp_ in 0...5) {
				y = _tmp_;
				aGridItem = new WeightedGridArray();
				aGridArray[aGridArrayCount] = aGridItem;
				aGridArray[aGridArrayCount].mX = x;
				aGridArray[aGridArrayCount].mY = y;
				aGridArray[aGridArrayCount].mWeight = 1;
				aGridArrayCount++;
			}
		}
		if (this.app.mGameMode == PVZApp.GAMEMODE_SCARY_POTTER_ENDLESS) {
			if (this.mSurvivalStage == 0) {
				this.ScaryPotterDontPlaceInCol(0, aGridArray, aGridArrayCount);
				this.ScaryPotterDontPlaceInCol(1, aGridArray, aGridArrayCount);
				this.ScaryPotterDontPlaceInCol(2, aGridArray, aGridArrayCount);
				this.ScaryPotterDontPlaceInCol(3, aGridArray, aGridArrayCount);
				this.ScaryPotterDontPlaceInCol(4, aGridArray, aGridArrayCount);
				this.ScaryPotterDontPlaceInCol(5, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_SEED, ZOMBIE_INVALID, SEED_PEASHOOTER, 5, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_SEED, ZOMBIE_INVALID, SEED_SQUASH, 5, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_ZOMBIE, ZOMBIE_NORMAL, SEED_NONE, 4, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_ZOMBIE, ZOMBIE_PAIL, SEED_NONE, 1, aGridArray, aGridArrayCount);
			} else if (this.mSurvivalStage == 1) {
				this.ScaryPotterDontPlaceInCol(0, aGridArray, aGridArrayCount);
				this.ScaryPotterDontPlaceInCol(1, aGridArray, aGridArrayCount);
				this.ScaryPotterDontPlaceInCol(2, aGridArray, aGridArrayCount);
				this.ScaryPotterDontPlaceInCol(3, aGridArray, aGridArrayCount);
				this.ScaryPotterDontPlaceInCol(4, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_SEED, ZOMBIE_INVALID, SEED_PEASHOOTER, 4, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_SEED, ZOMBIE_INVALID, SEED_SQUASH, 4, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_SEED, ZOMBIE_INVALID, SEED_SNOWPEA, 5, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_ZOMBIE, ZOMBIE_NORMAL, SEED_NONE, 5, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_ZOMBIE, ZOMBIE_PAIL, SEED_NONE, 1, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_ZOMBIE, ZOMBIE_FOOTBALL, SEED_NONE, 1, aGridArray, aGridArrayCount);
				this.ScaryPotterChangePotType(GRIDITEM_STATE_SCARY_POT_LEAF, 2);
			} else if (this.mSurvivalStage == 2) {
				this.ScaryPotterDontPlaceInCol(0, aGridArray, aGridArrayCount);
				this.ScaryPotterDontPlaceInCol(1, aGridArray, aGridArrayCount);
				this.ScaryPotterDontPlaceInCol(2, aGridArray, aGridArrayCount);
				this.ScaryPotterDontPlaceInCol(8, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_SEED, ZOMBIE_INVALID, SEED_LEFTPEATER, 7, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_SEED, ZOMBIE_INVALID, SEED_SQUASH, 2, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_SEED, ZOMBIE_INVALID, SEED_SNOWPEA, 3, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_SEED, ZOMBIE_INVALID, SEED_WALLNUT, 3, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_ZOMBIE, ZOMBIE_NORMAL, SEED_NONE, 6, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_ZOMBIE, ZOMBIE_PAIL, SEED_NONE, 3, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_DYNAMITE, ZOMBIE_INVALID, SEED_NONE, 1, aGridArray, aGridArrayCount);
				this.ScaryPotterChangePotType(GRIDITEM_STATE_SCARY_POT_LEAF, 2);
			} else {
				aNumExtraGargantuars = TodCommon.ClampInt(Std.int(this.mSurvivalStage / 10), 0, 8);
				this.ScaryPotterDontPlaceInCol(0, aGridArray, aGridArrayCount);
				this.ScaryPotterDontPlaceInCol(1, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_SEED, ZOMBIE_INVALID, SEED_LEFTPEATER, 8, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_SEED, ZOMBIE_INVALID, SEED_SNOWPEA, 2, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_SEED, ZOMBIE_INVALID, SEED_PEASHOOTER, 2, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_SEED, ZOMBIE_INVALID, SEED_SQUASH, 5, aGridArray, aGridArrayCount);

				this.ScaryPotterPlacePot(SCARYPOT_SEED, ZOMBIE_INVALID, SEED_WALLNUT, 2, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_SUN, ZOMBIE_INVALID, SEED_NONE, 1, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_ZOMBIE, ZOMBIE_NORMAL, SEED_NONE, 8 - aNumExtraGargantuars, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_ZOMBIE, ZOMBIE_PAIL, SEED_NONE, 5, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_ZOMBIE, ZOMBIE_FOOTBALL, SEED_NONE, 1 + aNumExtraGargantuars, aGridArray, aGridArrayCount);
				this.ScaryPotterPlacePot(SCARYPOT_DYNAMITE, ZOMBIE_INVALID, SEED_NONE, 1, aGridArray, aGridArrayCount);
				this.ScaryPotterChangePotType(GRIDITEM_STATE_SCARY_POT_LEAF, 2);
			}
		}
	}

	public function ScaryPotterOpenPot(theScaryPot:GridItem) {
		var aCoin:Coin = null;

		var aParticleType:String = null;
		var aZombie:Zombie = null;
		var aNumSum = 0;
		var i = 0;

		var aXPos = this.mBoard.GridToPixelX(theScaryPot.mGridX, theScaryPot.mGridY);
		var aYPos = this.mBoard.GridToPixelY(theScaryPot.mGridX, theScaryPot.mGridY);
		switch (theScaryPot.mScaryPotType) {
			case SCARYPOT_DYNAMITE:
				aCoin = this.mBoard.AddCoin(aXPos, aYPos, Coin.COIN_DYNAMITE, COIN_MOTION_COIN);
			case SCARYPOT_SEED:
				aCoin = this.mBoard.AddCoin(aXPos + 20, aYPos, COIN_USABLE_SEED_PACKET, COIN_MOTION_FROM_PLANT);
				aCoin.mUsableSeedType = theScaryPot.mSeedType;
			case SCARYPOT_ZOMBIE:
				aZombie = this.mBoard.AddZombieInRow(theScaryPot.mZombieType, theScaryPot.mGridY, 0);
				aZombie.mPosX = aXPos;
			case SCARYPOT_SUN:
				aNumSum = theScaryPot.mSunCount;
				var i:ASAny = 0;
				while (i < aNumSum) {
					this.mBoard.AddCoin(aXPos, aYPos, COIN_SUN, COIN_MOTION_FROM_PLANT);
					aXPos += 15;
					i++;
				}
		}
		theScaryPot.GridItemDie();
		if (this.ScaryPotterIsCompleted()) {
			this.PuzzlePhaseComplete(theScaryPot.mGridX, theScaryPot.mGridY);
		}
		this.app.foleyManager.playFoley(PVZFoleyType.BONK);
		this.app.foleyManager.playFoley(PVZFoleyType.VASE_BREAKING);
		if (theScaryPot.mGridItemState == GRIDITEM_STATE_SCARY_POT_LEAF) {
			aParticleType = PVZParticles.PARTICLE_VASESHATTERLEAF;
		} else if (theScaryPot.mGridItemState == GRIDITEM_STATE_SCARY_POT_ZOMBIE) {
			aParticleType = PVZParticles.PARTICLE_VASESHATTERZOMBIE;
		} else {
			aParticleType = PVZParticles.PARTICLE_VASESHATTER;
		}
		var anEffect = this.app.particleManager.spawnParticleSystem(aParticleType);
		anEffect.setPosition(aXPos + 20, aYPos);
		this.mBoard.mRenderManager.add(new ParticleRenderable(anEffect, Board.RENDER_LAYER_PARTICLE + 1));
	}

	public function ScaryPotterIsCompleted():Bool {
		var aGridItem:GridItem = null;
		for (_tmp_ in this.mBoard.mGridItems) {
			aGridItem = _tmp_;
			if (aGridItem.mGridItemType == GridItem.GRIDITEM_SCARY_POT && !aGridItem.mDead) {
				return false;
			}
		}
		if (this.mBoard.AreEnemyZombiesOnScreen()) {
			return false;
		}
		return true;
	}

	public function StartLevel() {
		var aMessage:String = null;
		if (this.mBoard.IsWallnutBowlingLevel()) {
			this.mBoard.mZombieCountDown = 200;
			this.mBoard.mZombieCountDownStart = this.mBoard.mZombieCountDown;
			this.mBoard.mSeedBank.AddSeed(SEED_WALLNUT, false);
			this.mConveyorBeltCounter = 400;
		}
		if (this.mBoard.IsWallnutBowlingLevel()) {
			this.mShowBowlingLine = true;
		}

		if (this.app.IsSurvivalMode() && this.mSurvivalStage == 0) {
			aMessage = "[ADVICE_SURVIVE_ENDLESS]";
			this.mBoard.DisplayAdvice(aMessage, Board.MESSAGE_STYLE_HINT_FAST, Board.ADVICE_SURVIVE_FLAGS);
		}
		if (this.mBoard.mLevel == 10) {
			this.mBoard.mZombieCountDown = 100;
			this.mBoard.mZombieCountDownStart = this.mBoard.mZombieCountDown;
			this.mConveyorBeltCounter = 200;
		}
	}

	public function ClearCursor() {}

	public function PuzzleIsAwardStage():Bool {
		if (this.app.IsAdventureMode()) {
			return false;
		}
		var aStagesPerAward = 1;
		if (this.app.mGameMode == PVZApp.GAMEMODE_SCARY_POTTER_ENDLESS) {
			aStagesPerAward = 10;
		}
		if ((this.mSurvivalStage + 1) % aStagesPerAward == 0) {
			return true;
		}
		return false;
	}

	public function Update() {
		var aTotalSun = 0;
		var anImage:ImageInst = null;
		if (this.mBoard.mPaused) {
			return;
		}
		if (this.mBoard.mGameScene != SCENE_PLAYING) {
			return;
		}
		if (this.mBoard.HasConveyorBeltSeedBank()) {
			this.UpdateConveyorBelt();
		}
		if (this.app.IsScaryPotterLevel()) {
			this.ScaryPotterUpdate();
		}
		if (this.app.IsScaryPotterLevel()) {
			if (this.mBoard.mSeedBank.mY < 0) {
				aTotalSun = this.mBoard.mSunMoney + this.mBoard.CountSunBeingCollected();
				anImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_SEEDBANK);
				if (aTotalSun > 0) {}
				if (aTotalSun > 0 || this.mBoard.mSeedBank.mY > -78) {
					this.mBoard.mSeedBank.mVisible = true;
					this.mBoard.mSeedBank.mY += 2;
					trace(this.mBoard.mSeedBank.mY);
					if (this.mBoard.mSeedBank.mY > 0) {
						this.mBoard.mSeedBank.mY = 0;
					}
				}
			}
		}
	}

	public function SpawnZombieWave() {
		var aCount = 0;
		var i = 0;
		var aIsFlagWave = this.mBoard.IsFlagWave(this.mBoard.mCurrentWave);
		if (this.app.IsSurvivalMode() && this.mBoard.mBackground == Board.BACKGROUND_2_NIGHT) {
			if (this.mBoard.mCurrentWave == this.mBoard.mNumWaves - 1) {
				aCount = this.mBoard.GetGraveStoneCount();
				var i:ASAny = 0;
				while (i < this.mSurvivalStage + 1) {
					if (aCount < 12) {
						this.GraveDangerSpawnRandomGrave();
					}
					i++;
				}
			}
		}
	}

	public function ScaryPotterChangePotType(thePotType:Int, theCount:Int) {
		var aGridItem:GridItem = null;
		var aResult:WeightedArray = null;
		var theGridItem:GridItem = null;
		var aPotArray = new Array<ASAny>();
		var aPotArrayCount = 0;
		var i = 0;
		while (i < this.mBoard.mGridItems.length) {
			aGridItem = this.mBoard.mGridItems[i];
			aPotArray[aPotArrayCount] = new WeightedArray();
			if (aGridItem.mGridItemState == GRIDITEM_STATE_SCARY_POT_QUESTION) {
				if (!(thePotType == GRIDITEM_STATE_SCARY_POT_LEAF && aGridItem.mScaryPotType != SCARYPOT_SEED)) {
					if (thePotType != GRIDITEM_STATE_SCARY_POT_ZOMBIE) {
						aPotArray[aPotArrayCount].mItem = i;
						aPotArray[aPotArrayCount].mWeight = 1;
						aPotArrayCount++;
					}
				}
			}

			i++;
		}
		if (theCount > aPotArrayCount) {
			theCount = aPotArrayCount;
		}
		var i:ASAny = 0;
		while (i < theCount) {
			aResult = TodCommon.TodPickArrayItemFromWeightedArray(aPotArray, aPotArrayCount);
			aResult.mWeight = 0;
			theGridItem = this.mBoard.mGridItems[aResult.mItem];
			theGridItem.mGridItemState = thePotType;
			i++;
		}
	}

	public function ScaryPotterStart() {
		if (this.app.IsAdventureMode()) {}
	}

	public function UpdateConveyorBelt() {
		var aSeedType = 0;
		var aArrayItem:WeightedArray = null;
		var aCountInBank = 0;
		if (this.mBoard.HasLevelAwardDropped()) {
			return;
		}
		this.mBoard.mSeedBank.UpdateConveyorBelt();
		--this.mConveyorBeltCounter;
		if (this.mConveyorBeltCounter > 0) {
			return;
		}
		var aConveyorSpeedMultiplier:Float = 1;
		if (this.mBoard.mSeedBank.GetNumSeedsOnConveyorBelt() > 8) {
			this.mConveyorBeltCounter = Std.int(1000 * aConveyorSpeedMultiplier);
		} else if (this.mBoard.mSeedBank.GetNumSeedsOnConveyorBelt() > 6) {
			this.mConveyorBeltCounter = Std.int(500 * aConveyorSpeedMultiplier);
		} else if (this.mBoard.mSeedBank.GetNumSeedsOnConveyorBelt() > 4) {
			this.mConveyorBeltCounter = Std.int(425 * aConveyorSpeedMultiplier);
		} else {
			this.mConveyorBeltCounter = Std.int(400 * aConveyorSpeedMultiplier);
		}
		var MAX_SPAWNING_SEED_TYPES = 20;
		var aSeedPickArray = new Array<ASAny>();
		var aNumSeedsType = 0;
		for (i in 0...7) {
			aSeedPickArray[i] = new WeightedArray();
		}
		if (this.mBoard.mLevel == 10) {
			aSeedPickArray[aNumSeedsType].mItem = SEED_PEASHOOTER;
			aSeedPickArray[aNumSeedsType].mWeight = 20;
			aNumSeedsType++;
			aSeedPickArray[aNumSeedsType].mItem = SEED_CHERRYBOMB;
			aSeedPickArray[aNumSeedsType].mWeight = 20;
			aNumSeedsType++;
			aSeedPickArray[aNumSeedsType].mItem = SEED_WALLNUT;
			aSeedPickArray[aNumSeedsType].mWeight = 15;
			aNumSeedsType++;
			aSeedPickArray[aNumSeedsType].mItem = SEED_REPEATER;
			aSeedPickArray[aNumSeedsType].mWeight = 20;
			aNumSeedsType++;
			aSeedPickArray[aNumSeedsType].mItem = SEED_SNOWPEA;
			aSeedPickArray[aNumSeedsType].mWeight = 10;
			aNumSeedsType++;
			aSeedPickArray[aNumSeedsType].mItem = SEED_CHOMPER;
			aSeedPickArray[aNumSeedsType].mWeight = 5;
			aNumSeedsType++;
			aSeedPickArray[aNumSeedsType].mItem = SEED_SQUASH;
			aSeedPickArray[aNumSeedsType].mWeight = 10;
			aNumSeedsType++;
		} else if (this.mBoard.IsWallnutBowlingLevel()) {
			aSeedPickArray[aNumSeedsType].mItem = SEED_WALLNUT;
			aSeedPickArray[aNumSeedsType].mWeight = 85;
			aNumSeedsType++;
			aSeedPickArray[aNumSeedsType].mItem = SEED_EXPLODE_O_NUT;
			aSeedPickArray[aNumSeedsType].mWeight = 15;
			aNumSeedsType++;
		}
		var i:ASAny = 0;
		while (i < aNumSeedsType) {
			aArrayItem = aSeedPickArray[i];
			aSeedType = aArrayItem.mItem;
			aCountInBank = this.mBoard.mSeedBank.CountOfTypeOnConveyorBelt(aArrayItem.mItem);
			if (aNumSeedsType > 2) {
				if (aCountInBank >= 4) {
					aArrayItem.mWeight = 1;
				} else if (aCountInBank >= 3) {
					aArrayItem.mWeight = 5;
				} else if (aSeedType == this.mLastConveyorSeedType) {
					aArrayItem.mWeight = Std.int(aArrayItem.mWeight / 2);
				}
			}
			i++;
		}
		aSeedType = TodCommon.TodPickFromWeightedArray(aSeedPickArray, aNumSeedsType);
		this.mBoard.mSeedBank.AddSeed(aSeedType, false);
		this.mLastConveyorSeedType = aSeedType;
	}
}
