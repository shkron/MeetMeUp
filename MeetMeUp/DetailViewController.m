//
//  DetailViewController.m
//  MeetMeUp
//
//  Created by Alex on 11/3/14.
//  Copyright (c) 2014 Alexey Emelyanov. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *rsvpCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupInfoLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *webButtonLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    NSNumber *rsvpCountNumber = [self.eventDetails objectForKey:@"yes_rsvp_count"];
    NSString *rsvpCountString = [NSString stringWithFormat:@"RSVP count: %@", rsvpCountNumber];
    self.rsvpCountLabel.text = rsvpCountString;

    NSDictionary *groupInfoDict = [self.eventDetails objectForKey:@"group"];
    NSString *groupInfoString = [groupInfoDict objectForKey:@"name"];
    self.groupInfoLabel.text = groupInfoString;
    
    NSString *description = [self.eventDetails objectForKey:@"description"];
    [self.webView loadHTMLString:description baseURL:nil];
   
}
- (IBAction)webButtonAction:(UIButton *)sender
{

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
    WebViewController *webVC = segue.destinationViewController;
    NSString *urlString = [self.eventDetails objectForKey:@"event_url"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    webVC.urlRequest = request;
}

@end
