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
      CCSprite *disabledSprite = [CCSprite node];
      [disabledSprite addChild:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png", stageName]] z:0];
      [disabledSprite addChild:[CCLayerColor layerWithColor:ccc4(0, 0, 0, 50)] z:5];
      [disabledSprite addChild:[CCSprite spriteWithFile:@"lock.png"] z:10];
      CCMenuItemSprite *item = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png",
                                                                                                stageName]]
                                                       selectedSprite:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png",
                                                                                                stageName]]
                                                               target:self
                                                             selector:@selector(selectLevel:)];
      if (![[UserData userData] isAvaliableStage:stageName])
        item.normalImage = disabledSprite;
      [menuArray addObject:item];
    }
    
    SlidingMenuGrid* menu = [SlidingMenuGrid menuWithArray:menuArray cols:4 rows:1 position:CGPointMake(240, 160) padding:CGPointMake(20, 0)];
    
    
    [menu setPosition:CGPointMake(240, 160)];
    
    [self addChild:menu z:5];
    
    moneyLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", [UserData userData].money] fontName:@"Nanum Pen Script" fontSize:20];
    
    [moneyLabel setPosition:CGPointMake(400, 280)];
    
    CCMenuItemSprite *shopButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:@"shop.jpg"]
                                                           selectedSprite:[CCSprite spriteWithFile:@"shop.jpg"]
                                                                    block:^(id sender) {
                                                                      [[CCDirector sharedDirector] pushScene:[Shop scene]];
                                                                    }];
    
    [shopButton setPosition:CGPointMake(420, 300)];
    
    CCMenuItemSprite *backButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:@"pause.png"] selectedSprite:[CCSprite spriteWithFile:@"pause.png"] block:^(id sender) {
        [[CCDirector sharedDirector] popScene];
    }];
    
    [backButton setPosition:CGPointMake(50, 300)];
    
    [self addChild:backButton z:10];
    [self addChild:moneyLabel z:10];
    [self addChild:shopButton z:10];
    
    return self;
  }
  
  return nil;
}

- (void)selectLevel:(id)sender
{
  if ([[UserData userData] isAvaliableStage:[stageInfoArray objectAtIndex:[sender tag] - 1]]) {
    [UserData userData].lastPlayedStage = [stageInfoArray objectAtIndex:[sender tag] - 1];
    [[CCDirector sharedDirector] pushScene:[[[GameScene alloc] init] autorelease]];
  }
  else
  {
    // TODO: buyStage?
    
    // Success
    [moneyLabel setString:[NSString stringWithFormat:@"%d", [UserData userData].money]];
    [(CCMenuItem *)sender setIsEnabled:YES];
  }
}

-(void)dealloc
{
  [stageInfoArray dealloc];
  [super dealloc];
}

@end
