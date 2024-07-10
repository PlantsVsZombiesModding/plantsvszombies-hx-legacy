package mx.core;

interface IRepeaterClient {
	@:flash.property @:isVar var instanceIndices(get, set):Array<ASAny>;
	@:flash.property @:isVar var isDocument(get, never):Bool;
	@:flash.property @:isVar var repeaters(get, set):Array<ASAny>;

	function initializeRepeaterArrays(param1:IRepeaterClient):Void;

	@:flash.property @:isVar var repeaterIndices(get, set):Array<ASAny>;
}
