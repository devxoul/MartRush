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
        [heartSprite2 setPosition:ccp(65,285)];
        heartSprite2.anchorPoint = ccp(0.5f, 0.0f);
        [self addChild:heartSprite2];

        heartSprite3 = [[CCSprite alloc] initWithFile:@"heart.png"];
        [heartSprite3 setPosition:ccp(105,285)];
        heartSprite3.anchorPoint = ccp(0.5f, 0.0f);
        [self addChild:heartSprite3];
        
        /*
        gauge = [[CCSprite alloc] initWithFile:@"gauge.png"];
        [gauge setPosition:ccp(260,285)];
        gauge.anchorPoint = ccp(0.5f, 0.0f);
        [self addChild:gauge];
        */
        
        gauge = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"gauge.png"] rect:CGRectMake(0,0,0,30)];
        [gauge setPosition:ccp(130,285)];
        gauge.anchorPoint = ccp(0.0f, 0.0f);
        
        [self addChild:gauge];

        infoButton = [[CCSprite alloc] initWithFile:@"heart.png"];
        [infoButton setPosition:ccp(415,285)];
        infoButton.anchorPoint = ccp(0.5f, 0.0f);
        [self addChild:infoButton];
        
        pauseButton = [[CCSprite alloc] initWithFile:@"heart.png"];
        [pauseButton setPosition:ccp(455,285)];
        pauseButton.anchorPoint = ccp(0.5f, 0.0f);
        [self addChild:pauseButton];

    }
	
	return self;
}

- (void)update{
    if(i==260)
        i=0;
    i += 1;
    [gauge setTextureRect:CGRectMake(0,0,i,30)];
}

@end
