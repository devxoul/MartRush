//
//  ResultScene.m
//  MartRush
//
//  Created by omniavinco on 11. 10. 10..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#define START_POSITION CGPointMake(10, 20)
#define END_POSITION CGPointMake(200, 20)

#import "ResultScene.h"
#import "SimpleAudioEngine.h"
#import "Merchandise.h"

@interface ResultScene(private)
- (void)updateLabel;
@end


@implementation ResultScene

+(CCScene *)sceneWithMerchandises:(NSArray *)merchandises andMission:(NSDictionary *)mission
{
  CCScene *scene = [CCScene node];
  
  CCLayer *layer = [[[ResultScene alloc] initWithMerchandises:merchandises andMission:mission] autorelease];
  
  [scene addChild:layer];
  
  return scene;
}

- (CCLayer *)initWithMerchandises:(NSArray *)merchandises andMission:(NSDictionary *)mission
{
  if (self = [super init])
  {
    numberOfCorrect = numberOfMiscorrect = compensation = 0;
    
    gottenMerchandiseArray = [[NSMutableArray alloc] initWithArray:merchandises];
    missionDictionary = [[NSMutableDictionary alloc] initWithDictionary:mission];
    
    CCSprite *background = [CCSprite spriteWithFile:@""];
    
    [background setPosition:CGPointMake(240, 160)];
    [self addChild:background z:0];
    
    CCSprite *reciept = [CCSprite spriteWithFile:@""];
    
    [reciept setPosition:CGPointMake(270, 20)];
    [self addChild:reciept z:10];
    
    numberOfCorrectLabel = [CCLabelTTF labelWithString:@"0" fontName:@"" fontSize:24];
    numberOfMiscorrectLabel = [CCLabelTTF labelWithString:@"0" fontName:@"" fontSize:24];
    compensationLabel = [CCLabelTTF labelWithString:@"0" fontName:@"" fontSize:24];
    
    
    // TODO: replace labels
    [numberOfCorrectLabel setPosition:CGPointMake(0, 0)];
    [numberOfMiscorrectLabel setPosition:CGPointMake(0, 0)];
    [compensationLabel setPosition:CGPointMake(0, 0)];
    
    [self addChild:numberOfCorrectLabel z:15];
    [self addChild:numberOfMiscorrectLabel z:15];
    [self addChild:compensationLabel z:15];
    
    [self schedule:@selector(update) interval:0.05];
    
    return self;
  }
  
  return nil;
}

- (void)update:(ccTime)dt
{
  if (gottenMerchandiseArray.count > 0) {
    NSString *name = [(Merchandise *)[gottenMerchandiseArray objectAtIndex:0] name];
    if ([missionDictionary objectForKey:name] > 0) {
      [missionDictionary setObject:[NSNumber numberWithInt:([[missionDictionary objectForKey:name] intValue] - 1)] forKey:name];
      numberOfCorrect++;
      compensation += [(Merchandise *)[gottenMerchandiseArray objectAtIndex:0] price];
      [numberOfCorrectLabel setString:[NSString stringWithFormat:@"%d", numberOfCorrect]];
      [compensationLabel setString:[NSString stringWithFormat:@"%d", compensation]];
    }
    else
    {
      numberOfMiscorrect++;
      [numberOfMiscorrectLabel setString:[NSString stringWithFormat:@"%d", numberOfMiscorrect]];
    }
    
    [gottenMerchandiseArray removeObjectAtIndex:0];
  }
  else
    [self unscheduleAllSelectors];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  if ([gottenMerchandiseArray count] > 0) {
    [self unscheduleAllSelectors];
    [self schedule:@selector(update:) interval:0.01];
  }
  else
  {
    // Goto Stage Select Menu
    [[CCDirector sharedDirector] popScene];
  }
}

-(void)dealloc
{
  [gottenMerchandiseArray dealloc];
  [missionDictionary dealloc];
  [super dealloc];
}

@end