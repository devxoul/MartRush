//
//  GameOverScene.m
//  MartRush
//
//  Created by omniavinco on 11. 10. 11..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "GameOverScene.h"
#import "SimpleAudioEngine.h"


@implementation GameOverScene

+(CCScene *)scene
{
  CCScene *scene = [CCScene node];
  
  CCLayer *layer = [GameOverScene node];
  
  [scene addChild:layer];
  
  return scene;
}

- (id)init
{
  if ([super init]) {
    [self setIsTouchEnabled:YES];
    // Play BGM
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"" loop:YES];
    
    // Draw background image
    CCSprite *background = [CCSprite spriteWithFile:@""];
    
    [self addChild:background z:0];
  }
  return self;
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  for (UITouch *touch in touches) {
    if (touch) {
      // Touch anywhere... popScene(main?)
      [[CCDirector sharedDirector] popScene];
    }
  }
}
@end
