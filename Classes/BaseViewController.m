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
	
	if (UIDeviceOrientationIsPortrait(deviceOrientation))
	{
		NSLog(@"orientationChanged to Portrait");
//		[[self modalViewController] dismissModalViewControllerAnimated:YES];
//		[self presentModalViewController:self.appsViewController animated:YES];
	}
	else
	{
		NSLog(@"orientationChanged to Landscape");
//		[[self modalViewController] dismissModalViewControllerAnimated:YES];
//		[self presentModalViewController:self.slideViewController animated:YES];
	}
	
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
