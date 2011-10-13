//
//  Setting.m
//  MartRush
//
//  Created by sung-eun Im on 11. 10. 13..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Setting.h"
#import "SimpleAudioEngine.h"
#import "MenuLayer.h"

@implementation Setting

- (id)init
{
  self = [super init];
  if (self) {
    // Initialization code here.
		self.isTouchEnabled = YES;
    
    CCLayer *layer = [CCLayer node];
    layer.anchorPoint = CGPointZero;
		[layer setPosition: ccp(0,0)];
    [self addChild: layer z:-1];
    
    
		//배경
    settingBgSprite = [[CCSprite alloc] initWithFile:@"setting_bg.png"];
    settingBgSprite.anchorPoint = CGPointZero;
		[settingBgSprite setPosition:ccp(0, 0)];
    [self addChild:settingBgSprite z:0];
		//titleBgSprite.position = ccp(s.width/2, s.height/2);
		
    //전체메뉴 
    CCMenuItemImage *menu_tutorial = [CCMenuItemImage itemFromNormalImage:@"menu_01.gif" selectedImage:@"menu_04.gif" target:self selector:@selector(back:)];
    menu_tutorial.anchorPoint = CGPointZero;
    CCMenuItemImage *menu_main = [CCMenuItemImage itemFromNormalImage:@"menu_02.gif" selectedImage:@"menu_03.gif" target:self selector:@selector(back:)];
    menu_main.anchorPoint = CGPointZero;
    CCMenuItemImage *menu_infinity = [CCMenuItemImage itemFromNormalImage:@"menu_03.gif" selectedImage:@"menu_02.gif" target:self selector:@selector(back:)];
    menu_infinity.anchorPoint = CGPointZero;
    CCMenuItemImage *menu_shop = [CCMenuItemImage itemFromNormalImage:@"menu_04.gif" selectedImage:@"menu_01.gif" target:self selector:@selector(back:)];
    menu_shop.anchorPoint = CGPointZero;
    
    CCMenu *menu = [CCMenu menuWithItems:menu_tutorial, menu_main, menu_infinity, menu_shop, nil];
    menu.anchorPoint = CGPointZero;
    [menu setPosition:ccp(0, 0)];
    
    [menu_tutorial setPosition:ccp(24, 115)];
    [menu_main setPosition:ccp(138, 115)];
    [menu_infinity setPosition:ccp(252, 115)];
    [menu_shop setPosition:ccp(366, 115)];
		
    [self addChild: menu];
    
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

+(CCScene*) scene
{
  CCScene *scene = [CCScene node];
  Setting *layer = [Setting node];
  [scene addChild:layer];
  
  return scene;           
}

- (void)back:(id)sender {
  
  [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:1 scene:[MenuLayer scene]]];
  [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];
}

@end
