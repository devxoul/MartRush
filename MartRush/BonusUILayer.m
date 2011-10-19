//
//  BonusUILayer.m
//  MartRush
//
//  Created by Han Sanghoon on 11. 10. 12..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "BonusUILayer.h"
#import "Boss.h"
#import "GameScene.h"
#import "Player.h"
#import "GameLayer.h"
#import "GamePauseMenuLayer.h"

@implementation BonusUILayer

@synthesize gameScene;
@synthesize pauseMenu;
@synthesize info;
@synthesize pause;

- (id)init
{
	if( self = [super init] )
	{
        i=0;
        limitTime = 30;
        
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
        
        
        
        countLabel = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"%d", limitTime] fontName:@"BurstMyBubble" fontSize:45];
        [countLabel setPosition:ccp(253,295)];
        countLabel.anchorPoint = ccp(0.5f, 0.5f);
        [countLabel setColor:ccBLACK];
        [self addChild:countLabel];
        
        clockIcon = [CCSprite spriteWithFile:@"clockicon.png"];
        clockIcon.anchorPoint = ccp(0.5f, 0.0f);
        [clockIcon setPosition:ccp(220,285)];
        [self addChild:clockIcon];
        
        
        info = [CCMenuItemImage itemFromNormalImage:@"cartbutton.png" selectedImage:@"cartbutton_pressed.png" target:self selector:nil];
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

}

-(void) gaugeUpdate{
}

-(void) startTimer{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeDecrease:) userInfo:nil repeats:YES];

}
-(void)timeDecrease:(id)sender{
    if(gameScene.gameState == GAME_STATE_START){
        limitTime--;
    }
    [countLabel setString:[NSString stringWithFormat:@"%d", limitTime]];
    if(limitTime == 0){
        [timer invalidate];
        gameScene.gameState = GAME_STATE_CLEAR;
    }
}


@end
