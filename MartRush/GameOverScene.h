//
//  GameOverScene.h
//  MartRush
//
//  Created by omniavinco on 11. 10. 11..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "GameScene.h"
#import "TitleLayer.h"

@interface GameOverScene : CCLayer<CCStandardTouchDelegate> {
    
//    CCMenuItemImage* menuTry;
//    CCMenuItemImage* menuMain;
//    CCMenuItemImage* menuShop;
//    
//    CCMenu* overMenu;    
}

+(CCScene *)scene;

-(void)menuItemTry:(id)sender;
-(void)menuItemMain:(id)sender;
-(void)menuItemShop:(id)sender;

@end
