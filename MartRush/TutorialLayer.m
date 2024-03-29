//
//  TutorialLayer.m
//  MartRush
//
//  Created by sung-eun Im on 11. 10. 14..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "TutorialLayer.h"
#import "StageSelectScene.h"
#import "MenuLayer.h"

@implementation TutorialLayer

- (id)init
{
    self = [super init];
    if (self) {
        
        self.isTouchEnabled = YES;
        
        // Initialization code here.
        for (int i = 0; i < TUTORIAL_MAX_SCENE; i++)
        {
            sceneSpr[i] = [[CCSprite alloc] initWithFile:[NSString stringWithFormat:@"scene_%d.png", i]];
            [self addChild:sceneSpr[i]];
            
            sceneSpr[i].visible = NO;
            sceneSpr[i].anchorPoint = ccp(0.5, 0.5);
            sceneSpr[i].position = ccp(240, 160);
        }
        
        tutorialCount = 0;
        sceneSpr[tutorialCount].visible = YES;
        
        skip = [CCMenuItemImage itemFromNormalImage:@"skip.png" selectedImage:@"skip_click.png" target:self 
                                           selector:@selector(clickSkip:)];     
        
        [skip setPosition:ccp(380, 260)];
        [skip setAnchorPoint:CGPointZero];
        
        back = [CCMenuItemImage itemFromNormalImage:@"back_pink.png" selectedImage:@"back_blue.png" target:self 
                                           selector:@selector(clickBack:)];
        
        [back setPosition:ccp(40, 280)];
        [skip setAnchorPoint:CGPointZero];
        
        CCMenu* menu = [CCMenu menuWithItems:back, nil];
        [menu setPosition:CGPointZero];
        [menu setAnchorPoint:CGPointZero];
        
        [self addChild:menu];
        
        CCMenu* menu1 = [CCMenu menuWithItems:skip, nil];
        [menu1 setPosition:CGPointZero];
        [menu1 setAnchorPoint:CGPointZero];
        
        [self addChild:menu1];
        
    }
    
    return self;
}

+(CCScene*)scene
{
    CCScene *scene = [CCScene node];
    TutorialLayer *layer = [TutorialLayer node];
    [scene addChild:layer];
    
    return scene;    
}

-(void)clickSkip:(id)sender
{
    [[CCDirector sharedDirector] pushScene:[CCTransitionSlideInR transitionWithDuration:1 scene:[StageSelectScene scene]]];    
}

-(void)clickBack:(id)back
{
    [[CCDirector sharedDirector] pushScene:[CCTransitionSlideInL transitionWithDuration:1 scene:[MenuLayer scene]]];    
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    sceneSpr[tutorialCount].visible = NO;
    
    tutorialCount++;
    if (tutorialCount == TUTORIAL_MAX_SCENE) 
        [[CCDirector sharedDirector] pushScene:[CCTransitionFadeDown transitionWithDuration:1 scene:[StageSelectScene scene]]];    
    else
        sceneSpr[tutorialCount].visible = YES;
    
}

-(void)dealloc
{
    [super dealloc];
    
    for (int i = 0; i < TUTORIAL_MAX_SCENE; i++) 
        [sceneSpr[i] release];
}

@end
