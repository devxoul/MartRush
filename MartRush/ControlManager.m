//
//  ControlManager.m
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "ControlManager.h"
#import "GameScene.h"
#import "MovementManager.h"
#import "Merchandise.h"
#import "GameLayer.h"
#import "Player.h"
#import "Cart.h"

@implementation ControlManager

- (ControlManager *)init
{
  if (self = [super init])
  {
    managedList = [[NSMutableArray alloc] initWithCapacity:6];
    touchList = [[NSMutableArray alloc] initWithCapacity:6];
    
    return self;
  }
  
  return nil;
}

- (bool)addMerchandiseToList:(Merchandise *)_object withTouch:(UITouch *)touch
{
  if (touchList.count >= 6)
    return NO;
  
  [managedList addObject:_object];
  [touchList addObject:touch];
  
  [gameScene_.merchandises removeObject:_object];
  
  [_object.merchandiseSpr runAction:[CCScaleTo actionWithDuration:0.3 scale:0.35]];
  
  return YES;
}

- (bool)moveObjectWithTouch:(UITouch *)touch
{
  if ([touchList indexOfObject:touch] == NSNotFound)
    return NO;
  
  Merchandise *merchandise = (Merchandise *)[managedList objectAtIndex:[touchList indexOfObject:touch]];
  
  CCSprite *targetSprite = (CCSprite *)merchandise.merchandiseSpr;
  
  CGPoint targetPoint = [[CCDirector sharedDirector] convertToGL:[touch locationInView: [touch view]]];
  targetPoint.y += targetSprite.boundingBox.size.height / 2;
  
  [targetSprite setPosition:targetPoint];
  
  return YES;
}

- (bool)removeObjectWithTouch:(UITouch *)touch
{
  if ([touchList indexOfObject:touch] == NSNotFound)
    return NO;
  
  Merchandise *merchandise = (Merchandise *)[managedList objectAtIndex:[touchList indexOfObject:touch]];
  
  CCSprite *targetSprite = (CCSprite *)merchandise.merchandiseSpr;
  
  CCAction *action = 0;
  
  CGPoint location = [[CCDirector sharedDirector] convertToGL:[touch locationInView: [touch view]]];
  
  if (CGRectIntersectsRect(gameScene_.gameLayer.player.boundingBox, CGRectMake(location.x - targetSprite.boundingBox.size.width/2, location.y - targetSprite.boundingBox.size.height/2, targetSprite.boundingBox.size.width, targetSprite.boundingBox.size.height)))
  {
    if (gameScene_.stageType == STAGE_TYPE_BOSS) {
      // 보스
      [merchandise.merchandiseSpr removeFromParentAndCleanup:YES];
        [gameScene_.movementManager createObstacle:merchandise.name wayState:gameScene_.gameLayer.player.wayState z:0 speed:-10];
    }
    else
    {
      // 카트에 물건 담기
      action = [CCSequence actions:
                [CCMoveTo actionWithDuration:0.3 position:
                 CGPointMake(
                             gameScene_.gameLayer.player.boundingBox.origin.x + gameScene_.gameLayer.player.boundingBox.size.width / 2,
                             gameScene_.gameLayer.player.boundingBox.origin.y + gameScene_.gameLayer.player.boundingBox.size.height / 2)],
                [CCScaleTo actionWithDuration:0.3 scale:0.1],
                [CCFadeOut actionWithDuration:0.3], [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [node removeFromParentAndCleanup:YES];
      }],nil];
      [gameScene_.gameLayer.player.cart cartItemAdd:merchandise];
    }
  }
  else
  {
    action = [CCSequence actions:[CCFadeOut actionWithDuration:0.3], [CCCallBlockN actionWithBlock:^(CCNode *node) {
      [node removeFromParentAndCleanup:YES];
    }], nil];
  }
  if (action)
    [targetSprite runAction:action];
  
  [managedList removeObject:merchandise];
  [touchList removeObject:touch];
  return YES;
}

- (void)dealloc
{
  [managedList dealloc];
  [touchList dealloc];
  
  [super dealloc];
}

@end
