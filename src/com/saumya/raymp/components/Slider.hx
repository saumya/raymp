
package com.saumya.raymp.components;

import openfl.display.Sprite;

import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.display.Graphics;
import openfl.geom.Point;

import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.text.TextFieldAutoSize;

import openfl.Assets;
import openfl.Lib;

class Slider extends Sprite {

	private var fontHt:UInt;
	private var tValue:TextField;

	private var btnDraggable:Sprite;
	private var btnLineIndicator:Sprite;
	

	public function new(fontHeight:Int=14) {
		super();
		this.fontHt = fontHeight;

		construct();
	}//new
	private function construct():Void{
		
		var font = Assets.getFont ("fonts/OpenSans-Regular.ttf");
		var defaultFormat = new TextFormat (font.fontName, this.fontHt, 0x000000);
		defaultFormat.align = TextFormatAlign.LEFT;
		
		// text
		tValue = new TextField();
		tValue.text = "Value";
		tValue.autoSize = TextFieldAutoSize.LEFT;
		tValue.x = 0;
		tValue.y = 0; // A little upward is actually makes it look in CENTER
		tValue.defaultTextFormat = defaultFormat;
		tValue.embedFonts = true;
		tValue.selectable = false;
		this.addChild(tValue);
		//
		this.btnDraggable = new Sprite();
		this.btnLineIndicator = new Sprite();

		this.addChild(this.btnLineIndicator);
		this.addChild(this.btnDraggable);


		drawBackground();
	}//construct
	private function drawBackground():Void{
		// whole background
		var g:Graphics = this.graphics;
		var c:UInt = 0xFFFFFF;
		g.beginFill(c,1.0);
		g.drawRect(0,0,300,50);
		g.endFill();
		// draw the buttons
		// line
		var g1:Graphics = this.btnLineIndicator.graphics;
		var c1:UInt = 0x666666;
		g1.beginFill(c1,1.0);
		g1.drawRect(0,0,200,2);
		g1.endFill();
		// draggable
		var g2:Graphics = this.btnDraggable.graphics;
		var c2:UInt = 0xCCCCCC;
		g2.beginFill(c2,1.0);
		g2.drawRect(0,0,20,20);
		g2.endFill();
		//
		this.btnLineIndicator.y = 14;
		this.btnDraggable.y = 4;
		this.tValue.y = 30;
		
		this.btnLineIndicator.x = btnDraggable.x = tValue.x = 10;
	}//drawBackground
}