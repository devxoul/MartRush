//
//  BossUILayer.m
//  MartRush
//
//  Created by Han Sanghoon on 11. 10. 12..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "BossUILayer.h"
#import "Boss.h"
#import "GameScene.h"
#import "Player.h"
#import "GameLayer.h"
#import "GameOverScene.h"
#import "GamePauseMenuLayer.h"
#import "UserData.h"
#import "SimpleAudioEngine.h"

@implementation BossUILayer

@synthesize gameScene;
@synthesize pauseMenu;
@synthesize info;
@synthesize pause;

- (id)init
{
	if( self = [super init] )
	{
        i=0;
        
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
        
        startIcon = [[CCSprite alloc] initWithFile:@"start.png"];
        [startIcon setPosition:ccp(135,285)];
        startIcon.anchorPoint = ccp(0.5f, 0.0f);
        [self addChild:startIcon];
        
        endIcon = [[CCSprite alloc] initWithFile:@"goal.png"];
        [endIcon setPosition:ccp(371,285)];
        endIcon.anchorPoint = ccp(0.5f, 0.0f);
        [self addChild:endIcon];
        
        gaugeBg = [[CCSprite alloc] initWithFile:@"gaugebg.png"];
        [gaugeBg setPosition:ccp(253,294)];
        gaugeBg.anchorPoint = ccp(0.5f, 0.0f);
        [self addChild:gaugeBg];
        
        gauge = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"gauge.png"] rect:CGRectMake(0,0,196,8)];
        [gauge setPosition:ccp(155,296)];
        gauge.anchorPoint = ccp(0.0f, 0.0f);
        [self addChild:gauge];
        
        
        
        info = [CCMenuItemImage itemFromNormalImage:@"cartbutton.png" selectedImage:@"cartbutton_pressed.png" block:^(id sender) {
            if (gameScene.gameState == GAME_STATE_START) {
                gameScene.gameState = GAME_STATE_PAUSE;
                gameScene.gameLayer.isTouchEnabled = NO;
                
                NSString *msg = @"Beat It!!";
                
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
        
        
        
        pause = [CCMenuItemImage itemFromNormalImage:@"pause.png" selectedImage:@"pause_pressed.png" block:^(id sender) {
            if (gameScene.gameState == GAME_STATE_START) {
                gameScene.gameState = GAME_STATE_PAUSE;
                [self addChild:[GamePauseMenuLayer layerWithStage:gameScene] z:10000];
                gameScene.gameLayer.isTouchEnabled = NO;
            }
        }];
        pause.anchorPoint = ccp(0.5f, 0.0f);        
        
        pauseMenu = [CCMenu menuWithItems:pause, info,nil];
        pauseMenu.anchorPoint = ccp(0.5f, 0.0f);
        
        [pauseMenu setPosition:ccp(0,0)];
        [info setPosition:ccp(415,285)];
        [pause setPosition:ccp(455,285)];
        
        [self addChild:pauseMenu];
    }
	
	return self;
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
    
    [self gaugeUpdate];
}

-(void) gaugeUpdate{
    if(gameScene.gameLayer.boss.bossHp > -1){
        float gaugeCount = 200 / (float)gameScene.gameLayer.boss.bossMaxHp; 
        [gauge setTextureRect:CGRectMake(0,0,(gaugeCount * (float)gameScene.gameLayer.boss.bossHp),8)];   
    }
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
