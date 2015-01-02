//
//  GCDrawDemoDocument+ShortestRoute.m
//  GCDrawKit
//
//  Created by graham on 30/07/2008.
//  Copyright 2008 Apptree.net. All rights reserved.
//

#import "GCDrawDemoDocument+ShortestRoute.h"
#import <GCDrawKit/DKDrawkit.h>

@implementation GCDrawDemoDocument (ShortestRoute)

static DKDrawablePath*	routePath = nil;
static DKDrawablePath*	origRoutePath = nil;

static NSComparisonResult compareLocations( DKDrawableObject* a, DKDrawableObject* b, void* context )
{
	BOOL sortXOrY = *(BOOL*)context;
	
	NSPoint pa, pb;
	
	pa = [a location];
	pb = [b location];
	
	float ppa, ppb;
	
	if( sortXOrY )
	{
		ppa = pa.x;
		ppb = pb.x;
	}
	else
	{
		ppa = pa.y;
		ppb = pb.y;
	}

	if( ppa > ppb )
		return NSOrderedAscending;
	else if ( ppa < ppb )
		return NSOrderedDescending;
	else
		return NSOrderedSame;
}



- (IBAction)		computeShortestRoute:(id) sender
{
	#pragma unused (sender)
	
	// locate the target layer - active layer of class
	
	DKObjectOwnerLayer* layer = (DKObjectOwnerLayer*)[[self drawing] activeLayerOfClass:[DKObjectOwnerLayer class]];
	
	if( layer != nil )
	{
		[[layer undoManager] disableUndoRegistration];
		
		if( routePath != nil )
			[layer removeObject:routePath];
			
		if( origRoutePath != nil )
			[layer removeObject:origRoutePath];
		
		NSArray*	objects = [layer objects];
		
		[DKRouteFinder setAlgorithm:kDKUseNearestNeighbour];
		DKRouteFinder* rf = [DKRouteFinder routeFinderWithObjects:objects withValueForKey:@"location"];
		
		[rf setProgressDelegate:self];
		[rf sortedArrayFromArray:objects];
		
		origRoutePath = [routePath copy];
		[layer addObject:origRoutePath];
		
		float p1, p2;
		
		p1 = [rf pathLength];
		
		[DKRouteFinder setAlgorithm:kDKUseSimulatedAnnealing];
		rf = [DKRouteFinder routeFinderWithObjects:objects withValueForKey:@"location"];
		
		[rf setProgressDelegate:self];
		[rf sortedArrayFromArray:objects];
		
		p2 = [rf pathLength];
	
		NSLog(@"path lengths: NN = %f; SA = %f; diff = %f", p1, p2, p1 - p2 );
		
		

		[[layer undoManager] enableUndoRegistration];
	}
}



- (DKDrawablePath*)	pathWithPoints:(NSArray*) points
{
	// given an array of NSPoint values, construct a path object having those points.
	
	NSBezierPath*	path = [NSBezierPath bezierPath];
	NSEnumerator*	iter = [points objectEnumerator];
	NSValue*		val;
	
	val = [iter nextObject];
	
	[path moveToPoint:[val pointValue]];
	
	while(( val = [iter nextObject]))
		[path lineToPoint:[val pointValue]];
		
	//NSLog(@"path length = %f", [path length]);
		
	return [DKDrawablePath drawablePathWithBezierPath:path];
}


- (NSArray*)		objectsInArray:(NSArray*) objects sortedByXOrY:(BOOL) xory
{
	// given an array of objects, sorts them by location x or y.
	
	return [objects sortedArrayUsingFunction:compareLocations context:&xory];
}


#define	ONLY_SHOW_FINAL_STATE 1

- (void)			routeFinder:(DKRouteFinder*) rf progressHasReached:(float) value
{
	// progress callback - in this case we use it to draw the path found so far
	
	#if ( ONLY_SHOW_FINAL_STATE )
	
	if ( value < 1.0 )
		return;
		
	#endif
	
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	
	NSArray* points = [rf shortestRoute];
	DKDrawablePath* path = [self pathWithPoints:points];
	
	//NSLog(@"making path for value: %.4f (length %f)", value, [rf pathLength] );
	
	NSColor* lineColour;
	
	if([rf algorithm] == kDKUseSimulatedAnnealing)
		lineColour = [NSColor redColor];
	else
		lineColour = [NSColor magentaColor];

	DKStyle* routeStyle = [DKStyle styleWithFillColour:nil strokeColour:lineColour strokeWidth:3];
	[path setStyle:routeStyle];
	
	DKObjectOwnerLayer* layer = (DKObjectOwnerLayer*)[[self drawing] activeLayerOfClass:[DKObjectOwnerLayer class]];
	
	if ( routePath != nil )
	{
		[layer removeObject:routePath];
		[routePath release];
	}
	
	[layer addObject:path];
	routePath = [path retain];
	
	NSWindow* win = [NSApp mainWindow];
	[win displayIfNeeded];
	
	[pool release];
	
}


@end
