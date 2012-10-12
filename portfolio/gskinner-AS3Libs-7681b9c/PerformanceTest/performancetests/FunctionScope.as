﻿/*** PerformanceTest by Grant Skinner. Apr 21, 2009* Visit www.gskinner.com/blog for documentation, updates and more free code.*** Copyright (c) 2009 Grant Skinner* * Permission is hereby granted, free of charge, to any person* obtaining a copy of this software and associated documentation* files (the "Software"), to deal in the Software without* restriction, including without limitation the rights to use,* copy, modify, merge, publish, distribute, sublicense, and/or sell* copies of the Software, and to permit persons to whom the* Software is furnished to do so, subject to the following* conditions:* * The above copyright notice and this permission notice shall be* included in all copies or substantial portions of the Software.* * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES* OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT* HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR* OTHER DEALINGS IN THE SOFTWARE.**/package performancetests {		import performancetests.FunctionScopeTest;		public class FunctionScope {			// Constants:			// Public Properties:		// optional property specifying the default number of iterations to run each test in the suite.		public var iterations:uint=2;		// optional property specifying a description to be used when reporting on this test suite:		public var description:String = "Tests the impact of variable scope on access time."		public var methods:Array = ["tare","instanceTest","staticTest"];		public var methodLabels:Array = ["", "instance", "static"]; 				// the number of loops to run in every test:		public var loops:uint = 100000;												// Protected Properties:				// set up some variables used in the test:		protected var staticRef:Object;		protected var instanceRef:Object;			// Initialization:		public function FunctionScope() {			staticRef = FunctionScopeTest;			instanceRef = new FunctionScopeTest();		}			// Public getter / setters:			// Public Methods:		// tare method that will be run to calculate the base time required to run the loop		// so it can be subtracted from the other test results.		public function tare():void {			for (var i:uint=0; i<loops; i++) {				var c:Number = i+i;			}		}				public function instanceTest():void {			for (var i:uint=0; i<loops; i++) {				var c:Number = instanceRef.instanceTest(i,i);			}		}			public function staticTest():void {			for (var i:uint=0; i<loops; i++) {				var c:Number = staticRef.staticTest(i,i);			}		}					// Protected Methods:			}	}