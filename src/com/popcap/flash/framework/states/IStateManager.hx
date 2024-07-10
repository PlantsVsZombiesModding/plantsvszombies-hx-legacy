package com.popcap.flash.framework.states;

import com.popcap.flash.framework.graphics.Graphics2D;

interface IStateManager {
	function popState():Void;

	function changeState(param1:String):Void;

	function draw(param1:Graphics2D):Void;

	function pushState(param1:String):Void;

	function update():Void;

	function bindState(param1:String, param2:IState):Void;
}
