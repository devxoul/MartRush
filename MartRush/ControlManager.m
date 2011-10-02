//
//  ControlManager.m
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "ControlManager.h"


@implementation ControlManager

- (ControlManager *)initWithCartSprite:(CCSprite *)_cartSprite;
{
  managedList = [[NSMutableArray alloc] initWithCapacity:6];
  cartSprite = _cartSprite;
  
  return self;
}

- (void)addObjectToList:(CCSprite *)_object
{
  [managedList addObject:_object];
}

- (void)moveObjectWithIndex:(NSUInteger)index ToPosition:(CGPoint)position
{
  if (index > managedList.count)
    return;
  
  //TODO :
  CCSprite *targetSprite = [managedList objectAtIndex:index];
  CCAction *action = [CCMoveTo actionWithDuration:0.1 position:position];
  [targetSprite runAction:action];

}

- (void)removeObjectFromList:(NSUInteger)index
{
  //TODO : check the position and run moveaction to cart or just fadeout
  CCSprite *targetSprite = [managedList objectAtIndex:index];
  CCAction *action = [CCFadeOut actionWithDuration:0.3];
  [targetSprite runAction:action];
  [managedList removeObject:targetSprite];
}

@end
