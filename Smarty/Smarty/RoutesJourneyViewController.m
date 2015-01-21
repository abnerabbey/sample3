//
//  RoutesJourneyViewController.m
//  Smarty
//
//  Created by Abner Castro Aguilar on 12/12/14.
//  Copyright (c) 2014 Abner Castro Aguilar. All rights reserved.
//

#import "RoutesJourneyViewController.h"
#import "JourneyRoutesCell.h"
#import "TravelingViewController.h"

@interface RoutesJourneyViewController ()
{
    NSArray *routes;
    NSString *routeSelected;
}

@end

@implementation RoutesJourneyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Navigation bar customization
    [[UINavigationBar appearance] setTranslucent:NO];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancelar" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelJourney)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.title = @"¿Qué ruta abordas?";
    
    
    routes = [[NSArray alloc] initWithObjects:@"Ruta 1",@"Ruta 2", @"Ruta 3", @"Ruta 4", @"Ruta 5", @"Ruta 6", @"Ruta 7", @"Ruta 8", @"Ruta 9", @"Ruta 10", @"Ruta 11", @"Ruta 12", nil];
    
    self.tableRoutes.delegate = self;
    self.tableRoutes.dataSource = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[UINavigationBar appearance] setTranslucent:YES];
}

#pragma mark TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [routes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JourneyRoutesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"routesID" forIndexPath:indexPath];
    cell.labelRouteName.text = [routes objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    routeSelected = [routes objectAtIndex:[indexPath row]];
    [self performSegueWithIdentifier:@"travelSegue" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"travelSegue"])
    {
        TravelingViewController *travelInit = [segue destinationViewController];
        travelInit.routeJourney = routeSelected;
    }
}

#pragma mark Helper Methods
- (void)cancelJourney
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end



































































































































































