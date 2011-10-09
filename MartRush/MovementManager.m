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
@interface MovementManager(Private)
//- (void)createMerchandise;
- (void)createObstacle;
- (void)moveMerchandise:(Merchandise *)merchandise;
- (void)moveObstalce:(Obstacle *)obstacle;
- (void)removeMerchandise:(Merchandise *)merchandise;
- (void)removeObstacle:(Obstacle *)obstacle;
- (void)setMerchandiseY:(Merchandise *)merchandise newY:(int)y;
- (void)setObstacleY:(Obstacle *)obstacle newY:(int)y;
- (CATransform3D)get3DTransform;
@end


@implementation MovementManager

- (id)initWithGameScene:(GameScene *)gameScene;
{
	if( self = [super initWithGameScene:gameScene] )
	{
		[self createMerchandise];
	}
	return self;
}
          
- (void)update
{	
	if( arc4random() % 50 == 1 )
		[self createObstacle];
	
	for( Merchandise *merchandise in gameScene_.merchandises )
	{
		merchandise.z -= 2;
		
		if( merchandise.z < -100 )
		{
//			[self removeMerchandise:merchandise];
		}
	}
	
	for( Obstacle *obstacle in gameScene_.obstacles )
	{
		obstacle.z -= 20;
		
		if( obstacle.z < -100 )
		{
			[self removeObstacle:obstacle];
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
	merchandise.z = 1000;
	int zOrder = ((Merchandise *)[gameScene_.merchandises lastObject]).merchandiseSpr.zOrder - 1;
	[gameScene_.gameLayer addChild:merchandise.merchandiseSpr z:zOrder];
	[gameScene_.merchandises addObject:merchandise];
//	merchandise.merchandiseSpr.skewY = 30;
}

- (void)createObstacle
{
	Obstacle *obstacle = [[Obstacle alloc] init];
	obstacle.wayState = arc4random() % 2;
	obstacle.obstacleSpr = [CCSprite spriteWithFile:@"fruit_banana.png"];
	obstacle.obstacleSpr.anchorPoint = ccp( 0.5f, 1.0f );
//	obstacle.obstacleSpr.position = ccp( 240, 320 );
	obstacle.z = 5000;
	int zOrder = ((Obstacle *)[gameScene_.obstacles lastObject]).obstacleSpr.zOrder - 1;
	[gameScene_.gameLayer addChild:obstacle.obstacleSpr z:zOrder];
	[gameScene_.obstacles addObject:obstacle];
}

- (void)createObstacle:(Obstacle *)obstacle wayState:way
{
	
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
	merchandise.merchandiseSpr.position = ccp(!merchandise.wayState ? y * 9 / 17 : -9 * y / 17 + 480, y);
	merchandise.merchandiseSpr.scale = (-1 * y * 3 / 8 + 170) / merchandise.merchandiseSpr.contentSize.width;
}

- (void)setObstacleY:(Obstacle *)obstacle newY:(int)y
{
	obstacle.obstacleSpr.position = ccp(!obstacle.wayState ? y * 3 / 16 + 155 : -1 * y * 3 / 16 + 325, y);
    obstacle.obstacleSpr.scale = (-1 * y * 3 / 8 + 170) / obstacle.obstacleSpr.contentSize.width;
}

@end
