//
//  Manager.m
//  MartRush
//
//  Created by 전 수열 on 11. 10. 4..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Manager.h"


@implementation Manager

@synthesize gameScene = gameScene_;

- (id)initWithGameScene:(GameScene *)gameScene;
{
<<<<<<< master
	if( self = [super init] )
=======
<<<<<<< Xoul
	if( self = [self init] )
=======
	if( [self init] )
>>>>>>> local
>>>>>>> local
	{
		gameScene_ = gameScene;
	}
	return self;
}

@end
