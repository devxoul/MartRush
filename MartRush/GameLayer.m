//
//  GameLayer.m
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "GameLayer.h"
#import "Merchandise.h"
#import "ControlManager.h"

@implementation GameLayer

@synthesize gameScene;

- (id)init
{
	if( self = [super init] )
	{
		self.isTouchEnabled = YES;
	}
	return self;
}

- (void)update
{
	
}

#pragma mark ControlManager - touch event

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  for (UITouch *touch in touches) {
    if (touch) {
      CGPoint location = [[CCDirector sharedDirector] convertToGL:[touch locationInView: [touch view]]];
     
      for (Merchandise *merchandise in gameScene.merchandises) {
        if (CGRectContainsPoint(merchandise.merchandiseSpr.boundingBox, location)) {
          [gameScene.controlManager addMerchandiseToList:merchandise withTouch:touch];
          [gameScene.merchandises removeObject:merchandise];
          break;
        }
      }
    }
  }
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  for (UITouch *touch in touches) {
    if (touch) {
      [gameScene.controlManager moveObjectWithTouch:touch];
    }
  }
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  for (UITouch *touch in touches) {
    if (touch) {
      [gameScene.controlManager removeObjectWithTouch:touch];
    }
  }
}

- (void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
  for (UITouch *touch in touches) {
    if (touch) {
      [gameScene.controlManager removeObjectWithTouch:touch];
    }
  }
}
@end
