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
    CCSprite *background = [CCSprite spriteWithFile:@""];
    [background setPosition:CGPointMake(240, 160)];
    [self addChild:background];
    
    stageInfoArray = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StageList" ofType:@"plist"]] allKeys];
    
    NSMutableArray *menuArray = [NSMutableArray array];
    for (NSString *stageName in stageInfoArray) {
      CCSprite *disabledSprite = [CCSprite node];
      [disabledSprite addChild:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png"]] z:0];
      [disabledSprite addChild:[CCLayerColor layerWithColor:ccc4(0, 0, 0, 50)] z:5];
      [disabledSprite addChild:[CCSprite spriteWithFile:@""] z:10];
      CCMenuItemSprite *item = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png"]]
                                                      selectedSprite:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png"]]
                                                      disabledSprite:disabledSprite
                                                               target:self selector:@selector(selectLevel:)];
      item.tag = [stageInfoArray indexOfObject:stageName];
      item.isEnabled = [[UserData userData] isAvaliableStage:stageName];
      [menuArray addObject:item];
    }
    
    SlidingMenuGrid* menu = [SlidingMenuGrid menuWithArray:menuArray cols:4 rows:1 position:CGPointMake(240, 160) padding:CGPointMake(20, 0)];
    
    [menu setPosition:CGPointMake(240, 160)];
    
    [self addChild:menu];
    
    moneyLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", [UserData userData].money] fontName:@"Nanum Pen Script" fontSize:20];
    
    [moneyLabel setPosition:CGPointMake(400, 280)];
    
    CCMenuItemSprite *shopButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:@""]
                                                     selectedSprite:[CCSprite spriteWithFile:@""]
                                                              block:^(id sender) {
                                                                // TODO: push shop
                                                              }];
    
    [shopButton setPosition:CGPointMake(420, 300)];
    
    [self addChild:moneyLabel z:10];
    [self addChild:shopButton z:10];
    
    return self;
  }
  
  return nil;
}

- (void)selectLevel:(id)sender
{
  if ([(CCMenuItem *)sender isEnabled]) {
    [UserData userData].lastPlayedStage = [stageInfoArray objectAtIndex:[sender tag]];
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
