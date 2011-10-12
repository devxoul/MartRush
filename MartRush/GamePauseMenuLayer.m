//
//  GamePauseMenuLayer.m
//  MartRush
//
//  Created by omniavinco on 11. 10. 13..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "GamePauseMenuLayer.h"
#import "GameScene.h"


@implementation GamePauseMenuLayer

- (id)init
{
  if (self = [super init]) {
    CCLayerColor *backgroundLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 50)];
    [self addChild:backgroundLayer];
    
    CCSprite *menuBackground = [CCSprite spriteWithFile:@""];
    [self addChild:menuBackground];
    
    CCMenu *menu = [CCMenu menuWithItems:
                    [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Continue" fontName:@"" fontSize:24] block:^(id sender) {
      // Continue
      [self removeFromParentAndCleanup:YES];
    }], [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Mute" fontName:@"" fontSize:24] block:^(id sender) {
      // Mute
    }], [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Restart" fontName:@"" fontSize:24] block:^(id sender) {
      // Restart
      [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipX transitionWithDuration:0.5 scene:[GameScene node]]];
    }], [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"StageSelect" fontName:@"" fontSize:24] block:^(id sender) {
      // StageSelect
      [[CCDirector sharedDirector] popScene];
    }], nil];
    
    [menu alignItemsVertically];
    
    [self addChild:menu];
    
    return self;
  }
  return nil;
}

@end
