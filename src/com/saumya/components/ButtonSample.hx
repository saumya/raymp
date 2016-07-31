
package com.saumya.components;

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

class ButtonSample extends Sprite {

	private var maxColorValue:UInt;
	private var buttonLabel:String;
	private var fontHeight:UInt;
	private var horizontalMargin:UInt;

	public function new(name:String="Saumya",h:Int=20) {
		super();
		this.maxColorValue = 256*256*256;
		this.buttonLabel = name;
		this.fontHeight = h;
		this.horizontalMargin = Math.round(this.fontHeight/10) ;
		
		construct();
	}//new
	private function construct():Void{
		
		var font = Assets.getFont ("fonts/OpenSans-Regular.ttf");
		//var font = Assets.getFont ("fonts/Archistico_Simple.ttf");
		
		//var font = Assets.getFont ("fonts/Quicksand-Light.otf");

		var defaultFormat = new TextFormat (font.fontName, this.fontHeight, 0x000000);
		
		//var defaultFormat = new TextFormat();
		//defaultFormat.color = 0x000000;
		defaultFormat.align = TextFormatAlign.LEFT;
		
		// text
		var t:TextField = new TextField();
		t.text = this.buttonLabel;
		t.autoSize = TextFieldAutoSize.LEFT;
		t.x = 0+this.horizontalMargin;
		t.y = -(this.fontHeight/10); // A little upward is actually makes it look in CENTER
		t.defaultTextFormat = defaultFormat;
		t.embedFonts = true;
		t.selectable = false;
		this.drawBackground(t.width,t.height,this.horizontalMargin);
		this.addChild(t);
	}//construct
	private function drawBackground(w:Float,h:Float,margin:Float):Void{
		var widthX:Float = w + (2*margin);
		var g:Graphics = this.graphics;
		var c:UInt = Math.round(Math.random()*this.maxColorValue);
		g.beginFill(c,1.0);
		g.drawRect(0,0,widthX,h);
		g.endFill();
	}//drawBackground
}