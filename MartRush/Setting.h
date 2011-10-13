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
  
  CCMenuItemImage *menu_back;
  
  CCMenu *backMenu;   
}

+(CCScene*) scene;
-(void)back:(id)sender;

@end
