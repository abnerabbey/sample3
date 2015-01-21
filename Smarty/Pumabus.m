//
//  Pumabus.m
//  Smarty
//
//  Created by Abner Castro Aguilar on 08/01/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import "Pumabus.h"

@implementation Pumabus

- (id)init
{
    self = [super init];
    if(self)
    {
        self.pumaID = 0;
        self.position = nil;
        self.datePosition = nil;
        self.numberLine = nil;
    }
    return self;
}

- (id)initWithID:(NSString *)IDPuma position:(CLLocation *)position datePosition:(NSDate *)datePosition ofLine:(NSString *)numberLine
{
    self = [super init];
    if(self)
    {
        self.pumaID = IDPuma;
        self.position = position;
        self.datePosition = datePosition;
        self.numberLine = numberLine;
    }
    return self;
}

- (id)initWithID:(NSString *)IDPuma datePosition:(NSDate *)date ofLine:(NSString *)numberLine
{
    self = [super init];
    if(self)
    {
        self.pumaID = IDPuma;
        self.datePosition = date;
        self.numberLine = numberLine;
        self.position = nil;
    }
    return self;
}

- (id)initWithID:(NSString *)IDPuma ofLine:(NSString *)numberLine
{
    self = [super init];
    if(self)
    {
        self.pumaID = IDPuma;
        self.numberLine = numberLine;
        self.position = 0;
        self.datePosition = nil;
    }
    return self;
}

- (id)initWithID:(NSString *)IDPuma
{
    self = [super init];
    if(self)
    {
        self.pumaID = IDPuma;
        self.position = nil;
        self.datePosition = nil;
        self.numberLine = nil;
    }
    return self;
}

@end








































































































































































