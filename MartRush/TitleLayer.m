//
//  TitleLayer.m
//  MartRush
//
//  Created by Youjin Lim on 11. 10. 2..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "TitleLayer.h"


@implementation TitleLayer

+ (CCScene *)scene
{
    CCScene *scene = [CCScene node];
    TitleLayer *layer = [TitleLayer node];
    [scene addChild:layer];
    return scene;
}

@end
