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

@interface StageSelectScene : CCLayer {
  NSDictionary *stageInfoArray;
  NSArray *stageKeys;
  CCLabelTTF *moneyLabel;
}

+ (CCScene *)scene;

- (void)selectLevel:(id)sender;

@end
