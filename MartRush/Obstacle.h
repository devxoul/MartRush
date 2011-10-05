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
	
	int wayState;
	int state;
	float speed;
	
	float z_;
}

@property (nonatomic, retain) CCSprite *obstacleSpr;

@property int wayState;
@property int state;
@property float speed;
@property (nonatomic) float z;

@end
