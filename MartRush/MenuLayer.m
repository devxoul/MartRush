//
//  MenuLayer.m
//  MartRush
//
//  Created by sung-eun Im on 11. 10. 13..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "MenuLayer.h"

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
        CCMenuItemImage *menu_tutorial = [CCMenuItemImage itemFromNormalImage:@"menu_01.gif" selectedImage:@"menu_04.gif" target:self selector:@selector(moveStageScene:)];
        menu_tutorial.anchorPoint = CGPointZero;
        
        // 스테이지 이동
        CCMenuItemImage *menu_stage = [CCMenuItemImage itemFromNormalImage:@"menu_02.gif" selectedImage:@"menu_03.gif" target:self selector:@selector(moveStageScene:)];
        menu_stage.anchorPoint = CGPointZero;
        
        // 무한모드 
        CCMenuItemImage *menu_infinity = [CCMenuItemImage itemFromNormalImage:@"menu_03.gif" selectedImage:@"menu_02.gif" target:self selector:@selector(moveStageScene:)];
        menu_infinity.anchorPoint = CGPointZero;
        
        // shop
        CCMenuItemImage *menu_shop = [CCMenuItemImage itemFromNormalImage:@"menu_04.gif" selectedImage:@"menu_01.gif" target:self selector:@selector(shop:)];
        menu_shop.anchorPoint = CGPointZero;
        
        CCMenu *menu = [CCMenu menuWithItems:menu_tutorial, menu_stage, menu_infinity, menu_shop, nil];
        menu.anchorPoint = CGPointZero;
        [menu setPosition:ccp(0, 0)];
        
        [menu_tutorial setPosition:ccp(24, 150)];
        [menu_stage setPosition:ccp(138, 150)];
        [menu_infinity setPosition:ccp(252, 150)];
        [menu_shop setPosition:ccp(366, 150)];
		
        [self addChild: menu z:1];
        
        //설정
        menu_setting = [CCMenuItemImage itemFromNormalImage:@"setting.jpg" selectedImage:@"setting.jpg" target:self selector:@selector(setting:)];
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
        menu_facebook = [CCMenuItemImage itemFromNormalImage:@"facebook.png" selectedImage:@"info.png" target:self selector:@selector(moveStageScene:)];
        menu_facebook.anchorPoint = CGPointZero;
        menu_ranking = [CCMenuItemImage itemFromNormalImage:@"ranking.jpg" selectedImage:@"facebook.png" target:self selector:@selector(moveStageScene:)];
        menu_ranking.anchorPoint = CGPointZero;
        menu_info = [CCMenuItemImage itemFromNormalImage:@"info.png" selectedImage:@"ranking.jpg" target:self selector:@selector(moveStageScene:)];
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

-(void)moveStageScene:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1 scene:[StageSelectLayer scene]]];    
}

-(void)onArrowTouch:(id)sender {
    if( !menu_more.visible ) [self openArrow];
    else [self closeArrow];
}

-(void)openArrow {
    
    arrow.normalImage = arrowLSprite;
    arrow.selectedImage = arrowLPressedSprite;
    
    menu_more.visible = YES;
    [menu_more runAction:[CCEaseInOut actionWithAction:[CCMoveTo actionWithDuration:1 position:ccp(20, 0)] rate:2.0]];
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

-(void)setting:(id)sender{
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1 scene:[Setting scene]]];
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];
    
}

-(void)shop:(id)sender{
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1 scene:[Shop scene]]];
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];
    
}

@end
