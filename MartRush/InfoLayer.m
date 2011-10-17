//
//  InfoLayer.m
//  MartRush
//
//  Created by sung-eun Im on 11. 10. 14..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "MenuLayer.h"
#import "InfoLayer.h"
#import "UserData.h"

@implementation InfoLayer

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        infoBg = [[CCSprite alloc] initWithFile:@"setting_bg.png"];
        [self addChild:infoBg];
        
        [infoBg setPosition:ccp(0, 0)];
        [infoBg setAnchorPoint:CGPointZero];
        
        CCMenuItemImage* back = [CCMenuItemImage itemFromNormalImage:@"back_pink.png" selectedImage:@"back_blue.png" 
                                                              target:self selector:@selector(moveBack:)];
        
        back.anchorPoint = CGPointZero;
        
        CCMenu* menu = [CCMenu menuWithItems:back, nil];
        [menu setAnchorPoint:CGPointZero];
        [menu setPosition:ccp(0, 270)];
        
        [self addChild:menu];
    }
    
    return self;
}

+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
    InfoLayer *layer = [InfoLayer node];
    [scene addChild:layer];
    
    return scene;       
}

-(void)moveBack:(id)sender
{
    if ([UserData userData].backSound)
        [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];    
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL transitionWithDuration:0.3 scene:[MenuLayer scene]]];        
}

@end
