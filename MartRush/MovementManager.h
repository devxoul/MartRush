//
//  MovementManager.h
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "Manager.h"

@class GameScene;

@interface MovementManager : Manager {
  NSArray *obstacleTypeArray;
  NSArray *merchandiseTypeArray;
	NSInteger rate;
}

- (id)initWithGameScene:(GameScene *)gameScene andGameInfo:(NSDictionary *)gameInfo;

- (void)createObstacle:(NSString *)image wayState:(int)wayState z:(float)z speed:(float)speed;

- (void)update;

@end
