//
//  ParseKeys.h
//  Smarty
//
//  Created by Abner Castro Aguilar on 09/01/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ParseKeys : NSObject

@property (nonatomic, strong)NSString *pumabusID;
@property (nonatomic, strong)NSString *pumabusPosition;
@property (nonatomic, strong)NSString *pumabusDatePosition;
@property (nonatomic, strong)NSString *pumabusLatitude;
@property (nonatomic, strong)NSString *pumabusLongitude;
@property (nonatomic, strong)NSString *pumabusHour;
@property (nonatomic, strong)NSString *pumabusMinute;

- (NSArray *)getAllPumabusesID:(NSArray *)parseObjects;

@end
