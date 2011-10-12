//
//  MenuLayer.h
//  MartRush
//
//  Created by sung-eun Im on 11. 10. 13..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "StageSelectLayer.h"
#import "Shop.h"
#import "GameScene.h"
#import "Setting.h"

@class StageSelectLayer;
@class Shop;
@class GameScene;
@class Setting;

@interface MenuLayer : CCLayer
{
    CCSprite *menuBgSprite;
    
    CCSprite *arrowRSprite;
    CCSprite *arrowRPressedSprite;
    CCSprite *arrowLSprite;
    CCSprite *arrowLPressedSprite;
    
    BOOL isOpenArrowPressed;
    BOOL isCloseArrowPressed;
    
    CCMenuItemImage *arrow;
    CCMenuItemImage *menu_facebook;
    CCMenuItemImage *menu_ranking;
    CCMenuItemImage *menu_info;
    CCMenuItemImage *menu_setting;
    
    CCMenu *settingMenu;
    CCMenu *arrowMenu;
    CCMenu *menu_more;    
}

+(CCScene*) scene;

-(void)moveStageScene:(id)sender;

-(void)onArrowTouch:(id)sender;
-(void)openArrow;
-(void)closeArrow;

-(void)setting:(id)sender;
-(void)shop:(id)sender;

@end
