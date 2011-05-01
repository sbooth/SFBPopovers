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
// The class that actually does the work of drawing the popover window
// ========================================
@interface SFBPopoverWindowFrame : NSView
{
@private
	SFBPopoverPosition _popoverPosition;

	CGFloat _distance;

	NSColor *_borderColor;
	CGFloat _borderWidth;
	CGFloat _cornerRadius;

	BOOL _drawsArrow;
	CGFloat _arrowWidth;
	CGFloat _arrowHeight;
	BOOL _drawRoundCornerBesideArrow;

	CGFloat _viewMargin;
	NSColor *_backgroundColor;
}

// ========================================
// Properties
// Changing these will NOT mark the view as dirty, to allow for efficient multiple property changes
@property (assign) SFBPopoverPosition popoverPosition;

@property (assign) CGFloat distance;

@property (copy) NSColor * borderColor;
@property (assign) CGFloat borderWidth;
@property (assign) CGFloat cornerRadius;

@property (assign) BOOL drawsArrow;
@property (assign) CGFloat arrowWidth;
@property (assign) CGFloat arrowHeight;
@property (assign) BOOL drawRoundCornerBesideArrow;

@property (assign) CGFloat viewMargin;
@property (copy) NSColor * backgroundColor;

// ========================================
// Geometry calculations
- (NSRect) frameRectForContentRect:(NSRect)contentRect;
- (NSRect) contentRectForFrameRect:(NSRect)windowFrame;

- (NSPoint) attachmentPoint;
- (NSPoint) attachmentPointForRect:(NSRect)rect;
@end
