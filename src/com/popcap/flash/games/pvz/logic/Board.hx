package com.popcap.flash.games.pvz.logic;

import com.popcap.flash.framework.graphics.Color;
import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.render.RenderManager;
import com.popcap.flash.framework.resources.fonts.FontInst;
import com.popcap.flash.framework.resources.images.ImageData;
import com.popcap.flash.framework.resources.images.ImageInst;
import com.popcap.flash.framework.resources.particles.ParticleSystem;
import com.popcap.flash.framework.resources.reanimator.Reanimation;
import com.popcap.flash.framework.utils.Utils;
import com.popcap.flash.framework.widgets.CWidget;
import com.popcap.flash.framework.widgets.ui.IButtonListener;
import com.popcap.flash.framework.widgets.ui.ImageButtonWidget;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.PVZFoleyType;
import com.popcap.flash.games.pvz.PVZMusic;
import com.popcap.flash.games.pvz.login.plants.CPlant;
import com.popcap.flash.games.pvz.login.plants.CherryBomb;
import com.popcap.flash.games.pvz.login.plants.Chomper;
import com.popcap.flash.games.pvz.login.plants.ExplodoNut;
import com.popcap.flash.games.pvz.login.plants.FumeShroom;
import com.popcap.flash.games.pvz.login.plants.GraveBuster;
import com.popcap.flash.games.pvz.login.plants.LeftPeater;
import com.popcap.flash.games.pvz.login.plants.PeaShooter;
import com.popcap.flash.games.pvz.login.plants.PuffShroom;
import com.popcap.flash.games.pvz.login.plants.Repeater;
import com.popcap.flash.games.pvz.login.plants.SnowPea;
import com.popcap.flash.games.pvz.login.plants.Squash;
import com.popcap.flash.games.pvz.login.plants.SunShroom;
import com.popcap.flash.games.pvz.login.plants.Sunflower;
import com.popcap.flash.games.pvz.login.plants.Wallnut;
import com.popcap.flash.games.pvz.logic.uI.OptionsDialog;
import com.popcap.flash.games.pvz.logic.uI.ToolTipWidget;
import com.popcap.flash.games.pvz.logic.zombies.Zombie;
import com.popcap.flash.games.pvz.logic.zombies.ZombieDef;
import com.popcap.flash.games.pvz.logic.zombies.ZombiePicker;
import com.popcap.flash.games.pvz.renderables.CoinRenderable;
import com.popcap.flash.games.pvz.renderables.GridItemRenderable;
import com.popcap.flash.games.pvz.renderables.ImageRenderable;
import com.popcap.flash.games.pvz.renderables.LawnMowerRenderable;
import com.popcap.flash.games.pvz.renderables.ParticleRenderable;
import com.popcap.flash.games.pvz.renderables.PlantRenderable;
import com.popcap.flash.games.pvz.renderables.ProjectileRenderable;
import com.popcap.flash.games.pvz.renderables.ZombieRenderable;
import com.popcap.flash.games.pvz.resources.PVZFonts;
import com.popcap.flash.games.pvz.resources.PVZImages;
import com.popcap.flash.games.pvz.resources.PVZParticles;
import com.popcap.flash.games.pvz.resources.PVZReanims;
import openfl.display.BitmapData;
import openfl.geom.Matrix;
import openfl.geom.Point;
import openfl.geom.Rectangle;

class Board extends CWidget implements IButtonListener {
	public static inline final TUTORIAL_MORESUN_COMPLETED = 12;

	public static inline final OBJECT_TYPE_PLANT = 1;

	public static inline final RENDER_LAYER_SCREEN_FADE = 900000;

	public static inline final GRIDITEM_SCARY_POT = 2;

	public static inline final ADVICE_CLICK_TO_CONTINUE = 7;

	public static inline final MESSAGE_STYLE_TUTORIAL_LATER = 3;

	public static inline final FLAG_RAISE_TIME = 100;

	public static inline final GRIDSQUARE_NONE = 0;

	public static inline final REANIM_CHERRYBOMB = 3;

	public static inline final BACKGROUND_1_DAY = 0;

	public static inline final ADVICE_NONE = -1;

	public static inline final CURSOR_TYPE_NORMAL = 0;

	public static inline final OBJECT_TYPE_NONE = 0;

	public static inline final ZOMBIE_DOOR = 6;

	public static inline final SCARYPOT_SUN = 3;

	public static inline final SCENE_CREDIT = 6;

	public static inline final GRIDITEM_GRAVESTONE = 1;

	public static inline final CURSOR_TYPE_HAMMER = 4;

	public static inline final SCARYPOT_SEED = 1;

	public static inline final COIN_NONE = "none";

	public static inline final PLANTING_NOT_PASSED_LINE = "not passed line";

	public static inline final SCENE_CHALLENGE = 7;

	public static inline final GRIDSQUARE_GRASS = 1;

	public static inline final LAWN_XMIN = 25;

	public static inline final PLANTING_ONLY_ON_GRAVES = "only on graves";

	public static inline final PLANTROW_DIRT = 1;

	public static inline final TUTORIAL_SHOVEL_DIG = 14;

	public static inline final MESSAGE_STYLE_TUTORIAL_LEVEL1 = 0;

	public static inline final MESSAGE_STYLE_TUTORIAL_LEVEL2 = 2;

	public static inline final MAX_ZOMBIE_WAVES = 100;

	public static inline final OBJECT_TYPE_SHOVEL = 5;

	public static inline final SCENE_LOADING = 0;

	public static inline final SEED_NONE = -1;

	public static inline final TUTORIAL_SHOVEL_COMPLETED = 16;

	public static inline final GRIDITEM_NONE = 0;

	public static inline final SEED_CHERRYBOMB = 2;

	public static inline final GRIDSQUARE_DIRT = 2;

	public static inline final SCENE_LEVEL_INTRO = 2;

	public static inline final ADVICE_PLANT_SUNFLOWER5 = 5;

	public static inline final ADVICE_CLICK_ON_SUN = 0;

	public static inline final PROGRESS_METER_COUNTER = 100;

	public static inline final TUTORIAL_SHOVEL_PICKUP = 13;

	public static inline final TUTORIAL_LEVEL_2_PICK_UP_SUNFLOWER = 5;

	public static inline final TUTORIAL_SHOVEL_KEEP_DIGGING = 15;

	public static inline final ADVICE_UNLOCKED_MODE = 9;

	public static inline final RENDER_LAYER_GROUND = 200000;

	public static inline final COIN_FINAL_SEED_PACKET = "finalseedpacket";

	public static inline final MESSAGE_STYLE_HUGE_WAVE = 14;

	public static inline final TUTORIAL_LEVEL_2_PLANT_SUNFLOWER = 6;

	public static inline final LAWN_YMIN = 77;

	public static inline final MESSAGE_STYLE_BIG_MIDDLE = 11;

	public static inline final TUTORIAL_LEVEL_1_COMPLETED = 4;

	public static inline final SEED_FUMESHROOM = 10;

	public static inline final ZOMBIE_COUNTDOWN_MIN = 400;

	public static inline final SCENE_CRAZY_DAVE = 8;

	public static inline final ZOMBIE_COUNTDOWN_FIRST_WAVE = 1800;

	public static inline final SCENE_AWARD = 5;

	public static inline final SEED_SNOWPEA = 5;

	public static inline final MESSAGE_STYLE_HINT_TALL_FAST = 8;

	public static inline final BOARD_HEIGHT = 405;

	public static inline final ZOMBIE_INVALID = -1;

	public static inline final COIN_MOTION_COIN = "coin";

	public static inline final SEED_SQUASH = 4;

	public static inline final TUTORIAL_LEVEL_1_REFRESH_PEASHOOTER = 3;

	public static inline final SCENE_ZOMBIES_WON = 4;

	public static inline final ADVICE_SEED_REFRESH = 3;

	public static inline final MESSAGE_STYLE_HINT_TALL_LONG = 10;

	public static inline final MESSAGE_STYLE_BIG_MIDDLE_FAST = 12;

	public static inline final ADVICE_PLANT_NOT_PASSED_LINE = 13;

	public static inline final ZOMBIE_COUNTDOWN_BEFORE_REPICK = 5500;

	public static inline final REANIM_PEASHOOTER = 0;

	public static inline final BOARD_WIDTH = 540;

	public static inline final TUTORIAL_OFF = 0;

	public static inline final REANIM_WALLNUT = 1;

	public static inline final SEED_LEFTPEATER = 49;

	public static inline final GRIDSIZEY = 5;

	public static inline final RENDER_LAYER_COIN_BANK = 600000;

	public static inline final SEED_GRAVEBUSTER = 11;

	public static inline final SCARYPOT_NONE = 0;

	public static inline final ADVICE_PEASHOOTER_DIED = 10;

	public static inline final ZOMBIE_POLEVAULTER = 3;

	public static inline final GRIDSIZEX = 9;

	public static inline final CURSOR_TYPE_PLANT_FROM_BANK = 1;

	public static inline final SEED_PUFFSHROOM = 8;

	public static inline final CURSOR_TYPE_PLANT_FROM_USABLE_COIN = 2;

	public static inline final OBJECT_TYPE_PROJECTILE = 2;

	public static inline final TUTORIAL_MORESUN_PICK_UP_SUNFLOWER = 9;

	public static inline final REANIM_SQUASH = 4;

	public static inline final SEED_PEASHOOTER = 0;

	public static inline final ZOMBIE_NORMAL = 0;

	public static inline final RENDER_LAYER_FOG = 500000;

	public static inline final TUTORIAL_MORESUN_PLANT_SUNFLOWER = 10;

	public static inline final ADVICE_CLICKED_ON_SUN = 1;

	public static inline final MESSAGE_STYLE_HOUSE_NAME = 13;

	public static inline final SEED_EXPLODE_O_NUT = 50;

	public static inline final NUM_ZOMBIE_TYPES = 8;

	public static inline final TUTORIAL_LEVEL_2_REFRESH_SUNFLOWER = 7;

	public static inline final LAWN_XMAX = 513;

	public static inline final SEED_SUNFLOWER = 1;

	public static inline final SUN_COUNTDOWN_MAX = 950;

	public static inline final ZOMBIE_COUNTDOWN = 2500;

	public static inline final MESSAGE_STYLE_OFF = -1;

	public static inline final SCENE_PLAYING = 3;

	public static inline final SEED_CHOMPER = 6;

	public static inline final ZOMBIE_PAIL = 4;

	public static inline final TUTORIAL_LEVEL_1_PICK_UP_PEASHOOTER = 1;

	public static inline final SCENE_MENU = 1;

	public static inline final ZOMBIE_COUNTDOWN_RANGE = 600;

	public static inline final ADVICE_PLANT_GRAVEBUSTERS_ON_GRAVES = 12;

	public static inline final PLANTING_NOT_ON_GRAVE = "not on graves";

	public static inline final OBJECT_TYPE_SEEDPACKET = 4;

	public static inline final LEVELS_PER_AREA = 10;

	public static inline final TUTORIAL_LEVEL_2_COMPLETED = 8;

	public static inline final SUN_COUNTDOWN_RANGE = 275;

	public static inline final SCARYPOT_ZOMBIE = 2;

	public static inline final ZOMBIE_FOOTBALL = 7;

	public static inline final COIN_MOTION_FROM_PLANT = "from plant";

	public static inline final ADVICE_CLICKED_ON_COIN = 2;

	public static inline final OBJECT_TYPE_COIN = 3;

	public static inline final COIN_SUN = "sun";

	public static inline final PLANTING_OK = "ok";

	public static inline final MESSAGE_STYLE_HINT_STAY = 7;

	public static inline final ADVICE_HUGE_WAVE = 6;

	public static inline final OBJECT_TYPE_MENU_BUTTON = 7;

	public static inline final MESSAGE_STYLE_HINT_FAST = 6;

	public static inline final SEED_REPEATER = 7;

	public static inline final PLANTROW_NORMAL = 0;

	public static inline final COIN_MOTION_FROM_SKY_SLOW = "from sky slow";

	public static inline final BACKGROUND_2_NIGHT = 1;

	public static inline final SEED_SUNSHROOM = 9;

	public static inline final LAWN_YMAX = 385;

	public static inline final BOARD_SHAKE_TIME = 12;

	public static inline final ZOMBIE_NEWSPAPER = 5;

	public static inline final RENDER_LAYER_LAWN = 300000;

	public static final RENDER_LAYER_PROJECTILE:Int = RENDER_LAYER_LAWN + 5000;

	public static final RENDER_LAYER_ZOMBIE:Int = RENDER_LAYER_LAWN + 3000;

	public static final RENDER_LAYER_GRAVE_STONE:Int = RENDER_LAYER_LAWN + 1000;

	public static final RENDER_LAYER_LAWN_MOWER:Int = RENDER_LAYER_LAWN + 6000;

	public static final RENDER_LAYER_PLANT:Int = RENDER_LAYER_LAWN + 2000;

	public static inline final SEED_WALLNUT = 3;

	public static inline final ZOMBIE_COUNTDOWN_BEFORE_FLAG = 4500;

	public static inline final OBJECT_TYPE_SCARY_POT = 6;

	public static inline final PLANTING_NOT_HERE = "not here";

	public static inline final ADVICE_PLANT_NOT_ON_GRAVE = 11;

	public static inline final RENDER_LAYER_ABOVE_UI = 800000;

	public static inline final MESSAGE_STYLE_HINT_LONG = 5;

	public static inline final ADVICE_SURVIVE_FLAGS = 8;

	public static inline final COIN_MOTION_FROM_SKY = "from sky";

	public static inline final TUTORIAL_LEVEL_1_PLANT_PEASHOOTER = 2;

	public static inline final MESSAGE_STYLE_HINT_TALL_UNLOCKMESSAGE = 9;

	public static inline final MESSAGE_STYLE_TUTORIAL_LATER_STAY = 4;

	public static inline final REANIM_SUNFLOWER = 2;

	public static inline final SUN_COUNTDOWN = 425;

	public static inline final REANIM_NONE = -1;

	public static inline final ZOMBIE_TRAFFIC_CONE = 2;

	public static inline final TUTORIAL_MORESUN_REFRESH_SUNFLOWER = 11;

	public static inline final CURSOR_TYPE_SHOVEL = 3;

	public static inline final ZOMBIE_FLAG = 1;

	public static inline final ADVICE_CANT_AFFORD_PLANT = 4;

	public static inline final RENDER_LAYER_UI_TOP = 700000;

	public static inline final MAX_ZOMBIES_IN_WAVE = 50;

	public static inline final RENDER_LAYER_TOP = 400000;

	public static inline final MESSAGE_STYLE_TUTORIAL_LEVEL1_STAY = 1;

	public static final RENDER_LAYER_PARTICLE:Int = RENDER_LAYER_LAWN + 7000;

	public static inline final RENDER_LAYER_UI_BOTTOM = 100000;

	public var mLevelFont:FontInst;

	var mLevelLabel:ImageInst;

	var seeds:Array<ASAny>;

	public var mSodPosition:Int = 0;

	public var mCursorPreview:CursorPreview;

	public var mShakeAmountX:Int = 0;

	public var mShakeAmountY:Int = 0;

	public var mHelpIndex:Int = 0;

	public var mGridItems:Array<ASAny>;

	var sod3Row:ImageInst;

	public var mPlants:Array<ASAny>;

	var cursorObject:CursorObject;

	public var mNumWaves:Int = 0;

	public var mShowShovel:Bool = false;

	public var mTimeStopCounter:Int = 0;

	public var mZombieCountDownStart:Int = 0;

	public var mTutorialState:Int = 0;

	public var mZombiePail:Array<ASAny>;

	var FlagMeterFlag:ImageInst;

	public var mTriggeredLawnMowers:Int = 0;

	public var mOptionsMenu:OptionsDialog;

	var seed:SeedPacket;

	public var mSunCountDown:Int = 0;

	var mApp:PVZApp;

	public var mChallenge:Challenge;

	public var mZombieHealthWaveStart:Int = 0;

	var lastTime:Float = 0;

	var mFlagRaiseCounter:Int = 0;

	var mLevelLabelString:String = "";

	public var mOutOfMoneyCounter:Int = 0;

	public var mNextSurvivalStageCounter:Int = 0;

	public var mZombieCountDown:Int = 0;

	public var mEnableGraveStones:Bool = false;

	public var mNumSunsFallen:Int = 0;

	public var mLawnMowers:Array<ASAny>;

	var mFinalWaveSoundCounter:Int = 0;

	public var mZombiePolevaulter:Array<ASAny>;

	public var mZombieHealthToNextWave:Int = 0;

	public var mMaxZombiesInWave:Array<ASAny>;

	public var mToolTip:ToolTipWidget;

	public var mZombieNewsPaper:Array<ASAny>;

	var doorOverlay:ImageInst;

	public var mZombieGoldenPail:Array<ASAny>;

	public var mShovelBankImage:ImageInst;

	var FlagMeterHead:ImageInst;

	public var mCutScene:CutScene;

	var seedBack:ImageInst;

	public var mLevelAwardSpawned:Bool = false;

	public var mPlantRow:Array<ASAny>;

	public var mProjectiles:Array<ASAny>;

	public var mZombieFlag:Array<ASAny>;

	public var mZombieAllowedLevels:Array<ASAny>;

	public var mLastBungeeWave:Int = 0;

	public var mProgressMeterWidth:Int = 0;

	public var mLevel:Int = 0;

	public var mTutorialTimer:Int = 0;

	public var mShakeCounter:Int = 0;

	var background:ImageInst;

	public var mHelpDisplayed:Array<ASAny>;

	public var mZombieAllowed:Array<ASAny>;

	public var mGridCelLook:Array<ASAny>;

	public var mCursorObject:CursorObject;

	public var mBoardFadeOutCounter:Int = 0;

	var grid:Array<ASAny>;

	public var mGravesCleared:Int = 0;

	public var mMainCounter:Int = 0;

	public var mSunMoney:Int = 0;

	public var mCurrentWave:Int = 0;

	public var mZombieWaves:Array<ASAny>;

	public var mGridCelOffset:Array<ASAny>;

	var activeGrid:ASObject = null;

	public var mLevelComplete:Bool = false;

	var sod1Row:ImageInst;

	var FlagMeterBar:ImageInst;

	public var mHugeWaveCountDown:Int = 0;

	public var mBackground:Int = 0;

	public var mRowPickingArray:Array<ASAny>;

	public var mShowZombieWalking:Bool = false;

	public var mZombieTraffic:Array<ASAny>;

	public var mZombieScreenDoor:Array<ASAny>;

	public var mCoins:Array<ASAny>;

	var FlagMeterFull:ImageInst;

	var unsoddedBackground:ImageInst;

	public var mGridSquareType:Array<ASAny>;

	public var mEasyPlantingCheat:Bool = false;

	var mWaveWarning:WaveWarning;

	public var mZombieNormal:Array<ASAny>;

	public var mAdviceFont:FontInst;

	public var mZombiesInWave:Array<ASAny>;

	public var mAdvice:MessageWidget;

	public var mShovelButtonRect:Rectangle;

	var doorMask:ImageInst;

	public var mRenderManager:RenderManager;

	public var mShovelImage:ImageInst;

	var mSpecialGraveStoneX:Int = 0;

	var mSpecialGraveStoneY:Int = 0;

	public var mGameScene:Int = 0;

	public var mMenuButton:ImageButtonWidget;

	public var mTotalSpawnedWaves:Int = 0;

	var plantTime:Float = 0;

	public var mSeedBank:SeedBank;

	public var mWaveRowGotLawnMowered:Array<ASAny>;

	public var mTutorialArrow:ParticleSystem;

	public var mZombies:Array<ASAny>;

	var FlagMeterEmpty:ImageInst;

	public var mShownMoreSunTutorial:Bool = false;

	public var Menu_button:Int = 100;

	public var mPaused:Bool = false;

	public var mRiseFromGraveCounter:Int = 0;

	public function new(app:PVZApp) {
		super();
		this.seeds = new Array<ASAny>();
		this.grid = new Array<ASAny>();
		this.mPlants = new Array<ASAny>();
		this.mPlantRow = new Array<ASAny>();
		this.mGridSquareType = new Array<ASAny>();
		this.mProjectiles = new Array<ASAny>();
		this.mCoins = new Array<ASAny>();
		this.mLawnMowers = new Array<ASAny>();
		this.mZombies = new Array<ASAny>();
		this.mZombieWaves = [4, 6, 8, 10, 8, 10, 20, 10, 20, 20, 10, 20, 10, 20, 10, 10, 20, 10, 20, 20];
		this.mZombieNormal = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
		this.mZombieFlag = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
		this.mZombieTraffic = [0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1];
		this.mZombiePolevaulter = [0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1];
		this.mZombiePail = [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0, 0];
		this.mZombieGoldenPail = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		this.mZombieNewsPaper = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0];
		this.mZombieScreenDoor = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1];
		this.mZombieAllowedLevels = [
			this.mZombieNormal,
			this.mZombieFlag,
			this.mZombieTraffic,
			this.mZombiePolevaulter,
			this.mZombiePail,
			this.mZombieNewsPaper,
			this.mZombieScreenDoor
		];
		this.mZombieAllowed = new Array<ASAny>();
		this.mMaxZombiesInWave = ASCompat.allocArray(MAX_ZOMBIES_IN_WAVE);
		this.mZombiesInWave = ASCompat.allocArray(MAX_ZOMBIE_WAVES);
		this.mRowPickingArray = ASCompat.allocArray(GRIDSIZEY);
		this.mGridItems = new Array<ASAny>();
		this.mGridCelLook = new Array<ASAny>();
		this.mGridCelOffset = new Array<ASAny>();
		this.mWaveRowGotLawnMowered = ASCompat.allocArray(GRIDSIZEY);
		this.mShovelButtonRect = new Rectangle(402, 0, 63, 65);
		this.mHelpDisplayed = new Array<ASAny>();
		this.mRenderManager = new RenderManager();
		// super();
		app.registerCheat("refreshSeedsCheat", this.refreshSeedsCheat);
		app.registerCheat("spawnAwardCheat", this.spawnAwardCheat);
		app.registerCheat("freePlantingCheat", this.freePlantingCheat);
		app.registerCheat("previousLevelCheat", this.previousLevelCheat);
		app.registerCheat("nextLevelCheat", this.nextLevelCheat);
		app.registerCheat("spawnWaveCheat", this.spawnWaveCheat);
		app.registerCheat("spawnNormalZombieCheat", this.spawnNormalZombieCheat);
		app.registerCheat("spawnScreendoorZombieCheat", this.spawnScreendoorZombieCheat);
		app.registerCheat("spawnNewspaperZombieCheat", this.spawnNewspaperZombieCheat);
		app.registerCheat("spawnFootballZombieCheat", this.spawnFootballZombieCheat);
		app.registerCheat("spawnBucketZombieCheat", this.spawnBucketZombieCheat);
		app.registerCheat("spawnConeheadZombieCheat", this.spawnConeheadZombieCheat);
		app.registerCheat("spawnPolevaultZombieCheat", this.spawnPolevaultZombieCheat);
		app.registerCheat("spawnGraveZombieCheat", this.spawnGraveZombieCheat);
		x = 0;
		y = 0;
		width = 540;
		height = 405;
		this.mApp = app;
		this.mCursorObject = new CursorObject(app, this);
		this.mCursorPreview = new CursorPreview(app, this);
		this.mSpecialGraveStoneX = -1;
		this.mSpecialGraveStoneY = -1;
		this.mEnableGraveStones = false;
		this.mGravesCleared = 0;
		this.mRiseFromGraveCounter = 0;
		this.mEasyPlantingCheat = false;
		this.mNextSurvivalStageCounter = 0;
		this.mToolTip = new ToolTipWidget(this.mApp, this);
		this.mTimeStopCounter = 0;
		this.mLevel = this.mApp.mLevel;
		if (this.mLevel > 10 || this.mApp.IsSurvivalMode() || this.mApp.IsScaryPotterLevel()) {
			this.background = app.imageManager.getImageInst(PVZImages.IMAGE_BACKGROUND2);
			this.doorOverlay = app.imageManager.getImageInst(PVZImages.IMAGE_BACKGROUND2_GAMEOVER_INTERIOR_OVERLAY);
			this.doorMask = app.imageManager.getImageInst(PVZImages.IMAGE_BACKGROUND2_GAMEOVER_MASK);
		} else {
			this.background = app.imageManager.getImageInst(PVZImages.IMAGE_BACKGROUND1);
			this.doorOverlay = app.imageManager.getImageInst(PVZImages.IMAGE_BACKGROUND1_GAMEOVER_INTERIOR_OVERLAY);
			this.doorMask = app.imageManager.getImageInst(PVZImages.IMAGE_BACKGROUND1_GAMEOVER_MASK);
		}
		this.unsoddedBackground = app.imageManager.getImageInst(PVZImages.IMAGE_BACKGROUND1UNSODDED);
		this.sod1Row = app.imageManager.getImageInst(PVZImages.IMAGE_SOD1ROW);
		this.sod3Row = app.imageManager.getImageInst(PVZImages.IMAGE_SOD3ROW);
		this.FlagMeterBar = app.imageManager.getImageInst(PVZImages.IMAGE_FLAGMETERBAR);
		this.FlagMeterFlag = app.imageManager.getImageInst(PVZImages.IMAGE_FLAGMETERFLAG);
		this.FlagMeterHead = app.imageManager.getImageInst(PVZImages.IMAGE_FLAGMETERHEAD);
		this.FlagMeterFull = app.imageManager.getImageInst(PVZImages.IMAGE_FLAGMETERFULL);
		this.FlagMeterEmpty = app.imageManager.getImageInst(PVZImages.IMAGE_FLAGMETEREMPTY);
		this.mAdvice = null;
		this.mAdviceFont = app.fontManager.getFontInst(PVZFonts.FONT_HOUSEOFTERROR28);
		this.mLevelFont = app.fontManager.getFontInst(PVZFonts.FONT_HOUSEOFTERROR16);
		this.mAdvice = new MessageWidget(app, this);
		this.mSeedBank = new SeedBank(app, this);
		this.mLevelAwardSpawned = false;
		this.mLevelComplete = false;
		this.mBoardFadeOutCounter = -1;
		this.mFlagRaiseCounter = 0;
		this.mTriggeredLawnMowers = 0;
		this.mShowShovel = false;
		this.mShowZombieWalking = false;
		this.mTutorialState = TUTORIAL_OFF;
		this.mTutorialTimer = -1;
		this.mShovelImage = app.imageManager.getImageInst(PVZImages.IMAGE_SHOVEL_SMALL);
		this.mShovelBankImage = app.imageManager.getImageInst(PVZImages.IMAGE_SHOVELBANK);
		this.mChallenge = new Challenge(this.mApp, this);
		this.MakeMenuButton();
		this.mWaveWarning = new WaveWarning(app);
	}

	public function CanZombieSpawnOnLevel(theZombieType:Int, theLevel:Int):Bool {
		var aZombieDef = this.GetZombieDefinition(theZombieType);
		if (theLevel < aZombieDef.mStartingLevel) {
			return false;
		}
		if (aZombieDef.mPickWeight == 0) {
			return false;
		}
		var aLevelIndex = TodCommon.ClampInt(theLevel - 1, 0, 14 - 1);
		if (this.mZombieAllowedLevels[theZombieType][aLevelIndex] == 0) {
			return false;
		}
		return true;
	}

	public function SpawnZombieWave() {
		var aZombieType = 0;
		this.mChallenge.SpawnZombieWave();
		var counter = 0;
		for (i in 0...MAX_ZOMBIES_IN_WAVE) {
			aZombieType = ASCompat.toInt(this.mZombiesInWave[this.mCurrentWave][i]);
			if (this.mCurrentWave == 4) {}
			if (aZombieType == ZOMBIE_INVALID) {
				break;
			}
			counter++;
			this.AddZombie(aZombieType, this.mCurrentWave);
		}
		if (this.mCurrentWave == this.mNumWaves - 1) {
			this.mRiseFromGraveCounter = 200;
		}
		if (this.IsFlagWave(this.mCurrentWave)) {
			this.mFlagRaiseCounter = FLAG_RAISE_TIME;
		}
		++this.mCurrentWave;
		++this.mTotalSpawnedWaves;
	}

	public function CanZombieGoInGridSpot(theZombieType:Int, theGridX:Int, theGridY:Int, theZombieGrid:Array<ASAny>):Bool {
		if (theZombieGrid[theGridX][theGridY]) {
			return false;
		}
		if (theGridX == 4 && theGridY == 0) {
			return false;
		}
		if (theZombieType == Board.ZOMBIE_POLEVAULTER) {
			if (theGridX == 0) {
				return false;
			}
			if (theGridX == 1 && theGridY == 0) {
				return false;
			}
		}
		return true;
	}

	public function AddZombie(theZombieType:Int, theFromWave:Int, row:Int = -1):Zombie {
		var aRow = row;
		if (aRow == -1) {
			aRow = this.PickRowForNewZombie(theZombieType);
		}
		return this.AddZombieInRow(theZombieType, aRow, theFromWave);
	}

	public function PlantingPixelToGridY(theX:Int, theY:Int, theSeedType:Int):Int {
		var aPlantingY = theY;
		return this.PixelToGridY(theX, aPlantingY);
	}

	public function IsFinalSurvivalStage():Bool {
		return false;
	}

	public function CountPlantByType(theSeedType:Int):Int {
		var aPlant:CPlant = null;
		var aCount = 0;
		for (_tmp_ in this.mPlants) {
			aPlant = _tmp_;
			if (aPlant.mSeedType == theSeedType) {
				aCount++;
			}
		}

		return aCount;
	}

	public function CanDropLoot():Bool {
		return false;
	}

	public function GetPlantDefinition(theSeedType:Int):String {
		var aReanimType:String = null;
		switch (theSeedType) {
			case SEED_PEASHOOTER:
				aReanimType = PVZReanims.REANIM_PEASHOOTERSINGLE;

			case SEED_SUNFLOWER:
				aReanimType = PVZReanims.REANIM_SUNFLOWER;

			case SEED_CHERRYBOMB:
				aReanimType = PVZReanims.REANIM_CHERRYBOMB;

			case SEED_CHOMPER:
				aReanimType = PVZReanims.REANIM_CHOMPER;

			case SEED_SNOWPEA:
				aReanimType = PVZReanims.REANIM_SNOWPEA;

			case SEED_SQUASH:
				aReanimType = PVZReanims.REANIM_SQUASH;
			case SEED_WALLNUT | SEED_EXPLODE_O_NUT:

				aReanimType = PVZReanims.REANIM_WALLNUT;

			case SEED_REPEATER:
				aReanimType = PVZReanims.REANIM_PEASHOOTER;

			case SEED_PUFFSHROOM:
				aReanimType = PVZReanims.REANIM_PUFFSHROOM;

			case SEED_SUNSHROOM:
				aReanimType = PVZReanims.REANIM_SUNSHROOM;

			case SEED_FUMESHROOM:
				aReanimType = PVZReanims.REANIM_FUMESHROOM;

			case SEED_GRAVEBUSTER:
				aReanimType = PVZReanims.REANIM_GRAVEBUSTER;
			case SEED_LEFTPEATER:
				aReanimType = PVZReanims.REANIM_PEASHOOTER;
		}

		return aReanimType;
	}

	public function FindAndPlaceZombie(theZombieType:Int, theZombieGrid:Array<ASAny>) {
		var aGridX = 0;
		var aGridY = 0;

		this.FindPlaceForStreetZombies(theZombieType, theZombieGrid, aGridX, aGridY);
	}

	public function PutZombieInWave(theZombieType:Int, theWaveNumber:Int, theZombiePicker:ZombiePicker) {
		this.mZombiesInWave[theWaveNumber][theZombiePicker.mZombieCount] = theZombieType;
		++theZombiePicker.mZombieCount;
		if (theZombiePicker.mZombieCount < MAX_ZOMBIES_IN_WAVE) {
			this.mZombiesInWave[theWaveNumber][theZombiePicker.mZombieCount] = ZOMBIE_INVALID;
		}
		var aIntroZombieDef = this.GetZombieDefinition(theZombieType);
		theZombiePicker.mZombiePoints -= aIntroZombieDef.mZombieValue;
		++theZombiePicker.mZombieTypeCount[theZombieType];

		++theZombiePicker.mAllWavesZombieTypeCount[theZombieType];
	}

	public function IsSlotMachineLevel():Bool {
		return false;
	}

	public function ChooseSeedsOnCurrentLevel():Bool {
		if (this.HasConveyorBeltSeedBank()) {
			return false;
		}
		if (this.mApp.IsSurvivalMode()) {
			return true;
		}
		if (this.mLevel <= 7) {
			return false;
		}

		return true;
	}

	public function UpdateZombieSpawning() {
		var SPAWN_DELAY_AFTER_HEALTH_TRIGGER = 0;
		var aTotalHealth = 0;
		if (this.mFinalWaveSoundCounter > 0) {
			--this.mFinalWaveSoundCounter;
			if (this.mFinalWaveSoundCounter == 0) {}
		}
		if (this.mTutorialState == TUTORIAL_LEVEL_1_PICK_UP_PEASHOOTER
			|| this.mTutorialState == TUTORIAL_LEVEL_1_PLANT_PEASHOOTER
			|| this.mTutorialState == TUTORIAL_LEVEL_1_REFRESH_PEASHOOTER) {
			return;
		}
		if (this.HasLevelAwardDropped()) {
			return;
		}
		if (this.mRiseFromGraveCounter > 0) {
			--this.mRiseFromGraveCounter;
			if (this.mRiseFromGraveCounter == 0) {
				this.SpawnZombiesFromGraves();
			}
		}
		if (this.mHugeWaveCountDown != 0) {
			--this.mHugeWaveCountDown;
			if (this.mHugeWaveCountDown == 0) {
				this.ClearAdvice(ADVICE_HUGE_WAVE);
				this.NextWaveComing();
				this.mZombieCountDown = 1;
			} else if (this.mHugeWaveCountDown != 725) {
				return;
			}
		}
		if (this.mChallenge.UpdateZombieSpawning()) {
			return;
		}
		if (this.mCurrentWave == this.mNumWaves) {
			if (!this.mApp.IsSurvivalMode()) {
				return;
			}
		}
		--this.mZombieCountDown;
		if (this.mCurrentWave == this.mNumWaves && this.mApp.IsSurvivalMode()) {
			if (this.mZombieCountDown == 0) {
				this.FadeOutLevel();
			}
			return;
		}
		var aTimeSinceLastSpawn = this.mZombieCountDownStart - this.mZombieCountDown;
		if (this.mZombieCountDown > 5 && aTimeSinceLastSpawn > ZOMBIE_COUNTDOWN_MIN) {
			SPAWN_DELAY_AFTER_HEALTH_TRIGGER = 200;
			aTotalHealth = this.TotalZombiesHealthInWave(this.mCurrentWave - 1);
			if (aTotalHealth <= this.mZombieHealthToNextWave && this.mZombieCountDown > SPAWN_DELAY_AFTER_HEALTH_TRIGGER) {
				this.mZombieCountDown = SPAWN_DELAY_AFTER_HEALTH_TRIGGER;
			}
		}
		if (this.mZombieCountDown == 5) {
			if (this.IsFlagWave(this.mCurrentWave)) {
				this.mHugeWaveCountDown = 750;
				this.mWaveWarning.showHugeWave(this.mHugeWaveCountDown);
				return;
			}
			this.NextWaveComing();
		}
		if (this.mZombieCountDown != 0) {
			return;
		}
		this.SpawnZombieWave();
		this.mZombieHealthWaveStart = this.TotalZombiesHealthInWave(this.mCurrentWave - 1);
		var aNoPauseBeforeHugeWave = this.IsWallnutBowlingLevel();
		if (this.mCurrentWave == this.mNumWaves && this.mApp.IsSurvivalMode()) {
			this.mZombieHealthToNextWave = 0;
			this.mZombieCountDown = ZOMBIE_COUNTDOWN_BEFORE_REPICK;
		} else if (this.IsFlagWave(this.mCurrentWave) && !aNoPauseBeforeHugeWave) {
			this.mZombieHealthToNextWave = 0;
			this.mZombieCountDown = ZOMBIE_COUNTDOWN_BEFORE_FLAG;
		} else {
			this.mZombieHealthToNextWave = Std.int(TodCommon.RandRangeFloat(0.5, 0.65) * this.mZombieHealthWaveStart);
			this.mZombieCountDown = Std.int(ZOMBIE_COUNTDOWN + Math.random() * ZOMBIE_COUNTDOWN_RANGE);
		}

		this.mZombieCountDownStart = this.mZombieCountDown;
	}

	public function PlantingPixelToGridX(theX:Int, theY:Int, theSeedType:Int):Int {
		var aPlantingY = theY;

		return this.PixelToGridX(theX, aPlantingY);
	}

	public function GetGraveStoneAt(theGridX:Int, theGridY:Int):GridItem {
		return this.GetGridItemAt(GRIDITEM_GRAVESTONE, theGridX, theGridY);
	}

	public function UpdateGameObjects() {
		this.mRenderManager.update();
		this.mCursorObject.update();
		this.mCursorPreview.update();
		var i = 0;
		while (i < this.mSeedBank.mNumPackets) {
			this.mSeedBank.mSeedPackets[i].update();

			i++;
		}
	}

	public function GetPlantSeedImage(g:Graphics2D) {}

	public function GetScaryPotAt(theGridX:Int, theGridY:Int):GridItem {
		return this.GetGridItemAt(GRIDITEM_SCARY_POT, theGridX, theGridY);
	}

	public function MakeMenuButton() {
		var w:Float = 79;
		var h:Float = 31;
		this.mMenuButton = new ImageButtonWidget(this.Menu_button, this);
		this.mMenuButton.resize(465, 0, w, h);
		this.mMenuButton.setDisabled(false);
		var x = 0;
		var y = 0;
		var theText = this.mApp.stringManager.translateString("[MENU_BUTTON]");
		var upImage = new ImageInst(new ImageData(new BitmapData(Std.int(w), Std.int(h), true, 0)));
		var bufferG = upImage.graphics;
		var anImage = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_BUTTON_LEFT);
		bufferG.drawImage(anImage, x, y);
		x += Std.int(anImage.width);
		anImage = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_BUTTON_MIDDLE);
		bufferG.drawImage(anImage, x, y);
		x += Std.int(anImage.width);
		anImage = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_BUTTON_RIGHT);
		bufferG.drawImage(anImage, x, y);
		var font = this.mApp.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT36GREENINSET);
		font.scale = 0.4;
		var offsetX = (w - font.stringImageWidth(theText)) / 2;
		var offsetY = (h - font.getHeight() - 5) / 2;
		bufferG.setFont(font);
		bufferG.drawString(theText, offsetX, offsetY);
		x = 0;
		y = 0;
		var downImage = new ImageInst(new ImageData(new BitmapData(Std.int(w), Std.int(h), true, 0)));
		bufferG = downImage.graphics;
		anImage = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_BUTTON_DOWN_LEFT);
		bufferG.drawImage(anImage, x, y);
		x += Std.int(anImage.width);
		anImage = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_BUTTON_DOWN_MIDDLE);
		bufferG.drawImage(anImage, x, y);
		x += Std.int(anImage.width);
		anImage = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_BUTTON_DOWN_RIGHT);
		bufferG.drawImage(anImage, x, y);
		font = this.mApp.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT36BRIGHTGREENINSET);
		font.scale = 0.4;
		bufferG.setFont(font);
		bufferG.drawString(theText, offsetX + 1, offsetY + 1);
		x = 0;
		y = 0;
		var overImage = new ImageInst(new ImageData(new BitmapData(Std.int(w), Std.int(h), true, 0)));
		bufferG = overImage.graphics;
		anImage = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_BUTTON_LEFT);
		bufferG.drawImage(anImage, x, y);
		x += Std.int(anImage.width);
		anImage = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_BUTTON_MIDDLE);
		bufferG.drawImage(anImage, x, y);
		x += Std.int(anImage.width);
		anImage = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_BUTTON_RIGHT);
		bufferG.drawImage(anImage, x, y);
		font = this.mApp.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT36BRIGHTGREENINSET);
		font.scale = 0.4;
		bufferG.setFont(font);
		bufferG.drawString(theText, offsetX, offsetY);
		this.mMenuButton.mUpImage = upImage;
		this.mMenuButton.mOverImage = overImage;
		this.mMenuButton.mDownImage = downImage;

		this.mMenuButton.mDownOffset = new Point(1, 1);
		this.mMenuButton.mDisabledImage = upImage;
	}

	function spawnWaveCheat() {
		if (this.mHugeWaveCountDown > 0) {
			this.mHugeWaveCountDown = 1;
		} else {
			this.mZombieCountDown = 6;
		}
	}

	public function ClearCursor() {
		this.mCursorObject.mType = SEED_NONE;
		this.mCursorObject.mCursorType = CURSOR_TYPE_NORMAL;
		this.mCursorObject.mSeedBankIndex = -1;
		if (this.mTutorialState == TUTORIAL_LEVEL_1_PLANT_PEASHOOTER) {
			this.SetTutorialState(TUTORIAL_LEVEL_1_PICK_UP_PEASHOOTER);
		} else if (this.mTutorialState == TUTORIAL_LEVEL_2_PLANT_SUNFLOWER || this.mTutorialState == TUTORIAL_LEVEL_2_REFRESH_SUNFLOWER) {
			if (!this.mSeedBank.mSeedPackets[1].CanPickUp()) {
				this.SetTutorialState(TUTORIAL_LEVEL_2_REFRESH_SUNFLOWER);
			} else {
				this.SetTutorialState(TUTORIAL_LEVEL_2_PICK_UP_SUNFLOWER);
			}
		} else if (this.mTutorialState == TUTORIAL_MORESUN_PLANT_SUNFLOWER || this.mTutorialState == TUTORIAL_MORESUN_REFRESH_SUNFLOWER) {
			if (!this.mSeedBank.mSeedPackets[1].CanPickUp()) {
				this.SetTutorialState(TUTORIAL_MORESUN_REFRESH_SUNFLOWER);
			} else {
				this.SetTutorialState(TUTORIAL_MORESUN_PICK_UP_SUNFLOWER);
			}
		} else if (this.mTutorialState == TUTORIAL_SHOVEL_DIG) {
			this.SetTutorialState(TUTORIAL_SHOVEL_PICKUP);
		}
	}

	public function SpawnZombiesFromGraves() {
		var aGridItem:GridItem = null;
		var aZombieType = 0;
		var aZombieDef:ZombieDef = null;
		var aZombie:Zombie = null;
		var aZombiePoints = this.GetGraveStoneCount();
		for (_tmp_ in this.mGridItems) {
			aGridItem = _tmp_;
			if (aGridItem.mGridItemType == GRIDITEM_GRAVESTONE) {
				if (aGridItem.mGridItemCounter >= 100) {
					aZombieType = this.PickGraveRisingZombieType(aZombiePoints);
					aZombieDef = this.GetZombieDefinition(aZombieType);
					aZombie = this.AddZombie(aZombieType, this.mCurrentWave, aGridItem.mGridY);
					if (aZombie == null) {
						return;
					}
					aZombie.RiseFromGrave(aGridItem.mGridX, aGridItem.mGridY);
					aZombiePoints -= aZombieDef.mZombieValue;
					aZombiePoints = Std.int(Math.max(1, aZombiePoints));
				}
			}
		}
	}

	public function IsWallnutBowlingLevel():Bool {
		if (this.mLevel == 5) {
			return true;
		}
		return false;
	}

	public function FindPlaceForStreetZombies(theZombieType:Int, theZombieGrid:Array<ASAny>, thePosX:Int, thePosY:Int) {
		var y = 0;
		var aWeightedGridArray:WeightedGridArray = null;
		var aPicks = new Array<ASAny>();
		var aPickCount = 0;
		for (x in 0...5) {
			for (_tmp_ in 0...5) {
				y = _tmp_;
				if (this.CanZombieGoInGridSpot(theZombieType, x, y, theZombieGrid)) {
					aWeightedGridArray = new WeightedGridArray();
					aPicks[aPickCount] = aWeightedGridArray;
					aPicks[aPickCount].mX = x;
					aPicks[aPickCount].mY = y;
					aPicks[aPickCount].mWeight = 1;
					aPickCount++;
				}
			}
		}
		if (aPickCount == 0) {
			thePosX = 2;
			thePosY = 2;
			return;
		}
		var aResultItem = TodCommon.TodPickFromWeightedGridArray(aPicks, aPickCount);

		thePosX = aResultItem.mX;
		thePosY = aResultItem.mY;
		theZombieGrid[thePosX][thePosY] = true;
		this.PlaceAZombie(theZombieType, thePosX, thePosY);
	}

	public function buttonMouseEnter(id:Float) {}

	public function PlaceStreetZombies() {
		var aZombieType = 0;
		var aGridY = 0;
		var aZombieArray:Array<ASAny> = null;
		var aNumToShow = 0;
		var aZombieIndex = 0;
		if (this.mApp.mPlacedZombies) {
			return;
		}
		this.mApp.mPlacedZombies = true;
		var aTotalZombieCount = 0;
		var aZombieTypeCount = new Array<ASAny>();
		var aZombieValueTotal = 0;
		for (i in 0...8) {
			aZombieTypeCount[i] = 0;
		}
		var aWaveIndex = 0;
		while (aWaveIndex < this.mApp.mBoard.mNumWaves) {
			var i:ASAny = 0;
			while (i < Board.MAX_ZOMBIES_IN_WAVE) {
				aZombieType = ASCompat.toInt(this.mApp.mBoard.mZombiesInWave[aWaveIndex][i]);
				if (aZombieType == Board.ZOMBIE_INVALID) {
					break;
				}
				aZombieValueTotal += this.mApp.mBoard.GetZombieDefinition(aZombieType).mZombieValue;
				if (aZombieType != Board.ZOMBIE_FLAG) {
					++aZombieTypeCount[aZombieType];
					aTotalZombieCount++;
				}
				i++;
			}
			aWaveIndex++;
		}
		var aZombieGrid = new Array<ASAny>();
		for (aGridX in 0...5) {
			for (_tmp_ in 0...5) {
				aGridY = _tmp_;
				aZombieArray = new Array<ASAny>();
				aZombieGrid.push(aZombieArray);
				aZombieGrid[aGridX][aGridY] = false;
			}
		}
		var amApproxNumberToShow = 10;
		if (this.mLevel == 10) {
			amApproxNumberToShow = 18;
		}
		for (_tmp_ in 0...8) {
			aZombieType = _tmp_;
			if (aZombieTypeCount[aZombieType] != 0) {
				aNumToShow = Std.int(aZombieTypeCount[aZombieType] * amApproxNumberToShow / aTotalZombieCount);
				aNumToShow = TodCommon.ClampInt(aNumToShow, 1, aZombieTypeCount[aZombieType]);
				for (_tmp_ in 0...aNumToShow) {
					aZombieIndex = _tmp_;
					this.FindAndPlaceZombie(aZombieType, aZombieGrid);
				}
			}
		}
	}

	public function buttonPress(id:Float) {}

	public function ClearAdviceImmediately() {
		this.ClearAdvice(ADVICE_NONE);
		this.mAdvice.mDuration = 0;
	}

	public function RefreshSeedPacketFromCursor() {
		var aCoin:Coin = null;
		var aSeedPacket:SeedPacket = null;
		if (this.mCursorObject.mCursorType == CURSOR_TYPE_PLANT_FROM_USABLE_COIN) {
			aCoin = this.mCursorObject.mCoin;
			aCoin.DroppedUsableSeed();
		}
		if (this.mCursorObject.mCursorType == CURSOR_TYPE_PLANT_FROM_BANK) {
			aSeedPacket = this.mSeedBank.mSeedPackets[this.mCursorObject.mSeedBankIndex];
			aSeedPacket.Activate();
		}
		this.ClearCursor();
	}

	public function MouseDownWithPlant(x:Int, y:Int) {
		var aCost = 0;
		var aPlant:CPlant = null;
		var aPeashooters = 0;
		var aSuns = 0;
		var aPlantingSeedType = this.GetSeedTypeInCursor();
		var aGridX = this.PlantingPixelToGridX(x, y, aPlantingSeedType);
		var aGridY = this.PlantingPixelToGridY(x, y, aPlantingSeedType);
		if (aGridX < 0 || aGridX >= GRIDSIZEX || aGridY < 0 || aGridY >= GRIDSIZEY) {
			this.RefreshSeedPacketFromCursor();
			this.mApp.foleyManager.playFoley(PVZFoleyType.DROP);
			return;
		}
		var aReason = this.CanPlantAt(aGridX, aGridY, aPlantingSeedType);
		if (aReason != PLANTING_OK) {
			if (aReason == PLANTING_ONLY_ON_GRAVES) {
				this.DisplayAdvice("[ADVICE_GRAVEBUSTERS_ON_GRAVES]", MESSAGE_STYLE_HINT_FAST, ADVICE_PLANT_GRAVEBUSTERS_ON_GRAVES);
			} else if (aReason == PLANTING_NOT_PASSED_LINE) {
				this.DisplayAdvice("[ADVICE_NOT_PASSED_LINE]", MESSAGE_STYLE_HINT_FAST, ADVICE_PLANT_NOT_PASSED_LINE);
			} else if (aReason == PLANTING_NOT_ON_GRAVE) {
				this.DisplayAdvice("[ADVICE_PLANT_NOT_ON_GRAVE]", MESSAGE_STYLE_HINT_FAST, ADVICE_PLANT_NOT_ON_GRAVE);
			}
			return;
		}
		this.ClearAdvice(ADVICE_PLANT_NOT_ON_GRAVE);
		this.ClearAdvice(ADVICE_PLANT_NOT_PASSED_LINE);
		this.ClearAdvice(ADVICE_PLANT_GRAVEBUSTERS_ON_GRAVES);
		this.ClearAdvice(ADVICE_SURVIVE_FLAGS);
		if (this.mCursorObject.mCursorType == CURSOR_TYPE_PLANT_FROM_BANK && !this.HasConveyorBeltSeedBank()) {
			aCost = this.GetCurrentPlantCost(this.mCursorObject.mType);
			if (!this.TakeSunMoney(aCost)) {
				return;
			}
		}
		if (this.mCursorObject.mCursorType == CURSOR_TYPE_PLANT_FROM_USABLE_COIN) {
			this.AddPlant(aGridX, aGridY, this.mCursorObject.mType);
			this.mCursorObject.mCoin.Die();
			this.mCursorObject.mCoin = null;
		} else if (this.mCursorObject.mCursorType == CURSOR_TYPE_PLANT_FROM_BANK) {
			aPlant = this.AddPlant(aGridX, aGridY, this.mCursorObject.mType);
			this.mSeedBank.mSeedPackets[this.mCursorObject.mSeedBankIndex].WasPlanted();
		}
		if (this.mTutorialState == TUTORIAL_LEVEL_1_PLANT_PEASHOOTER) {
			aPeashooters = this.mPlants.length;
			if (aPeashooters >= 2) {
				this.SetTutorialState(TUTORIAL_LEVEL_1_COMPLETED);
			} else {
				this.SetTutorialState(TUTORIAL_LEVEL_1_REFRESH_PEASHOOTER);
			}
		}
		if (this.mTutorialState == TUTORIAL_LEVEL_2_PLANT_SUNFLOWER) {
			aSuns = this.CountSunFlowers();
			if (aPlantingSeedType == SEED_SUNFLOWER && aSuns == 2) {
				this.DisplayAdvice("[ADVICE_MORE_SUNFLOWERS]", MESSAGE_STYLE_TUTORIAL_LEVEL2, ADVICE_NONE);
			}
			if (aSuns >= 3) {
				this.SetTutorialState(TUTORIAL_LEVEL_2_COMPLETED);
			} else if (!this.mSeedBank.mSeedPackets[1].CanPickUp()) {
				this.SetTutorialState(TUTORIAL_LEVEL_2_REFRESH_SUNFLOWER);
			} else {
				this.SetTutorialState(TUTORIAL_LEVEL_2_PICK_UP_SUNFLOWER);
			}
		}
		if (this.mTutorialState == TUTORIAL_MORESUN_PLANT_SUNFLOWER) {
			aSuns = this.CountSunFlowers();
			if (aSuns >= 3) {
				this.SetTutorialState(TUTORIAL_MORESUN_COMPLETED);
				this.DisplayAdvice("[ADVICE_PLANT_SUNFLOWER5]", MESSAGE_STYLE_TUTORIAL_LATER, ADVICE_PLANT_SUNFLOWER5);
				this.mTutorialTimer = -1;
			} else if (!this.mSeedBank.mSeedPackets[1].CanPickUp()) {
				this.SetTutorialState(TUTORIAL_MORESUN_REFRESH_SUNFLOWER);
			} else {
				this.SetTutorialState(TUTORIAL_MORESUN_PICK_UP_SUNFLOWER);
			}
		}
		if (this.IsWallnutBowlingLevel()) {}
		this.ClearCursor();
	}

	function previousLevelCheat() {
		if (this.mApp.IsAdventureMode()) {
			--this.mApp.mLevel;

			if (this.mApp.mLevel < 1) {
				this.mApp.mLevel = 1;
			}
		} else if (this.mApp.IsSurvivalMode()) {}
		this.mApp.stateManager.changeState(PVZApp.STATE_LEVEL_INTRO);
	}

	public function DisplayAdvice(theAdvice:String, theMessageStyle:Int, theHelpIndex:Int) {
		if (theHelpIndex != ADVICE_NONE) {
			if (this.mHelpDisplayed[theHelpIndex]) {
				return;
			}
			this.mHelpDisplayed[theHelpIndex] = true;
		}
		this.mAdvice.SetLabel(theAdvice, theMessageStyle);
		this.mHelpIndex = theHelpIndex;
	}

	public function GetCircleRectOverlap(theCircleX:Int, theCircleY:Int, theRadius:Int, theRect:Rectangle):Bool {
		var distSquared = 0;
		var aCircleIsLeftOrRight = false;
		var aCircleIsAboveOrBelow = false;
		var aDistX = 0;
		var aDistY = 0;
		if (theCircleX < theRect.x) {
			aCircleIsLeftOrRight = true;
			aDistX = Std.int(theRect.x - theCircleX);
		} else if (theCircleX > theRect.x + theRect.width) {
			aCircleIsLeftOrRight = true;
			aDistX = Std.int(theCircleX - theRect.x - theRect.width);
		}
		if (theCircleY < theRect.y) {
			aCircleIsAboveOrBelow = true;
			aDistY = Std.int(theRect.y - theCircleY);
		} else if (theCircleY > theRect.y + theRect.height) {
			aCircleIsAboveOrBelow = true;
			aDistY = Std.int(theCircleY - theRect.y - theRect.height);
		}
		if (!aCircleIsAboveOrBelow && !aCircleIsLeftOrRight) {
			return true;
		}
		if (aCircleIsLeftOrRight && aCircleIsAboveOrBelow) {
			distSquared = aDistX * aDistX + aDistY * aDistY;
			return distSquared <= theRadius * theRadius;
		}
		if (aCircleIsLeftOrRight) {
			return aDistX <= theRadius;
		}
		return aDistY <= theRadius;
	}

	public function UpdateSunSpawning() {
		if (this.StageIsNight()) {
			return;
		}
		if (this.mApp.IsScaryPotterLevel()) {
			return;
		}
		if (this.HasLevelAwardDropped()) {
			return;
		}
		if (this.HasConveyorBeltSeedBank()) {
			return;
		}
		if (this.mTutorialState == TUTORIAL_LEVEL_1_PICK_UP_PEASHOOTER || this.mTutorialState == TUTORIAL_LEVEL_1_PLANT_PEASHOOTER) {
			if (this.mPlants.length == 0) {
				return;
			}
		}
		--this.mSunCountDown;

		if (this.mSunCountDown != 0) {
			return;
		}
		var x = Std.int(67 + Math.random() * 371);
		++this.mNumSunsFallen;
		this.mSunCountDown = Std.int(Math.min(SUN_COUNTDOWN_MAX, SUN_COUNTDOWN + this.mNumSunsFallen * 10) + Math.random() * SUN_COUNTDOWN_RANGE);
		var aCoinType = COIN_SUN;
		this.AddCoin(x, 40, aCoinType, COIN_MOTION_FROM_SKY);
	}

	public function DrawLevelLabel(g:Graphics2D) {
		var aLevelStr:String = null;
		var aFlags = 0;
		var aFlagStr:String = null;
		var aCompletedStr:String = null;
		var aStreak = 0;
		var aStr:String = null;
		var screenBounds:Rectangle = null;
		if (this.mGameScene != PVZApp.SCENE_PLAYING) {
			return;
		}
		if (this.mApp.IsSurvivalMode()) {
			aFlags = this.GetSurvivalFlagsCompleted();
			if (aFlags > 0) {
				aFlagStr = this.Pluralize(aFlags, "[ONE_FLAG]", "[COUNT_FLAGS]");
				aCompletedStr = this.mApp.stringManager.translateString("[FLAGS_COMPLETED]").split("{FLAGS}").join(aFlagStr);
				aLevelStr = this.mApp.stringManager.translateString("[SURVIVAL_POOL_ENDLESS]") + " " + aCompletedStr;
			} else {
				aLevelStr = this.mApp.stringManager.translateString("[SURVIVAL_POOL_ENDLESS]");
			}
		} else if (this.mApp.IsAdventureMode()) {
			aLevelStr = this.mApp.stringManager.translateString("[LEVEL]") + " " + this.GetStageString(this.mLevel);
		} else if (this.mApp.IsScaryPotterLevel()) {
			aStreak = this.mChallenge.mSurvivalStage;
			if (this.mNextSurvivalStageCounter > 0) {
				aStreak++;
			}
			if (aStreak > 0) {
				aStr = this.mApp.stringManager.translateString("[ENDLESS_STREAK]").split("{STREAK}").join(aStreak);
				aLevelStr = aStr;
			} else {
				aLevelStr = this.mApp.stringManager.translateString("[SCARY_POTTER_ENDLESS]");
			}
		}
		if (aLevelStr != this.mLevelLabelString) {
			this.mLevelLabel = null;
		}
		this.mLevelLabelString = aLevelStr;
		if (this.mLevelLabel == null) {
			screenBounds = new Rectangle(0, 0, this.mApp.screenWidth, this.mApp.screenHeight);
			this.mLevelFont.setColor(1, 224 / 255, 187 / 255, 98 / 255);
			this.mLevelLabel = Utils.createStringImage(aLevelStr, this.mLevelFont, screenBounds, Utils.JUSTIFY_CENTER);
		}
		var aPosX = 530;
		var aPosY = 375;
		if (this.HasProgressMeter()) {
			aPosX = 400;
		}
		aPosX -= Std.int(this.mLevelLabel.width);
		g.drawImage(this.mLevelLabel, aPosX, aPosY);
	}

	function spawnNewspaperZombieCheat() {
		this.AddZombieInRow(ZOMBIE_NEWSPAPER, Std.int(Math.random() * 5), 1);
	}

	public function PickBackground() {
		var newArray:Array<ASAny> = null;
		var newGridCelArray:Array<ASAny> = null;
		var newGridCellOffsetArray:Array<ASAny> = null;
		var y = 0;
		var anArray:Array<ASAny> = null;
		if (this.mApp.IsAdventureMode() && this.mLevel <= 10) {
			this.mBackground = BACKGROUND_1_DAY;
		} else {
			this.mBackground = BACKGROUND_2_NIGHT;
		}
		if (this.mBackground == BACKGROUND_1_DAY || this.mBackground == BACKGROUND_2_NIGHT) {
			this.mPlantRow[0] = PLANTROW_NORMAL;
			this.mPlantRow[1] = PLANTROW_NORMAL;
			this.mPlantRow[2] = PLANTROW_NORMAL;
			this.mPlantRow[3] = PLANTROW_NORMAL;
			this.mPlantRow[4] = PLANTROW_NORMAL;
			this.mPlantRow[5] = PLANTROW_DIRT;
			if (this.mLevel == 1) {
				this.mPlantRow[0] = PLANTROW_DIRT;
				this.mPlantRow[1] = PLANTROW_DIRT;
				this.mPlantRow[3] = PLANTROW_DIRT;
				this.mPlantRow[4] = PLANTROW_DIRT;
			} else if (this.mLevel == 2 || this.mLevel == 3) {
				this.mPlantRow[0] = PLANTROW_DIRT;
				this.mPlantRow[4] = PLANTROW_DIRT;
			}
		}
		for (x in 0...GRIDSIZEX) {
			newArray = new Array<ASAny>();
			this.mGridSquareType.push(newArray);
			newGridCelArray = new Array<ASAny>();
			this.mGridCelLook.push(newGridCelArray);
			newGridCellOffsetArray = new Array<ASAny>();
			this.mGridCelOffset.push(newGridCellOffsetArray);
			for (_tmp_ in 0...GRIDSIZEY) {
				y = _tmp_;
				this.mGridCelLook[x][y] = Math.random() * 20;
				anArray = new Array<ASAny>();
				this.mGridCelOffset[x].push(anArray);
				this.mGridCelOffset[x][y][0] = Math.random() * 6 - 3;
				this.mGridCelOffset[x][y][1] = Math.random() * 6 - 3;
				if (this.mPlantRow[y] == PLANTROW_DIRT) {
					this.mGridSquareType[x][y] = GRIDSQUARE_DIRT;
				} else {
					this.mGridSquareType[x][y] = GRIDSQUARE_GRASS;
				}
			}
		}
		if (this.mBackground == BACKGROUND_2_NIGHT) {
			if (!this.mApp.IsAdventureMode() && !this.mApp.IsScaryPotterLevel()) {
				this.AddGraveStones(4, 1);
				this.AddGraveStones(5, 1);
				this.AddGraveStones(6, 2);
				this.AddGraveStones(7, 2);
				this.AddGraveStones(8, 3);
			} else if (this.mLevel == 11 || this.mLevel == 12 || this.mLevel == 13) {
				this.AddGraveStones(6, 1);
				this.AddGraveStones(7, 1);
				this.AddGraveStones(8, 2);
			} else if (this.mLevel == 14 || this.mLevel == 16 || this.mLevel == 18) {
				this.AddGraveStones(5, 1);
				this.AddGraveStones(6, 1);
				this.AddGraveStones(7, 2);
				this.AddGraveStones(8, 3);
			}
		}

		this.PickSpecialGraveStone();
	}

	public function StageIsNight():Bool {
		if (this.mBackground == BACKGROUND_2_NIGHT) {
			return true;
		}
		return false;
	}

	public function DrawProgressMeter(g:Graphics2D) {
		var aNumWavesPerFlag = 0;
		var i = 0;
		var aWave = 0;
		var aHeight = 0;
		var aLeft = 0;
		var aRight = 0;
		var aPosX = 0;
		if (!this.HasProgressMeter()) {
			return;
		}
		if (this.mGameScene != PVZApp.SCENE_PLAYING) {
			return;
		}
		var aMeterX = 405;
		var aMeterY = 388;
		g.drawImage(this.FlagMeterFull, aMeterX, aMeterY);
		var aBarSize = TodCommon.TodAnimateCurve(0, PROGRESS_METER_COUNTER, this.mProgressMeterWidth, 107, 0, TodCommon.CURVE_LINEAR);
		g.pushState();
		g.setClipRect(aMeterX, aMeterY, aBarSize, 16);
		g.drawImage(this.FlagMeterEmpty, aMeterX, aMeterY);
		g.popState();
		if (this.ProgressMeterHasFlags()) {
			aNumWavesPerFlag = this.GetNumWavesPerFlag();
			var i:ASAny = 1;
			while (i <= this.mNumWaves / aNumWavesPerFlag) {
				aWave = i * aNumWavesPerFlag;
				aHeight = 0;
				if (aWave < this.mCurrentWave) {
					aHeight = 11;
				} else if (aWave == this.mCurrentWave) {
					aHeight = TodCommon.TodAnimateCurve(FLAG_RAISE_TIME, 0, this.mFlagRaiseCounter, 0, 11, TodCommon.CURVE_LINEAR);
				}

				aLeft = aMeterX + 4;
				aRight = aMeterX + 107 - 8;
				aPosX = TodCommon.TodAnimateCurve(0, this.mNumWaves, aWave, aRight, aLeft, TodCommon.CURVE_LINEAR);
				g.drawImage(this.FlagMeterBar, aPosX, aMeterY - 4);
				g.drawImage(this.FlagMeterFlag, aPosX, aMeterY - aHeight - 3);
				i++;
			}
		}
		g.drawImage(this.FlagMeterBar, aMeterX + 30, aMeterY + 11);

		var aHeadPosX = TodCommon.TodAnimateCurve(0, PROGRESS_METER_COUNTER, this.mProgressMeterWidth, 0, 100, TodCommon.CURVE_LINEAR);
		g.drawImage(this.FlagMeterHead, aMeterX + 107 - aHeadPosX - 14, aMeterY - 2);
	}

	public function KillAllZombies() {
		var aZombies:Zombie = null;
		for (_tmp_ in this.mZombies) {
			aZombies = _tmp_;
			aZombies.DieNoLoot();
		}
	}

	public function PutInMissingZombies(theWaveNumber:Int, theZombiePicker:ZombiePicker) {
		var aZombieType = 0;
		for (i in 0...NUM_ZOMBIE_TYPES) {
			aZombieType = i;
			if (theZombiePicker.mZombieTypeCount[aZombieType] <= 0) {
				if (this.CanZombieSpawnOnLevel(aZombieType, this.mLevel)) {
					this.PutZombieInWave(aZombieType, theWaveNumber, theZombiePicker);
				}
			}
		}
	}

	public function StartLevel() {
		if (this.mApp.IsSurvivalMode() && this.mChallenge.mSurvivalStage > 0) {}
		this.mChallenge.StartLevel();
	}

	public function initLevel() {
		var bounds:Rectangle = null;
		var aSmoothArray:SmoothArray = null;
		var aSeedPacket:SeedPacket = null;
		this.mMainCounter = 0;
		this.mEnableGraveStones = false;
		this.mSodPosition = 0;
		if (!this.mApp.IsAdventureMode()) {
			this.mLevel = 0;
		}
		this.PickBackground();
		this.mCurrentWave = 0;
		this.InitZombieWaves();
		if (this.mApp.IsAdventureMode() && this.mLevel == 1) {
			this.mSunMoney = 150;
			bounds = new Rectangle(0, 0, 40, 15);
			this.mSeedBank.mSunText = Utils.createStringImage(Std.string(this.mSunMoney), this.mSeedBank.mSeedBankFont, bounds, Utils.JUSTIFY_CENTER);
		} else if (this.mApp.IsScaryPotterLevel()) {
			this.mSunMoney = 0;
			bounds = new Rectangle(0, 0, 40, 15);
			this.mSeedBank.mSunText = Utils.createStringImage(Std.string(this.mSunMoney), this.mSeedBank.mSeedBankFont, bounds, Utils.JUSTIFY_CENTER);
		} else {
			this.mSunMoney = 50;
			bounds = new Rectangle(0, 0, 40, 15);
			this.mSeedBank.mSunText = Utils.createStringImage(Std.string(this.mSunMoney), this.mSeedBank.mSeedBankFont, bounds, Utils.JUSTIFY_CENTER);
		}
		for (y in 0...GRIDSIZEY) {
			this.mWaveRowGotLawnMowered[y] = -100;
			aSmoothArray = new SmoothArray();
			this.mRowPickingArray[y] = aSmoothArray;
			this.mRowPickingArray[y].mItem = y;
			this.mRowPickingArray[y].mLastPicked = 0;
			this.mRowPickingArray[y].mSecondLastPicked = 0;
		}
		this.mNumSunsFallen = 0;
		if (!this.StageIsNight()) {
			this.mSunCountDown = TodCommon.RandRangeInt(SUN_COUNTDOWN, SUN_COUNTDOWN + SUN_COUNTDOWN_RANGE);
		}
		for (i in 0...17) {
			this.mHelpDisplayed[i] = false;
		}
		this.mSeedBank.mNumPackets = this.GetNumSeedsInBank();
		var i:ASAny = 0;
		while (i < SeedBank.SEEDBANK_MAX) {
			aSeedPacket = new SeedPacket(this.mApp, this);
			aSeedPacket.mIndex = i;
			aSeedPacket.mX = this.GetSeedPacketPositionX(i);
			if (this.HasConveyorBeltSeedBank()) {
				aSeedPacket.mY = 5;
			} else {
				aSeedPacket.mY = 6;
			}
			aSeedPacket.mPacketType = SEED_NONE;
			this.mSeedBank.mSeedPackets[i] = aSeedPacket;
			i++;
		}
		if (this.mApp.IsScaryPotterLevel()) {
			this.mSeedBank.mSeedPackets[0].mPacketType = SEED_CHERRYBOMB;
		} else if (!this.ChooseSeedsOnCurrentLevel() && !this.HasConveyorBeltSeedBank()) {
			this.mSeedBank.mNumPackets = this.GetNumSeedsInBank();
			var i:ASAny = 0;
			while (i < this.mSeedBank.mNumPackets) {
				this.mSeedBank.mSeedPackets[i].mPacketType = i;
				if (this.mSeedBank.mSeedPackets[i].GetRefreshTime(this.mSeedBank.mSeedPackets[i].mPacketType) == 3000) {
					this.mSeedBank.mSeedPackets[i].mRefreshCounter = 0;
					this.mSeedBank.mSeedPackets[i].mRefreshing = true;
					this.mSeedBank.mSeedPackets[i].mRefreshTime = 2000;
					this.mSeedBank.mSeedPackets[i].mActive = false;
				} else if (this.mSeedBank.mSeedPackets[i].GetRefreshTime(this.mSeedBank.mSeedPackets[i].mPacketType) == 5000) {
					this.mSeedBank.mSeedPackets[i].mRefreshCounter = 0;
					this.mSeedBank.mSeedPackets[i].mRefreshing = true;

					this.mSeedBank.mSeedPackets[i].mRefreshTime = 5000;
					this.mSeedBank.mSeedPackets[i].mActive = false;
				}
				i++;
			}
		}
		this.mApp.widgetManager.markAllDirty();
		this.mPaused = false;
		this.mOutOfMoneyCounter = 0;
		this.InitLawnMowers();
		this.doorMask.x = -PVZApp.BOARD_OFFSET;
		this.doorMask.y = 154;
		this.mRenderManager.add(new ImageRenderable(this.doorMask, RENDER_LAYER_ABOVE_UI));
		this.mChallenge.InitLevel();
	}

	public function ProcessDeleteQueue() {
		var newGridItems:Array<ASAny> = null;
		var aGridItem:GridItem = null;
		var newCoins:Array<ASAny> = null;
		var aCoin:Coin = null;
		var newZombies:Array<ASAny> = null;
		var aZombie:Zombie = null;
		var newLawnMowers:Array<ASAny> = null;
		var aLawnMower:LawnMower = null;
		var aPlantFilter:ASFunction = function(element:ASAny, index:Int, arr:Array<ASAny>):Bool {
			var aPlant = cast(element, CPlant);
			return !aPlant.mDead;
		};
		this.mPlants = this.mPlants.filter((cast aPlantFilter));
		if (this.mGridItems.length > 0) {
			newGridItems = new Array<ASAny>();
			for (_tmp_ in this.mGridItems) {
				aGridItem = _tmp_;
				if (!aGridItem.mDead) {
					newGridItems.push(aGridItem);
				}
			}
			this.mGridItems = newGridItems;
		}
		if (this.mCoins.length > 0) {
			newCoins = new Array<ASAny>();
			for (_tmp_ in this.mCoins) {
				aCoin = _tmp_;
				if (!aCoin.mDead) {
					newCoins.push(aCoin);
				}
			}
			this.mCoins = newCoins;
		}
		if (this.mZombies.length > 0) {
			newZombies = new Array<ASAny>();
			for (_tmp_ in this.mZombies) {
				aZombie = _tmp_;
				if (!aZombie.mDead) {
					newZombies.push(aZombie);
				}
			}
			this.mZombies = newZombies;
		}

		if (this.mLawnMowers.length > 0) {
			newLawnMowers = new Array<ASAny>();
			for (_tmp_ in this.mLawnMowers) {
				aLawnMower = _tmp_;
				if (!aLawnMower.mDead) {
					newLawnMowers.push(aLawnMower);
				}
			}
			this.mLawnMowers = newLawnMowers;
		}
	}

	public function GridToPixelX(theGridX:Int, theGridY:Int):Int {
		return theGridX * 54 + LAWN_XMIN;
	}

	public function buttonRelease(id:Float) {
		switch (id) {
			case(_ == this.Menu_button => true):
				this.mPaused = true;
				this.mApp.stateManager.pushState(PVZApp.STATE_OPTIONS_MENU);
			default:
		}
	}

	function freePlantingCheat() {
		this.mEasyPlantingCheat = true;
	}

	public function ZombiesWon(aZombie:Zombie) {
		var aOtherZombie:Zombie = null;
		var aRect:Rectangle = null;
		if (this.mGameScene == SCENE_ZOMBIES_WON) {
			return;
		}
		if (this.mNextSurvivalStageCounter > 0) {
			this.mNextSurvivalStageCounter = 0;
		}
		for (_tmp_ in this.mZombies) {
			aOtherZombie = _tmp_;
			if (aOtherZombie != aZombie) {
				aRect = aOtherZombie.GetZombieRect();
				if (aRect.x < -35) {
					aOtherZombie.DieNoLoot();
				}
			}
		}
		this.mGameScene = SCENE_ZOMBIES_WON;
		aZombie.WalkIntoHouse();
		this.TutorialArrowRemove();
		this.ClearCursor();
		this.UpdateCursor();
		this.mApp.stateManager.changeState(PVZApp.STATE_ZOMBIES_WON);
	}

	public function UpdateGame() {
		this.UpdateGameObjects();

		if (this.mGameScene != PVZApp.SCENE_PLAYING) {
			return;
		}
		++this.mMainCounter;

		this.UpdateSunSpawning();
		this.UpdateZombieSpawning();
		if (this.mMainCounter == 1) {
			if (this.mLevel == 1) {
				this.SetTutorialState(TUTORIAL_LEVEL_1_PICK_UP_PEASHOOTER);
			} else if (this.mLevel == 2) {
				this.SetTutorialState(TUTORIAL_LEVEL_2_PICK_UP_SUNFLOWER);
				this.DisplayAdvice("[ADVICE_PLANT_SUNFLOWER1]", MESSAGE_STYLE_TUTORIAL_LEVEL2, ADVICE_NONE);
				this.mTutorialTimer = 500;
			}
		}
		this.UpdateProgressMeter();
	}

	public function GetNumWavesPerSurvivalStage():Int {
		return 20;
	}

	public function HasConveyorBeltSeedBank():Bool {
		if (this.IsWallnutBowlingLevel() || this.mLevel == 10) {
			return true;
		}
		return false;
	}

	function spawnAwardCheat() {
		var aCoinType:String = null;
		if (this.mApp.IsAdventureMode() && this.mLevel <= 14) {
			if (this.mLevel == 9) {
				aCoinType = Coin.COIN_NOTE;
			} else if (this.mLevel == 4) {
				aCoinType = Coin.COIN_SHOVEL;
			} else {
				aCoinType = Coin.COIN_FINAL_SEED_PACKET;
			}
			this.AddCoin(200, 200, aCoinType, COIN_MOTION_COIN);
			this.mLevelAwardSpawned = true;
		}
	}

	public function MouseHitTest(x:Int, y:Int, theHitResult:HitResult):Bool {
		var aTopCoin:Coin = null;
		var aCoin:Coin = null;
		var aHitResultCoin:HitResult = null;
		var aHitCoin:Coin = null;
		var aGridX = 0;
		var aGridY = 0;
		var aGridItem:GridItem = null;
		if (this.mBoardFadeOutCounter >= 0) {
			theHitResult.mObject = null;
			theHitResult.mObjectType = OBJECT_TYPE_NONE;
			return false;
		}
		if (this.mSeedBank.MouseHitTest(x, y, theHitResult)) {
			if (this.mCursorObject.mCursorType == CURSOR_TYPE_NORMAL || this.mCursorObject.mCursorType == CURSOR_TYPE_HAMMER) {
				return true;
			}
		}
		if (this.mShowShovel && this.mShovelButtonRect.contains(x, y)) {
			theHitResult.mObjectType = OBJECT_TYPE_SHOVEL;
			return true;
		}
		if (this.mCursorObject.mCursorType == CURSOR_TYPE_NORMAL || this.mCursorObject.mCursorType == CURSOR_TYPE_HAMMER) {
			aTopCoin = null;
			for (_tmp_ in this.mCoins) {
				aCoin = _tmp_;
				aHitResultCoin = new HitResult();
				if (aCoin.MouseHitTest(x, y, aHitResultCoin)) {
					aHitCoin = cast(aHitResultCoin.mObject, Coin);
					if (aTopCoin == null || aHitCoin.mRenderOrder >= aTopCoin.mRenderOrder) {
						theHitResult.mObject = aHitResultCoin.mObject;
						theHitResult.mObjectType = aHitResultCoin.mObjectType;
						aTopCoin = aHitCoin;
					}
				}
			}
			if (aTopCoin != null) {
				return true;
			}
		}

		if (this.MouseHitTestPlant(x, y, theHitResult)) {
			return true;
		}
		if (this.mApp.IsScaryPotterLevel()) {
			if (this.mCursorObject.mCursorType == CURSOR_TYPE_NORMAL
				&& this.mChallenge.mChallengeState != Challenge.STATECHALLENGE_SCARY_POTTER_MALLETING
				&& this.mGameScene == SCENE_PLAYING) {
				aGridX = this.PixelToGridX(x, y);
				aGridY = this.PixelToGridY(x, y);
				aGridItem = this.GetScaryPotAt(aGridX, aGridY);
				if (aGridItem != null) {
					theHitResult.mObject = aGridItem;
					theHitResult.mObjectType = OBJECT_TYPE_SCARY_POT;
					return true;
				}
			}
		}
		theHitResult.mObject = null;
		theHitResult.mObjectType = OBJECT_TYPE_NONE;
		return false;
	}

	public function KillAllZombiesInRadius(theRow:Int, theX:Int, theY:Int, theRadius:Int, theRowRange:Int, theBurn:Bool) {
		var aZombie:Zombie = null;
		var aZombieRect:Rectangle = null;
		var aRowDiff = 0;
		for (_tmp_ in this.mZombies) {
			aZombie = _tmp_;
			aZombieRect = aZombie.GetZombieRect();
			aRowDiff = aZombie.mRow - theRow;
			if (!(aRowDiff > theRowRange || aRowDiff < -theRowRange)) {
				if (this.GetCircleRectOverlap(theX, theY, theRadius, aZombieRect)) {
					if (theBurn) {
						aZombie.ApplyBurn();
					} else {
						aZombie.TakeDamage(1800, 1);
					}
				}
			}
		}
	}

	public function UpdateMousePosition() {
		var aPlant:CPlant = null;
		var aCursorSeedType = 0;
		var aMouseX = 0;
		var aMouseY = 0;
		var aGridItem:GridItem = null;
		var aHitResult:HitResult = null;
		var aScaryPot:GridItem = null;
		this.UpdateCursor();
		this.UpdateToolTip();
		for (_tmp_ in this.mPlants) {
			aPlant = _tmp_;
			aPlant.mHighlighted = false;
		}
		aCursorSeedType = this.GetSeedTypeInCursor();

		aMouseX = Std.int(this.mApp.widgetManager.lastMouseX - x);
		aMouseY = Std.int(this.mApp.widgetManager.lastMouseY - y);
		if (this.mApp.IsScaryPotterLevel()) {
			for (_tmp_ in this.mGridItems) {
				aGridItem = _tmp_;
				if (aGridItem.mGridItemType == GRIDITEM_SCARY_POT) {
					aGridItem.mHighlighted = false;
				}
			}
			aHitResult = new HitResult();
			this.MouseHitTest(aMouseX, aMouseY, aHitResult);
			if (aHitResult.mObjectType == OBJECT_TYPE_SCARY_POT) {
				aScaryPot = cast(aHitResult.mObject, GridItem);
				aScaryPot.mHighlighted = true;
				return;
			}
		}
		if (this.mCursorObject.mCursorType == CURSOR_TYPE_SHOVEL) {
			this.HighlightPlantsForMouse(aMouseX, aMouseY);
		}
	}

	public function NextWaveComing() {
		var aShowFinalWaveMessage = false;
		if (this.mCurrentWave + 1 == this.mNumWaves) {
			aShowFinalWaveMessage = true;
			if (this.mApp.IsSurvivalMode()) {
				aShowFinalWaveMessage = false;
			}
			if (aShowFinalWaveMessage) {
				this.mFinalWaveSoundCounter = 60;
				this.mWaveWarning.showFinalWave(460);
			}
		}
		if (this.mCurrentWave == 0) {
			this.mApp.foleyManager.playFoley(PVZFoleyType.AWOOGA);
		} else if (this.IsFlagWave(this.mCurrentWave)) {}
	}

	public function CanPlantAt(theGridX:Int, theGridY:Int, theType:Int):String {
		var aPlantOnLawn:CPlant = null;
		if (theGridX < 0 || theGridX >= GRIDSIZEX || theGridY < 0 || theGridY >= GRIDSIZEY) {
			return PLANTING_NOT_HERE;
		}
		if (this.IsWallnutBowlingLevel()) {
			if (theGridX > 2) {
				return PLANTING_NOT_PASSED_LINE;
			}
		}
		aPlantOnLawn = this.GetPlantsOnLawn(theGridX, theGridY);
		var aHasGraveStone:ASAny = this.GetGraveStoneAt(theGridX, theGridY) != null;
		if (theType == SEED_GRAVEBUSTER) {
			if (aPlantOnLawn != null) {
				return PLANTING_NOT_HERE;
			}
			if (aHasGraveStone) {
				return PLANTING_OK;
			}

			return PLANTING_ONLY_ON_GRAVES;
		}
		if (aHasGraveStone) {
			return PLANTING_NOT_ON_GRAVE;
		}
		var aHasScaryPot:ASAny = this.GetScaryPotAt(theGridX, theGridY) != null;
		if (aHasScaryPot) {
			return PLANTING_NOT_HERE;
		}
		if (this.mGridSquareType[theGridX][theGridY] == GRIDSQUARE_DIRT) {
			return PLANTING_NOT_HERE;
		}
		if (aPlantOnLawn == null) {
			return PLANTING_OK;
		}
		return PLANTING_NOT_HERE;
	}

	function spawnPolevaultZombieCheat() {
		this.AddZombieInRow(ZOMBIE_POLEVAULTER, Std.int(Math.random() * 5), 1);
	}

	public function PickUpTool(theObjectType:Int) {
		if (theObjectType == OBJECT_TYPE_SHOVEL) {
			if (this.mTutorialState == TUTORIAL_SHOVEL_PICKUP) {
				this.SetTutorialState(TUTORIAL_SHOVEL_DIG);
			}
			this.mCursorObject.mCursorType = CURSOR_TYPE_SHOVEL;
			this.mApp.foleyManager.playFoley(PVZFoleyType.SHOVEL);
		}
	}

	public function HighlightPlantsForMouse(theMouseX:Int, theMouseY:Int) {
		var aPlant = this.ToolHitTest(theMouseX, theMouseY);
		if (aPlant != null) {
			aPlant.mHighlighted = true;
		}
	}

	public function UpdateLevelEndSequence() {
		var aFlags = 0;
		var aIsRepick = false;
		var aIsNote = false;
		if (this.mNextSurvivalStageCounter > 0) {
			--this.mNextSurvivalStageCounter;
			if (this.mNextSurvivalStageCounter == 0) {
				if (this.mApp.IsScaryPotterLevel()) {
					if (this.mApp.adAPI.enabled) {
						this.mApp.musicManager.pauseMusic();
						this.mApp.soundManager.pauseAll();
						this.mApp.adAPI.GameBreak(this.mChallenge.mSurvivalStage, this.ContinueVasebreaker);
					} else {
						this.mChallenge.PuzzleNextStageClear();
						this.mChallenge.ScaryPotterPopulate();
						this.mMenuButton.visible = true;
					}
				} else {
					this.mLevelComplete = true;
					this.RemoveZombiesForRepick();
					aFlags = this.GetSurvivalFlagsCompleted() + 1;
					if (this.mApp.IsSurvivalEndless() && aFlags == 20) {}
				}
				return;
			}
		}
		if (this.mBoardFadeOutCounter < 0) {
			return;
		}
		--this.mBoardFadeOutCounter;
		if (this.mBoardFadeOutCounter == 0) {
			this.mLevelComplete = true;
			return;
		}
		if (this.mBoardFadeOutCounter == 300) {
			aIsRepick = this.mApp.IsSurvivalMode();
			aIsNote = this.mLevel == 9 || this.mLevel == 19 || this.mLevel == 29 || this.mLevel == 39 || this.mLevel == 49;

			if (!aIsRepick && !aIsNote) {}
		}
		if (!this.CanDropLoot()) {
			return;
		}
		if (this.mApp.IsSurvivalMode()) {
			return;
		}
	}

	public function StageHasGraveStones():Bool {
		if (this.IsWallnutBowlingLevel() || this.mApp.IsScaryPotterLevel()) {
			return false;
		}
		if (this.mBackground == BACKGROUND_2_NIGHT) {
			return true;
		}
		return false;
	}

	public function GetSeedTypeInCursor():Int {
		if (!this.IsPlantInCursor()) {
			return SEED_NONE;
		}
		return this.mCursorObject.mType;
	}

	public function GridToPixelY(theGridX:Int, theGridY:Int):Int {
		var aResult = 0;
		return theGridY * 67 + LAWN_YMIN;
	}

	public function AddZombieInRow(theZombieType:Int, theRow:Int, theFromWave:Int):Zombie {
		var aVariant = false;
		if (Math.random() * 5 == 0) {
			aVariant = true;
		}
		var aZombie = new Zombie();
		aZombie.ZombieInitialize(theRow, theZombieType, aVariant, null, theFromWave, this.mApp, this);
		this.mZombies.push(aZombie);
		this.mRenderManager.add(new ZombieRenderable(aZombie, RENDER_LAYER_ZOMBIE + aZombie.mRow));
		return aZombie;
	}

	public function AddPlant(theGridX:Int, theGridY:Int, theSeedType:Int):CPlant {
		var aPlant = this.NewPlant(theGridX, theGridY, theSeedType);
		this.DoPlantingEffects(theGridX, theGridY, aPlant);
		return aPlant;
	}

	public function SetTutorialState(theTutorialState:Int) {
		var aPosX = Math.NaN;
		var aPosY = Math.NaN;
		var aShovelButtonRect:Rectangle = null;
		if (theTutorialState == TUTORIAL_LEVEL_1_PICK_UP_PEASHOOTER) {
			if (this.mPlants.length == 0) {
				aPosX = this.mSeedBank.mX + this.mSeedBank.mSeedPackets[0].mX + this.mSeedBank.mSeedPackets[0].mWidth / 2;
				aPosY = this.mSeedBank.mY + this.mSeedBank.mSeedPackets[0].mY + this.mSeedBank.mSeedPackets[0].mHeight;
				this.TutorialArrowShow(Std.int(aPosX), Std.int(aPosY));
				this.DisplayAdvice("[ADVICE_CLICK_SEED_PACKET]", MESSAGE_STYLE_TUTORIAL_LEVEL1_STAY, ADVICE_NONE);
			} else {
				this.DisplayAdvice("[ADVICE_ENOUGH_SUN]", MESSAGE_STYLE_TUTORIAL_LEVEL1_STAY, ADVICE_NONE);
				this.mTutorialTimer = 400;
			}
		} else if (theTutorialState == TUTORIAL_LEVEL_1_PLANT_PEASHOOTER) {
			this.mTutorialTimer = -1;
			this.TutorialArrowRemove();
			if (this.mPlants.length == 0) {
				this.DisplayAdvice("[ADVICE_CLICK_ON_GRASS]", MESSAGE_STYLE_TUTORIAL_LEVEL1_STAY, ADVICE_NONE);
			} else {
				this.ClearAdvice(ADVICE_NONE);
			}
		} else if (theTutorialState == TUTORIAL_LEVEL_1_REFRESH_PEASHOOTER) {
			this.DisplayAdvice("[ADVICE_PLANTED_PEASHOOTER]", MESSAGE_STYLE_TUTORIAL_LEVEL1, ADVICE_NONE);
			this.mSunCountDown = 200;
		} else if (theTutorialState == TUTORIAL_LEVEL_1_COMPLETED) {
			this.DisplayAdvice("[ADVICE_ZOMBIE_ONSLAUGHT]", MESSAGE_STYLE_TUTORIAL_LEVEL1, ADVICE_NONE);
			this.mZombieCountDown = 100;
			this.mZombieCountDownStart = this.mZombieCountDown;
		} else if (theTutorialState == TUTORIAL_LEVEL_2_PICK_UP_SUNFLOWER || theTutorialState == TUTORIAL_MORESUN_PICK_UP_SUNFLOWER) {
			aPosX = this.mSeedBank.mX + this.mSeedBank.mSeedPackets[1].mX + this.mSeedBank.mSeedPackets[1].mWidth / 2;
			aPosY = this.mSeedBank.mY + this.mSeedBank.mSeedPackets[1].mY + this.mSeedBank.mSeedPackets[1].mHeight;
			this.TutorialArrowShow(Std.int(aPosX), Std.int(aPosY));
		} else if (theTutorialState == TUTORIAL_LEVEL_2_PLANT_SUNFLOWER
			|| theTutorialState == TUTORIAL_LEVEL_2_REFRESH_SUNFLOWER
			|| theTutorialState == TUTORIAL_MORESUN_PLANT_SUNFLOWER
			|| theTutorialState == TUTORIAL_MORESUN_REFRESH_SUNFLOWER) {
			this.TutorialArrowRemove();
		} else if (theTutorialState == TUTORIAL_LEVEL_2_COMPLETED) {
			if (this.mCurrentWave == 0) {
				this.mZombieCountDown = 1000;

				this.mZombieCountDownStart = this.mZombieCountDown;
			}
		} else if (theTutorialState == TUTORIAL_SHOVEL_PICKUP) {
			this.DisplayAdvice("[ADVICE_CLICK_SHOVEL]", MESSAGE_STYLE_HINT_STAY, ADVICE_NONE);
			aShovelButtonRect = this.mShovelButtonRect;
			aPosX = aShovelButtonRect.x + aShovelButtonRect.width / 2;
			aPosY = aShovelButtonRect.y + aShovelButtonRect.height;
			this.TutorialArrowShow(Std.int(aPosX), Std.int(aPosY));
		} else if (theTutorialState == TUTORIAL_SHOVEL_DIG) {
			this.DisplayAdvice("[ADVICE_CLICK_PLANT]", MESSAGE_STYLE_HINT_STAY, ADVICE_NONE);
			this.TutorialArrowRemove();
		} else if (theTutorialState == TUTORIAL_SHOVEL_KEEP_DIGGING) {
			this.DisplayAdvice("[ADVICE_KEEP_DIGGING]", MESSAGE_STYLE_HINT_STAY, ADVICE_NONE);
		} else if (theTutorialState == TUTORIAL_SHOVEL_COMPLETED) {
			this.ClearAdvice(ADVICE_NONE);
		}

		this.mTutorialState = theTutorialState;
	}

	public function AddCoin(theX:Int, theY:Int, theCoinType:String, theCoinMotion:String):Coin {
		var aCoin = new Coin();

		aCoin.CoinInitialize(theX, theY, theCoinType, theCoinMotion, this.mApp, this);
		if (this.mLevel == 1) {
			this.DisplayAdvice("[ADVICE_CLICK_ON_SUN]", MESSAGE_STYLE_TUTORIAL_LEVEL1_STAY, ADVICE_CLICK_ON_SUN);
		}
		this.mCoins.push(aCoin);

		this.mRenderManager.add(new CoinRenderable(aCoin, RENDER_LAYER_COIN_BANK));
		return aCoin;
	}

	public function GetCurrentPlantCost(theSeedType:Int):Int {
		var aCost = 0;
		switch (theSeedType) {
			case SEED_PEASHOOTER:
				aCost = 100;

			case SEED_SUNFLOWER:
				aCost = 50;

			case SEED_CHERRYBOMB:
				aCost = 150;

			case SEED_WALLNUT:
				aCost = 50;
			case SEED_CHOMPER:
				aCost = 150;

			case SEED_SQUASH:
				aCost = 50;
			case SEED_SNOWPEA:
				aCost = 175;
			case SEED_REPEATER:
				aCost = 200;
			case SEED_PUFFSHROOM:
				aCost = 0;
			case SEED_SUNSHROOM:
				aCost = 25;
			case SEED_FUMESHROOM:
				aCost = 75;
			case SEED_GRAVEBUSTER:
				aCost = 75;
			default:
				aCost = 100;
		}
		return aCost;
	}

	public function PickSpecialGraveStone() {
		var aGridItem:GridItem = null;
		var MAX_GRAVE_STONES = GRIDSIZEX * GRIDSIZEY;
		var aPicks = new Array<ASAny>();
		var aPickCount = 0;
		for (_tmp_ in this.mGridItems) {
			aGridItem = _tmp_;
			if (aGridItem.mGridItemType == GRIDITEM_GRAVESTONE) {
				aPicks[aPickCount] = aGridItem;
				aPickCount++;
			}
		}
		if (aPickCount == 0) {
			return;
		}
		var aResultItem = cast(aPicks[TodCommon.TodPickFromArray(aPicks, aPickCount)], GridItem);
		aResultItem.mGridItemState = GridItem.GRIDITEM_STATE_GRAVESTONE_SPECIAL;
	}

	public function UpdateToolTip() {
		var aZombie:Zombie = null;
		var aZombieDef:ZombieDef = null;
		var aZombieName:ASAny = null;
		var aRect:Rectangle = null;
		var aSeedPacket:SeedPacket = null;
		var aUseSeedType = 0;
		var aCost = 0;
		if (this.mTimeStopCounter > 0 || this.mGameScene == SCENE_ZOMBIES_WON || this.mPaused) {
			this.mToolTip.mVisible = false;
			return;
		}
		var aMouseX = Std.int(this.mApp.widgetManager.lastMouseX - x);
		var aMouseY = Std.int(this.mApp.widgetManager.lastMouseY - y);
		if (this.mGameScene != SCENE_LEVEL_INTRO && aMouseY > 80) {
			this.mToolTip.mVisible = false;
			return;
		}
		if (this.mGameScene == SCENE_LEVEL_INTRO && this.ChooseSeedsOnCurrentLevel()) {
			aZombie = this.ZombieHitTest(aMouseX, aMouseY);
			if (aZombie == null || aZombie.mFromWave != Zombie.ZOMBIE_WAVE_CUTSCENE) {
				this.mToolTip.mVisible = false;
				return;
			}
			aZombieDef = this.GetZombieDefinition(aZombie.mZombieType);
			aZombieName = "[" + aZombieDef.mZombieName + "]";
			this.mToolTip.SetTitle(aZombieName);
			this.mToolTip.SetLabel("");
			this.mToolTip.SetWarningText("");
			aRect = aZombie.GetZombieRect();
			this.mToolTip.mX = Std.int(aRect.x + aRect.width / 2 + 5);
			this.mToolTip.mY = Std.int(aRect.y + aRect.height - 10);
			this.mToolTip.mVisible = true;
			this.mToolTip.mCenter = true;
			this.mToolTip.mMinLeft = Std.int(this.mApp.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BACKGROUND).width);
			this.mToolTip.mMaxBottom = BOARD_HEIGHT;
			return;
		}
		if (this.mGameScene != SCENE_PLAYING) {
			return;
		}
		this.mToolTip.mMinLeft = 0;
		this.mToolTip.mMaxBottom = BOARD_HEIGHT;
		this.mToolTip.SetLabel("");
		this.mToolTip.SetTitle("");
		this.mToolTip.SetWarningText("");
		this.mToolTip.mCenter = false;
		var aHitResult = new HitResult();
		this.MouseHitTest(aMouseX, aMouseY, aHitResult);
		if (aHitResult.mObjectType == OBJECT_TYPE_SHOVEL) {
			this.mToolTip.SetLabel("[SHOVEL_TOOLTIP]");
			this.mToolTip.mX = Std.int(this.mShovelButtonRect.x + 35);
			this.mToolTip.mY = Std.int(this.mShovelButtonRect.y + 72);
			this.mToolTip.mCenter = true;
			this.mToolTip.mVisible = true;
		} else if (aHitResult.mObjectType == OBJECT_TYPE_SEEDPACKET) {
			aSeedPacket = cast(aHitResult.mObject, SeedPacket);
			aUseSeedType = aSeedPacket.mPacketType;
			this.mToolTip.SetLabel(this.GetSeedName(aSeedPacket.mPacketType));
			aCost = this.GetCurrentPlantCost(aSeedPacket.mPacketType);
			if (this.mEasyPlantingCheat) {
				this.mToolTip.SetWarningText("FREE_PLANTING_CHEAT");
			} else if (!aSeedPacket.mActive) {
				this.mToolTip.SetWarningText("[WAITING_FOR_SEED]");
			} else if (!this.CanTakeSunMoney(aCost) && !this.HasConveyorBeltSeedBank()) {
				this.mToolTip.SetWarningText("[NOT_ENOUGH_SUN]");
			}
			this.mToolTip.mX = Std.int(this.mSeedBank.mX + aSeedPacket.mX + aSeedPacket.mOffsetX + (50 - this.mToolTip.mWidth) / 2);
			this.mToolTip.mY = this.mSeedBank.mY + aSeedPacket.mY + 70;
			this.mToolTip.mVisible = true;
		} else {
			this.mToolTip.mVisible = false;
		}
	}

	public function GetRectOverlap(rect1:Rectangle, rect2:Rectangle):Int {
		var aLeft1 = 0;

		var aRight1 = 0;
		var aLeft2 = 0;
		var aRight2 = 0;
		if (rect1.x < rect2.x) {
			aLeft1 = Std.int(rect1.x);
			aRight1 = Std.int(rect1.x + rect1.width);
			aLeft2 = Std.int(rect2.x);
			aRight2 = Std.int(rect2.x + rect2.width);
		} else {
			aLeft1 = Std.int(rect2.x);
			aRight1 = Std.int(rect2.x + rect2.width);

			aLeft2 = Std.int(rect1.x);
			aRight2 = Std.int(rect1.x + rect1.width);
		}
		if (aRight1 <= aLeft2) {
			return aRight1 - aLeft2;
		}
		if (aRight1 <= aRight2) {
			return aRight1 - aLeft2;
		}
		return aRight2 - aLeft2;
	}

	public function GetNumWavesPerFlag():Int {
		if (this.mApp.IsAdventureMode() && this.mNumWaves < 10) {
			return this.mNumWaves;
		}
		return 10;
	}

	public function GetPosYBasedOnRow(thePosX:Float, theRow:Int):Float {
		return this.GridToPixelY(0, theRow);
	}

	public function InitZombieWaves() {
		for (i in 0...8) {
			this.mZombieAllowed[i] = false;
		}
		if (this.mApp.IsAdventureMode()) {
			this.InitZombieWavesForLevel(this.mLevel);
		} else {
			this.mChallenge.InitZombieWaves();
		}
		this.PickZombieWaves();

		this.mCurrentWave = 0;
		this.mTotalSpawnedWaves = 0;
		if (this.mLevel == 2) {
			this.mZombieCountDown = 5000;
		} else if (this.mApp.IsSurvivalMode() && this.mChallenge.mSurvivalStage > 0) {
			this.mZombieCountDown = 600;
		} else {
			this.mZombieCountDown = 1800;
		}
		this.mZombieCountDownStart = this.mZombieCountDown;
		this.mZombieHealthToNextWave = -1;

		this.mZombieHealthWaveStart = 0;
		this.mLastBungeeWave = 0;
		this.mProgressMeterWidth = 0;

		this.mHugeWaveCountDown = 0;
		this.mLevelAwardSpawned = false;
	}

	function spawnGraveZombieCheat() {
		this.SpawnZombiesFromGraves();
	}

	function spawnBucketZombieCheat() {
		this.AddZombieInRow(ZOMBIE_PAIL, Std.int(Math.random() * 5), 1);
	}

	public function NewPlant(theGridX:Int, theGridY:Int, theSeedType:Int):CPlant {
		var aPlant:CPlant = null;
		switch (theSeedType) {

			case SEED_PEASHOOTER:
				aPlant = new PeaShooter(theGridX, theGridY, theSeedType, this.mApp, this);

			case SEED_SUNFLOWER:
				aPlant = new Sunflower(theGridX, theGridY, theSeedType, this.mApp, this);

			case SEED_CHERRYBOMB:
				aPlant = new CherryBomb(theGridX, theGridY, theSeedType, this.mApp, this);

			case SEED_WALLNUT:
				aPlant = new Wallnut(theGridX, theGridY, theSeedType, this.mApp, this);

			case SEED_SQUASH:
				aPlant = new Squash(theGridX, theGridY, theSeedType, this.mApp, this);

			case SEED_CHOMPER:
				aPlant = new Chomper(theGridX, theGridY, theSeedType, this.mApp, this);
			case SEED_SNOWPEA:
				aPlant = new SnowPea(theGridX, theGridY, theSeedType, this.mApp, this);
			case SEED_REPEATER:
				aPlant = new Repeater(theGridX, theGridY, theSeedType, this.mApp, this);
			case SEED_EXPLODE_O_NUT:
				aPlant = new ExplodoNut(theGridX, theGridY, theSeedType, this.mApp, this);

			case SEED_PUFFSHROOM:
				aPlant = new PuffShroom(theGridX, theGridY, theSeedType, this.mApp, this);
			case SEED_FUMESHROOM:
				aPlant = new FumeShroom(theGridX, theGridY, theSeedType, this.mApp, this);
			case SEED_SUNSHROOM:
				aPlant = new SunShroom(theGridX, theGridY, theSeedType, this.mApp, this);

			case SEED_GRAVEBUSTER:
				aPlant = new GraveBuster(theGridX, theGridY, theSeedType, this.mApp, this);

			case SEED_LEFTPEATER:
				aPlant = new LeftPeater(theGridX, theGridY, theSeedType, this.mApp, this);
			default:
				aPlant = new PeaShooter(theGridX, theGridY, theSeedType, this.mApp, this);
		}
		this.mPlants.push(aPlant);
		this.mRenderManager.add(new PlantRenderable(aPlant, RENDER_LAYER_PLANT));
		return aPlant;
	}

	function spawnNormalZombieCheat() {
		this.AddZombieInRow(ZOMBIE_NORMAL, Std.int(Math.random() * 5), 1);
	}

	public function TutorialArrowShow(x:Int, y:Int) {
		this.TutorialArrowRemove();
		this.mTutorialArrow = this.mApp.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_SEEDPACKETPICK);

		this.mTutorialArrow.setPosition(x, y + 10);
		this.mRenderManager.add(new ParticleRenderable(this.mTutorialArrow, RENDER_LAYER_TOP));
	}

	override public function onKeyDown(keyCode:UInt) {}

	override public function onKeyUp(keyCode:UInt) {
		switch (keyCode) {
			case 32:
				if (!this.mMenuButton.visible) {
					return;
				}
				if (this.mPaused) {
					this.mPaused = false;
					this.mApp.stateManager.changeState(PVZApp.STATE_PLAY_LEVEL);
				} else {
					this.mPaused = true;
					this.mApp.stateManager.changeState(PVZApp.STATE_OPTIONS_MENU);
				}
		}
	}

	public function DrawSeedType(g:Graphics2D, theSeedType:Int, theDrawVariation:String, thePosX:Float, thePosY:Float) {
		var thePlant:Reanimation = null;
		var aTransform:Matrix = null;
		var aOffsetX:Float = 0;
		var aOffsetY:Float = 0;
		var aFrame = 2;
		var aRow = 0;
		var aDrawSeedType = theSeedType;
		var aDrawVariation = theDrawVariation;

		var aPlantDef = this.GetPlantDefinition(aDrawSeedType);
		if (aPlantDef != "none") {
			thePlant = this.mApp.reanimator.createReanimation(aPlantDef);
			thePlant.x = thePosX + aOffsetX;
			thePlant.y = thePosY + aOffsetY;
			if (theSeedType == SEED_PEASHOOTER) {
				thePlant.currentTrack = "anim_full_idle";
			} else {
				thePlant.currentTrack = "anim_idle";
			}

			thePlant.update();
			aTransform = new Matrix();
			if (theDrawVariation == "cursor") {
				thePlant.drawLerp(g, aTransform, 0.5);
			} else {
				thePlant.drawLerp(g, aTransform);
			}
			return;
		}
	}

	public function PixelToGridY(theX:Int, theY:Int):Int {
		var aGridX = this.PixelToGridX(theX, theY);
		if (aGridX == -1 || theY < LAWN_YMIN) {
			return -1;
		}
		return TodCommon.ClampInt(Std.int((theY - LAWN_YMIN) / 67), 0, 4);
	}

	public function buttonDownTick(id:Float) {}

	public function RemoveCutsceneZombies() {
		var aZombie:Zombie = null;
		for (_tmp_ in this.mZombies) {
			aZombie = _tmp_;
			if (aZombie.mFromWave == -2) {
				aZombie.DieNoLoot();
			}
		}
	}

	override public function update() {
		markDirty();
		this.UpdateMousePosition();
		this.ProcessDeleteQueue();
		if (this.mPaused) {
			this.mChallenge.Update();
			this.mCursorPreview.mVisible = false;
			this.mCursorObject.mVisible = false;
			return;
		}
		this.mAdvice.Update();
		this.UpdateTutorial();
		if (this.mOutOfMoneyCounter > 0) {
			--this.mOutOfMoneyCounter;
		}
		if (this.mShakeCounter > 0) {
			--this.mShakeCounter;
			if (this.mShakeCounter == 0) {
				x = 0;
				y = 0;
			} else {
				if (Math.random() * 2 == 0) {
					this.mShakeAmountX = -this.mShakeAmountX;
				}
				x = TodCommon.TodAnimateCurve(BOARD_SHAKE_TIME, 0, this.mShakeCounter, 0, this.mShakeAmountX, TodCommon.CURVE_BOUNCE);
				y = TodCommon.TodAnimateCurve(BOARD_SHAKE_TIME, 0, this.mShakeCounter, 0, this.mShakeAmountY, TodCommon.CURVE_BOUNCE);
				move(x, y);
			}
		}
		this.UpdateGridItems();
		this.UpdateGame();
		this.mChallenge.Update();
		this.UpdateLevelEndSequence();
		this.mWaveWarning.update();
	}

	public function HasLevelAwardDropped():Bool {
		if (this.mLevelAwardSpawned) {
			return true;
		}
		if (this.mNextSurvivalStageCounter > 0 || this.mBoardFadeOutCounter >= 0) {
			return true;
		}
		return false;
	}

	public function UpdateProgressMeter() {
		var aNumFlags = 0;
		var aNumFlagsPassed = 0;
		var aTotalHealth = 0;
		var aHealthRange = 0;
		var aHealthFraction = Math.NaN;
		if (this.mCurrentWave == 0) {
			return;
		}
		if (this.mFlagRaiseCounter > 0) {
			--this.mFlagRaiseCounter;
		}
		var FLAG_GAP_SIZE = 9;
		var aWaveMeterPixelsToCover = PROGRESS_METER_COUNTER;
		var aNumWavesPerFlag = this.GetNumWavesPerFlag();
		if (this.ProgressMeterHasFlags()) {
			aNumFlags = Std.int(this.mNumWaves / aNumWavesPerFlag);
			aWaveMeterPixelsToCover -= aNumFlags * FLAG_GAP_SIZE;
		}
		var aWaveWidth = Std.int(aWaveMeterPixelsToCover / (this.mNumWaves - 1));
		var aFlagMeterWidthPrev = Std.int((this.mCurrentWave - 1) * aWaveMeterPixelsToCover / (this.mNumWaves - 1));
		var aFlagMeterWidthNext = Std.int(this.mCurrentWave * aWaveMeterPixelsToCover / (this.mNumWaves - 1));
		if (this.ProgressMeterHasFlags()) {
			aNumFlagsPassed = Std.int(this.mCurrentWave / aNumWavesPerFlag);
			aFlagMeterWidthPrev += aNumFlagsPassed * FLAG_GAP_SIZE;
			aFlagMeterWidthNext += aNumFlagsPassed * FLAG_GAP_SIZE;
		}
		var aFraction = (this.mZombieCountDownStart - this.mZombieCountDown) / this.mZombieCountDownStart;
		if (this.mZombieHealthToNextWave != -1) {
			aTotalHealth = this.TotalZombiesHealthInWave(this.mCurrentWave - 1);
			aHealthRange = Std.int(Math.max(this.mZombieHealthWaveStart - this.mZombieHealthToNextWave, 1));
			aHealthFraction = (aHealthRange - aTotalHealth + this.mZombieHealthToNextWave) / aHealthRange;
			if (aHealthFraction > aFraction) {
				aFraction = aHealthFraction;
			}
		}
		var aDestPosition = Std.int(aFlagMeterWidthPrev + Math.fround((aFlagMeterWidthNext - aFlagMeterWidthPrev) * aFraction));
		aDestPosition = TodCommon.ClampInt(aDestPosition, 1, PROGRESS_METER_COUNTER);
		var aDelta = aDestPosition - this.mProgressMeterWidth;
		if (aDelta > aWaveWidth && this.mMainCounter % 5 == 0) {
			++this.mProgressMeterWidth;
		} else if (aDelta > 0 && this.mMainCounter % 20 == 0) {
			++this.mProgressMeterWidth;
		}
	}

	public function RowCanHaveZombies(theRow:Int):Bool {
		if (theRow < 0 || theRow >= GRIDSIZEY) {
			return false;
		}
		if (this.mPlantRow[theRow] == PLANTROW_DIRT) {
			return false;
		}
		return true;
	}

	public function GetSeedPacketPositionX(theIndex:Int):Int {
		var aSeedsInBank = this.mSeedBank.mNumPackets;
		if (this.IsSlotMachineLevel()) {
			return theIndex * 59 + 247;
		}
		if (this.HasConveyorBeltSeedBank()) {
			return theIndex * 47 + 5;
		}
		if (aSeedsInBank <= 6) {
			return theIndex * 54 + 74;
		}
		if (aSeedsInBank == 7) {
			return theIndex * 59 + 85;
		}
		if (aSeedsInBank == 8) {
			return theIndex * 54 + 81;
		}
		if (aSeedsInBank == 9) {
			return theIndex * 52 + 80;
		}
		return theIndex * 51 + 79;
	}

	public function PickGraveRisingZombieType(theZombiePoints:Int):Int {
		var aZombieType = 0;
		var aZombieDef:ZombieDef = null;
		var aZombieWeightArray = new Array<ASAny>();
		var aPickCount = 0;
		aZombieWeightArray[aPickCount] = new WeightedArray();
		aZombieWeightArray[aPickCount].mItem = ZOMBIE_NORMAL;
		aZombieWeightArray[aPickCount].mWeight = this.GetZombieDefinition(ZOMBIE_NORMAL).mPickWeight;
		aPickCount++;
		aZombieWeightArray[aPickCount] = new WeightedArray();
		aZombieWeightArray[aPickCount].mItem = ZOMBIE_TRAFFIC_CONE;

		aZombieWeightArray[aPickCount].mWeight = this.GetZombieDefinition(ZOMBIE_TRAFFIC_CONE).mPickWeight;
		aPickCount++;
		if (!this.StageHasGraveStones()) {
			aZombieWeightArray[aPickCount] = new WeightedArray();
			aZombieWeightArray[aPickCount].mItem = ZOMBIE_PAIL;
			aZombieWeightArray[aPickCount].mWeight = this.GetZombieDefinition(ZOMBIE_PAIL).mPickWeight;
			aPickCount++;
		}
		for (i in 0...aPickCount) {
			aZombieType = ASCompat.toInt(aZombieWeightArray[i].mItem);
			aZombieDef = this.GetZombieDefinition(aZombieType);
			if (this.mLevel < aZombieDef.mStartingLevel) {
				aZombieWeightArray[i].mWeight = 0;
			} else if (!this.mZombieAllowed[aZombieType] && aZombieType != ZOMBIE_NORMAL) {
				aZombieWeightArray[i].mWeight = 0;
			} else {
				aZombieWeightArray[i].mWeight = aZombieDef.mPickWeight;
			}
		}
		return TodCommon.TodPickFromWeightedArray(aZombieWeightArray, aPickCount);
	}

	public function DrawDebugRects(g:Graphics2D) {
		var x = 0;
		var y = 0;
		var h = 0;
		var w = 0;
		var aRect:Rectangle = null;

		var aPlant:CPlant = null;
		var aZombie:Zombie = null;
		for (_tmp_ in this.mPlants) {
			aPlant = _tmp_;
			aRect = aPlant.GetPlantRect();
			g.fillRect(aRect.x, aRect.y, aRect.width, aRect.height, 4293263360);
		}
		for (_tmp_ in this.mZombies) {
			aZombie = _tmp_;
			aRect = aZombie.GetZombieRect();
			g.fillRect(aRect.x, aRect.y, aRect.width, aRect.height, 4293263360);
			aRect = aZombie.GetZombieAttackRect();
			g.fillRect(aRect.x, aRect.y, aRect.width, aRect.height, 4278248982);
		}
	}

	public function HasProgressMeter():Bool {
		if (this.mProgressMeterWidth == 0) {
			return false;
		}
		if (this.mApp.IsScaryPotterLevel()) {
			return false;
		}
		return true;
	}

	public function AreEnemyZombiesOnScreen():Bool {
		var aZombie:Zombie = null;
		if (this.mZombies.length == 0) {
			return false;
		}
		for (_tmp_ in this.mZombies) {
			aZombie = _tmp_;
			if (aZombie.mHasHead) {
				if (!aZombie.IsDeadOrDying()) {
					if (!aZombie.mMindControlled) {
						return true;
					}
				}
			}
		}
		return false;
	}

	function refreshSeedsCheat() {
		var aSeedPacket:SeedPacket = null;

		for (_tmp_ in this.mSeedBank.mSeedPackets) {
			aSeedPacket = _tmp_;
			if (aSeedPacket.mPacketType == SEED_NONE) {
				break;
			}
			if (aSeedPacket.mRefreshing) {
				aSeedPacket.mRefreshCounter = 0;
				aSeedPacket.mRefreshing = false;
				aSeedPacket.Activate();
				aSeedPacket.FlashIfReady();
			}
		}
	}

	override public function onMouseMove(x:Float, y:Float) {}

	public function InitSurvivalStage() {
		this.RefreshSeedPacketFromCursor();
		this.mLevelComplete = false;
		this.InitZombieWaves();
		this.mGameScene = SCENE_LEVEL_INTRO;
		for (y in 0...GRIDSIZEY) {
			this.mWaveRowGotLawnMowered[y] = -100;
		}
	}

	function nextLevelCheat() {
		if (this.mApp.IsAdventureMode()) {
			++this.mApp.mLevel;
			if (this.mApp.mLevel > 14) {
				this.mApp.mLevel = 14;
			}
			this.mApp.stateManager.changeState(PVZApp.STATE_LEVEL_INTRO);
		} else if (this.mApp.IsSurvivalMode()) {
			this.KillAllZombies();
			++this.mChallenge.mSurvivalStage;
			this.InitSurvivalStage();
			this.PlaceStreetZombies();
			this.mApp.mCutsceneTime = 0;
			this.mApp.stateManager.changeState(PVZApp.STATE_SURVIVAL_REPICK);
		}
	}

	public function PickZombieWaves() {
		var aWaveLevelIndex = 0;
		var aZombieWave:Array<ASAny> = null;
		var aIsFlagWave = false;
		var aIsFinalWave:ASAny = false;
		var aSpawnIntroZombie = false;
		var aBasicZombiePoints = 0;
		var i = 0;
		var aZombieType = 0;
		if (this.mApp.IsAdventureMode()) {
			aWaveLevelIndex = TodCommon.ClampInt(this.mLevel - 1, 0, 14 - 1);
			this.mNumWaves = this.mZombieWaves[aWaveLevelIndex];
		} else if (this.mApp.IsSurvivalMode()) {
			this.mNumWaves = this.GetNumWavesPerSurvivalStage();
		}
		var aZombiePicker = new ZombiePicker();
		this.ZombiePickerInit(aZombiePicker);
		var aIntroZombieType = this.GetIntroducedZombieType();
		var aWaveNumber = 0;
		while (aWaveNumber < this.mNumWaves) {
			this.ZombiePickerInitForWave(aZombiePicker);
			aZombieWave = new Array<ASAny>();
			this.mZombiesInWave[aWaveNumber] = aZombieWave;
			this.mZombiesInWave[aWaveNumber][0] = ZOMBIE_INVALID;
			aIsFlagWave = this.IsFlagWave(aWaveNumber);
			aIsFinalWave = aWaveNumber == this.mNumWaves - 1;
			if (this.mApp.IsSurvivalMode() && this.mChallenge.mSurvivalStage > 0) {
				aZombiePicker.mZombiePoints = Std.int((this.mChallenge.mSurvivalStage * this.GetNumWavesPerSurvivalStage() + aWaveNumber) * 2 / 5 + 1);
			} else {
				aZombiePicker.mZombiePoints = Std.int(aWaveNumber / 3 + 1);
			}
			if (aIsFlagWave) {
				aBasicZombiePoints = Std.int(Math.min(aZombiePicker.mZombiePoints, 8));
				aZombiePicker.mZombiePoints = Std.int(aZombiePicker.mZombiePoints * 2.5);
				var i:ASAny = 0;
				while (i < aBasicZombiePoints) {
					this.PutZombieInWave(ZOMBIE_NORMAL, aWaveNumber, aZombiePicker);
					i++;
				}
				this.PutZombieInWave(ZOMBIE_FLAG, aWaveNumber, aZombiePicker);
			}
			if (this.IsWallnutBowlingLevel()) {
				aZombiePicker.mZombiePoints *= 4;
			} else if (this.mApp.IsAdventureMode() && this.mLevel == 10) {
				aZombiePicker.mZombiePoints *= 3;
			}
			aSpawnIntroZombie = false;
			if (ASCompat.thisOrDefault(aWaveNumber == this.mNumWaves / 2, aIsFinalWave)) {
				aSpawnIntroZombie = true;
			}
			if (aSpawnIntroZombie) {
				if (aIntroZombieType != ZOMBIE_INVALID) {
					this.PutZombieInWave(aIntroZombieType, aWaveNumber, aZombiePicker);
				}
			}
			if (this.mApp.IsAdventureMode() && aIsFinalWave) {
				this.PutInMissingZombies(aWaveNumber, aZombiePicker);
			}
			while (aZombiePicker.mZombiePoints > 0 && aZombiePicker.mZombieCount < MAX_ZOMBIES_IN_WAVE) {
				aZombieType = this.PickZombieType(aZombiePicker.mZombiePoints, aWaveNumber, aZombiePicker);
				this.PutZombieInWave(aZombieType, aWaveNumber, aZombiePicker);
			}
			aWaveNumber++;
		}
		var i:ASAny = 0;
		while (i < MAX_ZOMBIES_IN_WAVE) {
			i++;
		}
	}

	public function InitZombieWavesForLevel(aForLevel:Int) {
		for (i in 0...NUM_ZOMBIE_TYPES) {
			this.mZombieAllowed[i] = this.CanZombieSpawnOnLevel(i, aForLevel);
			if (this.CanZombieSpawnOnLevel(i, aForLevel)) {}
		}
	}

	public function PlaceAZombie(theZombieType:Int, theGridX:Int, theGridY:Int) {
		var aZombie = new Zombie();
		var aVariant = false;
		if (Math.random() * 5 == 0) {
			aVariant = true;
		}

		aZombie.ZombieInitialize(0, theZombieType, aVariant, null, -2, this.mApp, this.mApp.mBoard);
		this.mApp.mBoard.mZombies.push(aZombie);
		aZombie.mPosX = 600 + 28 * theGridX;
		aZombie.mPosY = 77 + 50 * theGridY;
		if (theGridX % 2 == 1) {
			aZombie.mPosY += 21;
		} else {
			aZombie.mPosY += Math.random() * 10;
			aZombie.mPosX += Math.random() * 10;
		}
		this.mApp.mBoard.mRenderManager.add(new ZombieRenderable(aZombie, Board.RENDER_LAYER_ZOMBIE + aZombie.mPosY));
	}

	public function CanAddGraveStoneAt(theGridX:Int, theGridY:Int):Bool {
		var aGridItem:GridItem = null;
		if (this.mGridSquareType[theGridX][theGridY] != GRIDSQUARE_GRASS) {
			return false;
		}
		for (_tmp_ in this.mGridItems) {
			aGridItem = _tmp_;
			if (!(aGridItem.mGridX != theGridX || aGridItem.mGridY != theGridY)) {
				if (aGridItem.mGridItemType == GRIDITEM_GRAVESTONE) {
					return false;
				}
			}
		}
		return true;
	}

	public function ZombiePickerInitForWave(theZombiePicker:ZombiePicker) {
		theZombiePicker.mZombieCount = 0;
		theZombiePicker.mZombiePoints = 0;
		for (i in 0...NUM_ZOMBIE_TYPES) {
			theZombiePicker.mZombieTypeCount[i] = 0;
		}
	}

	public function buttonMouseMove(id:Float, x:Float, y:Float) {}

	public function DrawShovel(g:Graphics2D) {
		var x = 0;
		if (this.HasConveyorBeltSeedBank()) {
			this.mShovelButtonRect.x = 387;
			x = 387;
		} else {
			x = 401;
		}
		if (this.mShowShovel) {
			g.blitImage(this.mShovelBankImage, x, 0);
			if (this.mCursorObject.mCursorType != CURSOR_TYPE_SHOVEL) {
				g.blitImage(this.mShovelImage, x + 11, 12);
			}
		}
	}

	public function GetSeedToolTip(theType:Int):String {
		var aName:String = null;
		switch (theType) {

			case 0:
				aName = "[PEASHOOTER_TOOLTIP]";
			case 1:
				aName = "[SUNFLOWER_TOOLTIP]";

			case 2:
				aName = "[CHERRY_BOMB_TOOLTIP]";
			case 3:
				aName = "[WALL_NUT_TOOLTIP]";
			case 4:
				aName = "[SQUASH_TOOLTIP]";
			case 5:
				aName = "[SNOW_PEA_TOOLTIP]";
			case 6:
				aName = "[CHOMPER_TOOLTIP]";
			case 7:
				aName = "[REPEATER_TOOLTIP]";
			case 8:
				aName = "[PUFF_SHROOM_TOOLTIP]";
			case 9:
				aName = "[SUN_SHROOM_TOOLTIP]";

			case 10:
				aName = "[FUME_SHROOM_TOOLTIP]";
			case 11:
				aName = "[GRAVE_BUSTER_TOOLTIP]";
			case 50:
				aName = "[EXPLODE_O_NUT_TOOLTIP]";
		}
		return aName;
	}

	function spawnFootballZombieCheat() {
		this.AddZombieInRow(ZOMBIE_FOOTBALL, Std.int(Math.random() * 5), 1);
	}

	public function Pluralize(theCount:Int, theSingular:String, thePlural:String):String {
		var aResult:String = null;
		if (theCount == 1) {
			aResult = this.mApp.stringManager.translateString(theSingular);
			if (aResult.lastIndexOf("{COUNT}") != -1) {
				aResult.split("{COUNT}").join(theCount + " ");
			}
			return aResult;
		}
		aResult = this.mApp.stringManager.translateString(thePlural);
		if (aResult.lastIndexOf("{COUNT}") != -1) {
			aResult = aResult.split("{COUNT}").join(theCount + " ");
		}
		return aResult;
	}

	public function UpdateGridItems() {
		var aGridItem:GridItem = null;
		for (_tmp_ in this.mGridItems) {
			aGridItem = _tmp_;
			if (this.mEnableGraveStones && aGridItem.mGridItemType == GRIDITEM_GRAVESTONE) {
				if (aGridItem.mGridItemCounter < 100) {
					++aGridItem.mGridItemCounter;
				}
			}
		}
	}

	public function TotalZombiesHealthInWave(theWaveIndex:Int):Int {
		var aZombie:Zombie = null;
		var aTotalHealth = 0;
		for (_tmp_ in this.mZombies) {
			aZombie = _tmp_;
			if (aZombie.mFromWave == theWaveIndex) {
				if (!aZombie.IsDeadOrDying()) {
					aTotalHealth += aZombie.mBodyHealth;
					aTotalHealth += aZombie.mHelmHealth;
					aTotalHealth += Std.int(aZombie.mShieldHealth * 0.2);
					aTotalHealth += aZombie.mFlyingHealth;
				}
			}
		}
		return aTotalHealth;
	}

	public function RemoveZombiesForRepick() {
		var aZombie:Zombie = null;
		for (_tmp_ in this.mZombies) {
			aZombie = _tmp_;
			if (!aZombie.IsDeadOrDying()) {
				if (aZombie.mMindControlled && aZombie.mPosX > 486) {
					aZombie.DieNoLoot();
				}
			}
		}
	}

	public function GetNumSeedsInBank():Int {
		if (this.mApp.IsScaryPotterLevel()) {
			return 1;
		}
		if (this.HasConveyorBeltSeedBank()) {
			return 8;
		}
		var aSeedPackets = 6;
		if (this.mApp.IsSurvivalMode()) {
			aSeedPackets = 4;
		} else if (this.mLevel < aSeedPackets) {
			aSeedPackets = this.mLevel;
		} else if (this.mLevel == 6) {
			aSeedPackets = 5;
		}
		return aSeedPackets;
	}

	public function DrawFadeOut(g:Graphics2D) {
		if (this.mBoardFadeOutCounter < 0) {
			return;
		}
		if (this.mApp.IsSurvivalMode() && !this.IsFinalSurvivalStage()) {
			return;
		}

		if (this.mLevel == 14) {
			return;
		}
		var aAlpha = TodCommon.TodAnimateCurve(200, 0, this.mBoardFadeOutCounter, 0, 255, TodCommon.CURVE_LINEAR);

		g.pushState();
		var aColor:UInt = aAlpha << 24;
		if (this.mLevel == 9 || this.mLevel == 19 || this.mLevel == 29 || this.mLevel == 39 || this.mLevel == 49) {
			aColor |= 0;
		} else {
			aColor |= 16777215;
		}
		g.fillRect(0, 0, BOARD_WIDTH, BOARD_HEIGHT, aColor);
		g.popState();
	}

	public function GetSurvivalFlagsCompleted():Int {
		var aNumWavesPerFlag = this.GetNumWavesPerFlag();
		var aFromPreviousStages = Std.int(this.mChallenge.mSurvivalStage * this.GetNumWavesPerSurvivalStage() / aNumWavesPerFlag);
		if (this.IsFlagWave(this.mCurrentWave - 1) && this.mBoardFadeOutCounter < 0 && this.mNextSurvivalStageCounter == 0) {
			return Std.int((this.mCurrentWave - 1) / aNumWavesPerFlag + aFromPreviousStages);
		}
		return Std.int(this.mCurrentWave / aNumWavesPerFlag + aFromPreviousStages);
	}

	public function DoPlantingEffects(gridX:Float, gridY:Float, plant:CPlant) {
		var aXPos = this.GridToPixelX(Std.int(gridX), Std.int(gridY)) + 41 * 0.675;
		var aYPos = this.GridToPixelY(Std.int(gridY), Std.int(gridY)) + 74 * 0.675;
		this.mApp.foleyManager.playFoley(PVZFoleyType.PLANT);
		var anEffect = this.mApp.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_PLANTING);
		anEffect.setPosition(aXPos, aYPos);
		this.mRenderManager.add(new ParticleRenderable(anEffect, RENDER_LAYER_PARTICLE));
	}

	function spawnScreendoorZombieCheat() {
		this.AddZombieInRow(ZOMBIE_DOOR, Std.int(Math.random() * 5), 1);
	}

	public function IsInShovelTutorial():Bool {
		if (this.mTutorialState == TUTORIAL_SHOVEL_PICKUP
			|| this.mTutorialState == TUTORIAL_SHOVEL_DIG
			|| this.mTutorialState == TUTORIAL_SHOVEL_KEEP_DIGGING) {
			return true;
		}
		return false;
	}

	public function AddProjectile(theX:Int, theY:Int, aRenderOrder:Int, theRow:Int, projectileType:Int):Projectile {
		var proj:Projectile = null;
		var aProjectile:Projectile = null;
		var aNumProjectiles = this.mProjectiles.length;
		for (i in 0...aNumProjectiles) {
			proj = this.mProjectiles[i];
			if (proj.mDead) {
				aProjectile = proj;
				break;
			}
		}
		if (aProjectile == null) {
			aProjectile = new Projectile();
			this.mProjectiles.push(aProjectile);
		}
		aProjectile.ProjectileInitialize(theX, theY, aRenderOrder, theRow, projectileType, this.mApp, this);

		this.mRenderManager.add(new ProjectileRenderable(aProjectile, RENDER_LAYER_PROJECTILE));
		return aProjectile;
	}

	override public function draw(g:Graphics2D) {
		this.DrawBackdrop(g);
		this.mAdvice.Draw(g);
		if (this.mGameScene != SCENE_LEVEL_INTRO) {
			if (this.mGameScene != SCENE_ZOMBIES_WON) {
				this.mSeedBank.Draw(g);
				this.DrawShovel(g);
			}
			this.mRenderManager.draw(g);
		} else {
			this.mRenderManager.draw(g);
			if (this.mGameScene != SCENE_ZOMBIES_WON) {
				this.mSeedBank.Draw(g);
				this.DrawShovel(g);
			}
		}
		this.mWaveWarning.draw(g);
		this.DrawProgressMeter(g);
		this.DrawLevelLabel(g);
		this.mCursorPreview.draw(g);
		this.mCursorObject.draw(g);
		this.mToolTip.Draw(g);
		this.DrawFadeOut(g);
	}

	function spawnConeheadZombieCheat() {
		this.AddZombieInRow(ZOMBIE_TRAFFIC_CONE, Std.int(Math.random() * 5), 1);
	}

	public function CanTakeSunMoney(theAmount:Int):Bool {
		if (theAmount <= this.mSunMoney + this.CountSunBeingCollected()) {
			return true;
		}
		return false;
	}

	public function DisplayAdviceAgain(theAdvice:String, theMessageStyle:Int, theHelpIndex:Int) {
		if (theHelpIndex != ADVICE_NONE && ASCompat.toBool(this.mHelpDisplayed[theHelpIndex])) {
			this.mHelpDisplayed[theHelpIndex] = false;
		}
		this.DisplayAdvice(theAdvice, theMessageStyle, theHelpIndex);
	}

	public function SetZombieDefinitions() {}

	public function AddAGraveStone(theGridX:Int, theGridY:Int):GridItem {
		var aGridItem = new GridItem(this.mApp, this);
		aGridItem.mGridItemType = GRIDITEM_GRAVESTONE;
		aGridItem.mGridItemCounter = Std.int(Math.random() * -50);
		aGridItem.mGridX = theGridX;
		aGridItem.mGridY = theGridY;

		this.mRenderManager.add(new GridItemRenderable(aGridItem, RENDER_LAYER_GRAVE_STONE));
		this.mGridItems.push(aGridItem);
		return aGridItem;
	}

	public function GetGridItemAt(theGridItemType:Int, theGridX:Int, theGridY:Int):GridItem {
		var aGridItem:GridItem = null;
		for (_tmp_ in this.mGridItems) {
			aGridItem = _tmp_;
			if (!(aGridItem.mGridX != theGridX || aGridItem.mGridY != theGridY)) {
				if (aGridItem.mGridItemType == theGridItemType) {
					return aGridItem;
				}
			}
		}
		return null;
	}

	public function ProgressMeterHasFlags():Bool {
		if (this.mLevel == 1) {
			return false;
		}
		return true;
	}

	public function RowCanHaveZombieType(theRow:Int, theZombieType:Int):Bool {
		if (!this.RowCanHaveZombies(theRow)) {
			return false;
		}
		var aWaveNumber = this.mCurrentWave;
		return true;
	}

	public function UpdateTutorial() {
		var aPosX = 0;
		var aPosY = 0;
		if (this.mTutorialTimer > 0) {
			--this.mTutorialTimer;
		}
		if (this.mTutorialState == TUTORIAL_LEVEL_1_PICK_UP_PEASHOOTER) {
			if (this.mTutorialTimer == 0) {
				this.DisplayAdvice("[ADVICE_CLICK_PEASHOOTER]", MESSAGE_STYLE_TUTORIAL_LEVEL1_STAY, ADVICE_NONE);
				aPosX = this.mSeedBank.mX + this.mSeedBank.mSeedPackets[0].mX + this.mSeedBank.mSeedPackets[0].mWidth / 2;
				aPosY = this.mSeedBank.mY + this.mSeedBank.mSeedPackets[0].mY + this.mSeedBank.mSeedPackets[0].mHeight;
				this.TutorialArrowShow(aPosX, aPosY);

				this.mTutorialTimer = -1;
			}
		}
		if (this.mTutorialState == TUTORIAL_LEVEL_2_PICK_UP_SUNFLOWER
			|| this.mTutorialState == TUTORIAL_LEVEL_2_PLANT_SUNFLOWER
			|| this.mTutorialState == TUTORIAL_LEVEL_2_REFRESH_SUNFLOWER) {
			if (this.mTutorialTimer == 0) {
				this.DisplayAdvice("[ADVICE_PLANT_SUNFLOWER2]", MESSAGE_STYLE_TUTORIAL_LEVEL2, ADVICE_NONE);
				this.mTutorialTimer = -1;
			} else if (this.mZombieCountDown == 750 && this.mCurrentWave == 0) {
				this.DisplayAdvice("[ADVICE_PLANT_SUNFLOWER3]", MESSAGE_STYLE_TUTORIAL_LEVEL2, ADVICE_NONE);
			}
		}
		if (this.mTutorialState == TUTORIAL_MORESUN_PICK_UP_SUNFLOWER
			|| this.mTutorialState == TUTORIAL_MORESUN_PLANT_SUNFLOWER
			|| this.mTutorialState == TUTORIAL_MORESUN_REFRESH_SUNFLOWER) {
			if (this.mTutorialTimer == 0) {
				this.DisplayAdvice("[ADVICE_PLANT_SUNFLOWER5]", MESSAGE_STYLE_TUTORIAL_LATER, ADVICE_PLANT_SUNFLOWER5);
				this.mTutorialTimer = -1;
			}
		}
		if (this.mLevel >= 3
			&& this.mLevel != 5
			&& this.mLevel <= 7
			&& this.mTutorialState == TUTORIAL_OFF
			&& this.mCurrentWave >= 5
			&& !this.mShownMoreSunTutorial
			&& this.mSeedBank.mSeedPackets[1].CanPickUp()
			&& this.CountPlantByType(SEED_SUNFLOWER) < 3) {
			this.DisplayAdvice("[ADVICE_PLANT_SUNFLOWER4]", MESSAGE_STYLE_TUTORIAL_LATER_STAY, ADVICE_NONE);
			this.mShownMoreSunTutorial = true;
			this.SetTutorialState(TUTORIAL_MORESUN_PICK_UP_SUNFLOWER);
			this.mTutorialTimer = 500;
		}
	}

	public function IsPlantInCursor():Bool {
		if (this.mCursorObject.mCursorType == CURSOR_TYPE_PLANT_FROM_BANK
			|| this.mCursorObject.mCursorType == CURSOR_TYPE_PLANT_FROM_USABLE_COIN) {
			return true;
		}
		return false;
	}

	public function GetPlantsOnLawn(theGridX:Int, theGridY:Int):CPlant {
		var aPlant:CPlant = null;

		if (this.IsWallnutBowlingLevel() && !this.IsInShovelTutorial()) {
			return null;
		}
		if (theGridX < 0 || theGridX >= GRIDSIZEX || theGridY < 0 || theGridY >= GRIDSIZEY) {
			return null;
		}
		for (_tmp_ in this.mPlants) {
			aPlant = _tmp_;
			if (!(aPlant.getCol() != theGridX || aPlant.getRow() != theGridY)) {
				return aPlant;
			}
		}
		return null;
	}

	public function GetGraveStoneCount():Int {
		var aGridItem:GridItem = null;
		var aCount = 0;
		for (_tmp_ in this.mGridItems) {
			aGridItem = _tmp_;
			if (aGridItem.mGridItemType == GRIDITEM_GRAVESTONE) {
				aCount++;
			}
		}
		return aCount;
	}

	public function PixelToGridX(theX:Int, theY:Int):Int {
		if (theX < LAWN_XMIN) {
			return -1;
		}

		return TodCommon.ClampInt(Std.int((theX - LAWN_XMIN) / 54), 0, GRIDSIZEX - 1);
	}

	public function MouseDownWithTool(x:Int, y:Int, theCursorType:Int) {
		var aPlant = this.ToolHitTest(x, y);
		if (aPlant == null) {
			this.mApp.foleyManager.playFoley(PVZFoleyType.DROP);
			this.ClearCursor();
			return;
		}
		if (theCursorType == CURSOR_TYPE_SHOVEL) {
			this.mApp.foleyManager.playFoley(PVZFoleyType.USE_SHOVEL);
			aPlant.Die();
			if (this.mTutorialState == TUTORIAL_SHOVEL_DIG || this.mTutorialState == TUTORIAL_SHOVEL_KEEP_DIGGING) {
				if (this.CountPlantByType(SEED_PEASHOOTER) == 1) {
					this.SetTutorialState(TUTORIAL_SHOVEL_COMPLETED);
				} else {
					this.SetTutorialState(TUTORIAL_SHOVEL_KEEP_DIGGING);
				}
			}
		}

		this.ClearCursor();
	}

	public function GetZombieDefinition(aZombieType:Int):ZombieDef {
		var aZombieDef = new ZombieDef();
		switch (aZombieType) {

			case ZOMBIE_NORMAL:
				aZombieDef.mZombieValue = 1;
				aZombieDef.mStartingLevel = 1;
				aZombieDef.mFirstAllowedWave = 1;
				aZombieDef.mPickWeight = 4000;
				aZombieDef.mZombieName = "ZOMBIE";

			case ZOMBIE_FLAG:
				aZombieDef.mZombieValue = 1;
				aZombieDef.mStartingLevel = 1;
				aZombieDef.mFirstAllowedWave = 1;
				aZombieDef.mPickWeight = 0;
				aZombieDef.mZombieName = "FLAG_ZOMBIE";
			case ZOMBIE_TRAFFIC_CONE:
				aZombieDef.mZombieValue = 2;

				aZombieDef.mStartingLevel = 3;
				aZombieDef.mFirstAllowedWave = 1;
				aZombieDef.mPickWeight = 4000;
				aZombieDef.mZombieName = "CONEHEAD_ZOMBIE";
			case ZOMBIE_POLEVAULTER:
				aZombieDef.mZombieValue = 2;
				aZombieDef.mStartingLevel = 6;
				aZombieDef.mFirstAllowedWave = 5;
				aZombieDef.mPickWeight = 2000;
				aZombieDef.mZombieName = "POLE_VAULTING_ZOMBIE";
			case ZOMBIE_PAIL:
				aZombieDef.mZombieValue = 4;
				aZombieDef.mStartingLevel = 8;
				aZombieDef.mFirstAllowedWave = 1;
				aZombieDef.mPickWeight = 3000;
				aZombieDef.mZombieName = "BUCKETHEAD_ZOMBIE";
			case ZOMBIE_NEWSPAPER:
				aZombieDef.mZombieValue = 2;
				aZombieDef.mStartingLevel = 11;
				aZombieDef.mFirstAllowedWave = 1;
				aZombieDef.mPickWeight = 1000;
				aZombieDef.mZombieName = "NEWSPAPER_ZOMBIE";
			case ZOMBIE_DOOR:
				aZombieDef.mZombieValue = 4;
				aZombieDef.mStartingLevel = 13;
				aZombieDef.mFirstAllowedWave = 5;
				aZombieDef.mPickWeight = 3500;
				aZombieDef.mZombieName = "SCREEN_DOOR_ZOMBIE";
			case ZOMBIE_FOOTBALL:
				aZombieDef.mZombieValue = 7;
				aZombieDef.mStartingLevel = 16;

				aZombieDef.mFirstAllowedWave = 5;
				aZombieDef.mPickWeight = 2000;
				aZombieDef.mZombieName = "FOOTBALL_ZOMBIE";
		}
		return aZombieDef;
	}

	public function FindLawnMowerInRow(theRow:Int):LawnMower {
		var aLawnMower:LawnMower = null;
		for (_tmp_ in this.mLawnMowers) {
			aLawnMower = _tmp_;
			if (aLawnMower.mRow == theRow) {
				return aLawnMower;
			}
		}
		return null;
	}

	public function CountSunBeingCollected():Int {
		var aCoin:Coin = null;
		var anAmount = 0;
		for (_tmp_ in this.mCoins) {
			aCoin = _tmp_;
			if (aCoin.mIsBeingCollected && aCoin.IsSun()) {
				anAmount += aCoin.GetSunValue();
			}
		}
		return anAmount;
	}

	public function TutorialArrowRemove() {
		if (this.mTutorialArrow != null) {
			this.mTutorialArrow.die();
		}
		this.mTutorialArrow = null;
	}

	public function FadeOutLevel() {
		var aCoin:Coin = null;
		var aMessage:String = null;
		var aIsNote = false;
		this.mMenuButton.visible = false;
		if (this.mGameScene != SCENE_PLAYING) {
			this.RefreshSeedPacketFromCursor();
			this.mLevelComplete = true;
			return;
		}
		if (this.mLevel == 14) {
			this.mApp.mSaveObject.level = 1;
			this.mApp.mLevel = 1;
			if (this.mApp.mSaveObject.puzzleLocked) {
				this.mApp.mSaveObject.puzzleLocked = false;
				this.mApp.mPuzzleLocked = false;
			}
			if (this.mApp.mSaveObject.survivalLocked) {
				this.mApp.mSaveObject.survivalLocked = false;
				this.mApp.mSurvivalLocked = false;
			}
			this.mApp.setSaveData(this.mApp.mSaveObject);
		}
		var aCutMusic = true;
		if (this.mApp.IsSurvivalMode() || this.mApp.IsScaryPotterLevel()) {
			aCutMusic = false;
		}
		if (aCutMusic) {
			this.mApp.musicManager.playMusic(PVZMusic.WINMUSIC, false);
		}
		if (this.mLevel == 14) {
			this.mBoardFadeOutCounter = 600;
		} else if (this.mApp.IsScaryPotterLevel()) {
			this.mLevelAwardSpawned = true;
			this.mNextSurvivalStageCounter = 500;
			for (_tmp_ in this.mCoins) {
				aCoin = _tmp_;
				if (aCoin.mType == Coin.COIN_USABLE_SEED_PACKET) {
					aCoin.Die();
				} else {
					aCoin.TryAutoCollectAfterLevelAward();
				}
			}
			aMessage = this.mApp.stringManager.translateString("[ADVICE_MORE_SCARY_POTS]").split("{STREAK}").join(this.mChallenge.mSurvivalStage + 1);
			this.ClearAdvice(ADVICE_NONE);

			this.DisplayAdvice(aMessage, MESSAGE_STYLE_BIG_MIDDLE, ADVICE_NONE);
		} else if (!this.mApp.IsSurvivalMode()) {
			this.RefreshSeedPacketFromCursor();

			this.mMenuButton.visible = false;
			this.mBoardFadeOutCounter = 600;
			for (_tmp_ in this.mCoins) {
				aCoin = _tmp_;
				aCoin.TryAutoCollectAfterLevelAward();
			}
			aIsNote = this.mLevel == 9 || this.mLevel == 19 || this.mLevel == 29 || this.mLevel == 39 || this.mLevel == 49;
			if (aIsNote) {
				this.mBoardFadeOutCounter = 500;
			}
		} else {
			this.mNextSurvivalStageCounter = 500;
			this.DisplayAdvice("[ADVICE_MORE_ZOMBIES]", MESSAGE_STYLE_BIG_MIDDLE, ADVICE_NONE);
			this.mApp.foleyManager.playFoley(PVZFoleyType.HUGEWAVE);
		}
	}

	public function AddSunMoney(theAmount:Int) {
		this.mSunMoney += theAmount;
		if (this.mSunMoney > 9990) {
			this.mSunMoney = 9990;
		}
		var bounds = new Rectangle(0, 0, 40, 15);
		this.mSeedBank.mSunText = Utils.createStringImage(Std.string(this.mSunMoney), this.mSeedBank.mSeedBankFont, bounds, Utils.JUSTIFY_CENTER);
	}

	public function ClearAdvice(theHelpIndex:Int) {
		if (theHelpIndex != ADVICE_NONE && theHelpIndex != this.mHelpIndex) {
			return;
		}
		this.mAdvice.ClearLabel();
		this.mHelpIndex = ADVICE_NONE;
	}

	public function PixelToGridXKeepOnBoard(theX:Int, theY:Int):Int {
		return Std.int(Math.max(this.PixelToGridX(theX, theY), 0));
	}

	public function ZombieHitTest(theMouseX:Int, theMouseY:Int):Zombie {
		var aZombie:Zombie = null;
		var aRect:Rectangle = null;
		var aTopZombie:Zombie = null;
		for (_tmp_ in this.mZombies) {
			aZombie = _tmp_;
			if (!aZombie.IsDeadOrDying()) {
				aRect = aZombie.GetZombieRect();
				if (aRect.contains(theMouseX, theMouseY)) {
					if (aTopZombie == null || aZombie.mY > aTopZombie.mY) {
						aTopZombie = aZombie;
					}
				}
			}
		}
		return aTopZombie;
	}

	public function ZombiePickerInit(theZombiePicker:ZombiePicker) {
		this.ZombiePickerInitForWave(theZombiePicker);
		for (i in 0...NUM_ZOMBIE_TYPES) {
			theZombiePicker.mAllWavesZombieTypeCount[i] = 0;
		}
	}

	public function PickRowForNewZombie(theZombieType:Int):Int {
		var aWavesSinceMowed = 0;
		for (i in 0...GRIDSIZEY) {
			if (!this.RowCanHaveZombieType(i, theZombieType)) {
				this.mRowPickingArray[i].mWeight = 0;
			} else {
				aWavesSinceMowed = this.mCurrentWave - this.mWaveRowGotLawnMowered[i];
				if (aWavesSinceMowed <= 1) {
					this.mRowPickingArray[i].mWeight = 0.01;
				} else if (aWavesSinceMowed <= 2) {
					this.mRowPickingArray[i].mWeight = 0.5;
				} else {
					this.mRowPickingArray[i].mWeight = 1;
				}
			}
		}
		var i:ASAny = 0;
		while (i < GRIDSIZEY) {
			i++;
		}
		return TodCommon.TodPickFromSmoothArray(this.mRowPickingArray, GRIDSIZEY);
	}

	public function UpdateCursor() {
		var aHitResult:HitResult = null;
		var aSeedPacket:SeedPacket = null;
		var aShowFinger = false;
		var aShowDrag = false;

		var aHideCursor = false;
		var aMouseX = Std.int(this.mApp.widgetManager.lastMouseX - x);
		var aMouseY = Std.int(this.mApp.widgetManager.lastMouseY - y);
		if (ASCompat.toBool(this.mApp.mSeedChooserScreen) && this.mApp.mSeedChooserScreen.contains(aMouseX + x, aMouseY + y)) {
			return;
		}
		if (this.mPaused || this.mBoardFadeOutCounter >= 0 || this.mTimeStopCounter > 0 || this.mGameScene == SCENE_ZOMBIES_WON) {
			aShowFinger = false;
		} else {
			aHitResult = new HitResult();
			this.MouseHitTest(aMouseX, aMouseY, aHitResult);
			if (aHitResult.mObjectType == OBJECT_TYPE_SHOVEL || aHitResult.mObjectType == OBJECT_TYPE_COIN) {
				aShowFinger = true;
			} else if (aHitResult.mObjectType == OBJECT_TYPE_SEEDPACKET) {
				aSeedPacket = cast(aHitResult.mObject, SeedPacket);
				if (aSeedPacket.CanPickUp()) {
					aShowFinger = true;
				}
			} else if (aHitResult.mObjectType == OBJECT_TYPE_SCARY_POT) {
				aShowFinger = true;
			}
		}
		showFinger(aShowFinger);
	}

	public function ShakeBoard(theShakeAmountX:Int, theShakeAmountY:Int) {
		this.mShakeCounter = BOARD_SHAKE_TIME;
		this.mShakeAmountX = theShakeAmountX;
		this.mShakeAmountY = theShakeAmountY;
	}

	public function GetStageString(theLevel:Int):String {
		var aArea = TodCommon.ClampInt(Std.int((theLevel - 1) / LEVELS_PER_AREA + 1), 1, 6);
		var aSubArea = theLevel - (aArea - 1) * LEVELS_PER_AREA;
		return Std.string(aArea) + "-" + Std.string(aSubArea);
	}

	public function GetSeedBankExtraWidth():Int {
		return 0;
	}

	public function TakeSunMoney(theAmount:Int):Bool {
		var bounds:Rectangle = null;
		if (this.mEasyPlantingCheat) {
			return true;
		}
		if (theAmount <= this.mSunMoney + this.CountSunBeingCollected()) {
			this.mSunMoney -= theAmount;
			bounds = new Rectangle(0, 0, 40, 15);
			this.mSeedBank.mSunText = Utils.createStringImage(Std.string(this.mSunMoney), this.mSeedBank.mSeedBankFont, bounds, Utils.JUSTIFY_CENTER);
			return true;
		}
		this.mApp.foleyManager.playFoley(PVZFoleyType.BUZZER);
		this.mOutOfMoneyCounter = 70;
		return false;
	}

	public function PickZombieType(theZombiePoints:Int, theWaveIndex:Int, theZombiePicker:ZombiePicker):Int {
		var aFlags = 0;
		var aWeightedArray:WeightedArray = null;
		var aZombieType = 0;
		var aZombieDef:ZombieDef = null;
		var aFirstWave = 0;
		var aWeight = 0;
		var aWavesEarlier = 0;
		var aLimit = 0;
		var aZombieWeightArray = ASCompat.allocArray(NUM_ZOMBIE_TYPES);
		var aPickCount = 0;
		for (i in 0...NUM_ZOMBIE_TYPES) {
			aWeightedArray = new WeightedArray();
			aZombieWeightArray[aPickCount] = aWeightedArray;
			aZombieType = i;
			aZombieDef = this.GetZombieDefinition(aZombieType);
			if (this.mZombieAllowed[aZombieType]) {
				aFirstWave = aZombieDef.mFirstAllowedWave;
				if (this.mApp.IsSurvivalEndless()) {
					aFlags = this.GetSurvivalFlagsCompleted();
					aWavesEarlier = TodCommon.TodAnimateCurve(18, 50, aFlags, 0, 15, TodCommon.CURVE_LINEAR);
					aFirstWave = Std.int(Math.max(aFirstWave - aWavesEarlier, 1));
				}
				if (theWaveIndex + 1 >= aFirstWave) {
					if (theZombiePoints >= aZombieDef.mZombieValue) {
						aWeight = aZombieDef.mPickWeight;
						if (this.mApp.IsSurvivalMode()) {
							aFlags = this.GetSurvivalFlagsCompleted();
							if (aZombieType == 8) {
								aLimit = TodCommon.TodAnimateCurve(10, 50, aFlags, 2, 50, TodCommon.CURVE_LINEAR);
								if (theZombiePicker.mZombieTypeCount[aZombieType] >= aLimit) {
									continue;
								}
							}
							if (aZombieType == 8) {
								if (this.IsFlagWave(theWaveIndex)) {
									aLimit = TodCommon.TodAnimateCurve(14, 100, aFlags, 1, 50, TodCommon.CURVE_LINEAR);
									if (theZombiePicker.mZombieTypeCount[aZombieType] >= aLimit) {
										continue;
									}
								} else {
									aLimit = TodCommon.TodAnimateCurve(10, 110, aFlags, 1, 50, TodCommon.CURVE_LINEAR);
									if (theZombiePicker.mAllWavesZombieTypeCount[aZombieType] >= aLimit) {
										continue;
									}
									aWeight = 1000;
								}
							}
							if (aZombieType == ZOMBIE_NORMAL) {
								aWeight = TodCommon.TodAnimateCurve(10, 50, aFlags, aZombieDef.mPickWeight, Std.int(aZombieDef.mPickWeight / 10),
									TodCommon.CURVE_LINEAR);
							}
							if (aZombieType == ZOMBIE_TRAFFIC_CONE) {
								aWeight = TodCommon.TodAnimateCurve(10, 50, aFlags, aZombieDef.mPickWeight, Std.int(aZombieDef.mPickWeight / 4),
									TodCommon.CURVE_LINEAR);
							}
						}
						aZombieWeightArray[aPickCount].mItem = i;
						aZombieWeightArray[aPickCount].mWeight = aWeight;
						aPickCount++;
					}
				}
			}
		}
		return TodCommon.TodPickFromWeightedArray(aZombieWeightArray, aPickCount);
	}

	public function KillAllPlantsInRadius(theX:Int, theY:Int, theRadius:Int) {
		var aPlant:CPlant = null;
		var aPlantRect:Rectangle = null;
		for (_tmp_ in this.mPlants) {
			aPlant = _tmp_;
			aPlantRect = aPlant.GetPlantRect();

			if (this.GetCircleRectOverlap(theX, theY, theRadius, aPlantRect)) {
				aPlant.Die();
			}
		}
	}

	override public function onMouseDown(x:Float, y:Float) {
		var aCoin:Coin = null;
		var aSeedPacket:SeedPacket = null;
		if (this.mPaused) {
			return;
		}
		var aHitResult = new HitResult();
		this.MouseHitTest(Std.int(x), Std.int(y), aHitResult);
		if (this.mChallenge.MouseDown(Std.int(x), Std.int(y), aHitResult)) {
			return;
		}
		if (this.mGameScene == SCENE_ZOMBIES_WON) {
			return;
		}

		if (aHitResult.mObjectType == OBJECT_TYPE_COIN) {
			aCoin = cast(aHitResult.mObject, Coin);
			aCoin.MouseDown(Std.int(x), Std.int(y));
		} else if (this.mCursorObject.mCursorType == CURSOR_TYPE_SHOVEL) {
			this.MouseDownWithTool(Std.int(x), Std.int(y), this.mCursorObject.mCursorType);
		} else if (this.IsPlantInCursor()) {
			this.MouseDownWithPlant(Std.int(x), Std.int(y));
		} else if (aHitResult.mObjectType == OBJECT_TYPE_SEEDPACKET) {
			aSeedPacket = cast(aHitResult.mObject, SeedPacket);
			aSeedPacket.MouseDown(x, y);
		} else if (aHitResult.mObjectType == OBJECT_TYPE_SHOVEL) {
			this.PickUpTool(aHitResult.mObjectType);
		}
		this.UpdateCursor();
	}

	public function ContinueVasebreaker() {
		if (this.mApp.adAPI.enabled) {
			this.mApp.musicManager.resumeMusic();
			this.mApp.soundManager.resumeAll();
		}
		this.mChallenge.PuzzleNextStageClear();
		this.mChallenge.ScaryPotterPopulate();
		this.mMenuButton.visible = true;
	}

	public function AddGraveStones(theGridX:Int, theCount:Int) {
		var aGridY = 0;
		for (i in 0...theCount) {
			aGridY = Std.int(Math.random() * GRIDSIZEY);
			if (this.CanAddGraveStoneAt(theGridX, aGridY)) {
				this.AddAGraveStone(theGridX, aGridY);
			}
		}
	}

	public function GetIntroducedZombieType():Int {
		var aZombieType = 0;
		var aZombieDef:ZombieDef = null;
		if (!this.mApp.IsAdventureMode() || this.mLevel == 1) {
			return ZOMBIE_INVALID;
		}
		for (i in 0...NUM_ZOMBIE_TYPES) {
			aZombieType = i;
			aZombieDef = this.GetZombieDefinition(aZombieType);
			if (aZombieDef.mStartingLevel == this.mLevel) {
				return aZombieType;
			}
		}
		return ZOMBIE_INVALID;
	}

	public function DrawBackdrop(g:Graphics2D) {
		var aWidth = 0;
		var aSrcRect:Rectangle = null;
		var aImage:ImageInst = null;
		var flashSod:ImageInst = null;
		var aFlashingColor:Color = null;
		if (this.mApp.IsAdventureMode()) {
			if (this.mLevel == 1) {
				g.blitImage(this.unsoddedBackground, -PVZApp.BOARD_OFFSET, 0);
				aWidth = TodCommon.TodAnimateCurve(0, 1000, this.mSodPosition, 0, Std.int(this.sod1Row.width), TodCommon.CURVE_LINEAR);
				aSrcRect = new Rectangle(0, 0, aWidth, this.sod1Row.height);
				g.pushState();
				g.setClipRect(-PVZApp.BOARD_OFFSET + 161.5, 197, aWidth, this.sod1Row.height);
				g.drawImage(this.sod1Row, -PVZApp.BOARD_OFFSET + 161.5, 197);
				g.popState();
			} else if (this.mLevel == 2 || this.mLevel == 3) {
				g.blitImage(this.unsoddedBackground, -PVZApp.BOARD_OFFSET, 0);
				g.drawImage(this.sod1Row, -PVZApp.BOARD_OFFSET + 161.5, 197);
				aWidth = TodCommon.TodAnimateCurve(0, 1000, this.mSodPosition, 0, Std.int(this.sod3Row.width), TodCommon.CURVE_LINEAR);
				g.pushState();
				if (this.mLevel == 2) {
					g.setClipRect(-PVZApp.BOARD_OFFSET + 158.7, 118.5, aWidth, this.sod3Row.height);
				}
				g.drawImage(this.sod3Row, -PVZApp.BOARD_OFFSET + 158.5, 118.5);
				g.popState();
			} else if (this.mLevel == 4) {
				g.drawImage(this.unsoddedBackground, -PVZApp.BOARD_OFFSET, 0);
				g.drawImage(this.sod3Row, -PVZApp.BOARD_OFFSET + 158.7, 118.5);
				aWidth = TodCommon.TodAnimateCurve(0, 1000, this.mSodPosition, 0, Std.int(this.sod3Row.width), TodCommon.CURVE_LINEAR);
				g.pushState();
				aSrcRect = new Rectangle(156, 0, aWidth, this.background.height);
				g.setClipRect(-PVZApp.BOARD_OFFSET + 158.7, 0, aWidth, this.background.height);

				g.drawImage(this.background, -PVZApp.BOARD_OFFSET, 0);
				g.popState();
			} else {
				g.blitImage(this.background, -PVZApp.BOARD_OFFSET, 0);
			}
		} else {
			g.blitImage(this.background, -PVZApp.BOARD_OFFSET, 0);
		}
		if (this.mGameScene == SCENE_ZOMBIES_WON) {
			g.blitImage(this.doorOverlay, -85, 168);
		}
		if (this.IsWallnutBowlingLevel()) {
			if (this.mChallenge.mShowBowlingLine) {
				aImage = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_WALLNUT_BOWLINGSTRIPE);
				g.drawImage(aImage, 179, 65);
			}
		}
		if (this.mTutorialState == TUTORIAL_LEVEL_1_PLANT_PEASHOOTER) {
			flashSod = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_SOD1ROW);
			g.pushState();

			aFlashingColor = TodCommon.GetFlashingColor(this.mMainCounter, 75);
			flashSod.useColor = true;
			flashSod.setColor(aFlashingColor.alpha, aFlashingColor.red, aFlashingColor.blue, aFlashingColor.green);
			g.drawImage(flashSod, -PVZApp.BOARD_OFFSET + 161.5, 197);
			g.popState();
		}
	}

	public function MouseHitTestPlant(x:Int, y:Int, theHitResult:HitResult):Bool {
		var aGridX = this.PixelToGridX(x, y);
		var aGridY = this.PixelToGridY(x, y);
		var aPlant = this.GetPlantsOnLawn(aGridX, aGridY);
		if (aPlant != null) {
			theHitResult.mObject = aPlant;
			theHitResult.mObjectType = OBJECT_TYPE_PLANT;
			return true;
		}
		return false;
	}

	public function InitLawnMowers() {
		var aHasMower = false;
		var aLawnMower:LawnMower = null;
		for (y in 0...GRIDSIZEY) {
			if (this.mApp.IsScaryPotterLevel()) {
				aHasMower = false;
			} else if (this.mPlantRow[y] == PLANTROW_DIRT) {
				aHasMower = false;
			} else {
				aHasMower = true;
			}
			if (aHasMower) {
				aLawnMower = new LawnMower(this.mApp, this, y);
				aLawnMower.mVisible = false;
				this.mRenderManager.add(new LawnMowerRenderable(aLawnMower, RENDER_LAYER_ZOMBIE + y + 1));
				this.mLawnMowers.push(aLawnMower);
			}
		}
	}

	public function CountSunFlowers():Int {
		var aPlant:CPlant = null;

		var aCount = 0;
		for (_tmp_ in this.mPlants) {
			aPlant = _tmp_;
			if (aPlant.mSeedType == 0 != SEED_SUNFLOWER) {
				aCount++;
			}
		}

		return aCount;
	}

	public function buttonMouseLeave(id:Float) {}

	public function ToolHitTest(x:Int, y:Int):CPlant {
		var aHitResult = new HitResult();
		this.MouseHitTest(x, y, aHitResult);
		if (aHitResult.mObjectType != OBJECT_TYPE_PLANT) {
			return null;
		}

		return cast(aHitResult.mObject, CPlant);
	}

	public function IsFlagWave(theWaveNumber:Int):Bool {
		if (this.mApp.IsAdventureMode() && this.mLevel == 1) {
			return false;
		}

		var aNumWavesPerFlag = this.GetNumWavesPerFlag();
		return theWaveNumber % aNumWavesPerFlag == aNumWavesPerFlag - 1;
	}

	public function GetSeedName(theType:Int):String {
		var aName:String = null;
		switch (theType) {
			case 0:
				aName = "[PEASHOOTER]";
			case 1:
				aName = "[SUNFLOWER]";

			case 2:
				aName = "[CHERRY_BOMB]";
			case 3:
				aName = "[WALL_NUT]";
			case 4:
				aName = "[SQUASH]";
			case 5:
				aName = "[SNOW_PEA]";
			case 6:
				aName = "[CHOMPER]";
			case 7:
				aName = "[REPEATER]";
			case 8:
				aName = "[PUFF_SHROOM]";
			case 9:
				aName = "[SUN_SHROOM]";
			case 10:
				aName = "[FUME_SHROOM]";
			case 11:
				aName = "[GRAVE_BUSTER]";
			case 50:
				aName = "[EXPLODE_O_NUT]";
		}
		return aName;
	}

	public function RemoveAllZombies() {
		var aZombie:Zombie = null;
		for (_tmp_ in this.mZombies) {
			aZombie = _tmp_;
			if (!aZombie.IsDeadOrDying()) {
				aZombie.DieNoLoot();
			}
		}
	}
}
