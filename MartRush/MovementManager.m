//
//  MovementManager.m
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "MovementManager.h"
#import "Merchandise.h"
#import "Obstacle.h"


// private methods
@interface MovementManager()
- (void)createMerchandise;
- (void)createObstacle;
- (void)removeMerchandise:(Merchandise *)merchandise;
- (void)removeObstacle:(Obstacle *)obstacle;
- (void)setMerchandiseY:(Merchandise *)merchandise newY:(int)y;
- (void)setObstacleY:(Obstacle *)obstacle newY:(int)y;
- (BOOL)willBeRemoved:(CCSprite *)spr;
@end


@implementation MovementManager

@synthesize gameScene;

- (id)init
{
	if( self = [super init] )
	{
		
	}
	return self;
}

- (void)update
{
	if( arc4random() % 10 == 1 )
		[self createMerchandise];
	
	for( Merchandise *merchandise in gameScene.merchandises )
	{
		[self setMerchandiseY:merchandise newY:merchandise.merchandiseSpr.position.y - 1.0f];
		if( [self willBeRemoved:merchandise.merchandiseSpr] )
		{
			[self removeMerchandise:merchandise];
		}
	}
}

- (void)createMerchandise
{
	Merchandise *merchandise = [[Merchandise alloc] init];
	merchandise.wayState = arc4random() % 2;
	merchandise.merchandiseSpr = [CCSprite spriteWithFile:@"fruit_apple.png"];
	merchandise.merchandiseSpr.anchorPoint = ccp( 0.5f, 1.0f );
	merchandise.merchandiseSpr.position = ccp( 240, 320 );
	int zOrder = ((Merchandise *)[gameScene.merchandises lastObject]).merchandiseSpr.zOrder - 1;
	[gameScene.gameLayer addChild:merchandise.merchandiseSpr z:zOrder];
	[gameScene.merchandises addObject:merchandise];
}

- (void)createObstacle
{
	
}

- (void)removeMerchandise:(Merchandise *)merchandise
{
	[gameScene.gameLayer removeChild:merchandise.merchandiseSpr cleanup:YES];
	[gameScene.merchandises removeObject:merchandise];
}

- (void)removeObstacle:(Obstacle *)obstacle
{
	
}

- (void)setMerchandiseY:(Merchandise *)merchandise newY:(int)y
{
	merchandise.merchandiseSpr.position = ccp(!merchandise.wayState ? y * 9 / 17 : -9 * y / 17 + 480, y);
	merchandise.merchandiseSpr.scale = (-1 * y * 3 / 8 + 170) / merchandise.merchandiseSpr.contentSize.width;
}

- (void)setObstacleY:(Obstacle *)obstacle newY:(int)y
{
	obstacle.obstacleSpr.position = ccp(!obstacle.wayState ? y * 3 / 16 + 155 : -1 * y * 3 / 16 + 325, y);
    obstacle.obstacleSpr.scale = (-1 * y * 3 / 8 + 170) / obstacle.obstacleSpr.contentSize.width;
}

- (BOOL)willBeRemoved:(CCSprite *)spr
{
	return spr.position.y < -1 * spr.contentSize.height - 10;
}

@end
