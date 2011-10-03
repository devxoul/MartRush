//
//  MovementManager.h
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "Merchandise.h"
#import "Obstacle.h"

#import "GameScene.h"

@interface MovementManager : NSObject {
	GameScene *gameScene;
}

@property (nonatomic, retain) GameScene *gameScene;

- (void)update;
- (void)createObstacle:(Obstacle *)obstacle wayState:way;

@end
