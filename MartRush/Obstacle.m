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

- (id)init
{
  if (self = [super init])
  {
    return self;
  }
  return nil;
}

- (void)setZ:(float)z
{	
	float cameraY = 180;
	float cameraAngle = 30;
	float tanAngle = tanf(cameraAngle * M_PI / 180);
	
	float h = 180;
	
	float angle = (90 - cameraAngle) * M_PI / 180;
	
	float z2 = cameraY / ( tanAngle + cameraY / z );
	float y2 = cameraY * tanAngle / (tanAngle + cameraY / z);
	
	float z_2 = cameraY / ( tanAngle + ( cameraY - h ) / z );
	float y_2 = cameraY * tanAngle / ( tanAngle + ( cameraY - h ) / z );
	
//	float z3 = cosf(angle) * z2 - sinf(angle) * y2;
	float y3 = sinf(angle) * z2 + cosf(angle) * y2;
	
//	float z_3 = cosf(angle) * z_2 - sinf(angle) * y_2;
	float y_3 = sinf(angle) * z_2 + cosf(angle) * y_2;
	
	self.obstacleSpr.position = ccp( self.wayState ? y3 / 3 + 120 : -1 * y3 / 3 + 360, y3 );
	self.obstacleSpr.scale = 0.5 * ( y_3 - y3 ) / self.obstacleSpr.contentSize.width;
	
	z_ = z;
}

@end
