//
//  GameOverScene.m
//  MartRush
//
//  Created by omniavinco on 11. 10. 11..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "GameOverScene.h"

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
  if (self = [super init]) {
    [self setIsTouchEnabled:YES];
    // Play BGM
//    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"" loop:YES];
    
    // Draw background image
    CCSprite *background = [CCSprite spriteWithFile:@"GameOver_bg.png"];
    background.position = ccp(240, 0);
    background.anchorPoint = ccp(0.5f, 0.0f);
      
    [self addChild:background z:0];
      
    CCMenuItemImage *menuMain = [CCMenuItemImage itemFromNormalImage:@"GameOver_Btn_normal_Main.png" selectedImage:@"GameOver_Btn_Main_click.png" block:^(id sender){
          [[CCDirector sharedDirector] popScene];
    }];

    CCMenuItemImage *menuTry = [CCMenuItemImage itemFromNormalImage:@"GameOver_Btn_normal_Retry.png" selectedImage:@"GameOver_Btn_Retry_click.png" block:^(id sender) {
      [[CCDirector sharedDirector] replaceScene:[[[GameScene alloc] initWithMissionName:@"fruit_1"] autorelease]];
    }];

    [menuMain setPosition:ccp(170, -60)];
    [menuTry setPosition:ccp(170, -105)];
 
    [self addChild:[CCMenu menuWithItems:menuTry, menuMain, nil]];

		return self;
  }
  return nil;
}

<<<<<<< HEAD
-(void)menuItemTry:(id)sender
{
//    [[CCDirector sharedDirector] replaceScene:[GameScene node]];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:0.3 scene:[GameScene node]]];
}

-(void)menuItemMain:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:0.3 scene:[MenuLayer scene]]];
}

=======
>>>>>>> e5a8509388a95bc04e031f847b9b69a6cce00342
-(void)menuItemShop:(id)sender
{
    
}

-(void)dealloc
{
    [super dealloc];
}

@end
