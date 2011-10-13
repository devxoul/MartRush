//
//  Merchandise.m
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Merchandise.h"


@implementation Merchandise

@synthesize merchandiseSpr, wayState, name, price;
@synthesize z = z_;

- (id)initWithName:(NSString *)name_ andSprite:(CCSprite *)sprite andWay:(NSInteger)way andPrice:(NSInteger)price_ andZ:(float)z
{
  if (self = [self init])
  {
    merchandiseSpr = [sprite retain];
    wayState = way;
    name = [name_ retain];
    price = price_;
    [self setZ:z];
    
    return self;
  }
  
  return nil;
}

- (void)setZ:(float)z
{
	float cameraY = 180;
	float cameraAngle = 30;
	float tanAngle = tanf(cameraAngle * M_PI / 180);
	
	float h = 180;
	
	float angle = (90 - cameraAngle) * M_PI / 180;
	
	float z2 = cameraY / ( tanAngle + cameraY / z );
	float y2 = cameraY * tanAngle / (tanAngle + cameraY / z);
	
	float z_2 = cameraY / ( tanAngle + ( cameraY - h ) / z );
	float y_2 = cameraY * tanAngle / ( tanAngle + ( cameraY - h ) / z );
	
  //	float z3 = cosf(angle) * z2 - sinf(angle) * y2;
	float y3 = sinf(angle) * z2 + cosf(angle) * y2;
	
  //	float z_3 = cosf(angle) * z_2 - sinf(angle) * y_2;
	float y_3 = sinf(angle) * z_2 + cosf(angle) * y_2;
	
	self.merchandiseSpr.position = ccp( !wayState ? y3 / 0.9 - 200 : -1 * y3 / 0.9 + 680, y3 );
	self.merchandiseSpr.scale = 0.5 * ( y_3 - y3 ) / self.merchandiseSpr.contentSize.width;
	
	z_ = z;
}

-(void)dealloc
{
  [merchandiseSpr release];
  [name release];
  
  [super dealloc];
}

@end
