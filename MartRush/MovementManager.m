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
	if( arc4random() % 30 == 1 )
		[self createMerchandise];
	
	for( Merchandise *merchandise in gameScene_.merchandises )
	{
		/*glPushMatrix();
		glRotatef(30.0f, 0.0f, 30.0f, 0.0f);
		[merchandise.merchandiseSpr visit];
		glPopMatrix();*/
		
		
//		break;
		
		merchandise.z -= 2;
		
		if( merchandise.z < 0 )
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
	merchandise.z = 320;
	int zOrder = ((Merchandise *)[gameScene_.merchandises lastObject]).merchandiseSpr.zOrder - 1;
	[gameScene_.gameLayer addChild:merchandise.merchandiseSpr z:zOrder];
	[gameScene_.merchandises addObject:merchandise];
//	merchandise.merchandiseSpr.skewY = 30;
}

- (void)createObstacle
{
	
}

- (void)createObstacle:(Obstacle *)obstacle
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
