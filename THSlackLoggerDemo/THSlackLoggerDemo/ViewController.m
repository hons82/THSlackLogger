//
//  ViewController.m
//  THSlackLoggerDemo
//
//  Created by Hannes Tribus on 12/02/16.
//  Copyright © 2016 3Bus. All rights reserved.

#import "ViewController.h"
#import <THSlackLogger/THSlackLogger.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

#if DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postNotification:(id)sender {
    [[THSlackLogger sharedInstance] postNotificationToChannel:nil
                                                         text:@"Sample from THSlackLoggerDemo"
                                                     username:@"John Doe"
                                                      iconURL:nil
                                                    iconEmoji:nil
                                                     progress:nil
                                                      success:nil
                                                      failure:nil];
}

- (IBAction)logError:(id)sender {
    DDLogError(@"Sample Error from THSlackLoggerDemo");
}

- (IBAction)logWarning:(id)sender {
    DDLogWarn(@"Sample Error from THSlackLoggerDemo");
}

- (IBAction)logInfo:(id)sender {
    DDLogInfo(@"Sample Error from THSlackLoggerDemo");
}

- (IBAction)logTrace:(id)sender {
    DDLogVerbose(@"Sample Error from THSlackLoggerDemo");
}

@end
