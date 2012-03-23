//
//  ViewController.h
//  Neighborhoods
//
//  Created by Ricky Cheng
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ASIHTTPRequest.h"

@interface ViewController : UIViewController <MKMapViewDelegate, ASIHTTPRequestDelegate> {
    MKMapView* _mapView;
    CLLocation* _currentLocation;
}

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocation *currentLocation;

- (void)locate;

@end
