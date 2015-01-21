//
//  Pumabus.h
//  Smarty
//
//  Created by Abner Castro Aguilar on 08/01/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface Pumabus : NSObject

@property (nonatomic, strong)CLLocation *position;
@property (nonatomic, strong)NSDate *datePosition;
@property (nonatomic, strong)NSString *numberLine;
@property (nonatomic, strong)NSString *pumaID;
@property double distanceFromUser;
@property (nonatomic, strong)UIImage *pumaThumb;

- (id)initWithID:(NSString *)IDPuma position:(CLLocation *)position datePosition:(NSDate *)datePosition ofLine:(NSString *)numberLine;
- (id)initWithID:(NSString *)IDPuma datePosition:(NSDate *)date ofLine:(NSString *)numberLine;
- (id)initWithID:(NSString *)IDPuma ofLine:(NSString *)numberLine;
- (id)initWithID:(NSString *)IDPuma;





@end
