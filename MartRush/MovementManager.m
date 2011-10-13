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
#import "GameLayer.h"
#import "Player.h"

// private methods
@interface MovementManager(Private)
- (void)createMerchandise:(NSString *)image wayState:(int)wayState;

- (void)moveMerchandise:(Merchandise *)merchandise;
- (void)moveObstalce:(Obstacle *)obstacle;

- (void)removeMerchandise:(Merchandise *)merchandise;
- (void)removeObstacle:(Obstacle *)obstacle;
@end


@implementation MovementManager

- (id)initWithGameScene:(GameScene *)gameScene;
{
	if( self = [super initWithGameScene:gameScene] )
	{
		
	}
	return self;
}

- (void)update
{
	if( [gameScene_.merchandises count] == 0 || ( (Merchandise *)[gameScene_.merchandises lastObject] ).z < DEFAULT_Z - MIN_GAP )
	{
		[self createMerchandise:@"fruit_apple.png" wayState:arc4random() % 2];
	}
	
	if( [gameScene_.obstacles count] == 0 || ( (Obstacle *)[gameScene_.obstacles lastObject] ).z < DEFAULT_Z - MIN_GAP )
	{
		if( arc4random() % 100 <= 100 )
			[self createObstacle:@"fruit_banana.png" wayState:arc4random() % 2 z:DEFAULT_Z speed:10];
	}
	
	
	for( Merchandise *merchandise in gameScene_.merchandises )
	{
		merchandise.z -= 10;//gameScene_.gameLayer.player.playerSpeed;
		
		if( merchandise.z < 0 )
		{
			[self removeMerchandise:merchandise];
		}
	}
	
	for( Obstacle *obstacle in gameScene_.obstacles )
	{
		obstacle.z -= obstacle.speed;
		
		if( 100 <= obstacle.z && obstacle.z <= 150 && obstacle.wayState == gameScene_.gameLayer.player.playerWayState )
		{
            gameScene_.gameLayer.player.playerState = PLAYER_STATE_CRASH;
			[self removeObstacle:obstacle];
			continue;
		}
		
		if( obstacle.z < 0 )
		{
			[self removeObstacle:obstacle];
			continue;
		}
	}
}

- (void)createMerchandise:(NSString *)image wayState:(int)wayState
{
	Merchandise *merchandise = [[Merchandise alloc] init];
	merchandise.merchandiseSpr = [CCSprite spriteWithFile:image];
	merchandise.merchandiseSpr.anchorPoint = ccp( 0.5f, 1.0f );
	merchandise.wayState = wayState;
	merchandise.z = 3500;
	int zOrder = [gameScene_.merchandises count] ? ((Merchandise *)[gameScene_.merchandises lastObject]).merchandiseSpr.zOrder - 1 : Z_ORDER_MERCHANDISE;
	[gameScene_.gameLayer addChild:merchandise.merchandiseSpr z:zOrder];
	[gameScene_.merchandises addObject:[merchandise autorelease]];
}

- (void)createObstacle:(NSString *)image wayState:(int)wayState z:(float)z speed:(float)speed
{
	Obstacle *obstacle = [[Obstacle alloc] init];
	obstacle.obstacleSpr = [CCSprite spriteWithFile:image];
	obstacle.obstacleSpr.anchorPoint = ccp( 0.5f, 1.0f );
	obstacle.wayState = wayState;
	obstacle.z = z;
	obstacle.speed = speed;
	int zOrder = [gameScene_.obstacles count] ? ((Obstacle *)[gameScene_.obstacles lastObject]).obstacleSpr.zOrder - 1 : Z_ORDER_OBSTACLE;
	[gameScene_.gameLayer addChild:obstacle.obstacleSpr z:zOrder];
	[gameScene_.obstacles addObject:[obstacle autorelease]];
}

- (void)moveMerchandise:(Merchandise *)merchandise
{
//	merchandise.merchandiseSpr.position.y += 
}

- (void)moveObstalce:(Obstacle *)obstacle
{
	
}

- (void)removeMerchandise:(Merchandise *)merchandise
{
	[gameScene_.gameLayer removeChild:merchandise.merchandiseSpr cleanup:YES];
	[gameScene_.merchandises removeObject:merchandise];
}

- (void)removeObstacle:(Obstacle *)obstacle
{
	[gameScene_.gameLayer removeChild:obstacle.obstacleSpr cleanup:YES];
	[gameScene_.obstacles removeObject:obstacle];
}

- (void)setMerchandiseY:(Merchandise *)merchandise newY:(int)y
{
	merchandise.merchandiseSpr.position = ccp( !merchandise.wayState ? y * 9 / 17 : -9 * y / 17 + 480, y );
	merchandise.merchandiseSpr.scale = ( -1 * y * 3 / 8 + 170 ) / merchandise.merchandiseSpr.contentSize.width;
}

- (void)setObstacleY:(Obstacle *)obstacle newY:(int)y
{
	obstacle.obstacleSpr.position = ccp(!obstacle.wayState ? y * 3 / 16 + 155 : -1 * y * 3 / 16 + 325, y );
    obstacle.obstacleSpr.scale = ( -1 * y * 3 / 8 + 170 ) / obstacle.obstacleSpr.contentSize.width;
}

@end
