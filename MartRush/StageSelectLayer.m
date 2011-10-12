//
//  StageSelectLayer.m
//  MartRush
//
//  Created by sung-eun Im on 11. 10. 13..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "StageSelectLayer.h"

@implementation StageSelectLayer

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
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

@end
