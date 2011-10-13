//
//  MenuLayer.m
//  MartRush
//
//  Created by sung-eun Im on 11. 10. 13..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "MenuLayer.h"

#import "SimpleAudioEngine.h"
#import "StageSelectScene.h"
#import "Shop.h"
#import "GameScene.h"
#import "TutorialLayer.h"
#import "InfoLayer.h"

@implementation MenuLayer

- (id)init
{
  self = [super init];
  if (self) {
    // Initialization code here.
    self.isTouchEnabled = YES;
    
    //메뉴배경
    menuBgSprite = [[CCSprite alloc] initWithFile:@"menu_bg.png"];
    menuBgSprite.anchorPoint = CGPointZero;
		[menuBgSprite setPosition:ccp(0, 0)];
    [self addChild:menuBgSprite z:0];
    
    //전체메뉴 
    //튜토리얼 이동
    mainmenu[0] = [CCMenuItemImage itemFromNormalImage:@"menu_01.gif" selectedImage:@"menu_04.gif" target:self 
                                              selector:@selector(moveTutorial:)];
    
    // 스테이지 이동
    mainmenu[1] = [CCMenuItemImage itemFromNormalImage:@"menu_02.gif" selectedImage:@"menu_03.gif" target:self 
                                              selector:@selector(moveStage:)];
    
    // 무한모드 
    mainmenu[2] = [CCMenuItemImage itemFromNormalImage:@"menu_03.gif" selectedImage:@"menu_02.gif" target:self 
                                              selector:@selector(moveStage:)];
    
    // shops
    mainmenu[3] = [CCMenuItemImage itemFromNormalImage:@"menu_04.gif" selectedImage:@"menu_01.gif" target:self 
                                              selector:@selector(moveShop:)];
    
    
    for (int i = 0; i < 4; i++) {
      mainmenu[i].anchorPoint = CGPointZero;
    }
    
    [mainmenu[0] setPosition:ccp(24, 150)];
    [mainmenu[1] setPosition:ccp(138, 150)];
    [mainmenu[2] setPosition:ccp(252, 150)];
    [mainmenu[3] setPosition:ccp(366, 150)];
    
    
    CCMenu *menu = [CCMenu menuWithItems:mainmenu[0], mainmenu[1], mainmenu[2], mainmenu[3], nil];
    
    menu.anchorPoint = CGPointZero;
    [menu setPosition:ccp(0, 0)];
		
    [self addChild: menu z:1];
    
    mainmenuLb[0] = [CCLabelTTF labelWithString:@"Tutorial" fontName:@"sheepsansbold.ttf" fontSize:24];
    mainmenuLb[1] = [CCLabelTTF labelWithString:@"Stage" fontName:@"sheepsansbold.ttf" fontSize:24];
    mainmenuLb[2] = [CCLabelTTF labelWithString:@"Infinite" fontName:@"sheepsansbold.ttf" fontSize:24];
    mainmenuLb[3] = [CCLabelTTF labelWithString:@"Shop" fontName:@"sheepsansbold.ttf" fontSize:24];
    
    for (int i = 0; i < 4; i++) {
      mainmenuLb[i].color = ccBLACK;
      [mainmenuLb[i] setAnchorPoint:ccp(0.0f, 0.0f)];
      mainmenuLb[i].position = mainmenu[i].position;
      
      [self addChild:mainmenuLb[i] z:2];
    } 
    
    
    //설정
    menu_setting = [CCMenuItemImage itemFromNormalImage:@"setting.jpg" selectedImage:@"setting.jpg" target:self selector:@selector(moveSetting:)];
    menu_setting.anchorPoint = CGPointZero;
    
    settingMenu = [CCMenu menuWithItems:menu_setting, nil];
    settingMenu.anchorPoint = CGPointZero;
    [settingMenu setPosition:ccp(420, 260)];
    
    [self addChild:settingMenu];
    
    //화살표, 눌렀을 때 화살표 
    arrowRSprite = [[CCSprite alloc] initWithFile:@"arrowR.jpg"];
    arrowRSprite.anchorPoint = CGPointZero;
    [arrowRSprite setPosition:ccp(10, 10)];
    
    arrowRPressedSprite = [[CCSprite alloc] initWithFile:@"arrowR_on.jpg"];
    arrowRPressedSprite.anchorPoint = CGPointZero;
    arrowRPressedSprite.position = arrowRSprite.position;
    
    arrowLSprite = [[CCSprite alloc] initWithFile:@"arrowL.jpg"];
    arrowLSprite.anchorPoint = CGPointZero;
    [arrowLSprite setPosition:ccp(10, 10)];
    
    arrowLPressedSprite = [[CCSprite alloc] initWithFile:@"arrowL_on.jpg"];
    arrowLPressedSprite.anchorPoint = CGPointZero;
    arrowLPressedSprite.position = arrowLSprite.position;
    
    //화살표
    arrow = [CCMenuItemImage itemFromNormalImage:@"arrowR.jpg" selectedImage:@"arrowR_on.jpg" target:self selector:@selector(onArrowTouch:)];
    arrow.anchorPoint = CGPointZero;
    
    arrowMenu = [CCMenu menuWithItems:arrow, nil];
    arrowMenu.anchorPoint = CGPointZero;
    arrowMenu.position = ccp(10, 10);
    
    [self addChild:arrowMenu];
    
    //화살표 열면 생길 메뉴 아이템 
    menu_facebook = [CCMenuItemImage itemFromNormalImage:@"facebook.png" selectedImage:@"info.png" target:self 
                                                selector:@selector(moveFacebook:)];
    menu_facebook.anchorPoint = CGPointZero;
    
    menu_ranking = [CCMenuItemImage itemFromNormalImage:@"ranking.jpg" selectedImage:@"facebook.png" target:self 
                                               selector:@selector(moveRank:)];
    menu_ranking.anchorPoint = CGPointZero;
    
    menu_info = [CCMenuItemImage itemFromNormalImage:@"info.png" selectedImage:@"ranking.jpg" target:self 
                                            selector:@selector(moveInfo:)];
    menu_info.anchorPoint = CGPointZero;
    
    [menu_facebook setPosition:ccp(65, 10)];
    [menu_ranking setPosition:ccp(120, 10)];
    [menu_info setPosition:ccp(175, 10)];
    
    menu_more = [CCMenu menuWithItems:menu_facebook, menu_ranking, menu_info, nil];
    menu_more.anchorPoint = CGPointZero;
    [menu_more setPosition:ccp(0, 0)];
    
    [self addChild:menu_more];
    menu_more.visible = NO;
    
  }
  
  return self;
}

+(CCScene*)scene
{
  CCScene *scene = [CCScene node];
  MenuLayer *layer = [MenuLayer node];
  [scene addChild:layer];
  
  return scene;    
}

-(void)moveStage:(id)sender
{
  [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:1 scene:[StageSelectScene scene]]];    
}

-(void)moveTutorial:(id)sender
{
  [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:0.3 scene:[TutorialLayer scene]]];    
}

-(void)moveInfinite:(id)sender
{
  [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:0.3 scene:[GameScene node]]];        
}

-(void)moveSetting:(id)sender{
  
  [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:1 scene:[Setting scene]]];
  [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];
  
}

-(void)moveShop:(id)sender
{    
  [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:1 scene:[Shop scene]]];
  [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];
}

-(void)moveFacebook:(id)sender
{
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.facebook.com/profile.php?id=100002194178648"]];
}

-(void)moveRank:(id)sender
{
  
}

-(void)moveInfo:(id)sender
{
  [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:1 scene:[InfoLayer scene]]];        
}


-(void)onArrowTouch:(id)sender {
  
  if( !menu_more.visible ) 
    [self openArrow];
  else [self closeArrow];
}

-(void)openArrow {
  
  arrow.normalImage = arrowLSprite;
  arrow.selectedImage = arrowLPressedSprite;
  
  menu_more.visible = YES;
  [menu_more runAction:[CCEaseInOut actionWithAction:[CCMoveTo actionWithDuration:1 position:ccp(0, 0)] rate:2.0]];
}

-(void)closeArrow {
  
  arrow.normalImage = arrowRSprite;
  arrow.selectedImage = arrowRPressedSprite;
  
  CCEaseInOut *action = [CCEaseInOut actionWithAction:[CCMoveTo actionWithDuration:1 position:ccp(0, 0)] rate:2.0];
  CCCallFunc *func = [CCCallFunc actionWithTarget:self selector:@selector(onMenuMoreActionFinished:)];
  CCSequence *sequence = [CCSequence actions:action, func, nil];
  [menu_more runAction:sequence];
}

- (void)onMenuMoreActionFinished:(id)sender
{
  menu_more.visible = NO;
}


@end
