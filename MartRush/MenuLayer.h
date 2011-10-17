//
//  MenuLayer.h
//  MartRush
//
//  Created by sung-eun Im on 11. 10. 13..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Setting.h"

@class StageSelectLayer;
@class Shop;
@class GameScene;
@class Setting;
@class TutorialLayer;
@class InfoLayer;
@class TitleLayer;
@class UserData;

@interface MenuLayer : CCLayer
{
    CCSprite *menuBgSprite;
    
    CCMenuItemLabel * mainmenu[4];
    
    CCMenuItemImage *arrow;
    CCMenuItemImage *menu_facebook;
    CCMenuItemImage *menu_ranking;
    CCMenuItemImage *menu_info;
    
    CCMenuItemImage *menu_setting;
    CCMenuItemImage *menu_back;
    
    CCMenu *settingMenu;
    CCMenu *arrowMenu;
    CCMenu *menu_more;    
}

+(CCScene*) scene;

-(void)moveStage:(id)sender;
-(void)moveTutorial:(id)sender;
-(void)moveInfinite:(id)sender;
-(void)moveShop:(id)sender;

-(void)moveSetting:(id)sender;
-(void)moveTitle:(id)sender;

-(void)moveFacebook:(id)sender;
-(void)moveRank:(id)sender;
-(void)moveInfo:(id)sender;

@end
