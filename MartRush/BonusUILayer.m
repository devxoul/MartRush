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
        backGround = [[CCSprite alloc] initWithFile:@"uilayer_bg.png"];
        [backGround setPosition:ccp(240,280)];
        backGround.anchorPoint = ccp(0.5f, 0.0f);
        [self addChild:backGround];
        
        heartSprite1 = [[CCSprite alloc] initWithFile:@"heart.png"];
        [heartSprite1 setPosition:ccp(25,285)];
        heartSprite1.anchorPoint = ccp(0.5f, 0.0f);
        [self addChild:heartSprite1];
        
        
        heartSprite2 = [[CCSprite alloc] initWithFile:@"heart.png"];
        [heartSprite2 setPosition:ccp(58,285)];
        heartSprite2.anchorPoint = ccp(0.5f, 0.0f);
        [self addChild:heartSprite2];
        
        
        heartSprite3 = [[CCSprite alloc] initWithFile:@"heart.png"];
        [heartSprite3 setPosition:ccp(91,285)];
        heartSprite3.anchorPoint = ccp(0.5f, 0.0f);
        [self addChild:heartSprite3];
        
        startIcon = [[CCSprite alloc] initWithFile:@"heart.png"];
        [startIcon setPosition:ccp(135,285)];
        startIcon.anchorPoint = ccp(0.5f, 0.0f);
        [self addChild:startIcon];
        
      
        countLabel = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"%d", limitTime] fontName:@"marker felt" fontSize:25];
        [countLabel setPosition:ccp(253,285)];
        countLabel.anchorPoint = ccp(0.5f, 0.0f);
        [countLabel setColor:ccBLACK];
        [self addChild:countLabel];
        
        endIcon = [[CCSprite alloc] initWithFile:@"heart.png"];
        [endIcon setPosition:ccp(371,285)];
        endIcon.anchorPoint = ccp(0.5f, 0.0f);
        [self addChild:endIcon];
        
        
        info = [CCMenuItemImage itemFromNormalImage:@"cartbutton.png" selectedImage:@"cartbutton_pressed.png" target:self selector:nil];
        info.anchorPoint = ccp(0.5f, 0.0f);
        
        pause = [CCMenuItemImage itemFromNormalImage:@"pause.png" selectedImage:@"pause_pressed.png" target:self selector:nil];
        pause.anchorPoint = ccp(0.5f, 0.0f);        
        
        pauseMenu = [CCMenu menuWithItems:pause, info,nil];
        pauseMenu.anchorPoint = ccp(0.5f, 0.0f);
        
        [pauseMenu setPosition:ccp(0,0)];
        [info setPosition:ccp(415,285)];
        [pause setPosition:ccp(455,285)];
        
        [self addChild:pauseMenu];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeDecrease:) userInfo:nil repeats:YES];
    }
	
	return self;
}

- (void)update{
    if(gameScene.gameLayer.player.playerHp == 2){
        CCFiniteTimeAction *action = [CCFadeOut actionWithDuration:1.0];
        [heartSprite3 runAction:action];
        
    }  
    if(gameScene.gameLayer.player.playerHp == 1){
        CCFiniteTimeAction *action = [CCFadeOut actionWithDuration:1.0];
        [heartSprite2 runAction:action];
        
    }  
    if(gameScene.gameLayer.player.playerHp == 0){
        CCFiniteTimeAction *action = [CCFadeOut actionWithDuration:1.0];
        [heartSprite1 runAction:action];
        
    }
    [self gaugeUpdate];
}

-(void) gaugeUpdate{
    
}

-(void)timeDecrease:(id)sender{
    limitTime--;
    [countLabel setString:[NSString stringWithFormat:@"%d", limitTime]];
    if(limitTime == 0){
        [timer invalidate];
        NSLog(@"Fire");
    }
}


@end
