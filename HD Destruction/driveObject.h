//
//  transactionObject.h
//  Hitch
//
//  Created by Robert Crosby on 8/21/17.
//  Copyright © 2017 fully toasted. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface driveObject : NSObject

@property (nonatomic, strong) NSString* serial;
@property (nonatomic, strong) NSNumber* time;

-(instancetype)initWithType:(NSString*)serial andTime:(int)time;

@end
