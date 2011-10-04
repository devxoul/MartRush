//
//  GameLayer.m
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "GameLayer.h"
#import "Merchandise.h"

@implementation GameLayer

@synthesize gameScene;

- (id)init
{
	if( self = [super init] )
	{
#ifdef MARTRUSH_BOC_EDIT        
		player = [Player alloc];
        [player init:self];
        
        boss = [Boss alloc];
        [boss init:self];

        self.isTouchEnabled = YES;
#endif
	}
	return self;
}

- (void)update
{
#ifdef MARTRUSH_BOC_EDIT
	[player update];
    [player playerSetZorder:self :0];
#endif
}


@end
