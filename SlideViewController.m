//
//  SlideViewController.m
//  iPadGestureExperiments
//
//  Created by Satty Bhens on 7/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SlideViewController.h"


@implementation SlideViewController

@synthesize swipeRecognizer, tapRecognizer, slideImageView, tapImageView, slidePopUpViewController;

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
	
  self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  
	UIGestureRecognizer *recognizer;
	
	recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
	[self.view addGestureRecognizer:recognizer];
	self.tapRecognizer = (UITapGestureRecognizer *)recognizer;
	recognizer.delegate = self;
	[recognizer release];
	
	
	recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
	[self.view addGestureRecognizer:recognizer];
	[recognizer release];
	
	recognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationFrom:)];
	[self.view addGestureRecognizer:recognizer];
	[recognizer release];
	
	
	UIImageView *aSlideImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 960.0, 720.0)];
	aSlideImageView.contentMode = UIViewContentModeCenter;
	self.slideImageView = aSlideImageView;
	[aSlideImageView release];
	[self.view addSubview:slideImageView];
	
	slideImageView.image = [UIImage imageNamed:@"Slide1.jpg"];
	slideImageView.alpha = 1.0;
	
	/*
	 Create an image view to display the gesture description.
	 */
	UIImageView *anImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, 75.0)];
	anImageView.contentMode = UIViewContentModeCenter;
	self.tapImageView = anImageView;
	[anImageView release];
	[self.view addSubview:tapImageView];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Overriden to allow any orientation.
	return YES;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	[super viewDidUnload];
	
	self.tapRecognizer = nil;
	self.swipeRecognizer = nil;
	self.slideImageView = nil;
	self.tapImageView = nil;
	
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark Responding to gestures

- (void)showImageWithText:(NSString *)string atPoint:(CGPoint)centerPoint {
	
	/*
	 Set the appropriate image for the image view, move the image view to the given point, then dispay it by setting its alpha to 1.0.
	 */
	NSString *imageName = [string stringByAppendingString:@".png"];
	tapImageView.image = [UIImage imageNamed:imageName];
	tapImageView.center = centerPoint;
	tapImageView.alpha = 1.0;	
}

/*
 In response to a tap gesture, show the image view appropriately then make it fade out in place.
 */
- (void)handleTapFrom:(UITapGestureRecognizer *)recognizer {
	
	CGPoint location = [recognizer locationInView:self.view];
	[self showImageWithText:@"tap" atPoint:location];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	tapImageView.alpha = 0.0;
	[UIView commitAnimations];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	
	[tapRecognizer release];
	[swipeRecognizer release];
	[slideImageView release];
	[tapImageView release];
	[super dealloc];
}


@end
