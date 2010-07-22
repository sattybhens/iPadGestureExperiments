    //
//  BaseViewController.m
//  iPadGestureExperiments
//
//  Created by Satty Bhens on 7/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"

#import "AppsViewController.h"
#import "SlideViewController.h"

@implementation BaseViewController

@synthesize slideViewController, appsViewController;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization

    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
  
  [self.view addSubview:self.appsViewController.view];
  [self.view addSubview:self.slideViewController.view];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
										  selector:@selector(orientationChanged:)
                      name:@"UIDeviceOrientationDidChangeNotification"
										  object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.

    return YES;
}

- (void)orientationChanged:(NSNotification *)notification {
	
	UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
	BOOL isPortrait = UIDeviceOrientationIsPortrait(deviceOrientation);

  if (isPortrait)
   {
     [self.view bringSubviewToFront:self.appsViewController.view];
     self.appsViewController.label.text = [ [NSDate date] descriptionWithLocale: @"yyyy-MM-dd" ];
   } else
     [self.view bringSubviewToFront:self.slideViewController.view];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
    [super dealloc];
}


@end
