﻿/*** TagCloud by Grant Skinner. Jul 16, 2008* Visit www.gskinner.com/blog for documentation, updates and more free code.*** Copyright (c) 2011 Grant Skinner* * Permission is hereby granted, free of charge, to any person* obtaining a copy of this software and associated documentation* files (the "Software"), to deal in the Software without* restriction, including without limitation the rights to use,* copy, modify, merge, publish, distribute, sublicense, and/or sell* copies of the Software, and to permit persons to whom the* Software is furnished to do so, subject to the following* conditions:* * The above copyright notice and this permission notice shall be* included in all copies or substantial portions of the Software.* * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES* OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT* HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR* OTHER DEALINGS IN THE SOFTWARE.**/package  {		import flash.display.Sprite;	import flash.text.TextField;	import flash.events.TextEvent;		public class TagCloud extends Sprite {			// Constants:			// Public Properties:		public var minFontSize:Number=9;		public var maxFontSize:Number=36;		public var minCount:Number=0;		public var cloudFld:TextField;			// Private Properties:		protected var _data:Array;			// Initialization:		public function TagCloud() {			cloudFld.addEventListener(TextEvent.LINK, clickTag);		}			// Public getter / setters:		public function set data(value:Array):void {			_data = value.slice();			_data.sortOn("count",Array.NUMERIC|Array.DESCENDING);			buildTagCloud();		}				public function get selected():Array {			var arr:Array = [];			for (var i:int=0; i<_data.length; i++) {				if (_data[i].selected) { arr.push(_data[i]); }			}			return arr;		}			// Public Methods:					// Private Methods:		protected function buildTagCloud():void {			if (!_data) { cloudFld.htmlText = ""; return; }			var arr:Array = _data.slice();			var l:Number = arr.length;			var minValue:Number = Math.max(minCount,arr[l-1].count);			var maxValue:Number = arr[0].count;			var range:Number = maxValue-minValue;						var html:String = "";						for (var i:uint=0;i<l;i++) {				var item:Object = arr[i];				if (item.count < minValue) { break; }				var size:int = Math.round(((item.count-minValue)/range)*(maxFontSize-minFontSize)+minFontSize);				html += "<a href='event:"+i+"	"+item.word+"'><font size='"+size+"' color='#"+((item.selected)?"FF0000":"000000")+"'>"+item.word.split(" ").join("&nbsp;")+"</font></a> ";			}			cloudFld.htmlText = html;		}				protected function clickTag(evt:TextEvent):void {			var keys:Array = evt.text.split("	");			var index:uint = parseInt(keys[0]);			var word:String = keys[1];			for (var i:int=0; i<_data.length; i++) {				if (_data[i].word == word) { _data[i].selected = !Boolean(_data[i].selected); }			}			buildTagCloud();		}			}	}