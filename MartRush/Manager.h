//
//  Manager.h
//  MartRush
//
//  Created by 전 수열 on 11. 10. 4..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameScene;

@interface Manager : NSObject {
  GameScene *gameScene_;
}

@property (nonatomic, retain, readonly) GameScene *gameScene;

- (id)initWithGameScene:(GameScene *)gameScene;

@end
