package com.saumya.components;

import openfl.display.Sprite;
import openfl.display.Graphics;

import openfl.events.Event;
import openfl.events.TouchEvent;
import openfl.events.MouseEvent;

import motion.Actuate;
import motion.easing.Quad;
import motion.easing.Elastic;


class ToggleButton extends Sprite {

	public static var TOGGLE_EVENT:String = "ToggleEvent";

	private var btn:Sprite;
	private var isOn:Bool;

	private var widthX:Float;
	private var heightX:Float;

	public function new() {
		super();
		construct();
	}
	private function construct():Void{
		isOn = false;

		btn = new Sprite();
		this.addEventListener(MouseEvent.CLICK,onClick);
		addChild(btn);

		widthX = 40;
		heightX = 20;
		drawBackground(widthX,heightX);
	}
	private function drawBackground(w:Float,h:Float):Void{
		//var widthX:Float = w + (2*margin);
		var g:Graphics = this.graphics;
		//var c:UInt = Math.round(Math.random()*this.maxColorValue);
		var c1:UInt = 0xFF0000;
		g.beginFill(c1,1.0);
		g.drawRect(0,0,w/2,h);
		g.endFill();

		var c2:UInt = 0x00FF00;
		g.beginFill(c2,1.0);
		g.drawRect(w/2,0,w/2,h);
		g.endFill();

		// draw the button
		var g1:Graphics = this.btn.graphics;
		var c3:UInt = 0xEEEEEE;
		g1.beginFill(c3,1.0);
		g1.drawRect(0,0,w/2,h);
		g1.endFill();
	}//drawBackground
	private function onClick(e:MouseEvent){
		//trace(btn);
		// Change value
		isOn = !isOn;
		// animate
		var newX:Float = 0.0; // (100-4)-(50)
		var newColor:UInt = 0xFFFFFF;
		if (isOn) {
			newX = widthX/2;
			newColor = 0xFFFFFF;
		} else{
			newX = 0;
			newColor = 0xCCCCCC;
		}
		Actuate.tween(this.btn,0.6,{ x:newX }).ease (Quad.easeOut);
		//finally 
		dispatchEvent(new Event(ToggleButton.TOGGLE_EVENT));
	} // onClick
}