//
//  ETViewController.h
//  Estimote Tutorial
//
//  Created by アンディット ヘリスティヨ on 2014/08/29.
//  Copyright (c) 2014年 Digital Garage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ESTBeaconManager.h>
#import <ESTBeacon.h>

typedef enum : int {
    ESTScanTypeBlueTooth,
    ESTScanTypeBeacon
}ESTScanType;

@interface ETViewController : UIViewController

@property (nonatomic, copy) void (^completion)(ESTBeacon *);
@property (nonatomic, assign) ESTScanType scanType;

@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@property (nonatomic, strong) ESTBeaconRegion *region;
@property (strong, nonatomic) NSArray *beaconsArray;

@property (strong, nonatomic) UILabel *messageLabel;

@property (strong, nonatomic) UILabel *major1;
@property (strong, nonatomic) UILabel *minor1;
@property (strong, nonatomic) UILabel *dist1;
@property (strong, nonatomic) UILabel *major2;
@property (strong, nonatomic) UILabel *minor2;
@property (strong, nonatomic) UILabel *dist2;
@property (strong, nonatomic) UILabel *major3;
@property (strong, nonatomic) UILabel *minor3;
@property (strong, nonatomic) UILabel *dist3;
@property (strong, nonatomic) UILabel *major4;
@property (strong, nonatomic) UILabel *minor4;
@property (strong, nonatomic) UILabel *dist4;

@property (strong, nonatomic) NSArray *majorArray;
@property (strong, nonatomic) NSArray *minorArray;
@property (strong, nonatomic) NSArray *distArray;

- (id)initWithScanType:(ESTScanType)scanType completion:(void (^)(ESTBeacon *))completion;

@end
