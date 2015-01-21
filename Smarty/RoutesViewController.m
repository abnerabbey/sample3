//
//  RoutesViewController.m
//  Smarty
//
//  Created by Abner Castro Aguilar on 11/12/14.
//  Copyright (c) 2014 Abner Castro Aguilar. All rights reserved.
//

#import "RoutesViewController.h"

@interface RoutesViewController ()
{
    NSArray *routes;
}

@end

@implementation RoutesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Navigation bar customization
    [[UINavigationBar appearance] setTranslucent:NO];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancelar" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelView)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.title = @"Rutas";
    
    
    routes = [[NSArray alloc] initWithObjects: @"Ninguna", @"Ruta 1",@"Ruta 2", @"Ruta 3", @"Ruta 4", @"Ruta 5", @"Ruta 6", @"Ruta 7", @"Ruta 8", @"Ruta 9", @"Ruta 10", @"Ruta 11", @"Ruta 12", nil];
    
    //Table view customization
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
    RoutesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"routesID" forIndexPath:indexPath];
    cell.labelRouteName.text = [routes objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[self delegate] didRouteSelected:[indexPath row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Helper Methods
- (void)cancelView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end



















































































































































































































































