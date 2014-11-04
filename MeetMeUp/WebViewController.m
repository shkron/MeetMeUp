//
//  WebViewController.m
//  MeetMeUp
//
//  Created by Alex on 11/3/14.
//  Copyright (c) 2014 Alexey Emelyanov. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.webView loadRequest:self.urlRequest];
}


-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicator startAnimating];


}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
    NSString *webTitle = ([self.webView stringByEvaluatingJavaScriptFromString:@"document.title"]);
    self.navigationItem.title = webTitle;
}


- (IBAction)goBackButton:(UIButton *)sender
{

    if(self.webView.canGoBack)
    {
        [self.webView goBack];
    }
    else{}

}


- (IBAction)goForwardButton:(UIButton *)sender
{

    if(self.webView.canGoForward)
    {
        [self.webView goForward];
    }
    else{}

}

@end
