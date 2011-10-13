//
//  GamePauseMenuLayer.m
//  MartRush
//
//  Created by omniavinco on 11. 10. 13..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "GamePauseMenuLayer.h"
#import "Const.h"
#import "GameScene.h"
#import "UserData.h"


@implementation GamePauseMenuLayer

+ (CCLayer *)layerWithStage:(GameScene *)gameScene
{
  return [[[GamePauseMenuLayer alloc] initWithStage:gameScene] autorelease];
}

- (id)initWithStage:(GameScene *)gameScene_
{
  if (self = [super init]) {
    gameScene = gameScene_;
    
    CCLayerColor *backgroundLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 50)];
    [self addChild:backgroundLayer];
    
    CCSprite *menuBackground = [CCSprite spriteWithFile:@""];
    [self addChild:menuBackground];
    
    CCMenu *menu = [CCMenu menuWithItems:
                    [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:[UserData userData].lastPlayedStage fontName:@"Nanum Pen Script" fontSize:24]],
                    [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Continue" fontName:@"Nanum Pen Script" fontSize:24] block:^(id sender) {
      // Continue
      [self removeFromParentAndCleanup:YES];
      gameScene.gameState = GAME_STATE_START;
      [gameScene.gameLayer setIsTouchEnabled:YES];
    }], [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Mute" fontName:@"Nanum Pen Script" fontSize:24] block:^(id sender) {
      // Mute
    }], [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Restart" fontName:@"Nanum Pen Script" fontSize:24] block:^(id sender) {
      // Restart
      [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipX transitionWithDuration:0.5 scene:[[[GameScene alloc] init] autorelease]]];
    }], [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"StageSelect" fontName:@"Nanum Pen Script" fontSize:24] block:^(id sender) {
      // StageSelect
      [[CCDirector sharedDirector] popScene];
    }], nil];
    
    [menu alignItemsVertically];
    [menu setPosition:CGPointMake(240, 160)];
    
    [self addChild:menu];
    
    return self;
  }
  return nil;
}

-(void)dealloc
{
  [super dealloc];
}
@end
