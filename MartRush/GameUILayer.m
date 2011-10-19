//
//  GameUILayer.m
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "GameUILayer.h"
#import "GameScene.h"
#import "Player.h"
#import "GamePauseMenuLayer.h"
#import "GameLayer.h"
#import "GameOverScene.h"
#import "UserData.h"
#import "SimpleAudioEngine.h"
#import "Cart.h"
#import "Merchandise.h"

@implementation GameUILayer

@synthesize gameScene, processedPortion;

- (id)init
{
	if( self = [super init] )
	{
        self.processedPortion = 0;
        
        backGround = [CCSprite spriteWithFile:@"uilayer_bg.png"];
        [backGround setPosition:ccp(240,280)];
        backGround.anchorPoint = ccp(0.5f, 0.0f);
        [self addChild:backGround];
        
        heartArray = [[NSMutableArray alloc] init];
        
        CCSprite *heart = [CCSprite spriteWithFile:@"heart.png"];
        [heart setPosition:ccp(25,285)];
        [heartArray addObject:heart];
        
        heart = [CCSprite spriteWithFile:@"heart.png"];
        [heart setPosition:ccp(58,285)];
        [heartArray addObject:heart];
        
        heart = [CCSprite spriteWithFile:@"heart.png"];
        [heart setPosition:ccp(91,285)];
        [heartArray addObject:heart];
        
        for (CCSprite *heart in heartArray) {
            heart.anchorPoint = ccp(0.5f, 0.0f);
            [self addChild:heart];
        }
        
        startIcon = [CCSprite spriteWithFile:@"start.png"];
        [startIcon setPosition:ccp(135,285)];
        startIcon.anchorPoint = ccp(0.5f, 0.0f);
        [self addChild:startIcon];
        
        endIcon = [CCSprite spriteWithFile:@"goal.png"];
        [endIcon setPosition:ccp(371,285)];
        endIcon.anchorPoint = ccp(0.5f, 0.0f);
        [self addChild:endIcon];
        
        
        info = [CCMenuItemImage itemFromNormalImage:@"cartbutton.png" selectedImage:@"cartbutton_pressed.png" block:^(id sender) {
            if (gameScene.gameState == GAME_STATE_START) {
                gameScene.gameState = GAME_STATE_PAUSE;
                gameScene.gameLayer.isTouchEnabled = NO;

                NSDictionary *gameInfoDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:
                                                                                                        [UserData userData].lastPlayedStage ofType:@"plist"]];
                NSString *msg = @"";
                
                NSMutableDictionary *missions = [NSMutableDictionary dictionaryWithDictionary:[gameInfoDictionary objectForKey:@"mission"]];
                int i=0;
                for( NSString *key in missions )
                {   int count = 0;
                    i++;
                    for(Merchandise *temp in gameScene.gameLayer.player.cart.itemList){
                        if([[temp name] isEqualToString:key])
                            count++;
                    }
                    msg = [msg stringByAppendingFormat:@"%@ : %d / %d", [[key componentsSeparatedByString:@"_"] objectAtIndex:1],count, [[missions objectForKey:key] integerValue]];
                    if(i < [missions count]){
                        msg = [msg stringByAppendingFormat:@"\n"];
                    }
                }
                
                
                missionAlert = [[CCSprite alloc] initWithFile:@"mission.png"];
                [missionAlert setAnchorPoint:ccp(0.5, 0.5)];
                [missionAlert setPosition:ccp(240, 140)];
                
                [self addChild:missionAlert z:Z_ORDER_PLAYER+1];
                
                missionLabel = [CCLabelTTF labelWithString:msg dimensions:CGSizeMake(400,130) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap  fontName:@"BurstMyBubble.ttf" fontSize:24];
                
                [missionLabel setAnchorPoint:ccp(0.5, 0.5)];
                [missionLabel setPosition:ccp(205, 80)];
                missionLabel.color = ccBLACK;
                
                [missionAlert addChild:missionLabel];
                
                missionCheck = [CCMenuItemImage itemFromNormalImage:@"btn_yes.png" selectedImage:@"btn_yes.png" 
                                                             target:self selector:@selector(missionAlertCheck:)];
                [missionCheck setAnchorPoint:CGPointZero];
                
                missionMenu = [CCMenu menuWithItems:missionCheck, nil];
                [missionMenu setAnchorPoint:CGPointZero];
                [missionMenu setPosition:ccp(190, 50)];
                
                [self addChild:missionMenu z:Z_ORDER_PLAYER+2];
                
                missionLabel.visible = YES;
                missionAlert.visible = YES;
                missionCheck.visible = YES;
                missionMenu.visible = YES;
                
            }
        }];
        info.anchorPoint = ccp(0.5f, 0.0f);
        
        gaugeBg = [[CCSprite alloc] initWithFile:@"gaugebg.png"];
        [gaugeBg setPosition:ccp(253,294)];
        gaugeBg.anchorPoint = ccp(0.5f, 0.0f);
        [self addChild:gaugeBg];
        
        gauge = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"gauge.png"] rect:CGRectMake(0,0,0,8)];
        [gauge setPosition:ccp(155,296)];
        gauge.anchorPoint = ccp(0.0f, 0.0f);
        
        [self addChild:gauge];
        
        pause = [CCMenuItemImage itemFromNormalImage:@"pause.png" selectedImage:@"pause_pressed.png" block:^(id sender) {
            if (gameScene.gameState == GAME_STATE_START) {
                gameScene.gameState = GAME_STATE_PAUSE;
                [self addChild:[GamePauseMenuLayer layerWithStage:gameScene] z:10000];
                gameScene.gameLayer.isTouchEnabled = NO;
            }
        }];
        pause.anchorPoint = ccp(0.5f, 0.0f);        
        
        pauseMenu = [CCMenu menuWithItems:pause, info, nil];
        pauseMenu.anchorPoint = ccp(0.5f, 0.0f);
        
        [pauseMenu setPosition:ccp(0,0)];
        [info setPosition:ccp(415,285)];
        [pause setPosition:ccp(455,285)];
        
        [self addChild:pauseMenu];
        
        return self;
    }
    
    return nil;
}

-(float)processedPortion
{
	return processedPortion;
}

- (void)setProcessedPortion:(float)processedPortion_
{
	processedPortion = processedPortion_;
	[gauge setTextureRect:CGRectMake(0, 0, processedPortion, 8)];
}

-(void) heartUpdate{
	CCFiniteTimeAction *action = [CCFadeOut actionWithDuration:0.3];
	CCSprite *heart = 0;
	if(gameScene.gameLayer.player.hp == 2){
		heart = [heartArray objectAtIndex:2];
	}  
	if(gameScene.gameLayer.player.hp == 1){
		heart = [heartArray objectAtIndex:1];
	}  
	if(gameScene.gameLayer.player.hp == 0){
		heart = [heartArray objectAtIndex:0];
		action = [CCSequence actions:action, [CCCallFunc actionWithTarget:self selector:@selector(endGame:)], nil];
	}
	if (heart) {
		[heart runAction:action];
	}
}

- (void)update{
}

-(void)endGame:(id)sender
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeDown transitionWithDuration:1 scene:[GameOverScene scene]]];
}

-(void)missionAlertCheck:(id)sender
{
	if( gameScene.gameState == GAME_STATE_PAUSE )
	{
		missionLabel.visible = NO;
		missionAlert.visible = NO;
		missionCheck.visible = NO;
		missionMenu.visible = NO;
        
        gameScene.gameState = GAME_STATE_START;
        gameScene.gameLayer.isTouchEnabled = YES;

		if ([UserData userData].backSound)
			[[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];        
	}	
}

@end
