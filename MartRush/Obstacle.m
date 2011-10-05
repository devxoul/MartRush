//
//  Obstacle.m
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Obstacle.h"


@implementation Obstacle

@synthesize obstacleSpr, wayState, state, speed;
@synthesize z = z_;

- (void)setZ:(float)z
{
	self.obstacleSpr.position = ccp(!self.wayState ? z * 3 / 16 + 155 : -1 * z * 3 / 16 + 325, z );
	self.obstacleSpr.scale = (-3 * z / 8 + 170) / self.obstacleSpr.contentSize.width;
	z_ = z;
}

@end
