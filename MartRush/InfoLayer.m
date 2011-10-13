//
//  InfoLayer.m
//  MartRush
//
//  Created by sung-eun Im on 11. 10. 14..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "InfoLayer.h"

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
    
    CCMenuItemImage* back = [CCMenuItemImage itemFromNormalImage:@"skip.png" selectedImage:@"skip_click.png" target:self selector:@selector(moveBack:)];
    
    CCMenu* menu = [CCMenu menuWithItems:back, nil];
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
  [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1 scene:[MenuLayer scene]]];        
}

@end
