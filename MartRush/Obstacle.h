//
//  Obstacle.h
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Obstacle : NSObject {
	CCSprite *obstacleSpr;
	
	NSInteger wayState;
	NSInteger state;
	float speed;
	
	float z_;
}

@property (nonatomic, retain) CCSprite *obstacleSpr;

@property (readonly) NSInteger wayState;
@property NSInteger state;
@property float speed;
@property (nonatomic) float z;

- (id)initWithWay:(NSInteger)way andSprite:(CCSprite *)sprite andSpeed:(float)_speed;
@end
