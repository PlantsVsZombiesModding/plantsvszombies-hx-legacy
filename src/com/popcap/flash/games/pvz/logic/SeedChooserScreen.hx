package com.popcap.flash.games.pvz.logic;

import com.popcap.flash.framework.graphics.Graphics2D;
import com.popcap.flash.framework.resources.fonts.FontInst;
import com.popcap.flash.framework.resources.images.ImageData;
import com.popcap.flash.framework.resources.images.ImageInst;
import com.popcap.flash.framework.widgets.CWidget;
import com.popcap.flash.framework.widgets.ui.IButtonListener;
import com.popcap.flash.framework.widgets.ui.ImageButtonWidget;
import com.popcap.flash.games.pvz.PVZApp;
import com.popcap.flash.games.pvz.PVZFoleyType;
import com.popcap.flash.games.pvz.logic.uI.DialogBox;
import com.popcap.flash.games.pvz.logic.uI.ToolTipWidget;
import com.popcap.flash.games.pvz.renderables.StringRenderable;
import com.popcap.flash.games.pvz.resources.PVZFonts;
import com.popcap.flash.games.pvz.resources.PVZImages;
import flash.display.BitmapData;
import flash.geom.Point;

class SeedChooserScreen extends CWidget implements IButtonListener {
	public static inline final SEED_EXPLODE_O_NUT = 50;

	public static inline final SEED_PUFFSHROOM = 8;

	static inline final SEED_NONE = -1;

	public static inline final SEED_IN_BANK = 1;

	static inline final SEED_CHERRYBOMB = 2;

	static inline final SEED_SQUASH = 4;

	static inline final SEED_PEASHOOTER = 0;

	public static inline final SEED_IN_CHOOSER = 3;

	public static inline final SEED_FLYING_TO_CHOOSER = 2;

	static inline final SEED_CHOMPER = 6;

	public static inline final SEED_SUNSHROOM = 9;

	static inline final SEED_REPEATER = 7;

	public static inline final NUM_SEEDS_IN_CHOOSER = 14;

	public static inline final CHOOSE_ENTER = 1;

	static inline final SEED_WALLNUT = 3;

	public static inline final SEED_FUMESHROOM = 10;

	public static inline final CHOOSE_NORMAL = 0;

	public static inline final SEED_FLYING_TO_BANK = 0;

	public static inline final CHOOSE_LEAVE = 2;

	public static inline final SEED_LEFTPEATER = 49;

	public static inline final SEED_PACKET_HIDDEN = 4;

	public static inline final SEED_GRAVEBUSTER = 11;

	static inline final SEED_SUNFLOWER = 1;

	static inline final SEED_SNOWPEA = 5;

	public static inline final CHOOSE_VIEW_LAWN = 3;

	public var mStartButton:ImageButtonWidget;

	public var mChooseState:Int = 0;

	var mButtonImage:ImageInst;

	public var mSeedsInBank:Int = 0;

	var mUpsellText:StringRenderable;

	public var Options_Menu:Int = 100;

	public var app:PVZApp;

	public var mChosenSeeds:Array<ASAny>;

	var mSeedPacket:Array<ASAny>;

	public var mLawnViewButton:ImageButtonWidget;

	public var mToolTip:ToolTipWidget;

	public var mMenuButton:ImageButtonWidget;

	public var mToolTipSeed:Int = 0;

	public var mSeedsInFlight:Int = 0;

	public var mViewLawnTime:Int = 0;

	var mPacketSilhouette:ImageInst;

	public var mLastMouseX:Int = 0;

	public var mLastMouseY:Int = 0;

	public var mNumSeedsToChoose:Int = 0;

	public var mSeedChooserAge:Int = 0;

	public var Start_Game:Int = 102;

	public var Lawn_View:Int = 101;

	public var mBoard:Board;

	var mBackground:ImageInst;

	public var mDialogBox:DialogBox;

	public function new(app:PVZApp, theBoard:Board) {
		super();
		var i = 0;
		var aChosenSeed:ChosenSeed = null;
		var aPoint:Point = null;
		var aSeedPacket:SeedPacket = null;
		var aSeedType = 0;
		this.mChosenSeeds = new Array<ASAny>();
		this.mSeedPacket = new Array<ASAny>();
		// super();
		x = 0;
		y = 0;
		width = 460;
		height = 405;
		this.app = app;
		this.mBoard = theBoard;
		this.mSeedsInFlight = 0;
		this.mSeedsInBank = 0;
		this.mLastMouseX = -1;
		this.mLastMouseY = -1;
		this.mViewLawnTime = 0;
		this.mToolTip = new ToolTipWidget(app, theBoard);
		var font = app.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT18YELLOW);
		font.scale = 0.7;
		var anImage = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BUTTON);
		var aString = app.stringManager.translateString("[LETS_ROCK_BUTTON]");
		this.mStartButton = new ImageButtonWidget(this.Start_Game, this);
		this.mStartButton.mUpImage = this.MakeButton(anImage, font, aString);
		font.setColor(1, 1.5, 1.5, 1.5);
		var aGlowImage = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BUTTON_GLOW);
		this.mStartButton.mDownImage = this.MakeGlowButton(anImage, aGlowImage, font, aString);
		this.mStartButton.mDownOffset = new Point(1, 1);
		this.mStartButton.mOverImage = this.MakeGlowButton(anImage, aGlowImage, font, aString);
		anImage = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BUTTON_DISABLED);
		font.setColor(1, 64 / 255, 64 / 255, 64 / 255);
		this.mStartButton.mDisabledImage = this.MakeButton(anImage, font, aString);
		this.mStartButton.visible = true;
		this.mStartButton.resize(115, 715, 105, 28);
		this.EnableStartButton(false);
		this.mLawnViewButton = new ImageButtonWidget(this.Lawn_View, this);
		anImage = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BUTTON2);
		aString = app.stringManager.translateString("[VIEW_LAWN]");
		font = app.fontManager.getFontInst(PVZFonts.FONT_BRIANNETOD16);
		font.scale = 0.6;
		font.setColor(1, 42 / 255, 42 / 255, 90 / 255);
		this.mLawnViewButton.mUpImage = this.MakeButton(anImage, font, aString);
		aGlowImage = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BUTTON2_GLOW);
		this.mLawnViewButton.mDownImage = this.MakeGlowButton(anImage, aGlowImage, font, aString);
		this.mLawnViewButton.mDownOffset = new Point(1, 1);
		this.mLawnViewButton.mOverImage = this.MakeGlowButton(anImage, aGlowImage, font, aString);
		this.mLawnViewButton.mDisabledImage = this.MakeButton(anImage, font, aString);
		this.mLawnViewButton.visible = true;
		this.mLawnViewButton.resize(20, 720, 75, 18);
		if (app.IsAdventureMode() || this.mBoard.mChallenge.mSurvivalStage == 0) {
			this.mLawnViewButton.visible = false;
			this.mLawnViewButton.setDisabled(true);
		}
		var i:ASAny = 0;
		while (i < 12) {
			aChosenSeed = new ChosenSeed();
			aPoint = new Point();
			this.GetSeedPositionInChooser(i, aPoint);
			aChosenSeed.mX = Std.int(aPoint.x);
			aChosenSeed.mY = Std.int(aPoint.y);
			aChosenSeed.mSeedType = i;
			aChosenSeed.mTimeStartMotion = 0;
			aChosenSeed.mTimeEndMotion = 0;
			aChosenSeed.mStartX = aChosenSeed.mX;
			aChosenSeed.mStartY = aChosenSeed.mY;
			aChosenSeed.mEndX = aChosenSeed.mX;
			aChosenSeed.mEndY = aChosenSeed.mY;
			aChosenSeed.mSeedState = SEED_IN_CHOOSER;
			aChosenSeed.mSeedIndexInBank = 0;
			aChosenSeed.mRefreshCounter = 0;
			aChosenSeed.mRefreshing = false;
			aChosenSeed.mCrazyDavePicked = false;
			this.mChosenSeeds[i] = aChosenSeed;
			i++;
		}
		if (app.IsSurvivalMode() && this.mBoard.mChallenge.mSurvivalStage > 0 && this.mBoard.mGameScene == Board.SCENE_LEVEL_INTRO) {
			var i:ASAny = 0;
			while (i < this.mBoard.mSeedBank.mNumPackets) {
				aSeedPacket = this.mBoard.mSeedBank.mSeedPackets[i];
				aSeedType = aSeedPacket.mPacketType;
				aChosenSeed = this.mChosenSeeds[aSeedType];
				aChosenSeed.mRefreshing = aSeedPacket.mRefreshing;
				aChosenSeed.mRefreshCounter = aSeedPacket.mRefreshCounter;
				i++;
			}
			var i:ASAny = 0;
			while (i < 6) {
				aSeedPacket = this.mBoard.mSeedBank.mSeedPackets[i];
				aSeedPacket.mX = this.mBoard.GetSeedPacketPositionX(i);
				aSeedPacket.mPacketType = SEED_NONE;
				i++;
			}
			this.mBoard.mSeedBank.mNumPackets = 4;
		}
		this.mBackground = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BACKGROUND);
		this.mButtonImage = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BUTTON);
		this.mPacketSilhouette = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDPACKETSILHOUETTE);
		this.mUpsellText = new StringRenderable(0);
		this.mUpsellText.setBounds(27, 240, 270, 130);
		var upsellString = app.stringManager.translateString("[SEEDCHOOSER_UPSELL_MESSAGE]");
		font = app.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT18YELLOW);
		font.setColor(1, 1, 1, 1);
		font.scale = 1.2;
		this.mUpsellText.font = font;

		this.mUpsellText.text = upsellString;
		this.mDialogBox = new DialogBox(app, this.mBoard);
		this.mDialogBox.setVisible(false);
	}

	public function buttonMouseEnter(id:Float) {}

	public function ShowToolTip() {
		if (this.mChooseState != CHOOSE_NORMAL) {
			this.RemoveToolTip();
			return;
		}
		if (this.mSeedsInFlight > 0) {
			return;
		}
		var aSeedType = this.SeedHitTest(this.mLastMouseX, this.mLastMouseY);
		if (aSeedType == SEED_NONE) {
			this.RemoveToolTip();
			return;
		}
		if (aSeedType == this.mToolTipSeed) {
			return;
		}
		this.RemoveToolTip();
		var aChosenSeed:ChosenSeed = this.mChosenSeeds[aSeedType];
		this.mToolTip.SetWarningText("");
		this.mToolTip.SetTitle(this.mBoard.GetSeedName(aSeedType));
		this.mToolTip.SetLabel(this.mBoard.GetSeedToolTip(aSeedType));
		var aPoint = new Point();
		if (aChosenSeed.mSeedState == SEED_IN_BANK) {
			this.GetSeedPositionInBank(aChosenSeed.mSeedIndexInBank, aPoint);
		} else {
			this.GetSeedPositionInChooser(aSeedType, aPoint);
		}
		var aPosX = Std.int(aPoint.x + (50 - this.mToolTip.mWidth) / 2);
		aPosX = TodCommon.ClampInt(aPosX, 0, Board.BOARD_WIDTH - this.mToolTip.mWidth);
		this.mToolTip.mX = aPosX;

		this.mToolTip.mY = Std.int(aPoint.y + 70);
		this.mToolTip.mVisible = true;
		this.mToolTipSeed = aSeedType;
	}

	public function buttonMouseMove(id:Float, x:Float, y:Float) {}

	public function EnableStartButton(theEnabled:Bool) {
		this.mStartButton.setDisabled(!theEnabled);
	}

	public function LandFlyingSeed(theChosenSeed:ChosenSeed) {
		if (theChosenSeed.mSeedState == SEED_FLYING_TO_BANK) {
			theChosenSeed.mTimeStartMotion = 0;
			theChosenSeed.mTimeEndMotion = 0;
			theChosenSeed.mSeedState = SEED_IN_BANK;
			theChosenSeed.mX = theChosenSeed.mEndX;
			theChosenSeed.mY = theChosenSeed.mEndY;
			--this.mSeedsInFlight;
		} else if (theChosenSeed.mSeedState == SEED_FLYING_TO_CHOOSER) {
			theChosenSeed.mTimeStartMotion = 0;
			theChosenSeed.mTimeEndMotion = 0;
			theChosenSeed.mSeedState = SEED_IN_CHOOSER;
			theChosenSeed.mX = theChosenSeed.mEndX;

			theChosenSeed.mY = theChosenSeed.mEndY;
			--this.mSeedsInFlight;
		}
	}

	public function CloseSeedChooser() {
		var aSeedType = 0;
		var aChosenSeed:ChosenSeed = null;
		var aSeedPacket:SeedPacket = null;
		this.mBoard.mSeedBank.mVisible = true;
		var i = 0;
		while (i < this.mBoard.mSeedBank.mNumPackets) {
			aSeedType = this.FindSeedInBank(i);
			aChosenSeed = this.mChosenSeeds[aSeedType];
			aSeedPacket = this.mBoard.mSeedBank.mSeedPackets[i];
			aSeedPacket.mPacketType = aSeedType;
			aSeedPacket.mUpdateImage = true;
			aSeedPacket.mVisible = true;
			if (aChosenSeed != null) {
				if (aChosenSeed.mRefreshing) {
					aSeedPacket.mRefreshCounter = this.mChosenSeeds[aSeedType].mRefreshCounter;
					aSeedPacket.mRefreshTime = aSeedPacket.GetRefreshTime(aSeedPacket.mPacketType);
					aSeedPacket.mRefreshing = true;
					aSeedPacket.mActive = false;
					aSeedPacket.mUpdateImage = true;
					aSeedPacket.mVisible = true;
				} else {
					aSeedPacket.mRefreshCounter = 0;
					aSeedPacket.mRefreshTime = 0;
					aSeedPacket.mRefreshing = false;
					aSeedPacket.mActive = true;
				}
			}
			if (aSeedPacket.GetRefreshTime(aSeedPacket.mPacketType) == 3000) {
				aSeedPacket.mRefreshCounter = this.mChosenSeeds[aSeedType].mRefreshCounter;
				aSeedPacket.mRefreshing = true;
				aSeedPacket.mRefreshTime = 2000;
				aSeedPacket.mActive = false;
			} else if (aSeedPacket.GetRefreshTime(aSeedPacket.mPacketType) == 5000) {
				aSeedPacket.mRefreshCounter = this.mChosenSeeds[aSeedType].mRefreshCounter;
				aSeedPacket.mRefreshing = true;
				aSeedPacket.mRefreshTime = 5000;

				aSeedPacket.mActive = false;
			}
			i++;
		}
	}

	public function ClickedSeedInChooser(theChosenSeed:ChosenSeed) {
		if (this.mSeedsInBank == this.mBoard.mSeedBank.mNumPackets) {
			return;
		}
		theChosenSeed.mTimeStartMotion = this.mSeedChooserAge;
		theChosenSeed.mTimeEndMotion = this.mSeedChooserAge + 25;
		theChosenSeed.mStartX = theChosenSeed.mX;
		theChosenSeed.mStartY = theChosenSeed.mY;
		var aPoint = new Point();
		aPoint.x = theChosenSeed.mEndX;
		aPoint.y = theChosenSeed.mEndY;
		this.GetSeedPositionInBank(this.mSeedsInBank, aPoint);
		theChosenSeed.mEndX = Std.int(aPoint.x);
		theChosenSeed.mEndY = Std.int(aPoint.y);
		theChosenSeed.mSeedState = SEED_FLYING_TO_BANK;
		theChosenSeed.mSeedIndexInBank = this.mSeedsInBank;
		++this.mSeedsInFlight;
		++this.mSeedsInBank;
		this.RemoveToolTip();
		this.app.foleyManager.playFoley(PVZFoleyType.DROP);

		if (this.mSeedsInBank == this.mBoard.mSeedBank.mNumPackets) {
			this.EnableStartButton(true);
		}
	}

	public function SeedNotAllowedToPick(theSeedType:Int):Bool {
		return false;
	}

	public function PickedPlantType(theSeedType:Int):Bool {
		var chosenSeed:ChosenSeed = null;
		for (i in 0...NUM_SEEDS_IN_CHOOSER) {
			chosenSeed = this.mChosenSeeds[i];
			if (chosenSeed != null) {
				if (chosenSeed.mSeedState == SEED_IN_BANK) {
					if (chosenSeed.mSeedType == theSeedType) {
						return true;
					}
				}
			}
		}
		return false;
	}

	public function GetSeedPositionInChooser(theIndex:Int, thePoint:Point) {
		var aRow = Std.int(theIndex / 6);
		var aCol = theIndex % 6;
		thePoint.x = 12 + aCol * 50;
		thePoint.y = 110 + aRow * 65;
	}

	public function buttonPress(id:Float) {}

	public function KillDialogBox() {
		this.mDialogBox.setVisible(false);
		this.mDialogBox.KillButtons();
		this.mLawnViewButton.setDisabled(false);
		this.mStartButton.setDisabled(false);
	}

	public function OnStartButton() {
		if (this.app.IsAdventureMode != null && this.mBoard.mLevel == 11 && !this.PickedPlantType(SEED_PUFFSHROOM)) {
			this.DisplayRepickWarningDialog("[SEED_CHOOSER_PUFFSHROOM_WARNING]");
		} else if (!this.PickedPlantType(SEED_SUNFLOWER) && !this.PickedPlantType(SEED_SUNSHROOM) && this.app.IsAdventureMode()) {
			if (this.mBoard.mLevel == 11) {
				this.DisplayRepickWarningDialog("[SEED_CHOOSER_NIGHT_SUN_WARNING]");
			} else {
				this.DisplayRepickWarningDialog("[SEED_CHOOSER_SUN_WARNING]");
			}
		} else {
			this.mChooseState = CHOOSE_LEAVE;
			this.CloseSeedChooser();
		}
	}

	public function RemoveToolTip() {
		this.mToolTip.mVisible = false;
		this.mToolTipSeed = SEED_NONE;
	}

	public function ClickedSeedInBank(theChosenSeed:ChosenSeed) {
		var aSeedIndex = 0;
		var aMoveSeed:ChosenSeed = null;
		var aPoint = new Point();
		var i = theChosenSeed.mSeedIndexInBank + 1;
		while (i < this.mBoard.mSeedBank.mNumPackets) {
			if (this.mBoard.mSeedBank.mSeedPackets[i].mPacketType != SEED_NONE) {
				this.mBoard.mSeedBank.mSeedPackets[i].mVisible = false;
			}
			aSeedIndex = this.FindSeedInBank(i);
			if (aSeedIndex != SEED_NONE) {
				aMoveSeed = this.mChosenSeeds[aSeedIndex];
				aMoveSeed.mTimeStartMotion = this.mSeedChooserAge;
				aMoveSeed.mTimeEndMotion = this.mSeedChooserAge + 15;
				aMoveSeed.mStartX = aMoveSeed.mX;
				aMoveSeed.mStartY = aMoveSeed.mY;
				aPoint.x = aMoveSeed.mEndX;
				aPoint.y = aMoveSeed.mEndY;
				this.GetSeedPositionInBank(i - 1, aPoint);
				aMoveSeed.mEndX = Std.int(aPoint.x);
				aMoveSeed.mEndY = Std.int(aPoint.y);
				aMoveSeed.mSeedState = SEED_FLYING_TO_BANK;
				aMoveSeed.mSeedIndexInBank = i - 1;
				++this.mSeedsInFlight;
			}
			i++;
		}
		var i:ASAny = theChosenSeed.mSeedIndexInBank;
		if (this.mBoard.mSeedBank.mSeedPackets[i].mPacketType != SEED_NONE) {
			this.mBoard.mSeedBank.mSeedPackets[i].mVisible = false;
		}
		theChosenSeed.mTimeStartMotion = this.mSeedChooserAge;
		theChosenSeed.mTimeEndMotion = this.mSeedChooserAge + 25;
		theChosenSeed.mStartX = theChosenSeed.mX;
		theChosenSeed.mStartY = theChosenSeed.mY;
		aPoint.x = theChosenSeed.mEndX;
		aPoint.y = theChosenSeed.mEndY;
		this.GetSeedPositionInChooser(theChosenSeed.mSeedType, aPoint);
		theChosenSeed.mEndX = Std.int(aPoint.x);
		theChosenSeed.mEndY = Std.int(aPoint.y);
		theChosenSeed.mSeedState = SEED_FLYING_TO_CHOOSER;

		theChosenSeed.mSeedIndexInBank = 0;
		++this.mSeedsInFlight;
		--this.mSeedsInBank;
		this.EnableStartButton(false);
		this.app.foleyManager.playFoley(PVZFoleyType.DROP);
	}

	public function UpdateCursor() {
		var aShowFinger = false;
		var aChosenSeed:ChosenSeed = null;
		var aHitSeedType = this.SeedHitTest(this.mLastMouseX, this.mLastMouseY);
		if (aHitSeedType != SEED_NONE) {
			aChosenSeed = this.mChosenSeeds[aHitSeedType];
			if (aChosenSeed.mSeedState == SEED_IN_BANK && aChosenSeed.mCrazyDavePicked) {
				aHitSeedType = SEED_NONE;
			}
		}
		if (this.mChooseState == CHOOSE_VIEW_LAWN) {
			aShowFinger = false;
		} else if (aHitSeedType != SEED_NONE) {
			if (this.SeedNotAllowedToPick(aHitSeedType)) {
				aShowFinger = false;
			} else {
				aShowFinger = true;
			}
		} else {
			aShowFinger = false;
		}
		showFinger(aShowFinger);
	}

	override public function onMouseDown(x:Float, y:Float) {
		var i = 0;
		var aChosenSeed:ChosenSeed = null;
		if (this.mSeedsInFlight > 0) {
			var i:ASAny = 0;
			while (i < NUM_SEEDS_IN_CHOOSER) {
				aChosenSeed = this.mChosenSeeds[i];
				if (aChosenSeed != null) {
					this.LandFlyingSeed(aChosenSeed);
				}
				i++;
			}
		}
		var aSeedType = this.SeedHitTest(Std.int(x), Std.int(y));
		if (aSeedType == SEED_NONE) {
			return;
		}
		aChosenSeed = this.mChosenSeeds[aSeedType];
		if (aChosenSeed.mSeedState == SEED_IN_BANK && aChosenSeed.mCrazyDavePicked) {
			return;
		}
		if (aChosenSeed.mSeedState == SEED_IN_BANK) {
			this.ClickedSeedInBank(aChosenSeed);
		} else if (aChosenSeed.mSeedState == SEED_IN_CHOOSER) {
			this.ClickedSeedInChooser(aChosenSeed);
		}
	}

	override public function update() {
		var aChosenSeed:ChosenSeed = null;
		this.mLastMouseX = Std.int(this.app.widgetManager.lastMouseX);
		this.mLastMouseY = Std.int(this.app.widgetManager.lastMouseY);
		++this.mSeedChooserAge;
		this.mToolTip.Update();
		for (i in 0...NUM_SEEDS_IN_CHOOSER) {
			if (this.HasSeedType(i)) {
				aChosenSeed = this.mChosenSeeds[i];
				if (aChosenSeed.mSeedState == SEED_FLYING_TO_BANK || aChosenSeed.mSeedState == SEED_FLYING_TO_CHOOSER) {
					aChosenSeed.mX = TodCommon.TodAnimateCurve(aChosenSeed.mTimeStartMotion, aChosenSeed.mTimeEndMotion, this.mSeedChooserAge,
						aChosenSeed.mStartX, aChosenSeed.mEndX, TodCommon.CURVE_EASE_IN_OUT);
					aChosenSeed.mY = TodCommon.TodAnimateCurve(aChosenSeed.mTimeStartMotion, aChosenSeed.mTimeEndMotion, this.mSeedChooserAge,
						aChosenSeed.mStartY, aChosenSeed.mEndY, TodCommon.CURVE_EASE_IN_OUT);
				}
				if (aChosenSeed.mSeedState == SEED_FLYING_TO_BANK && this.mSeedChooserAge >= aChosenSeed.mTimeEndMotion) {
					this.LandFlyingSeed(aChosenSeed);
				}
				if (aChosenSeed.mSeedState == SEED_FLYING_TO_CHOOSER && this.mSeedChooserAge >= aChosenSeed.mTimeEndMotion) {
					this.LandFlyingSeed(aChosenSeed);
				}
			}
		}
		this.ShowToolTip();
		this.UpdateCursor();
		markDirty();
	}

	public function FindSeedInBank(theIndexInBank:Int):Int {
		var aChosenSeed:ChosenSeed = null;
		for (i in 0...NUM_SEEDS_IN_CHOOSER) {
			if (this.HasSeedType(i)) {
				aChosenSeed = this.mChosenSeeds[i];
				if (aChosenSeed.mSeedState == SEED_IN_BANK && aChosenSeed.mSeedIndexInBank == theIndexInBank) {
					return i;
				}
			}
		}
		return SEED_NONE;
	}

	public function buttonDownTick(id:Float) {}

	public function MakeGlowButton(theImage:ImageInst, theGlowImage:ImageInst, theFont:FontInst, theText:String):ImageInst {
		var w = theImage.width;
		var h = theImage.height;
		var aBufferedImage = new ImageInst(new ImageData(new BitmapData(Std.int(w), Std.int(h), true, 0)));
		var bufferG = aBufferedImage.graphics;
		bufferG.drawImage(theImage, 0, 0);
		bufferG.drawImage(theGlowImage, 0, 0);
		while (theFont.stringImageWidth(theText) > theImage.width) {
			theFont.scale -= 0.1;
		}
		bufferG.setFont(theFont);
		var offsetX = (theImage.width - theFont.stringImageWidth(theText)) / 2;
		var offsetY = (theImage.height - theFont.getHeight()) / 2;
		bufferG.drawString(theText, offsetX, offsetY);
		return aBufferedImage;
	}

	override public function draw(g:Graphics2D) {
		var aPoint:Point = null;
		var x = 0;
		var y = 0;
		var aSeedType = 0;
		var aChosenSeed:ChosenSeed = null;
		var upsellImage:ImageInst = null;
		if (!this.mBoard.ChooseSeedsOnCurrentLevel()) {
			return;
		}
		g.drawImage(this.mBackground, 0, 78);
		var font = this.app.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT18YELLOW);
		font.setColor(1, 1, 1, 1);
		font.scale = 0.8;
		g.pushState();
		g.setFont(font);
		g.drawString(this.app.stringManager.translateString("[CHOOSE_YOUR_PLANTS]"), 55, 82);
		g.popState();
		var aSeedPlaces = 24;
		for (i in 0...aSeedPlaces) {
			aPoint = new Point();
			this.GetSeedPositionInChooser(i, aPoint);
			x = Std.int(aPoint.x);
			y = Std.int(aPoint.y);
			aSeedType = i;
			if (this.HasSeedType(aSeedType)) {
				aChosenSeed = this.mChosenSeeds[i];
				if (aChosenSeed.mSeedState != SEED_IN_CHOOSER) {
					if (this.mSeedPacket[i] == null) {
						this.DrawSeedPacket(g, i);
					}
					this.mSeedPacket[i].useColor = true;
					this.mSeedPacket[i].setColor(1, 0.25, 0.25, 0.25);
					g.drawImage(this.mSeedPacket[i], x, y);
				}
			} else {
				g.drawImage(this.mPacketSilhouette, x, y);
			}
		}
		var aNumPlacesInBank = this.mBoard.mSeedBank.mNumPackets;
		var i:ASAny = 0;
		while (i < aNumPlacesInBank) {
			if (this.FindSeedInBank(i) == SEED_NONE) {
				this.GetSeedPositionInBank(i, aPoint);
				g.drawImage(this.mPacketSilhouette, aPoint.x, aPoint.y);
			}
			i++;
		}
		var i:ASAny = 0;
		while (i < NUM_SEEDS_IN_CHOOSER) {
			if (this.HasSeedType(i)) {
				aChosenSeed = this.mChosenSeeds[i];
				if (!(aChosenSeed.mSeedState == SEED_FLYING_TO_CHOOSER
					|| aChosenSeed.mSeedState == SEED_FLYING_TO_BANK
					|| aChosenSeed.mSeedState == SEED_PACKET_HIDDEN)) {
					x = aChosenSeed.mX;
					y = aChosenSeed.mY;
					if (aChosenSeed.mSeedState == SEED_IN_BANK) {
						x -= Std.int(this.x);
						y -= Std.int(this.y);
					}
					if (this.mSeedPacket[i] == null) {
						this.DrawSeedPacket(g, i);
					}
					this.mSeedPacket[i].useColor = true;
					this.mSeedPacket[i].setColor(1, 1, 1, 1);
					g.drawImage(this.mSeedPacket[i], x, y);
				}
			}
			i++;
		}
		var i:ASAny = 0;
		while (i < NUM_SEEDS_IN_CHOOSER) {
			if (this.HasSeedType(i)) {
				aChosenSeed = this.mChosenSeeds[i];
				if (!(aChosenSeed.mSeedState != SEED_FLYING_TO_CHOOSER && aChosenSeed.mSeedState != SEED_FLYING_TO_BANK)) {
					this.mSeedPacket[i].useColor = true;
					this.mSeedPacket[i].setColor(1, 1, 1, 1);
					g.drawImage(this.mSeedPacket[i], aChosenSeed.mX, aChosenSeed.mY);
				}
			}

			i++;
		}
		if (this.mBoard.mLevel > 12 || this.app.IsSurvivalMode()) {
			upsellImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_UPSELL);
			g.drawImage(upsellImage, 15, 242);
			this.mUpsellText.draw(g);
		}
		this.mToolTip.Draw(g);
	}

	function DrawSeedPacket(g:Graphics2D, theType:Int) {
		var aSeedBackImg:ImageInst = null;
		var aPlantImg:ImageInst = null;
		aSeedBackImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_SEEDBACK);
		var w = aSeedBackImg.width;
		var h = aSeedBackImg.height;
		this.mSeedPacket[theType] = new ImageInst(new ImageData(new BitmapData(Std.int(w), Std.int(h), true, 0)));

		var bufferG:Graphics2D = this.mSeedPacket[theType].graphics;
		bufferG.drawImage(aSeedBackImg, 0, 0);
		var aOffsetX:Float = 5;
		var aOffsetY:Float = 10;
		var aScale:Float = 0.75;

		switch (theType) {
			case SEED_PEASHOOTER:
				aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_PEASHOOTERSINGLE);
				aOffsetY += 4;

			case SEED_SUNFLOWER:
				aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_SUNFLOWER);
				aOffsetY += 1;
				aOffsetX += 2;

			case SEED_CHERRYBOMB:
				aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_CHERRYBOMB);
				aOffsetY += 3;
				aOffsetX += -1;

			case SEED_SQUASH:
				aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_SQUASH);
				aOffsetX += 0;
				aOffsetY += -2;

			case SEED_CHOMPER:
				aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_CHOMPER);
				aOffsetX += -2;

				aOffsetY += -3;
				aScale = 0.6;
			case SEED_SNOWPEA:
				aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_SNOWPEA);

				aOffsetY += 3;
			case SEED_REPEATER:
				aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_PEASHOOTER);
				aOffsetY += 5;

			case SEED_PUFFSHROOM:
				aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_PUFFSHROOM);
				aOffsetY += 10;
				aOffsetX += 7;

			case SEED_SUNSHROOM:
				aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_SUNSHROOM);
				aOffsetY += 10;
				aOffsetX += 7;

			case SEED_GRAVEBUSTER:
				aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_GRAVEDIGGER);
				aOffsetY += 0;
				aOffsetX += -3;
				aScale = 0.6;
			case SEED_FUMESHROOM:
				aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_FUMESHROOM);
				aOffsetY += 1;
				aScale = 0.65;
			case SEED_WALLNUT:
				aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_WALLNUT);
				aOffsetX += 3;
		}
		bufferG.pushState();
		bufferG.scale(aScale, aScale);
		bufferG.drawImage(aPlantImg, aOffsetX, aOffsetY);
		bufferG.popState();

		var aCost = this.mBoard.GetCurrentPlantCost(theType);
		var aSeedPacketFont = this.app.fontManager.getFontInst(PVZFonts.FONT_PICO129);
		aSeedPacketFont.setColor(1, 0, 0, 0);
		var width = Std.int(aSeedPacketFont.stringWidth(Std.string(aCost)));

		var height = Std.int(aSeedPacketFont.getAscent());
		var aTextOffsetX = 30 - width;
		var aTextOffsetY = 40 + height;
		bufferG.setFont(aSeedPacketFont);
		bufferG.drawString(Std.string(aCost), aTextOffsetX, aTextOffsetY);
	}

	public function buttonMouseLeave(id:Float) {}

	public function HasSeedType(theType:Int):Bool {
		var aArea = Std.int((this.app.mLevel - 1) / 10 + 1);
		var aSubArea = (this.app.mLevel - 1) % 10 + 1;
		var aSeeds = (aArea - 1) * 8 + aSubArea;
		if (aSubArea >= 10) {
			aSeeds -= 2;
		} else if (aSubArea >= 5) {
			aSeeds--;
		}
		if (aSeeds > 40) {
			aSeeds = 40;
		}
		if (!this.app.IsAdventureMode()) {
			aSeeds = 12;
		}
		var theSeedType = Std.int(Math.min(12, aSeeds));
		if (theType >= theSeedType) {
			return false;
		}
		return true;
	}

	public function MakeButton(theImage:ImageInst, theFont:FontInst, theText:String):ImageInst {
		var w = theImage.width;
		var h = theImage.height;
		var aBufferedImage = new ImageInst(new ImageData(new BitmapData(Std.int(w), Std.int(h), true, 0)));
		var bufferG = aBufferedImage.graphics;
		bufferG.drawImage(theImage, 0, 0);

		while (theFont.stringImageWidth(theText) > theImage.width) {
			theFont.scale -= 0.1;
		}
		bufferG.setFont(theFont);
		var offsetX = (theImage.width - theFont.stringImageWidth(theText)) / 2;
		var offsetY = (theImage.height - theFont.getHeight()) / 2;
		bufferG.drawString(theText, offsetX, offsetY);
		return aBufferedImage;
	}

	public function DisplayRepickWarningDialog(theMessage:String) {
		var aDialogHeader = this.app.stringManager.translateString("[DIALOG_WARNING]");
		var aDialogMessage = this.app.stringManager.translateString(theMessage);
		var aDialogOk = this.app.stringManager.translateString("[DIALOG_BUTTON_YES]");

		var aDialogCancel = this.app.stringManager.translateString("[REPICK_BUTTON]");
		this.mDialogBox.resize(255 - 63 * 2, 130 - 36 * 2, 153 + 63 * 2, 184 + 36 * 2);
		this.mDialogBox.InitializeDialogBox(aDialogHeader, aDialogMessage, aDialogOk, aDialogCancel, 2, 2);
		this.mDialogBox.mDialogType = DialogBox.DIALOG_REPICK;
		this.mDialogBox.setVisible(true);
		this.mDialogBox.mOkButton.setVisible(true);
		this.mDialogBox.mCancelButton.setVisible(true);
		this.mLawnViewButton.setDisabled(true);
		this.mStartButton.setDisabled(true);
	}

	public function SeedHitTest(x:Int, y:Int):Int {
		var aChosenSeed:ChosenSeed = null;
		for (i in 0...NUM_SEEDS_IN_CHOOSER) {
			if (this.HasSeedType(i)) {
				aChosenSeed = this.mChosenSeeds[i];
				if (aChosenSeed.mSeedState != SEED_PACKET_HIDDEN) {
					if (x >= aChosenSeed.mX && y >= aChosenSeed.mY && x < aChosenSeed.mX + 46 && y < aChosenSeed.mY + 65) {
						return i;
					}
				}
			}
		}
		return SEED_NONE;
	}

	public function buttonRelease(id:Float) {
		switch (id) {
			case(_ == this.Start_Game => true):
				this.OnStartButton();
			case(_ == this.Lawn_View => true):
				this.CloseSeedChooser();

				this.mChooseState = CHOOSE_VIEW_LAWN;

			default:
		}
	}

	public function GetSeedPositionInBank(theIndex:Int, thePoint:Point) {
		thePoint.x = this.mBoard.mSeedBank.mX + this.mBoard.GetSeedPacketPositionX(theIndex) - this.x;
		thePoint.y = this.mBoard.mSeedBank.mY + 6 - this.y;
	}
}
