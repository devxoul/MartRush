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
        menuBgSprite = [[CCSprite alloc] initWithFile:@"menubg2.png"];
        menuBgSprite.anchorPoint = CGPointZero;
		[menuBgSprite setPosition:ccp(0, 0)];
        [self addChild:menuBgSprite z:0];
        
        //전체메뉴 
        //튜토리얼 이동
        mainmenu[0] = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Tutorial" fontName:@"sheepsansbold.ttf" fontSize:24] target:self selector:@selector(moveTutorial:)];
        
        // 스테이지 이동
        mainmenu[1] = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Stage" fontName:@"sheepsansbold.ttf" fontSize:24] target:self selector:@selector(moveStage:)];
        
        // 무한모드 
        mainmenu[2] = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Infinite" fontName:@"sheepsansbold.ttf" fontSize:24] target:self selector:@selector(moveInfinite:)];

        // shops
        mainmenu[3] = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Shop" fontName:@"sheepsansbold.ttf" fontSize:24] target:self selector:@selector(moveShop:)];        
        
        for (int i = 0; i < 4; i++) {
            mainmenu[i].anchorPoint = CGPointZero;
            [mainmenu[i] setColor:ccBLACK];
        }
        
        [mainmenu[0] setPosition:ccp(24, 100)];
        [mainmenu[1] setPosition:ccp(142, 100)];
        [mainmenu[2] setPosition:ccp(252, 100)];
        [mainmenu[3] setPosition:ccp(376, 100)];
        
        
        CCMenu *menu = [CCMenu menuWithItems:mainmenu[0], mainmenu[1], mainmenu[2], mainmenu[3], nil];
        
        menu.anchorPoint = CGPointZero;
        [menu setPosition:ccp(0, 0)];
		
        [self addChild: menu z:1];
        
        //설정
        menu_setting = [CCMenuItemImage itemFromNormalImage:@"setting_pink.png" selectedImage:@"setting_blue.png" 
                                                     target:self selector:@selector(moveSetting:)];
        menu_setting.anchorPoint = CGPointZero;
        
        settingMenu = [CCMenu menuWithItems:menu_setting, nil];
        settingMenu.anchorPoint = CGPointZero;
        [settingMenu setPosition:ccp(420, 270)];
        
        [self addChild:settingMenu];
                
        //화살표
        //        arrow = [CCMenuItemSprite itemFromNormalSprite:arrowRSprite selectedSprite:arrowRPressedSprite target:self selector:@selector(onArrowTouch:)];        
        //        arrow.position = ccp(10, 10);
        
        arrow = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:@"arrowPink.png"] 
                                        selectedSprite:[CCSprite spriteWithFile:@"arrowPink.png"]
                                                 block:^(id sender) {
                                                     [sender runAction:[CCRotateBy actionWithDuration:0.5 angle:180]];
                                                     if (menu_more.visible) {
                                                         [menu_more runAction:
                                                          [CCSequence actions:
                                                           [CCEaseInOut actionWithAction:[CCMoveTo actionWithDuration:0.5 position:ccp(0, 0)] rate:2.0],
                                                           [CCCallBlockN actionWithBlock:^(CCNode *node) {
                                                              menu_more.visible = NO;
                                                          }], nil]];
                                                     }
                                                     else
                                                     {
                                                         menu_more.visible = YES;
                                                         [menu_more runAction:[CCEaseInOut actionWithAction:[CCMoveTo actionWithDuration:0.5 position:ccp(0, 0)] rate:2.0]];
                                                     }
                                                 }];
        
        arrow.anchorPoint = ccp(0.5f, 0.5f);
        arrow.position = ccp(15, 15); 
        
        arrowMenu = [CCMenu menuWithItems:arrow, nil];
        arrowMenu.anchorPoint = CGPointZero;
        arrowMenu.position = ccp(15, 15);
        
        [self addChild:arrowMenu];
        
        //화살표 열면 생길 메뉴 아이템 
        menu_facebook = [CCMenuItemImage itemFromNormalImage:@"facebook_blue.png" selectedImage:@"facebook_pink.png" target:self 
                                                    selector:@selector(moveFacebook:)];
        menu_facebook.anchorPoint = CGPointZero;
        
        menu_ranking = [CCMenuItemImage itemFromNormalImage:@"ranking.jpg" selectedImage:@"facebook.png" target:self 
                                                   selector:@selector(moveRank:)];
        menu_ranking.anchorPoint = CGPointZero;
        
        menu_info = [CCMenuItemImage itemFromNormalImage:@"info_pink.png" selectedImage:@"info_blue.jpg" target:self 
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
  [[CCDirector sharedDirector] pushScene:[CCTransitionSlideInT transitionWithDuration:1 scene:[StageSelectScene scene]]];    
}

-(void)moveTutorial:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:1 scene:[TutorialLayer scene]]];    
}

-(void)moveInfinite:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:1 scene:[GameScene node]]];        
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

@end
