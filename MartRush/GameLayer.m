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
#import "Player.h"
#import "Boss.h"
#import "GameScene.h"

@implementation GameLayer

@synthesize gameScene, player, boss;

- (id)init
{
	if( self = [super init] )
	{
		CCSprite *bg = [CCSprite spriteWithFile:@"game_bg.png"];
		bg.anchorPoint = ccp( 0, 0 );
		[self addChild:bg];
		
		player = [[Player alloc] initWithGameLayer:self];
    
    boss = [Boss alloc];
    [boss init:self];
    
    self.isTouchEnabled = YES;
    
    return self;
	}
	return nil;
}

- (void)update
{
	[player update];
  [boss update];
  
  if (player.state == PLAYER_STATE_DEAD)
  {
    gameScene.gameState = GAME_STATE_OVER;
  }
}

-(Cart*) getCartpointer
{
  return player.cart;
}

-(void)dealloc
{
  [player dealloc];
  [boss dealloc];
  
  [super dealloc];
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
      if (![gameScene.controlManager removeObjectWithTouch:touch])
      {
        CGPoint location = [[CCDirector sharedDirector] convertToGL:[touch locationInView: [touch view]]];
        if (location.y >= 0 && location.y <= 150)
        {
          if ((location.x > ((location.y * 9 / 17) + 20)) && (location.x < 240))
          {
            player.wayState = LEFT_WAY;
          }
          else if((location.x < ((-9 * location.y / 17 + 480) - 20)) && (location.x > 240))
          {
            player.wayState = RIGHT_WAY;
          }
        }
      }
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
