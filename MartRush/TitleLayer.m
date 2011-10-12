//
//  TitleLayer.m
//  MartRush
//
//  Created by Youjin Lim on 11. 10. 2..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "TitleLayer.h"


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
        
//        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"GameBGM.mp3"];
        
        titleBgSprite = [[CCSprite alloc] initWithFile:@"mart_bg.jpg"];
        titleBgSprite.anchorPoint = CGPointZero;
		[titleBgSprite setPosition:ccp(0, 0)];
        
        [self addChild:titleBgSprite z:0];
        
        touchTheScreenSprite = [[CCSprite alloc] initWithFile:@"touchthescreen.png"];
        touchTheScreenSprite.anchorPoint = CGPointZero;
        [touchTheScreenSprite setPosition:ccp(0, 50)];
        
        [self addChild:touchTheScreenSprite z:1];
                
	}
	return self;
    
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
//    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1 scene:[MenuLayer scene]]];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:0.3 scene:[MenuLayer scene]]];
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];
}


-(void)dealloc
{
    [super dealloc];
    
//    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
}

@end
