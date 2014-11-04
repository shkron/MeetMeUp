//
//  ViewController.m
//  MeetMeUp
//
//  Created by Alex on 11/3/14.
//  Copyright (c) 2014 Alexey Emelyanov. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"
#define kStartingPoint @"https://api.meetup.com/2/open_events.json?zip=94103&text=mobile&time=,1w&key=3c7f626d333e3a7433a44552f6b775f"

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *tableViewArray;
@property (nonatomic, strong) NSArray *dataMethodArray;

@end

@implementation RootViewController

#pragma mark - view load sequence

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self dataWithURLRequest:kStartingPoint];
//    self.tableViewArray = self.dataMethodArray;

    NSURL *url = [NSURL URLWithString:kStartingPoint];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                           if (connectionError)
                                           {
                                               [self netowrkAlertWindow:connectionError.localizedDescription];
                                           }
                                           else
                                           {
                                               NSDictionary *rawDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                               self.tableViewArray = [rawDict objectForKey:@"results"];
                                               [self.tableView reloadData];
                                           }
                                       }];





}

#pragma mark - delegation methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *meetUpDict = self.tableViewArray[indexPath.row];
     NSDictionary *groupDict = [meetUpDict objectForKey:@"group"];
    cell.textLabel.text = [meetUpDict objectForKey:@"name"];
    cell.detailTextLabel.text = [groupDict objectForKey:@"name"];

//    NSDictionary *venueDict = [meetUpDict objectForKey:@"venue"];

//    NSNumber *groupID = [groupDict objectForKey:@"id"];
//    NSString *apiURL = [NSString stringWithFormat:@"https://api.meetup.com/2/groups.json?photo-host=public&group_id=%@&key=3c7f626d333e3a7433a44552f6b775f", groupID];
//    NSURL *url = [NSURL URLWithString:apiURL];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//                                           if (connectionError)
//                                           {
//                                               [self netowrkAlertWindow:connectionError.localizedDescription];
//                                           }
//                                           else
//                                           {
//                                               NSDictionary *rawDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                                               self.dataMethodArray = [rawDict objectForKey:@"results"];
//                                           }
//                                       }];
//
//
//    NSDictionary *photoDict = self.dataMethodArray[0];
//    NSDictionary *groupPhotoDict = [photoDict objectForKey:@"group_photo"];
//    NSString *thumbPhoto = [groupPhotoDict objectForKey:@"thumb_link"];
//
//    dispatch_async(dispatch_get_global_queue(0,0), ^{
//        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:thumbPhoto]];
//        if ( data == nil )
//            return;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // WARNING: is the cell still using the same data by this point??
//            cell.imageView.image = [UIImage imageWithData: data];
//            [self.tableView reloadData];
//        });
//    });
//

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

return self.tableViewArray.count;

}

#pragma mark - methods

-(void)netowrkAlertWindow:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network Error" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Gosh Darnet" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}

//-(void)dataWithURLRequest:(NSString *)urlString
//{

//    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=94103&text=mobile&time=,1w&key=3c7f626d333e3a7433a44552f6b775f"];
//    NSURL *url = [NSURL URLWithString:kStartingPoint];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//                                           if (connectionError)
//                                           {
//                                               [self netowrkAlertWindow:connectionError.localizedDescription];
//                                           }
//                                           else
//                                           {
//                                               NSDictionary *rawDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                                               self.tableViewArray = [rawDict objectForKey:@"results"];
//                                               [self.tableView reloadData];
//                                           }
//                                       }];
//}

//-(void)getGroupThumbPhoto
//{
//    dispatch_async(dispatch_get_global_queue(0,0), ^{
//        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: @"http://myurl/mypic.jpg"]];
//        if ( data == nil )
//            return;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // WARNING: is the cell still using the same data by this point??
//            cell.image = [UIImage imageWithData: data];
//        });
//        [data release];
//    });
//}

#pragma mark - segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *vc = segue.destinationViewController;
    NSInteger rowNumber = [self.tableView indexPathForSelectedRow].row;
    NSDictionary *details = [self.tableViewArray objectAtIndex:rowNumber];
    vc.eventDetails = details;

}

@end
