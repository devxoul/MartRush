//
//  StageSelectScene.h
//  MartRush
//
//  Created by omniavinco on 11. 10. 13..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class MenuLayer;
@class SlidingMenuGrid;

@interface StageSelectScene : CCLayer {
	NSDictionary *stageInfoArray;
	NSArray *stageKeys;
	CCLabelTTF *moneyLabel;
	
	CCSprite* buyAlert;
	CCMenuItemImage* buyYes;
	CCMenuItemImage* buyNO;
	CCMenu* menuBuy;
	CCLabelTTF* buylab;
	CCLabelTTF* buyValue;
	
	CCMenuItemImage* cashNO;
	CCMenu* cashMenu;
	
	NSInteger buyState;
	
	NSNumber* selectStage;
	NSString* tempStage;
	
	CCLayer* buyLayer;
	
	///
	NSMutableArray *menuArray;
	CCMenuItemSprite *item;
	SlidingMenuGrid* menu;
}

+ (CCScene *)scene;

- (void)selectLevel:(id)sender;

@end
