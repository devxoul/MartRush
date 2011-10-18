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
#import "GameScene.h"
#import "Player.h"
#import "Boss.h"

// private methods
@interface MovementManager(Private)
- (BOOL)isMerchandiseCreatable;
- (void)createMerchandise:(NSString *)image wayState:(int)wayState;

- (void)removeMerchandise:(Merchandise *)merchandise;
- (void)removeObstacle:(Obstacle *)obstacle;
@end


@implementation MovementManager

- (id)initWithGameScene:(GameScene *)gameScene andGameInfo:(NSDictionary *)gameInfo;
{
    if (self = [super initWithGameScene:gameScene]) {
        obstacleTypeArray = [[NSArray alloc] initWithArray:[gameInfo objectForKey:@"obstacles"]];
        merchandiseTypeArray = [[NSArray alloc] initWithArray:[gameInfo objectForKey:@"merchandises"]];
        
        return self;
    }
    return nil;
}

- (void)update
{
	if( [self isMerchandiseCreatable] )
	{
		[self createMerchandise:[merchandiseTypeArray objectAtIndex:arc4random()%merchandiseTypeArray.count] wayState:arc4random() % 2];
	}
	
	if( gameScene_.stageType == STAGE_TYPE_NORMAL && [self isObstacleCreatable] ){
		if( arc4random() % 100 <= rate )
			[self createObstacle:[obstacleTypeArray objectAtIndex:arc4random()%obstacleTypeArray.count] wayState:arc4random() % 2 z:DEFAULT_Z speed:10];
    }
	
	NSMutableIndexSet *willBeRemovedMerchandisesIndices = [[NSMutableIndexSet alloc] init];
	NSMutableIndexSet *willBeRemovedObstaclesIndices = [[NSMutableIndexSet alloc] init];
	
	for( Merchandise *merchandise in gameScene_.merchandises )
	{
		merchandise.z -= 10;
		
		if( merchandise.z < 0 )
		{
			[willBeRemovedMerchandisesIndices addIndex:[gameScene_.merchandises indexOfObject:merchandise]];
            [merchandise.merchandiseSpr removeFromParentAndCleanup:YES];
		}
	}
	
	[gameScene_.merchandises removeObjectsAtIndexes:willBeRemovedMerchandisesIndices];
	
	for( Obstacle *obstacle in gameScene_.obstacles )
	{
		obstacle.z -= obstacle.speed;
		
		if( 100 <= obstacle.z && obstacle.z <= 140 && obstacle.wayState == gameScene_.gameLayer.player.wayState && obstacle.speed > 0 )
		{
			gameScene_.gameLayer.player.state = PLAYER_STATE_CRASH;
            [obstacle.obstacleSpr removeFromParentAndCleanup:YES];
            [willBeRemovedObstaclesIndices addIndex:[gameScene_.obstacles indexOfObject:obstacle]];
			continue;
		}
		else if( DEFAULT_Z_BOSS_OBSTACLE - 50 <= obstacle.z && obstacle.z <= DEFAULT_Z_BOSS_OBSTACLE + 25 && obstacle.speed < 0 && [gameScene_.gameLayer.boss bossState] != BOSS_STATE_MOVING)
		{
            if(gameScene_.gameLayer.boss.bossWayState == obstacle.wayState){
                gameScene_.gameLayer.boss.bossState = BOSS_STATE_CRASH;
                [obstacle.obstacleSpr removeFromParentAndCleanup:YES];
                [willBeRemovedObstaclesIndices addIndex:[gameScene_.obstacles indexOfObject:obstacle]];
                continue;
            }
		}
		
		if( obstacle.z < 0 || obstacle.z > 3500 )
		{
			[willBeRemovedObstaclesIndices addIndex:[gameScene_.obstacles indexOfObject:obstacle]];
        }
	}
	
	[gameScene_.obstacles removeObjectsAtIndexes:willBeRemovedObstaclesIndices];
	
	willBeRemovedMerchandisesIndices = nil;
	willBeRemovedObstaclesIndices = nil;
	[willBeRemovedMerchandisesIndices release];
	[willBeRemovedObstaclesIndices release];
	
	gameScene_.gameLayer.player.playerRunDistance += gameScene_.gameLayer.player.speed;
}

- (BOOL)isMerchandiseCreatable
{
	return [gameScene_.merchandises count] == 0 || ( (Merchandise *)[gameScene_.merchandises lastObject] ).z < DEFAULT_Z - MIN_GAP;
}

- (BOOL)isObstacleCreatable
{
	return [gameScene_.obstacles count] == 0 || ( (Obstacle *)[gameScene_.obstacles lastObject] ).z < DEFAULT_Z - MIN_GAP;
}

- (void)createMerchandise:(NSString *)image wayState:(int)wayState
{
	Merchandise *merchandise = [[Merchandise alloc] initWithName:image andSprite:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png", image]] andWay:wayState andPrice:100 andZ:DEFAULT_Z];
	merchandise.merchandiseSpr.anchorPoint = ccp( 0.5f, 1.0f );
	[gameScene_.gameLayer addChild:merchandise.merchandiseSpr z:DEFAULT_Z];
	[gameScene_.merchandises addObject:[merchandise autorelease]];
}

- (void)createObstacle:(NSString *)image wayState:(int)wayState z:(float)z speed:(float)speed
{
	Obstacle *obstacle = [[Obstacle alloc] initWithWay:wayState andSprite:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png", image]] andSpeed:speed];
    
	obstacle.obstacleSpr.anchorPoint = ccp( 0.5f, 1.0f );
	obstacle.z = z;
    
	[gameScene_.gameLayer addChild:obstacle.obstacleSpr z:DEFAULT_Z];
	[gameScene_.obstacles addObject:[obstacle autorelease]];
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
