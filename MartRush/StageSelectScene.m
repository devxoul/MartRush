//
//  StageSelectScene.m
//  MartRush
//
//  Created by omniavinco on 11. 10. 13..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "StageSelectScene.h"
#import "GameScene.h"
#import "UserData.h"
#import "SlidingMenuGrid.h"
#import "Shop.h"
#import "SimpleAudioEngine.h"

@implementation StageSelectScene

+ (CCScene *)scene
{
  CCScene *scene = [CCScene node];
  
  [scene addChild:[StageSelectScene node]];
  
  return scene;
}

- (id)init
{
  if (self = [super init]) {
    CCSprite *background = [CCSprite spriteWithFile:@"stage_bg.png"];
    [background setPosition:CGPointMake(240, 160)];
    [self addChild:background];
    
    stageInfoArray = [[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StageList" ofType:@"plist"]] allKeys] retain];
    
    NSMutableArray *menuArray = [NSMutableArray array];
    for (NSString *stageName in stageInfoArray) {
      /*
      CCLabelTTF *label;
      CCSprite *disabledSprite = [CCSprite node];
      [disabledSprite addChild:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png", stageName]] z:0];
      label = [CCLabelTTF labelWithString:stageName fontName:@"NanumScript.ttf" fontSize:20];
      [label setColor:ccc3(0, 0, 0)];
      [disabledSprite addChild:label z:10];
      
      CCSprite *selected = [CCSprite node];
      label = [CCLabelTTF labelWithString:stageName fontName:@"NanumScript.ttf" fontSize:20];
      [label setColor:ccc3(0, 0, 0)];
      [selected addChild:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png", stageName]] z:0];
      [selected addChild:label z:10];
      */
      CCMenuItemSprite *item = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png", stageName]]
                                                       selectedSprite:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png", stageName]]
                                                               target:self
                                                             selector:@selector(selectLevel:)];
      [menuArray addObject:item];
    }
    
    SlidingMenuGrid* menu = [SlidingMenuGrid menuWithArray:menuArray cols:4 rows:1 position:CGPointMake(90, 160) padding:CGPointMake(100, 0)];
    
    [self addChild:menu z:5];
    
    moneyLabel = [[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", [UserData userData].money] fontName:@"NanumScript.ttf" fontSize:40] retain];
    
    [self addChild:moneyLabel z:20];
    
    [moneyLabel setColor:ccc3(0, 0, 0)];
    
    [moneyLabel setPosition:CGPointMake(400, 280)];
    
    CCMenu *shopButton = [CCMenu menuWithItems:[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:@"shop.jpg"]
                                                           selectedSprite:[CCSprite spriteWithFile:@"shop.jpg"]
                                                                    block:^(id sender) {
                                                                      [[CCDirector sharedDirector] pushScene:[Shop scene]];
                                                                    }], nil];
    
    [self addChild:shopButton z:20];
    
    [shopButton setPosition:CGPointMake(400, 300)];
    
    CCMenu *backButton = [CCMenu menuWithItems:[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:@"pause.png"] selectedSprite:[CCSprite spriteWithFile:@"pause.png"] block:^(id sender) {
        [[CCDirector sharedDirector] popScene];
    }], nil];
    
    [backButton setPosition:CGPointMake(25, 300)];
    
    [self addChild:backButton z:20];
        
    return self;
  }
  
  return nil;
}

- (void)selectLevel:(id)sender
{
  if ([[UserData userData] isAvaliableStage:[stageInfoArray objectAtIndex:[sender tag] - 1]]) {
    [UserData userData].lastPlayedStage = [stageInfoArray objectAtIndex:[sender tag] - 1];
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];
    [[CCDirector sharedDirector] pushScene:[[[GameScene alloc] init] autorelease]];
  }
  else
  {
    // TODO: buyStage?
    
    if ([[UserData userData] buyStage:[stageInfoArray objectAtIndex:[sender tag] - 1]]) {
      // Success
      [[SimpleAudioEngine sharedEngine] playEffect:@"unlock.mp3"];
      [moneyLabel setString:[NSString stringWithFormat:@"%d", [UserData userData].money]];
      [(CCMenuItem *)sender setIsEnabled:YES];
    }
    
  }
}

-(void)dealloc
{
  [stageInfoArray dealloc];
  [super dealloc];
}

@end
