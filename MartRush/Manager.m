//
//  Manager.m
//  MartRush
//
//  Created by 전 수열 on 11. 10. 4..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Manager.h"


@implementation Manager

@synthesize gameScene = gameScene_;

- (id)initWithGameScene:(GameScene *)gameScene;
{
	if([self init])
	{
		gameScene_ = gameScene;
	}
  
	return self;
}

- (void)update
{
}
@end
