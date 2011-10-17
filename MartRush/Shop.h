//
//  Shop.h
//  MartRush
//
//  Created by sung-eun Im on 11. 10. 13..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class MenuLayer;

@interface Shop : CCLayer
{
  NSDictionary *cartInfoArray;
  NSArray *cartKeys;
  
  CGSize winSize;
  
  CCSprite *shopBgSprite;
  CCSprite *tab1BgSprite;
  CCSprite *tab2BgSprite;
  CCSprite *userInfoBgSprite;
  
  CCMenuItemImage *menu_back;
  CCMenuItemImage *tab1;
  CCMenuItemImage *tab2;
  
  CCMenu *backMenu;
  CCMenu *tabMenu;    
}

+(CCScene*)scene;

-(void)back:(id)sender;
-(void)onTabTouch:(id)sender;
-(void)tab1Clicked:(id)sender;
-(void)tab2Clicked:(id)sender;

-(void)selectCart:(id)sender;

@end
