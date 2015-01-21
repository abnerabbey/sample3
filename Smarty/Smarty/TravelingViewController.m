//
//  TravelingViewController.m
//  Smarty
//
//  Created by Abner Castro Aguilar on 12/12/14.
//  Copyright (c) 2014 Abner Castro Aguilar. All rights reserved.
//

#import "TravelingViewController.h"
#import <Parse/Parse.h>
#import "ParseKeys.h"

@interface TravelingViewController ()
{
    SmartyLocation *locationSingleton;
    NSTimer *timerLocation;
    NSString *pumaID;
    
    ParseKeys *parseKeys;
}

@end

@implementation TravelingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Core Location Singleton
    locationSingleton = [SmartyLocation sharedInstance];
    [[locationSingleton locationManager] setDelegate:self];
    [[locationSingleton locationManager] startUpdatingLocation];
    
    //Set the route name salected from the table view that the user selected before to travel. This is to add a new pumabus
    self.routeJourney = [self.routeJourney stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.IDsPumabus = [defaults objectForKey:@"IDs"];
    if(self.IDsPumabus.count > 0)
    {
        for(int i = 0; i < self.IDsPumabus.count; i++)
        {
            NSString *oldID = [self.IDsPumabus objectAtIndex:i];
            int newID = [oldID intValue] + 1;
            pumaID = [NSString stringWithFormat:@"%d", newID];
        }
    }
    else
        pumaID = @"1";
    self.pumabus = [[Pumabus alloc] initWithID:pumaID ofLine:self.routeJourney];
    parseKeys = [[ParseKeys alloc] init];
    
    [self performSelector:@selector(updateLocationToParse) withObject:nil afterDelay:1.0];
    
    //UINavigationBar configuration
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"Viajando...";
    
    NSLog(@"routeJourney: %@", self.routeJourney);
    
}

#pragma mark Location Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.locationUpdate = [locations lastObject];
}

- (void)updateLocationToParse
{
    NSLog(@"Entra");
    self.pumabus.position = self.locationUpdate;
    self.pumabus.datePosition = [NSDate date];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:self.pumabus.datePosition];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    int hora = (int)hour;
    int minuto = (int)minute;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.calendar = calendar;
    formatter.locale = calendar.locale;
    [formatter setDateStyle:NSDateFormatterShortStyle];
    NSString *fecha = [formatter stringFromDate:self.pumabus.datePosition];
    
    //[self deleteObsoleteData];
    PFObject *objectParseManager = [PFObject objectWithClassName:self.routeJourney];
    objectParseManager[parseKeys.pumabusID] = pumaID;
    objectParseManager[parseKeys.pumabusLatitude] = [NSString stringWithFormat:@"%f", self.pumabus.position.coordinate.latitude];
    objectParseManager[parseKeys.pumabusLongitude] = [NSString stringWithFormat:@"%f", self.pumabus.position.coordinate.longitude];
    objectParseManager[parseKeys.pumabusDatePosition] = fecha;
    objectParseManager[parseKeys.pumabusHour] = [NSString stringWithFormat:@"%d", hora];
    objectParseManager[parseKeys.pumabusMinute] = [NSString stringWithFormat:@"%d", minuto];
    [objectParseManager saveInBackground];
    NSLog(@"Success! (=");
    
}

- (void)deleteObsoleteData
{
    PFQuery *query = [PFQuery queryWithClassName:self.routeJourney];
    [query whereKeyExists:self.pumabus.pumaID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            for (PFObject *object in objects) {
                [object delete];
            }
        }
    }];
}

#pragma IBActions
- (IBAction)stopJourney:(UIButton *)sender
{
    //Stop Core Location updates
    [[locationSingleton locationManager] stopUpdatingLocation];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"¿Calificar Pumabús?" message:@"¿Deseas calificar la unidad del pumabús donde viajaste?\nSólo te tomará unos segundos." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *despues = [UIAlertAction actionWithTitle:@"Después" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *calificar = [UIAlertAction actionWithTitle:@"Calificar" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:calificar];
    [alert addAction:despues];
    [self presentViewController:alert animated:YES completion:nil];
}
@end


























































































































