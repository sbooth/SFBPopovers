/*
 *  Copyright (C) 2011 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *
 *    - Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *    - Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *    - Neither the name of Stephen F. Booth nor the names of its 
 *      contributors may be used to endorse or promote products derived
 *      from this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <Cocoa/Cocoa.h>
#import "SFBPopoverWindow.h"

// ========================================
// A simple NSWindowController subclass with additions for controlling a popover window
// ========================================
@interface SFBPopoverWindowController : NSWindowController
{
@private
	BOOL _closesWhenPopoverResignsKey;
	BOOL _closesWhenApplicationBecomesInactive;
	BOOL _animates;
}

// ========================================
// Properties
@property (assign) BOOL animates;
@property (assign) BOOL closesWhenPopoverResignsKey;
@property (assign) BOOL closesWhenApplicationBecomesInactive;

// ========================================
// Calculate the best position to use in the given window
- (SFBPopoverPosition) bestPositionInWindow:(NSWindow *)window atPoint:(NSPoint)point;

// ========================================
// Show the popover- prefer these to showWindow:
- (void) displayPopoverInWindow:(NSWindow *)window atPoint:(NSPoint)point;
- (void) displayPopoverInWindow:(NSWindow *)window atPoint:(NSPoint)point chooseBestLocation:(BOOL)chooseBestLocation;

// ========================================
// Move the popover to a new attachment point (should be currently displayed)
- (void) movePopoverToPoint:(NSPoint)point;

// ========================================
// Close the popover
- (IBAction) closePopover:(id)sender;

// ========================================
// Get the popover window this object manages
- (SFBPopoverWindow *) popoverWindow;

@end
