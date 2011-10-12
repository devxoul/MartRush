//
//  ResultScene.m
//  MartRush
//
//  Created by omniavinco on 11. 10. 10..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#define START_POSITION CGPointMake(10, 20)
#define END_POSITION CGPointMake(200, 20)

#import "ResultScene.h"
#import "SimpleAudioEngine.h"

@interface ResultScene(private)
- (void)addMerchandise;
@end


@implementation ResultScene

+(CCScene *)sceneWithMerchandises:(NSArray *)merchandises
{
  CCScene *scene = [CCScene node];
  
  CCLayer *layer = [ResultScene node];
  
  [scene addChild:layer];
  
  return scene;
}

- (CCLayer *)initWithMerchandises:(NSArray *)merchandises
{
  if (self = [super init])
  {
    merchandiseArray = [[NSMutableArray alloc] init];
    gottenMerchandiseArray = [[NSMutableArray alloc] initWithArray:merchandises];
    [self addMerchandise];
    [self schedule:@selector(update)];
  }
  return self;
}

- (void)update:(ccTime)dt
{
  for (NSUInteger i = 0; i < merchandiseArray.count; ++i) { // remove Objects
    // Play Effect
    [[SimpleAudioEngine sharedEngine] playEffect:@""];
    CCSprite *merchandise = [merchandiseArray objectAtIndex:i];
    if (merchandise.opacity == 0) {
      [merchandise removeFromParentAndCleanup:YES];
      [merchandiseArray removeObject:merchandise];
      --i;
      // TODO: add new merchandise animation
      [self addMerchandise];
    }
  }
}

- (void)addMerchandise
{
  CCSprite *sprite = [CCSprite spriteWithFile:@""];
  [sprite setPosition:START_POSITION];
  
  [gottenMerchandiseArray removeObjectAtIndex:0];
  
  // moving animation
  [sprite runAction:
   [CCSequence actions:
    [CCMoveTo actionWithDuration:3.0 position:END_POSITION],
    [CCFadeOut actionWithDuration:0.4],
    nil]];
  
  [self addChild:sprite];
  [merchandiseArray addObject:sprite];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  
}

@end