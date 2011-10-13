//
//  Shop.m
//  MartRush
//
//  Created by sung-eun Im on 11. 10. 13..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Shop.h"
#import "SimpleAudioEngine.h"
#import "MenuLayer.h"

@implementation Shop

- (id)init
{
  self = [super init];
  if (self) {
    // Initialization code here.		self.isTouchEnabled = YES;
    
    winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayer *layer = [CCLayer node];
    layer = [CCLayer node];
    layer.anchorPoint = CGPointZero;
		[layer setPosition: ccp(0,0)];
    [self addChild: layer z:-1];
    
    //배경
    shopBgSprite = [[CCSprite alloc] initWithFile:@"shop_bg.jpg"];
    shopBgSprite.anchorPoint = CGPointZero;
		[shopBgSprite setPosition:ccp(0, 0)];
    [self addChild:shopBgSprite z:0];
		//titleBgSprite.position = ccp(s.width/2, s.height/2);
    
    //탭배경 
    tab1BgSprite = [[CCSprite alloc] initWithFile:@"tab1_bg.jpg"];
    tab1BgSprite.anchorPoint = CGPointZero;
    [tab1BgSprite setPosition:ccp(60, 20)];
    [self addChild:tab1BgSprite z:3];
    
    tab2BgSprite = [[CCSprite alloc] initWithFile:@"tab2_bg.jpg"];
    tab2BgSprite.anchorPoint = CGPointZero;
    tab2BgSprite.position = tab1BgSprite.position;
    //[arrowRPressedSprite setPosition:ccp(10, 10)];
    [self addChild:tab2BgSprite z:2];
    
    
    //탭버튼
    tab1 = [CCMenuItemImage itemFromNormalImage:@"tab1.png" selectedImage:@"tab2.png" target:self selector:@selector(tab1Clicked:)];
    tab1.anchorPoint = CGPointZero;
    [tab1 setPosition:ccp(20, 170)];
    
    tab2 = [CCMenuItemImage itemFromNormalImage:@"tab2.png" selectedImage:@"tab1.png" target:self selector:@selector(tab2Clicked:)];
    tab2.anchorPoint = CGPointZero;
    [tab2 setPosition:ccp(20, 20)];
    
    tabMenu = [CCMenu menuWithItems:tab1, tab2, nil];
    tabMenu.anchorPoint = CGPointZero;
    tabMenu.position = ccp(0, 0);
    [self addChild:tabMenu];
    
    //유저인포 
    userInfoBgSprite = [[CCSprite alloc] initWithFile:@"userinfo_bg.png"];
    userInfoBgSprite.anchorPoint = CGPointZero;
    [userInfoBgSprite setPosition:ccp(380, 20)];
    [self addChild:userInfoBgSprite];
    
    //뒤로가기 
    menu_back = [CCMenuItemImage itemFromNormalImage:@"back_button.png" selectedImage:@"back_button.png" target:self selector:@selector(back:)];
    menu_back.anchorPoint = CGPointZero;
    
    backMenu = [CCMenu menuWithItems:menu_back, nil];
    backMenu.anchorPoint = CGPointZero;
    [backMenu setPosition:ccp(10, 260)];
    
    [self addChild:backMenu];
    
  }
  
  return self;
}

+(CCScene*)scene
{
  CCScene *scene = [CCScene node];
  Shop *layer = [Shop node];
  [scene addChild:layer];
  
  return scene;       
}

-(void)onTabTouch:(id)sender{
  
}

-(void)tab1Clicked:(id)sender{
  
  tab1BgSprite.visible = YES;
}

-(void)tab2Clicked:(id)sender{
  
  tab1BgSprite.visible = NO;
  NSLog(@"뒤에 배경화면 뿅");
  
}

- (void)back:(id)sender {
  
  [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1 scene:[MenuLayer scene]]];
  [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];
}

@end
