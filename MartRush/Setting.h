//
//  Setting.h
//  MartRush
//
//  Created by sung-eun Im on 11. 10. 13..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class MenuLayer;

@interface Setting : CCLayer
{
    CCSprite *settingBgSprite;
    CCSprite *setOff[2];
    
    CCMenuItemImage *menu_back;
    CCMenu *backMenu;
    
    int resetState;
    CCMenu* reset_menu;
    CCSprite* popSpr;
    CCLabelTTF* label;
}

+(CCScene*) scene;
-(void)back:(id)sender;

-(void)setSound:(id)sender;
-(void)setVibration:(id)sender;
-(void)setReset:(id)sender;

@end

