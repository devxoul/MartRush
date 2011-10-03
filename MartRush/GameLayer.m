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
#endif
	}
	return self;
}

- (void)update
{
#ifdef MARTRUSH_BOC_EDIT
	[player update];
#endif
}


#ifdef MARTRUSH_BOC_EDIT
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [player setPlayerWayState:RIGHT_WAY];
}
#endif


@end
