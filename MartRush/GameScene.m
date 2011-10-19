
//  GameScene.m
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "GameScene.h"
#import "MovementManager.h"
#import "ControlManager.h"
#import "Player.h"
#import "GameLayer.h"
#import "GameUILayer.h"
#import "ResultScene.h"
#import "Const.h"
#import "Cart.h"
#import "GameOverScene.h"
#import "ResultScene.h"
#import "SimpleAudioEngine.h"

#import "UserData.h"
#import "BossUILayer.h"
#import "BonusUILayer.h"

@interface GameScene(Private)
- (void)initLayers;
- (void)initManagers;
@end


@implementation GameScene

@synthesize gameLayer, gameUILayer, merchandises, obstacles, movementManager, controlManager,bossUILayer, bonusUILayer;
@synthesize gameState, stageLevel, stageType, gameInfoDictionary;

-(id)init
{
	if( self = [super init] )
	{
		[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
		
		merchandises = [[NSMutableArray alloc] init];
		obstacles = [[NSMutableArray alloc] init];
		
        //		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"gamebg_sound.mp3"];
		
		NSLog( @"lastPlayedStage : %@", [UserData userData].lastPlayedStage );
		
		gameInfoDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:
																				  [UserData userData].lastPlayedStage ofType:@"plist"]];
		
		stageType = [[gameInfoDictionary objectForKey:@"type"] integerValue];
		stageLevel = [[[[UserData userData].stageInfo objectForKey:[UserData userData].lastPlayedStage] objectForKey:@"level"] integerValue];
		
		[self initLayers];
		[self initManagers];
		
		gameState = GAME_STATE_MISSION;
		
		if ([UserData userData].backSound) 
			[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"GameBGM.mp3"];
		
		// 카운트다운, 클리어 라벨
		label = [[CCLabelTTF alloc] initWithString:@"" fontName:@"NanumScript.ttf" fontSize:100];
		label.color = ccc3( 0, 0, 0 );
		
		NSString *msg = @"";
		
		if (stageType == STAGE_TYPE_NORMAL) 
		{
			NSMutableDictionary *missions = [NSMutableDictionary dictionaryWithDictionary:[gameInfoDictionary objectForKey:@"mission"]];
			
			for( NSString *key in missions )
			{
				msg = [msg stringByAppendingFormat:@"%@ : %d\n", [[key componentsSeparatedByString:@"_"] objectAtIndex:1], [[missions objectForKey:key] integerValue]];
			}
		}
		else if (stageType == STAGE_TYPE_BOSS)
		{
			msg = @"Beat It!!";
		}
		else if (stageType == STAGE_TYPE_BONUS)
		{
			msg = @"Get as many as possible!";
		}
		else if(stageType == STAGE_TYPE_INFINITE)
		{
			msg = @"Survive as long as possible";
		}
        
		missionAlert = [[CCSprite alloc] initWithFile:@"mission.png"];
		[missionAlert setAnchorPoint:ccp(0.5, 0.5)];
		[missionAlert setPosition:ccp(240, 140)];
		
		[self addChild:missionAlert z:10];
		
        missionLabel = [CCLabelTTF labelWithString:msg dimensions:CGSizeMake(200,100) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap  fontName:@"BurstMyBubble.ttf" fontSize:45];
        
		[missionLabel setAnchorPoint:ccp(0.5, 0.5)];
		[missionLabel setPosition:ccp(205, 100)];
		missionLabel.color = ccBLACK;
		
		[missionAlert addChild:missionLabel];
		
		missionCheck = [CCMenuItemImage itemFromNormalImage:@"btn_yes.png" selectedImage:@"btn_yes.png" 
													 target:self selector:@selector(missionAlertCheck:)];
		[missionCheck setAnchorPoint:CGPointZero];
		
		missionMenu = [CCMenu menuWithItems:missionCheck, nil];
		[missionMenu setAnchorPoint:CGPointZero];
		[missionMenu setPosition:ccp(190, 50)];
		
		[self addChild:missionMenu z:11];
		
		missionLabel.visible = YES;
		missionAlert.visible = YES;
		missionCheck.visible = YES;
		missionMenu.visible = YES;
        
		return self;
	}
	
	return nil;
}

- (void)initLayers
{
    gameLayer = [GameLayer alloc];
	gameLayer.gameScene = self;
    [gameLayer init];
	
	[self addChild:gameLayer];
	
	switch (stageType) {
		case STAGE_TYPE_NORMAL:
			gameUILayer = [[GameUILayer alloc] init];
			gameUILayer.gameScene = self;
			[self addChild:gameUILayer];
			break;
		case STAGE_TYPE_BOSS:
			bossUILayer = [[BossUILayer alloc] init];
			bossUILayer.gameScene = self;
			[self addChild:bossUILayer];
			break;
		case STAGE_TYPE_BONUS:
			bonusUILayer = [[BonusUILayer alloc] init];
			bonusUILayer.gameScene = self;
			[self addChild:bonusUILayer];
			break;
	}
	
}

- (void)initManagers
{
	movementManager = [[MovementManager alloc] initWithGameScene:self andGameInfo:gameInfoDictionary];
	controlManager = [[ControlManager alloc] initWithGameScene:self];
}

- (void)draw
{
	[super draw];
    
	if (gameState == GAME_STATE_START) 
	{
        
		[movementManager update];
		[gameLayer update];
		gameUILayer.processedPortion +=  1.0 / [[gameInfoDictionary objectForKey:@"length"] integerValue] * 200;
		
		if (gameUILayer.processedPortion > 200) {
			gameState = GAME_STATE_CLEAR;
		}
		
		switch (stageType) {
			case STAGE_TYPE_NORMAL:
				[gameUILayer update];
				break;
			case STAGE_TYPE_BOSS:
				[bossUILayer update];
				break;
			case STAGE_TYPE_BONUS:
				[bonusUILayer update];
				break;
		}
	}
	
	else if (gameState == GAME_STATE_PAUSE)
	{
		switch (stageType) {
			case STAGE_TYPE_NORMAL:
				[gameUILayer update];
				break;
			case STAGE_TYPE_BOSS:
				[bossUILayer update];
				break;
			case STAGE_TYPE_BONUS:
				[bonusUILayer update];
				break;
		}
	}
	else if (gameState == GAME_STATE_OVER)
	{
		switch (stageType) {
			case STAGE_TYPE_NORMAL:
				[gameUILayer update];
				break;
			case STAGE_TYPE_BOSS:
				[bossUILayer update];
				break;
			case STAGE_TYPE_BONUS:
				[bonusUILayer update];
				break;
		}
	}
	else if(gameState == GAME_STATE_CLEAR)
	{
		[self addChild:label];
		label.position = ccp( 240, 480 );
		label.string = @"Clear!";
		[label runAction:[CCEaseBackInOut actionWithAction:[CCMoveTo actionWithDuration:0.5 position:ccp( 240, 160 )]]];
		gameState = GAME_STATE_CLEARING;
		[self schedule:@selector(onClearLabelEnd:) interval:2.0];
		
		if ([UserData userData].backSound) 
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"clear.mp3"];
	}
	
}

-(void)missionAlertCheck:(id)sender
{
	if( gameState == GAME_STATE_MISSION )
	{
		missionLabel.visible = NO;
		missionAlert.visible = NO;
		missionCheck.visible = NO;
		missionMenu.visible = NO;
		
		gameState = GAME_STATE_COUNT;
		count = 3;
		label.position = ccp( 240, 160 );
		label.string = @"3";
		[self addChild:label];
		[self schedule:@selector(countDown:) interval:1];
		
		if ([UserData userData].backSound)
			[[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];        
	}	
}

- (void)countDown:(id)sender
{
	label.string = [NSString stringWithFormat:@"%d", --count];
	
	if( count == 0 )
	{
		label.string = @"Start!";
		gameState = GAME_STATE_START; // 물품이 처음 나오는데 걸리는 시간때문에 미리 바꿔놓음
	}
	else if( count == -1 )
	{
        if(stageType == STAGE_TYPE_BONUS)
            [bonusUILayer startTimer];
		[self removeChild:label cleanup:NO];
		[self unschedule:@selector(countDown:)];
	}
}

- (void)onClearLabelEnd:(id)sender
{
	[self unschedule:@selector(countDown:)];
    if(stageType == STAGE_TYPE_BOSS){
        [[UserData userData] setLastPlayedStage:@"bonus"];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL transitionWithDuration:0.3 scene:[[[GameScene alloc]init] autorelease]]];
    }
    
    else{
        [[CCDirector sharedDirector] replaceScene:[ResultScene sceneWithMerchandises:gameLayer.player.cart.itemList andMission:[gameInfoDictionary objectForKey:@"mission"]]];
    }
}

-(void)dealloc
{
	[merchandises dealloc];
	[obstacles dealloc];
	[gameInfoDictionary dealloc];
	
	[movementManager dealloc];
	[controlManager dealloc];
	
	[gameLayer dealloc];
	[gameUILayer dealloc];
	
	[super dealloc];
}

@end
