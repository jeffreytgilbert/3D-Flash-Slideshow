package classes {

	import flash.display.*;
  	import flash.events.*;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.ByteArray;
	import flash.media.SoundMixer;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.errors.EOFError;
	import flash.utils.Timer;
	import flash.text.*;
	import flash.text.TextField;
	import fl.motion.easing.*;
	import flash.net.*;
	import flash.text.TextFormat;
	import flash.text.TextFieldType ;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.xml.XMLDocument;
	import flash.events.ErrorEvent;
	import flash.display.SimpleButton;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
 	import flash.utils.*;
	import flash.external.*;
	import flash.system.Capabilities;
	import flash.filters.GlowFilter;
	import flash.filters.DropShadowFilter;
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.ColorShortcuts;

	
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// VARS AND MC'S LINKING
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	public class Core extends MovieClip {

    	///--- We create 2 important vars : the background gradient, and the global container ---///
	 	public var bgGradient:MovieClip = new MovieClip();
		public var globalBg:Sprite; 
		
		public var mainMC:main_mc = new main_mc();	// This is the linked name of our mainMC example in the .fla file
	
		public var skyClouds:_clouds = new _clouds();	    // This is the linked name of our clouds MC in the .fla file
		public var bigCloud1:_bigCloud1 = new _bigCloud1();	// This is the linked name of our big cloud #1 in the .fla file
		public var bigCloud2:_bigCloud2 = new _bigCloud2();	// This is the linked name of our big cloud #2 in the .fla file

	public function Core() {
	  	//--- We set all the stage properties with the initStage function ---//
	  	initStage();
    	intro();
  	}
  
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CORE FUNCTIONS
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	

	///--- We set the main properties of our stage like the frameRate, the ScaleMode and a listener for resize ---///
	private function initStage():void {
      	stage.frameRate = 30;
      	stage.showDefaultContextMenu = false;
      	stage.scaleMode = StageScaleMode.NO_SCALE;
      	stage.align = StageAlign.TOP_LEFT;
		stage.addEventListener(Event.RESIZE, onStageResize);
	}	

	public function intro():void {
		addClouds(); // we call the function that will position and display the clouds on screen
		addMC();     // we call the function that will add the mainMC example on screen
		
	}
	
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// GLOBAL CONTAINER ELEMENTS
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	

	///--- Function to add our a color gradient as background ---///
	public function addClouds():void {
		globalBg = new Sprite();  // We first create a sprite and give it a width and height
		globalBg.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);      
		addChild(globalBg);  // we add it to the DisplayList             
		
    	var matrix:Matrix = new Matrix();
    	matrix.createGradientBox(stage.stageWidth,stage.stageHeight, (Math.PI/180)*90, 0, 00);
    	var colors:Array = [ 0xFFFFFF, 0xc6def8];                     // first color from top to bottom
    	var alphas:Array = [ 1.0, 0.7];                               // alpha of the 2 choosen colors
    	var ratios:Array = [ 100, 255];                               // position of the gradient's beginning
    	bgGradient.graphics.beginGradientFill(GradientType.LINEAR,colors, alphas, ratios, matrix);
    	bgGradient.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
    	bgGradient.graphics.endFill();

		globalBg.addChild(bgGradient);   // we're done with the gradient, so we display it too

		// Below we give our 3 clouds MC a x/y position, together with an alpha for better look
		


		skyClouds.x = 0;
		skyClouds.y = stage.stageHeight/3;  
		skyClouds.alpha= 0.8;
		globalBg.addChild(skyClouds);
		skyClouds.addEventListener(Event.ENTER_FRAME, onCloudsEnterFrame); // we will make this one move with actionscript, so we add an enterFrame

		bigCloud1.y = stage.stageHeight-(bigCloud1.height/2);
		bigCloud1.x = -500;  // adjust this to show the cloud elsewhere
		bigCloud1.alpha= 1;
		globalBg.addChild(bigCloud1);
		bigCloud1.addEventListener(Event.ENTER_FRAME, onCloud1EnterFrame); // we will make this one move with actionscript, so we add an enterFrame

		bigCloud2.y = stage.stageHeight-(bigCloud2.height/2);
		bigCloud2.x = stage.stageWidth-200;
		bigCloud2.alpha= 1;
		globalBg.addChild(bigCloud2);
		bigCloud2.addEventListener(Event.ENTER_FRAME, onCloud2EnterFrame); // we will make this one move with actionscript, so we add an enterFrame
		

	}	
	
	// This enterFrame function will make our cloud1 move from left to right with a defined speed that you can modify
	private function onCloud1EnterFrame(event:Event):void {
        bigCloud1.x = bigCloud1.x+0.4; // modidy the speed by adjusting this number
		// We want the cloud to reappear at left if it comes out of screen, we test its x position for that
		trace(bigCloud1.x);
		trace(stage.stageWidth);
		if (bigCloud1.x>=stage.stageWidth) { 
			globalBg.removeChild(bigCloud1);
			globalBg.addChild(bigCloud1);
		    bigCloud1.x = 0 - bigCloud1.width;  
		}
    }
	
	// This enterFrame function will make our cloud2 move from left to right with a defined speed that you can modify
	private function onCloud2EnterFrame(event:Event):void {
        bigCloud2.x = bigCloud2.x+0.3; // modidy the speed by adjusting this number
		// We want the cloud to reappear at left if it comes out of screen, we test its x position for that
		if (bigCloud2.x>=stage.stageWidth) {
			globalBg.removeChild(bigCloud2);
			globalBg.addChild(bigCloud2);
		    bigCloud2.x = 0 - bigCloud2.width;  
		}
    }

	// This enterFrame function will make our cloud2 move from left to right with a defined speed that you can modify
	private function onCloudsEnterFrame(event:Event):void {
        skyClouds.x = skyClouds.x+0.6; // modidy the speed by adjusting this number
		// We want the cloud to reappear at left if it comes out of screen, we test its x position for that
		if (skyClouds.x>=stage.stageWidth) {
			globalBg.removeChild(skyClouds);
			globalBg.addChild(skyClouds);
		    skyClouds.x = 0 - skyClouds.width;  
		}
    }





  ///--- Function to add the main MC at the middle of screen ---///
 	public function addMC():void {
		mainMC.x = (stage.stageWidth/2);                // we position it on the x axe (almost centered)
		mainMC.y = (stage.stageHeight/2);               // we position it on the y axe (almost centered)
		addChild(mainMC);                               // we add it on the the display list
	}

  

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SCREEN RESIZE 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	

  private function onStageResize(event:Event):void 
  {
	  
		bgGradient.width = stage.stageWidth; // we stretch gradient to fit our whole screen
		bgGradient.height = stage.stageHeight;  
		Tweener.addTween(mainMC, {x:stage.stageWidth/2,  time:0.25, transition:"linear"}); // we realign our mainMC to the middle of the screen
		Tweener.addTween(mainMC, {y:stage.stageHeight/2, time:0.25, transition:"linear"}); 		

  }

}
}