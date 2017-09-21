//
//  transactionObject.m
//  Hitch
//
//  Created by Robert Crosby on 8/21/17.
//  Copyright © 2017 fully toasted. All rights reserved.
//

#import "driveObject.h"

@implementation driveObject

-(instancetype)initWithType:(NSString*)serial andTime:(int)time{
    self = [super init];
    if(self)
    {
        self.serial = serial;
        self.time = [NSNumber numberWithInt:time];

    }
    return self;
}



@end
