package com.popcap.flash.games.pvz;

import com.popcap.flash.framework.AppBase;
import com.popcap.flash.framework.resources.foley.FoleyManager;
import com.popcap.flash.framework.resources.foley.FoleyType;
import com.popcap.flash.framework.resources.particles.ParticleManager;
import com.popcap.flash.framework.resources.reanimator.Reanimator;
import com.popcap.flash.games.pvz.logic.AwardScreen;
import com.popcap.flash.games.pvz.logic.Board;
import com.popcap.flash.games.pvz.logic.ChallengeScreen;
import com.popcap.flash.games.pvz.logic.SeedChooserScreen;
import com.popcap.flash.games.pvz.logic.uI.DialogBox;
import com.popcap.flash.games.pvz.logic.uI.OptionsDialog;
import com.popcap.flash.games.pvz.logic.uI.UpsellScreen;
import com.popcap.flash.games.pvz.states.loading.LoadingState;
import com.popcap.flash.games.pvz.states.loading.TitleScreenState;
import com.popcap.flash.games.pvz.states.mainmenu.MainMenuState;
import com.popcap.flash.games.pvz.states.playing.ChallengeScreenState;
import com.popcap.flash.games.pvz.states.playing.ChooseSeedsState;
import com.popcap.flash.games.pvz.states.playing.CrazyDaveState;
import com.popcap.flash.games.pvz.states.playing.DialogState;
import com.popcap.flash.games.pvz.states.playing.LawnViewState;
import com.popcap.flash.games.pvz.states.playing.LevelIntroState;
import com.popcap.flash.games.pvz.states.playing.OptionsMenuState;
import com.popcap.flash.games.pvz.states.playing.PanLeftState;
import com.popcap.flash.games.pvz.states.playing.PanRightState;
import com.popcap.flash.games.pvz.states.playing.PauseState;
import com.popcap.flash.games.pvz.states.playing.PlayLevelState;
import com.popcap.flash.games.pvz.states.playing.ReadySetStartState;
import com.popcap.flash.games.pvz.states.playing.ShowAwardState;
import com.popcap.flash.games.pvz.states.playing.SlideUIState;
import com.popcap.flash.games.pvz.states.playing.SodRollState;
import com.popcap.flash.games.pvz.states.playing.StartLevelState;
import com.popcap.flash.games.pvz.states.playing.SurvivalRepickState;
import com.popcap.flash.games.pvz.states.playing.UpsellScreenState;
import com.popcap.flash.games.pvz.states.playing.ZombiesWonState;
import flash.display.Loader;
import com.XMLC;

class PVZApp extends AppBase {
	public static inline final STATE_PAUSE_SCREEN = "PauseScreen";

	public static inline final STATE_RESUME_FROM_PAUSE = "ResumeFromPause";

	public static inline final GAMEMODE_SURVIVAL_ENDLESS_STAGE_2 = 1;

	public static inline final STATE_SLIDE_UI = "SlideUI";

	public static inline final BACKGROUND_IMAGE_WIDTH = 945;

	public static inline final STATE_SHOWAWARD = "ShowAward";

	public static inline final BOARDRESULT_RESTART = 3;

	public static inline final STATE_SODROLL = "SodRoll";

	public static inline final APP_ID = "pvz";

	public static inline final STATE_PLAY_LEVEL = "PlayLevel";

	public static inline final SCENE_CREDIT = 6;

	public static inline final STATE_UPSELL_SCREEN = "UpsellScreen";

	public static inline final GAMEMODE_SURVIVAL_NORMAL_STAGE_3 = 3;

	public static inline final GAMEMODE_SURVIVAL_NORMAL_STAGE_5 = 5;

	public static inline final STATE_SURVIVAL_REPICK = "SurvivalRepick";

	public static inline final SCENE_CHALLENGE = 7;

	public static inline final GAMEMODE_SURVIVAL_NORMAL_STAGE_4 = 4;

	public static inline final SCENE_PLAYING = 3;

	public static inline final GAMEMODE_SURVIVAL_NORMAL_STAGE_2 = 17;

	public static inline final BOARD_OFFSET = 148;

	public static inline final SCENE_LOADING = 0;

	public static inline final STATE_LOADING = "Loading";

	public static inline final SCENE_MENU = 1;

	public static inline final STATE_ZOMBIES_WON = "ZombiesWon";

	public static inline final GAMEMODE_UPSELL = 7;

	public static inline final STATE_START_LEVEL = "StartLevel";

	public static inline final STATE_TITLE_SCREEN = "TitleScreen";

	public static inline final SCENE_LEVEL_INTRO = 2;

	public static inline final STATE_PAN_RIGHT = "PanRight";

	public static inline final BOARDRESULT_QUIT_APP = 5;

	public static inline final STATE_READY_SET_START = "ReadySetStart";

	public static inline final BOARDRESULT_LOST = 2;

	public static inline final STATE_CRAZY_DAVE = "CrazyDave";

	public static inline final STATE_OPTIONS_MENU = "OptionsMenu";

	public static inline final BOARDRESULT_NONE = 0;

	public static inline final STATE_PAN_LEFT = "PanLeft";

	public static inline final BOARDRESULT_WON = 1;

	public static inline final GAMEMODE_CHALLENGE_WALLNUT_BOWLING = 6;

	public static inline final STATE_LAWN_VIEW = "LawnView";

	public static inline final BOARDRESULT_QUIT = 4;

	public static inline final SCENE_CRAZY_DAVE = 8;

	public static inline final GAMEMODE_SCARY_POTTER_1 = 8;

	public static inline final GAMEMODE_SCARY_POTTER_2 = 9;

	public static inline final SCENE_AWARD = 5;

	public static inline final GAMEMODE_SCARY_POTTER_6 = 13;

	public static inline final GAMEMODE_SCARY_POTTER_8 = 15;

	public static inline final GAMEMODE_SCARY_POTTER_9 = 16;

	public static inline final GAMEMODE_SCARY_POTTER_3 = 10;

	public static inline final GAMEMODE_SCARY_POTTER_4 = 11;

	public static inline final GAMEMODE_SCARY_POTTER_5 = 12;

	public static inline final STATE_SEEDCHOOSER = "SeedChooser";

	public static inline final GAMEMODE_SCARY_POTTER_7 = 14;

	public static inline final STATE_DIALOG_BOX = "DialogBox";

	public static inline final GAMEMODE_ADVENTURE = 0;

	public static inline final SCENE_ZOMBIES_WON = 4;

	public static inline final GAMEMODE_SCARY_POTTER_ENDLESS = 2;

	public static inline final STATE_MAIN_MENU = "MainMenu";

	public static inline final BOARDRESULT_CHEAT = 6;

	public static inline final STATE_LEVEL_INTRO = "LevelIntro";

	public static inline final STATE_CHALLENGE_SCREEN = "ChallengeScreen";

	public var mBoard:Board;

	public var mChallengeScreen:ChallengeScreen;

	var mFoleyManager:FoleyManager;

	public var mCutsceneTime:Int = 0;

	public var mSurvivalFlags:Int = 0;

	var mResourceLoader:Loader;

	var mParticleManager:ParticleManager;

	public var mLevel:Int = 0;

	public var mSoundOn:Bool = false;

	public var mPlacedZombies:Bool = false;

	public var mMaxTime:Int = 0;

	public var mSeedChooserScreen:SeedChooserScreen;

	public var mSurvivalLocked:Bool = false;

	public var mMusicOn:Bool = false;

	public var mUpsellOn:Bool = false;

	public var mGameMode:Int = 0;

	public var mUpsellScreen:UpsellScreen;

	public var mGamesPlayed:Int = 0;

	public var mSodTime:Int = 0;

	public var mMaxPlays:Int = 0;

	public var mTotalZombiesKilled:Int = 0;

	public var mUpsellLink:String;

	var mReanimator:Reanimator;

	public var mSaveObject:ASObject;

	public var mOptionsMenu:OptionsDialog;

	public var mPuzzleLocked:Bool = false;

	public var mDialogBox:DialogBox;

	public var adAPI:MSNAdAPI;

	public var mMaxExecutions:Int = 0;

	public var mShowedCrazyDaveVasebreaker:Bool = false;

	public var mAwardScreen:AwardScreen;

	public var mBoardResult:Int = 0;

	public function new() {
		this.mResourceLoader = new Loader();
		super(APP_ID);
	}

	override public function togglePause(isPaused:Bool) {
		super.togglePause(isPaused);
		if (isPaused) {
			stateManager.pushState(STATE_PAUSE_SCREEN);
		} else {
			stateManager.popState();
		}
	}

	@:flash.property @:isVar public var foleyManager(get, never):FoleyManager;

	public function get_foleyManager():FoleyManager {
		return this.mFoleyManager;
	}

	public function GetPlayerData() {
		this.mSaveObject = getSaveData();
		if (this.mSaveObject.level != /*undefined*/ null) {
			this.mLevel = ASCompat.toInt(this.mSaveObject.level);
		} else {
			this.mSaveObject.level = 1;
			this.mLevel = 1;
		}
		if (this.mSaveObject.puzzleLocked != /*undefined*/ null) {
			this.mPuzzleLocked = ASCompat.toBool(this.mSaveObject.puzzleLocked);
		} else {
			this.mSaveObject.puzzleLocked = true;
			this.mPuzzleLocked = true;
		}
		if (this.mSaveObject.survivalLocked != /*undefined*/ null) {
			this.mSurvivalLocked = ASCompat.toBool(this.mSaveObject.survivalLocked);
		} else {
			this.mSaveObject.survivalLocked = true;
			this.mSurvivalLocked = true;
		}
		if (this.mSaveObject.soundOn != /*undefined*/ null) {
			this.mSoundOn = ASCompat.toBool(this.mSaveObject.soundOn);
		} else {
			this.mSaveObject.soundOn = true;
			this.mSoundOn = true;
		}
		if (this.mSaveObject.musicOn != /*undefined*/ null) {
			this.mMusicOn = ASCompat.toBool(this.mSaveObject.musicOn);
		} else {
			this.mSaveObject.musicOn = true;
			this.mMusicOn = true;
		}
		setSaveData(this.mSaveObject);
	}

	override public function init() {
		var constant:XMLC = null;
		var foleyName:String = null;
		var ft:FoleyType = null;
		super.init();
		this.adAPI = new MSNAdAPI(this);
		this.mReanimator = new Reanimator(this);
		this.mParticleManager = new ParticleManager(this);
		this.mFoleyManager = new FoleyManager(this);
		var foleyType:XMLC = ASCompat.describeType(PVZFoleyType);
		/*
			for each(constant in foleyType.constant)
			{
						foleyName = constant.@name;
						ft = PVZFoleyType[foleyName] as FoleyType;
						this.mFoleyManager.loadFoley(ft);
			}
		 */
		musicManager.registerMusic(PVZMusic.CEREBRAWL, PVZMusic.CEREBRAWL_FILE);
		musicManager.registerMusic(PVZMusic.CHOOSE_YOUR_SEEDS, PVZMusic.CHOOSE_YOUR_SEEDS_FILE);
		musicManager.registerMusic(PVZMusic.CONVEYOR, PVZMusic.CONVEYOR_FILE);
		musicManager.registerMusic(PVZMusic.CRAZY_DAVE, PVZMusic.CRAZY_DAVE_FILE);
		musicManager.registerMusic(PVZMusic.GRASS_WALK, PVZMusic.GRASS_WALK_FILE);
		musicManager.registerMusic(PVZMusic.LOON_BOON, PVZMusic.LOON_BOON_FILE);
		musicManager.registerMusic(PVZMusic.WINMUSIC, PVZMusic.WINMUSIC_FILE);
		musicManager.registerMusic(PVZMusic.LOSEMUSIC, PVZMusic.LOSEMUSIC_FILE);
		musicManager.registerMusic(PVZMusic.ZENGARDEN, PVZMusic.ZENGARDEN_FILE);
		musicManager.registerMusic(PVZMusic.MOONGRAINS, PVZMusic.MOONGRAINS_FILE);
	}

	public function IsSurvivalEndless():Bool {
		if (this.mGameMode == GAMEMODE_SURVIVAL_ENDLESS_STAGE_2) {
			return true;
		}
		return false;
	}

	public function IsAdventureMode():Bool {
		if (this.mGameMode == GAMEMODE_ADVENTURE) {
			return true;
		}
		return false;
	}

	@:flash.property @:isVar public var reanimator(get, never):Reanimator;

	public function get_reanimator():Reanimator {
		return this.mReanimator;
	}

	public function IsScaryPotterLevel():Bool {
		if (this.mGameMode == GAMEMODE_SCARY_POTTER_ENDLESS) {
			return true;
		}

		return false;
	}

	@:flash.property @:isVar public var particleManager(get, never):ParticleManager;

	public function get_particleManager():ParticleManager {
		return this.mParticleManager;
	}

	override public function start() {
		this.GetPlayerData();
		stateManager.bindState(STATE_LOADING, new LoadingState(this));
		stateManager.bindState(STATE_TITLE_SCREEN, new TitleScreenState(this));
		stateManager.bindState(STATE_MAIN_MENU, new MainMenuState(this));
		stateManager.bindState(STATE_LEVEL_INTRO, new LevelIntroState(this));
		stateManager.bindState(STATE_LAWN_VIEW, new LawnViewState(this));
		stateManager.bindState(STATE_PAN_LEFT, new PanLeftState(this));
		stateManager.bindState(STATE_PAN_RIGHT, new PanRightState(this));
		stateManager.bindState(STATE_SEEDCHOOSER, new ChooseSeedsState(this));
		stateManager.bindState(STATE_READY_SET_START, new ReadySetStartState(this));
		stateManager.bindState(STATE_SLIDE_UI, new SlideUIState(this));
		stateManager.bindState(STATE_START_LEVEL, new StartLevelState(this));
		stateManager.bindState(STATE_SODROLL, new SodRollState(this));
		stateManager.bindState(STATE_SHOWAWARD, new ShowAwardState(this));
		stateManager.bindState(STATE_ZOMBIES_WON, new ZombiesWonState(this));
		stateManager.bindState(STATE_CRAZY_DAVE, new CrazyDaveState(this));
		stateManager.bindState(STATE_SURVIVAL_REPICK, new SurvivalRepickState(this));
		stateManager.bindState(STATE_OPTIONS_MENU, new OptionsMenuState(this));
		stateManager.bindState(STATE_CHALLENGE_SCREEN, new ChallengeScreenState(this));
		stateManager.bindState(STATE_DIALOG_BOX, new DialogState(this));
		stateManager.bindState(STATE_PLAY_LEVEL, new PlayLevelState(this));
		stateManager.bindState(STATE_UPSELL_SCREEN, new UpsellScreenState(this));
		stateManager.bindState(STATE_PAUSE_SCREEN, new PauseState(this));
		if (!this.mSoundOn) {
			soundManager.mute();
		}
		if (!this.mMusicOn) {
			musicManager.mute();
		}
		stateManager.changeState(STATE_LOADING);

		this.adAPI.init();
		super.start();
	}

	public function IsSurvivalMode():Bool {
		if (this.mGameMode == GAMEMODE_SURVIVAL_ENDLESS_STAGE_2) {
			return true;
		}

		return false;
	}
}
