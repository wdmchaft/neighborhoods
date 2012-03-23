//
//  ViewController.m
//  Neighborhoods
//
//  Created by Ricky Cheng
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize mapView = _mapView;
@synthesize currentLocation = _currentLocation;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    self.currentLocation = _mapView.userLocation.location;
    DLog(@"%f, %f", _currentLocation.coordinate.latitude, _currentLocation.coordinate.longitude);
    [self locate];
}

- (void)locate {
    CLLocationCoordinate2D coord = _currentLocation.coordinate;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?address=%f,%f&sensor=false", kGOOGLE_MAPS_API_URL, coord.latitude, coord.longitude]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}

#pragma -
#pragma ASIHTTPRequest Delegate
- (void)requestFinished:(ASIHTTPRequest *)request {
    @autoreleasepool {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONWritingPrettyPrinted error:nil];
        NSDictionary *addresses = [[[dictionary objectForKey:@"results"] objectAtIndex:0] objectForKey:@"address_components"];
        
        for (NSDictionary *address in addresses) {
            NSArray* neighborhood = [address objectForKey:@"types"];

            if ([neighborhood containsObject:@"neighborhood"]) {
                self.title = [address objectForKey:@"short_name"];
            }
        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    DLog(@"%@", [request error]);
}

@end
