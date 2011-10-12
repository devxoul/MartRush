//
//  StageSelectScene.m
//  MartRush
//
//  Created by omniavinco on 11. 10. 13..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "StageSelectScene.h"
#import "GameScene.h"

@implementation StageSelectScene

+ (CCScene *)scene
{
  CCScene *scene = [CCScene node];
  
  [scene addChild:[StageSelectScene node]];
  
  return scene;
}

- (id)init
{
  if (self = [super init]) {
    stageInfoArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StageList" ofType:@"plist"]];
    
    SlidingMenuGrid* menu = [SlidingMenuGrid menuWithArray:nil cols:4 rows:1 position:CGPointMake(240, 160) padding:CGPointMake(20, 0)];
    
    [self addChild:menu];
    
    return self;
  }
  
  return nil;
}

- (void)selectLevel:(id)sender
{
  [[CCDirector sharedDirector] pushScene:[[[GameScene alloc] initWithMissionName:@""] autorelease]];
}

@end
