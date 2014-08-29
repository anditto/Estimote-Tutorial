//
//  ETViewController.m
//  Estimote Tutorial
//
//  Created by アンディット ヘリスティヨ on 2014/08/29.
//  Copyright (c) 2014年 Digital Garage. All rights reserved.
//

#import "ETViewController.h"

@interface ETViewController () <ESTBeaconManagerDelegate>

@end

@implementation ETViewController

- (id)initWithScanType:(ESTScanType)scanType completion:(void (^)(ESTBeacon *))completion
{
    self = [super init];
    if (self) {
        self.scanType = scanType;
        self.completion = [completion copy];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    
    self.region = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID identifier:@"EstimoteSampleRegion"];
    
    [self.beaconManager startRangingBeaconsInRegion:self.region];
    [self.beaconManager startEstimoteBeaconsDiscoveryForRegion:self.region];
    
    // Add labels to view
    CGFloat x_position = self.view.frame.size.width / 4;
    
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 3, 300, 200, 30)];
    self.messageLabel.text = @"Getting closer!";
    [self.view addSubview:self.messageLabel];
    
    self.major1 = [[UILabel alloc] initWithFrame:CGRectMake(x_position, 50, 60, 30)];
    self.major1.text = @"Major1";
    [self.view addSubview:self.major1];
    
    self.minor1 = [[UILabel alloc] initWithFrame:CGRectMake(x_position * 2, 50, 60, 30)];
    self.minor1.text = @"Minor1";
    [self.view addSubview:self.minor1];
    
    self.dist1 = [[UILabel alloc] initWithFrame:CGRectMake(x_position * 3, 50, 60, 30)];
    self.dist1.text = @"Dist1";
    [self.view addSubview:self.dist1];
    
    self.major2 = [[UILabel alloc] initWithFrame:CGRectMake(x_position, 75, 60, 30)];
    self.major2.text = @"Major2";
    [self.view addSubview:self.major2];
    
    self.minor2 = [[UILabel alloc] initWithFrame:CGRectMake(x_position * 2, 75, 60, 30)];
    self.minor2.text = @"Minor2";
    [self.view addSubview:self.minor2];
    
    self.dist2 = [[UILabel alloc] initWithFrame:CGRectMake(x_position * 3, 75, 60, 30)];
    self.dist2.text = @"Dist2";
    [self.view addSubview:self.dist2];
    
    self.major3 = [[UILabel alloc] initWithFrame:CGRectMake(x_position, 100, 60, 30)];
    self.major3.text = @"Major3";
    [self.view addSubview:self.major3];
    
    self.minor3 = [[UILabel alloc] initWithFrame:CGRectMake(x_position * 2, 100, 60, 30)];
    self.minor3.text = @"Minor3";
    [self.view addSubview:self.minor3];
    
    self.dist3 = [[UILabel alloc] initWithFrame:CGRectMake(x_position * 3, 100, 60, 30)];
    self.dist3.text = @"Dist3";
    [self.view addSubview:self.dist3];
    
    self.major4 = [[UILabel alloc] initWithFrame:CGRectMake(x_position, 125, 60, 30)];
    self.major4.text = @"Major4";
    [self.view addSubview:self.major4];
    
    self.minor4 = [[UILabel alloc] initWithFrame:CGRectMake(x_position * 2, 125, 60, 30)];
    self.minor4.text = @"Minor4";
    [self.view addSubview:self.minor4];
    
    self.dist4 = [[UILabel alloc] initWithFrame:CGRectMake(x_position * 3, 125, 60, 30)];
    self.dist4.text = @"Dist4";
    [self.view addSubview:self.dist4];
    
    self.majorArray = @[self.major1, self.major2, self.major3, self.major4];
    self.minorArray = @[self.minor1, self.minor2, self.minor3, self.minor4];
    self.distArray  = @[self.dist1, self.dist2, self.dist3, self.dist4];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Beacon Manager methods

- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    self.beaconsArray = beacons;
    [self pushBeaconInfo];
}

- (void)beaconManager:(ESTBeaconManager *)manager didDiscoverBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    self.beaconsArray = beacons;
    [self pushBeaconInfo];
}

#pragma mark - Pushing info to view

- (void)pushBeaconInfo
{
    for (int i = 0; i < self.beaconsArray.count; i++) {
        NSString *beaconMajorString = [((ESTBeacon *) self.beaconsArray[i]).major stringValue];
        NSString *beaconMinorString = [((ESTBeacon *) self.beaconsArray[i]).minor stringValue];
        
        NSNumber *beacondist = ((ESTBeacon *) self.beaconsArray[i]).distance;
        
        // Beacon Major
        ((UILabel *) self.majorArray[i]).text = beaconMajorString;
        
        // Beacon Minor
        ((UILabel *) self.minorArray[i]).text = beaconMinorString;
        
        // Beacon Distance
        if ( (beacondist) && (![[beacondist stringValue] isEqualToString:@"-1"]) )
        {
            ((UILabel *) self.distArray[i]).text = [NSString stringWithFormat:@"%.02f", [beacondist floatValue]];
            if ([beacondist floatValue] < 2.0)
            {
                ((UILabel *) self.distArray[i]).backgroundColor = [UIColor colorWithRed:(2.0 - [beacondist floatValue])/2.0 green:0.0 blue:[beacondist floatValue]/2.0 alpha:1.0];
            }
        }
        
        if ( (beacondist) && ([beacondist floatValue] < 0.5) && (![[beacondist stringValue] isEqualToString:@"-1"]) )
        {
            self.messageLabel.text = @"You found it!";
        }
    }
}

@end
