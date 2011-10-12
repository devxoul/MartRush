//
//  GameUILayer.m
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "GameUILayer.h"
#import "GameScene.h"


@implementation GameUILayer

@synthesize gameScene;
@synthesize pauseMenu;
@synthesize info;
@synthesize pause;

- (id)init
{
	if( self = [super init] )
	{
        i=0;
        
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
        
        gauge = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"gauge.png"] rect:CGRectMake(0,0,0,30)];
        [gauge setPosition:ccp(153,285)];
        gauge.anchorPoint = ccp(0.0f, 0.0f);
        
        [self addChild:gauge];
        
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
    }
	
	return self;
}

- (void)update{
    if(i==200)
        i=0;
    i += 1;
    [gauge setTextureRect:CGRectMake(0,0,i,30)];
}

@end
