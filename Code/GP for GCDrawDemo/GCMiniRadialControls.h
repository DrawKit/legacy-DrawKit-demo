//
//  GCMiniRadialControls.h
//  panel
//
//  Created by Graham on Thu Apr 12 2007.
//  Copyright (c) 2007 __MyCompanyName__. All rights reserved.
//

#import "GCMiniControl.h"


@interface GCMiniRadialControls : GCMiniControl
{
	float			mRadius;
	NSPoint			mCentre;
}


- (void)			setCentre:(NSPoint) p;
- (NSPoint)			centre;

- (void)			setRadius:(float) radius;
- (float)			radius;


- (NSRect)			targetRect;
- (NSRect)			rectForRadius;

@end

// hit part codes:

enum
{
	kDKHitRadialTarget	= 24,
	kDKHitRadialRadius	= 42
};
