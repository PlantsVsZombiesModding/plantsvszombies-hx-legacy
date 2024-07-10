package com.popcap.flash.games.pvz.states.playing;

import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.resources.images.ImageInst;
import com.popcap.flash.framework.states.IState;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.PVZMusic;
import com.popcap.flash.games.pvz.logic.Board;
import com.popcap.flash.games.pvz.logic.TodCommon;
import com.popcap.flash.games.pvz.logic.WeightedGridArray;
import com.popcap.flash.games.pvz.logic.zombies.Zombie;
import com.popcap.flash.games.pvz.renderables.ZombieRenderable;

class LevelIntroState implements IState {
	public static var TimeRollSodStart:Int = 7500;

	public static var TimeRollSodEnd:Int = TimeRollSodStart + 2000;

	var app:PVZApp;

	var boardImg:ImageInst;

	public function new(app:PVZApp) {
		// super();
		this.app = app;
	}

	public function onEnter() {
		this.app.widgetManager.removeAllWidgets();
		if (this.app.mBoard != null) {
			this.app.widgetManager.removeWidget(this.app.mBoard);
			this.app.mBoard = null;
		}
		this.app.mBoard = new Board(this.app);
		this.app.widgetManager.addWidget(this.app.mBoard);
		this.app.widgetManager.setFocus(this.app.mBoard);
		this.app.widgetManager.addWidget(this.app.mBoard.mMenuButton);
		this.app.mBoard.mMenuButton.setVisible(false);
		this.app.mBoard.mSeedBank.mVisible = false;
		this.app.mBoard.mToolTip.mVisible = false;
		this.app.mBoard.mGameScene = PVZApp.SCENE_LEVEL_INTRO;
		this.app.mBoard.initLevel();
		this.app.mCutsceneTime = 0;
		var aHasSod = false;
		if (this.app.IsAdventureMode()) {
			if (this.app.mBoard.mLevel == 1 || this.app.mBoard.mLevel == 2 || this.app.mBoard.mLevel == 4) {
				aHasSod = true;
			}
		}
		if (aHasSod) {
			this.app.mSodTime = TimeRollSodEnd - TimeRollSodStart;
			this.app.mBoard.mSodPosition = 0;
		} else {
			this.app.mSodTime = 0;
			this.app.mBoard.mSodPosition = 1000;
		}
		this.app.mBoard.PlaceStreetZombies();
		if (this.app.mBoard.IsWallnutBowlingLevel()) {
			this.app.musicManager.playMusic(PVZMusic.CRAZY_DAVE, true, 50);
			this.app.stateManager.changeState(PVZApp.STATE_CRAZY_DAVE);
		} else if (this.app.IsScaryPotterLevel()) {
			this.app.mBoard.mSeedBank.Move(0, -78);
			if (this.app.mShowedCrazyDaveVasebreaker) {
				this.app.musicManager.playMusic(PVZMusic.CEREBRAWL, true, 50);
				this.app.stateManager.changeState(PVZApp.STATE_START_LEVEL);
			} else {
				this.app.mShowedCrazyDaveVasebreaker = true;
				this.app.musicManager.playMusic(PVZMusic.CRAZY_DAVE, true, 50);
				this.app.stateManager.changeState(PVZApp.STATE_CRAZY_DAVE);
			}
		} else if (this.app.IsAdventureMode() && this.app.mLevel == 11) {
			this.app.musicManager.playMusic(PVZMusic.CRAZY_DAVE, true, 50);
			this.app.stateManager.changeState(PVZApp.STATE_CRAZY_DAVE);
		} else {
			this.app.musicManager.playMusic(PVZMusic.CHOOSE_YOUR_SEEDS, true, 50);
			this.app.stateManager.changeState(PVZApp.STATE_PAN_RIGHT);
		}
	}

	public function PlaceStreetZombies() {
		var aZombieType = 0;
		var aGridY = 0;
		var aZombieArray:Array<ASAny> = null;
		var aNumToShow = 0;
		var aZombieIndex = 0;
		if (this.app.mPlacedZombies) {
			return;
		}
		this.app.mPlacedZombies = true;
		var aTotalZombieCount = 0;
		var aZombieTypeCount = new Array<ASAny>();
		var aZombieValueTotal = 0;
		for (i in 0...8) {
			aZombieTypeCount[i] = 0;
		}
		var aWaveIndex = 0;
		while (aWaveIndex < this.app.mBoard.mNumWaves) {
			var i:ASAny = 0;
			while (i < Board.MAX_ZOMBIES_IN_WAVE) {
				aZombieType = ASCompat.toInt(this.app.mBoard.mZombiesInWave[aWaveIndex][i]);
				if (aZombieType == Board.ZOMBIE_INVALID) {
					break;
				}
				aZombieValueTotal += this.app.mBoard.GetZombieDefinition(aZombieType).mZombieValue;
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
		var aApproxNumberToShow = 10;
		for (_tmp_ in 0...7) {
			aZombieType = _tmp_;
			if (aZombieTypeCount[aZombieType] != 0) {
				aNumToShow = Std.int(aZombieTypeCount[aZombieType] * aApproxNumberToShow / aTotalZombieCount);
				aNumToShow = TodCommon.ClampInt(aNumToShow, 1, aZombieTypeCount[aZombieType]);
				for (_tmp_ in 0...aNumToShow) {
					aZombieIndex = _tmp_;

					this.FindAndPlaceZombie(aZombieType, aZombieGrid);
				}
			}
		}
	}

	public function draw(g:Graphics2D) {
		this.app.widgetManager.drawScreen(g);
	}

	public function PlaceAZombie(theZombieType:Int, theGridX:Int, theGridY:Int) {
		var aZombie = new Zombie();
		var aVariant = false;
		if (Math.random() * 5 == 0) {
			aVariant = true;
		}
		aZombie.ZombieInitialize(0, theZombieType, aVariant, null, -2, this.app, this.app.mBoard);
		this.app.mBoard.mZombies.push(aZombie);
		aZombie.mPosX = 600 + 28 * theGridX;
		aZombie.mPosY = 77 + 50 * theGridY;
		if (theGridX % 2 == 1) {
			aZombie.mPosY += 21;
		} else {
			aZombie.mPosY += Math.random() * 10;
			aZombie.mPosX += Math.random() * 10;
		}
		this.app.mBoard.mRenderManager.add(new ZombieRenderable(aZombie, Board.RENDER_LAYER_ZOMBIE + aZombie.mPosY));
	}

	public function onPush() {}

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

	public function FindAndPlaceZombie(theZombieType:Int, theZombieGrid:Array<ASAny>) {
		var aGridX = 0;
		var aGridY = 0;
		this.FindPlaceForStreetZombies(theZombieType, theZombieGrid, aGridX, aGridY);
	}

	public function update() {
		this.app.widgetManager.updateFrame();

		if (this.app.resourceManager.isLoading()) {
			return;
		}
	}

	public function onPop() {}

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
					aPicks.push(aWeightedGridArray);
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

	public function onExit() {
		this.app.mPlacedZombies = false;
	}
}
