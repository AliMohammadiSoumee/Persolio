//
//  MyLocationPicker.h
//  Kababchi
//
//  Created by hAmidReza on 7/20/17.
//  Copyright © 2017 innovian. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "_HomeBaseVC.h"

@interface MyLocationPicker : _HomeBaseVC

@property (retain, nonatomic) CLLocation* location;

@property (copy, nonatomic) void (^callback) (CLLocation* coordinate);



/**
 In case of not GPS it will load this location at first.
 */
@property (retain, nonatomic) CLLocation* defaultLocation;



/**
 default zoom amount. defaults to: .03
 */
@property (assign, nonatomic) float spanDelta;

@end
