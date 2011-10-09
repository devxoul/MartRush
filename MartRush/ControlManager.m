//
//  ControlManager.m
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "ControlManager.h"
#import "Merchandise.h"


@implementation ControlManager

- (ControlManager *)init
{
  if ([super init])
  {
    managedList = [[NSMutableArray alloc] initWithCapacity:6];
    touchList = [[NSMutableArray alloc] initWithCapacity:6];
    
    return self;
  }
  
  return nil;
}

- (ControlManager *)initWithGameScene:(GameScene *)_gameScene andCartSprite:(CCSprite *)_cartSprite
{
  if ([self initWithGameScene:_gameScene])
  {
    cartSprite = _cartSprite;
    
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
  if (![touchList indexOfObject:touch])
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
  //TODO : check the position and run moveaction to cart or just fadeout
  if (![touchList indexOfObject:touch])
    return NO;
  
  Merchandise *merchandise = (Merchandise *)[managedList objectAtIndex:[touchList indexOfObject:touch]];
  
  CCSprite *targetSprite = (CCSprite *)merchandise.merchandiseSpr;

  CCAction *action;
  
  CGPoint location = [[CCDirector sharedDirector] convertToGL:[touch locationInView: [touch view]]];
  
  if (CGRectContainsPoint(cartSprite.boundingBox, location))
  {
    action = [CCSequence actions:[CCFadeOut actionWithDuration:0.3], [CCMoveTo actionWithDuration:0.3 position:CGPointMake(cartSprite.position.x + cartSprite.boundingBox.size.width / 2, cartSprite.position.y + cartSprite.boundingBox.size.height / 2)], [CCScaleTo actionWithDuration:0.3 scale:0.1], nil];
  }
  else
  {
    action = [CCFadeOut actionWithDuration:0.3];
  }
  
  [targetSprite runAction:action];
  
  [managedList removeObject:merchandise];
  [touchList removeObject:touch];
  return YES;
}

@end
