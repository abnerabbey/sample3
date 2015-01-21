//
//  MainViewController.m
//  Smarty
//
//  Created by Abner Castro Aguilar on 11/12/14.
//  Copyright (c) 2014 Abner Castro Aguilar. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "SmartyLocation.h"
#import "ParseKeys.h"

@interface MainViewController ()
{
    CLLocation *userLocation;
    SmartyLocation *locationSingleton;
    
    UIBarButtonItem *refreshButton;
    
    NSArray *parseDataObjects;
}

@property (nonatomic, strong)ParseKeys *parseKeys;//Keys to save data in Parse and methods to do it

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Navigation bar customization
    self.navigationItem.title = @"Smarty";
    
    //Map view Configuration
    //This sets the initial region that has to be in Campus Central, CU
    [self performSelector:@selector(setInitialRegionInMap) withObject:nil afterDelay:0.5];
    [[self mapUser] setDelegate:self];
    
    //Button Localization
    UIBarButtonItem *locMeButton = [[UIBarButtonItem alloc] initWithTitle:@"Loc" style:UIBarButtonItemStyleBordered target:self action:@selector(locMe)];
    NSArray *rigthButtons = [[NSArray alloc] initWithObjects: self.routesButton, locMeButton, nil];
    self.navigationItem.rightBarButtonItems = rigthButtons;
    
    refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshData)];
    refreshButton.enabled = NO;
    UIBarButtonItem *getPumaBusButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(getTheBusOn)];
    NSArray *leftButtons = [[NSArray alloc] initWithObjects:refreshButton, getPumaBusButton, nil];
    self.navigationItem.leftBarButtonItems = leftButtons;
    
    locationSingleton = [SmartyLocation sharedInstance];
    locationSingleton.locationManager.delegate = self;
}

#pragma mark IBActions
- (void)refreshData
{
    
}

- (void)getTheBusOn
{
    [[locationSingleton locationManager] stopUpdatingLocation];
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)
        
        [self performSegueWithIdentifier:@"initJourney" sender:self];
    
    else
        
    {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Localización Desactivada" message:@"Necesitas permitir la localización de Smarty en Ajustes para poder continuar." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        
        UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"Activar" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            
        }];
        
        [alert addAction:okAction];
        
        [alert addAction:settingsAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}


#pragma mark Methods Created
- (void)locMe
{
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.mapUser.userLocation.location.coordinate, 500, 500);
        [[self mapUser] setRegion:region animated:YES];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Localización Desactivada" message:@"Necesitas permitir la localización de Smarty en Ajustes para poder continuar." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"Activar" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        [alert addAction:okAction];
        [alert addAction:settingsAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark Core Location Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    userLocation = [locations lastObject];
}

#pragma mark Routes View Delegate
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"segueRoutes"])
    {
        RoutesViewController *routesView = [segue destinationViewController];
        routesView.delegate = self;
    }
    if([[segue identifier] isEqualToString:@"initJourney"])
    {
        NSArray *IDs = [self getAllPumabusesID:parseDataObjects];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if(IDs.count > 0)
        {
            NSLog(@"IDs: %@", IDs);
            [defaults setObject:IDs forKey:@"IDs"];
            [defaults synchronize];
        }
        else
        {
            [defaults removeObjectForKey:@"IDs"];
            [defaults synchronize];
        }
    }
}

- (void)didRouteSelected:(NSInteger)numberRoute
{
    [self.mapUser removeAnnotations:[self.mapUser annotations]];
    const NSString *routeName = @"Ruta";
    if(numberRoute != 0)
    {
        [[locationSingleton locationManager] setDelegate:self];
        [[locationSingleton locationManager] startUpdatingLocation];
        self.navigationItem.title = [NSString stringWithFormat:@"%@ %d", routeName, (int)numberRoute];
        
        //Parse Data
        self.parseKeys = [[ParseKeys alloc] init];
        PFQuery *query = [PFQuery queryWithClassName:[self.navigationItem.title stringByReplacingOccurrencesOfString:@" " withString:@"_"]];
         NSLog(@"Escogí ruta y ahora va el query");
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if(!error){
                parseDataObjects = objects;
                [self createPumabuses:parseDataObjects];
            }
            else
                [self ParseQueryErrorAlert];
        }];
        refreshButton.enabled = YES;
    }
    else
    {
        refreshButton.enabled = NO;
        self.navigationItem.title = @"Smarty";
    }
}

#pragma mark Helper Methods
- (void)setInitialRegionInMap
{
    CLLocationCoordinate2D campusCoords;
    campusCoords.latitude = 19.333360;
    campusCoords.longitude = -99.187222;
    MKCoordinateRegion centralCampusCU = MKCoordinateRegionMakeWithDistance(campusCoords, 2500, 2500);
    [[self mapUser] setRegion:centralCampusCU animated:YES];
}

- (void)ParseQueryErrorAlert
{
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error de Conexión" message:@"Hubo un error de conexión al intentar descargar los datos. Inténtalo más tarde" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    [errorAlert addAction:okAction];
    [self presentViewController:errorAlert animated:YES completion:nil];
}


#pragma mark Parse Data
- (void)createPumabuses:(NSArray *)parseObjects
{
    if(parseObjects.count > 0)
    {
        for (PFObject *object in parseObjects)
        {
            NSString *latitud = [object objectForKey:self.parseKeys.pumabusLatitude];
            NSString *longitud = [object objectForKey:self.parseKeys.pumabusLongitude];
            NSString *hora = [object objectForKey:self.parseKeys.pumabusHour];
            NSString *minuto = [object objectForKey:self.parseKeys.pumabusMinute];
            
            MKPointAnnotation *puma = [[MKPointAnnotation alloc] init];
            puma.title = [NSString stringWithFormat:@"Pumabús a las %d:%d", [hora intValue], [minuto intValue]];
            CLLocation *location = [[CLLocation alloc] initWithLatitude:[latitud doubleValue] longitude:[longitud doubleValue]];
            CLLocationDistance distance = [location distanceFromLocation:userLocation];
            puma.subtitle = [NSString stringWithFormat:@"A %f m de ti", distance];
            puma.coordinate = location.coordinate;
            [self.mapUser addAnnotation:puma];
        }
    }
    else
    {
        UIAlertController *noPumasAlert = [UIAlertController alertControllerWithTitle:@"No Hay Pumabuses" message:@"No hay Pumabuses en estos momentos. Inténtalo más tarde con el botón de refrescar" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
        [noPumasAlert addAction:okAction];
        [self presentViewController:noPumasAlert animated:YES completion:nil];
    }
    [[locationSingleton locationManager] stopUpdatingLocation];
}

- (NSArray *)getAllPumabusesID:(NSArray *)parseObjects
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[parseObjects count]];
    for (PFObject *object in parseObjects)
    {
        NSString *ID = [object objectForKey:self.parseKeys.pumabusID];
        [array addObject:ID];
    }
    return (NSArray *)array;
}

@end



















































































































































































































































