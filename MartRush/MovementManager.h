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

#import "Merchandise.h"
#import "Obstacle.h"

@interface MovementManager : Manager {
	NSArray *obstacleTypeArray;
  NSArray *merchandiseTypeArray;
}

- (id)initWithGameScene:(GameScene *)gameScene andGameInfo:(NSDictionary *)gameInfo;

- (void)createObstacle:(NSString *)image wayState:(int)wayState z:(float)z speed:(float)speed;

- (void)update;

@end
