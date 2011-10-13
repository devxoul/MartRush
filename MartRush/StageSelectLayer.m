//
//  StageSelectLayer.m
//  MartRush
//
//  Created by sung-eun Im on 11. 10. 13..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "StageSelectLayer.h"
#import "SlidingMenuGrid.h"
#import "GameScene.h"

@implementation StageSelectLayer

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        CCSprite *background = [CCSprite spriteWithFile:@""];
        [background setPosition:CGPointMake(240, 160)];
        [self addChild:background];
        
        stageInfoArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StageList" ofType:@"plist"]];
        
        NSMutableArray *menuArray = [NSMutableArray array];
        for (NSString *stageName in stageInfoArray) {
            CCMenuItemSprite *item = [CCMenuItemSprite itemFromNormalSprite:
                                      [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png"]]
                                                             selectedSprite:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png"]]
                                                                     target:self selector:@selector(selectLevel:)];
            item.tag = [stageInfoArray indexOfObject:stageName];
            [menuArray addObject:item];
        }
        
        SlidingMenuGrid* menu = [SlidingMenuGrid menuWithArray:menuArray cols:4 rows:1 position:CGPointMake(240, 160) padding:CGPointMake(20, 0)];
        
        [menu setPosition:CGPointMake(240, 160)];
        
        [self addChild:menu];
        
        return self;        
    }
    
    return self;
}

+(CCScene*)scene
{
    CCScene *scene = [CCScene node];
    StageSelectLayer *layer = [StageSelectLayer node];
    [scene addChild:layer];
    
    return scene;           
}

- (void)selectLevel:(id)sender
{
    [[CCDirector sharedDirector] pushScene:[[[GameScene alloc] initWithMissionName:[stageInfoArray objectAtIndex:[sender tag]]] autorelease]];
}


@end
