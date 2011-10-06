//
//  Merchandise.m
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Merchandise.h"


@implementation Merchandise

@synthesize merchandiseSpr, wayState;
@synthesize z = z_;

- (id)init
{
	if( self = [super init] )
	{
		
	}
	return self;
}

- (void)setZ:(float)z
{
	self.merchandiseSpr.position = ccp(!self.wayState ? z * 9 / 17 : -9 * z / 17 + 480, z);
	
	// Obstacle
//	self.merchandiseSpr.position = ccp(!self.wayState ? z * 3 / 16 + 155 : -1 * z * 3 / 16 + 325, z );
	self.merchandiseSpr.scale = (-3 * z / 8 + 170) / self.merchandiseSpr.contentSize.width;
	z_ = z;
}

@end
