//
//  StageSelectLayer.h
//  MartRush
//
//  Created by sung-eun Im on 11. 10. 13..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface StageSelectLayer : CCLayer
{
    NSArray *stageInfoArray;    
}

+ (CCScene *)scene;
- (void)selectLevel:(id)sender;

@end
