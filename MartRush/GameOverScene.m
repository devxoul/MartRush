//
//  GameOverScene.m
//  MartRush
//
//  Created by omniavinco on 11. 10. 11..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "GameOverScene.h"
#import "SimpleAudioEngine.h"
#import "UserData.h"

#import "MenuLayer.h"
#import "GameScene.h"
#import "TitleLayer.h"

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
      [[CCDirector sharedDirector] replaceScene:[[[GameScene alloc] init] autorelease]];
    }];
    
    [menuMain setPosition:ccp(170, -60)];
    [menuTry setPosition:ccp(170, -105)];
    
    [self addChild:[CCMenu menuWithItems:menuTry, menuMain, nil]];
    
		return self;
  }
  return nil;
}

-(void)menuItemShop:(id)sender
{
  
}

-(void)dealloc
{
  [super dealloc];
}

@end
