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

@synthesize gameScene, player;

- (id)init
{
	if( self = [super init] )
	{
#ifdef MARTRUSH_BOC_EDIT        
		player = [Player alloc];
        [player init:self];
        
        boss = [Boss alloc];
        [boss init:self:MARTRUSH_STAGE_1];

        self.isTouchEnabled = YES;
#endif
        
	}
	return self;
}

- (void)update
{
#ifdef MARTRUSH_BOC_EDIT
	[player update];
    [boss update];
#endif

#ifdef MARTRUSH_HAN_EDIT
    [boss setBossState:BOSS_STATE_CRASH];

#endif
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
