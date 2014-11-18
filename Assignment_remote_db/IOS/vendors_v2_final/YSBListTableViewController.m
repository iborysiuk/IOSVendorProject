//
//  YSBListTableViewController.m
//  vendors_v1
//
//  Created by macadmin on 2014-10-15.
//  Copyright (c) 2014 com.example. All rights reserved.
//

#import "YSBListTableViewController.h"
#import "YSBVendorLocation.h"
#import "YSBDetailViewController.h"
#import "YSBAddViewController.h"

@interface YSBListTableViewController ()
{
    YSBModel *_vendorModel;
    NSArray *_feedItems;
    NSDictionary *_alphabetized;
    YSBVendorLocation *_selectedLocation;
}
@end

@implementation YSBListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    
    //Create array object and assign it to _feedItems variable
    _feedItems = [[NSArray alloc] init];
    
    //Create new VendorModel object and assign it to _vendorModel variable
    _vendorModel = [[YSBModel alloc] init];
    
    //Set this view controller object as the delegate for the vendor model objext
    _vendorModel.delegate = self;
    
    //Call the download items methods of the home model object
    [_vendorModel downloadItems];    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)itemsDownloaded:(NSArray *)items {
    
    //Set the downloaded items to the array
    _feedItems = items;
   _alphabetized = [self alphabetized:_feedItems];
    
    //Reload the table view
    [self.listTableView reloadData];
    
}

- (NSDictionary *)alphabetized:(NSArray *)_feedItems {

    NSMutableDictionary *buffer = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < [_feedItems count]; i++) {
     //   NSString *feeditems = [_feedItems objectAtIndex:i];
        YSBVendorLocation *item = [_feedItems objectAtIndex:i];
        NSString *firsLetter = [[item.name substringToIndex:1] uppercaseString];
        
        if ([buffer objectForKey:firsLetter]) {
            [(NSMutableArray *)[buffer objectForKey:firsLetter] addObject:item];
        } else {
            NSMutableArray *multableArray = [[NSMutableArray alloc] initWithObjects:item, nil];
            [buffer setObject:multableArray forKey:firsLetter];
        }
    }
    
    //Sort feedItems
    NSArray *keys = [buffer allKeys];
   /* for (int j = 0; j < [keys count]; j++) {
        NSString *key = [keys objectAtIndex:j];
        [(NSMutableArray *)[buffer objectForKey:key] sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }*/
    
    NSDictionary *result = [NSDictionary dictionaryWithDictionary:buffer];
    return result;
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    NSArray *keys = [_alphabetized allKeys];
    return [keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSArray *unsortedKeys = [_alphabetized allKeys];
    NSArray *sortedKeys = [unsortedKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *key = [sortedKeys objectAtIndex:section];
    NSArray *feedItemsSection = [_alphabetized objectForKey:key];
    return [feedItemsSection count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIndentifier = @"cell";
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
    
    NSArray *unsortedKeys = [_alphabetized allKeys];
    NSArray *sortedKeys = [unsortedKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *key = [sortedKeys objectAtIndex:[indexPath section]];
    NSArray *feedItemsSection = [_alphabetized objectForKey:key];
    YSBVendorLocation *item = [feedItemsSection objectAtIndex:[indexPath row]];
    
    
    [myCell.textLabel setText:item.name];
    return myCell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *keys = [[_alphabetized allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *key = [keys objectAtIndex:section];
    return key;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSArray *keys = [[_alphabetized allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    return keys;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Set selected location to var
   // _selectedLocation = _feedItems[indexPath.row];
    NSArray *unsortedKeys = [_alphabetized allKeys];
    NSArray *sortedKeys = [unsortedKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *key = [sortedKeys objectAtIndex:[indexPath section]];
    NSArray *feedItemsSection = [_alphabetized objectForKey:key];
    _selectedLocation = [feedItemsSection objectAtIndex:[indexPath row]];
    //Manually call segue to detail view controller
    [self performSegueWithIdentifier:@"detail_push" sender:self];
    
}

- (NSInteger)realRowNumberForIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView
{
    NSInteger retInt = 0;
    if (!indexPath.section) {
        return  indexPath.row;
    }
    for (int i = 0; i < indexPath.section; i++) {
        retInt += [tableView numberOfRowsInSection:i];
    }
    
    return retInt + indexPath.row;

}
-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger realRows = [self realRowNumberForIndexPath:indexPath inTableView:tableView];
    cell.backgroundColor = (realRows%2)?[UIColor lightGrayColor]:[UIColor lightTextColor];
}


#pragma mark Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get reference to the destination view controller
    YSBDetailViewController *detailVC = segue.destinationViewController;
    
    if (_selectedLocation != nil) {
       detailVC.selectedLocation = _selectedLocation;
    };
    
    YSBAddViewController *addVC = segue.destinationViewController;
    
}

- (IBAction)addV:(id)sender {
    
    [self performSegueWithIdentifier:@"add_push" sender:self];
}
@end
