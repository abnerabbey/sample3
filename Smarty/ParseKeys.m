//
//  ParseKeys.m
//  Smarty
//
//  Created by Abner Castro Aguilar on 09/01/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import "ParseKeys.h"

@implementation ParseKeys

- (id)init
{
    self = [super init];
    if(self)
    {
        self.pumabusID = @"PumabusID";
        self.pumabusPosition = @"PumabusPosition";
        self.pumabusDatePosition = @"DatePosition";
        self.pumabusLatitude = @"PumabusLatitude";
        self.pumabusLongitude = @"PumabusLongitude";
        self.pumabusHour = @"PumabusHour";
        self.pumabusMinute = @"PumabusMinute";
    }
    return self;
}

- (NSArray *)getAllPumabusesID:(NSArray *)parseObjects
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[parseObjects count]];
    for (PFObject *object in parseObjects)
    {
        NSString *ID = [object objectForKey:[self pumabusID]];
        [array addObject:ID];
    }
    return (NSArray *)array;
}






























































































@end
