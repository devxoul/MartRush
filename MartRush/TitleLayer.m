//
//  TitleLayer.m
//  MartRush
//
//  Created by Youjin Lim on 11. 10. 2..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "TitleLayer.h"
#import "SimpleAudioEngine.h"
#import "MenuLayer.h"
#import "UserData.h"

@implementation TitleLayer

+(CCScene *)scene
{
    CCScene *scene = [CCScene node];
    TitleLayer *layer = [TitleLayer node];
    [scene addChild:layer];
    
    return scene;
}

-(id)init
{
	if( (self=[super init] )) {
		
		self.isTouchEnabled = YES;
        
        if ([UserData userData].backSound) 
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"GameBGM.mp3"];
        
        titleBack = [[CCSprite alloc] initWithFile:@"mainbg.png"];
        titleBack.anchorPoint = CGPointZero;
        titleBack.position = ccp(0, 0);
        
        [self addChild:titleBack z:0];
        
        titleBgSprite2 = [[CCSprite alloc] initWithFile:@"mart_bga.png"];
        titleBgSprite2.anchorPoint = CGPointZero;
        titleBgSprite2.position = ccp(0, 0);
        
        [self addChild:titleBgSprite2 z:1];
        
        titleBgSprite2.visible = NO;
        
        titleBgSprite = [[CCSprite alloc] initWithFile:@"mart_bg.png"];
        titleBgSprite.anchorPoint = CGPointZero;
		[titleBgSprite setPosition:ccp(0, 0)];
        
        [self addChild:titleBgSprite z:1];
        
        for (int i = 0; i < 2; i++)
        {
            titleLine[i] = [[CCSprite alloc] initWithFile:@"mart_line.png"];
            titleLine[i].anchorPoint = ccp(0.5, 0.0);
            [titleLine[i] setPosition:ccp(240, 0)];
            
            [self addChild:titleLine[i] z:2];
        }
        
        titleLogo = [[CCSprite alloc] initWithFile:@"mart_logo.png"];
        titleLogo.anchorPoint = ccp(0.5, 0.0);
        titleLogo.position = ccp(240, 0);
        
        [self addChild:titleLogo z:3];
        
        touchTheScreenSprite = [[CCSprite alloc] initWithFile:@"touchthescreen.png"];
        touchTheScreenSprite.anchorPoint = CGPointZero;
        [touchTheScreenSprite setPosition:ccp(0, 0)];
        
        [self addChild:touchTheScreenSprite z:4];
        
	}
	return self;
    
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    touchTheScreenSprite.visible = NO;
    
    [titleLogo runAction:[CCSequence actions:[CCMoveTo actionWithDuration:1.5 position:ccp(titleLogo.position.x , 350)], 
                          [CCCallBlockN actionWithBlock:^(CCNode *node) {
        
        [titleLine[0] runAction:[CCMoveTo actionWithDuration:1.5 position:ccp(360, titleLine[0].position.y)]];
        [titleLine[1] runAction:[CCSequence actions:[CCMoveTo actionWithDuration:1.5 position:ccp(120, titleLine[0].position.y)], 
                                 [CCCallBlockN actionWithBlock:^(CCNode *node) {
            
            titleLogo.visible = NO;
            
            [[CCDirector sharedDirector] pushScene:[CCTransitionSlideInT transitionWithDuration:0.5 scene:[MenuLayer scene]]];
            
            if ([UserData userData].backSound)
                [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];        
        }], nil]];
    }],nil]];
}


-(void)dealloc
{
    [super dealloc];
    
    [titleBack release];
    [titleBgSprite release];
    [titleBgSprite2 release];
    [titleLogo release];
    [titleLine[0] release];
    [titleLine[1] release];
}

@end
