/*
 * Copyright (C) 2011 - 2019 Stephen F. Booth <me@sbooth.org>
 * See https://github.com/sbooth/SFBPopovers/blob/master/LICENSE.txt for license information
 */

#import <Cocoa/Cocoa.h>

#import "SFBPopoverWindow.h"

// ========================================
// The class that actually does the work of drawing the popover window
// ========================================
@interface SFBPopoverWindowFrame : NSView

// ========================================
// Properties
// Changing these will NOT mark the view as dirty, to allow for efficient multiple property changes
@property (nonatomic, assign) SFBPopoverPosition popoverPosition;

@property (nonatomic, assign) CGFloat distance;

@property (nonatomic, copy, nonnull) NSColor * borderColor;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) CGFloat cornerRadius;

@property (nonatomic, assign) BOOL drawsArrow;
@property (nonatomic, assign) CGFloat arrowWidth;
@property (nonatomic, assign) CGFloat arrowHeight;
@property (nonatomic, assign) BOOL drawRoundCornerBesideArrow;

@property (nonatomic, assign) CGFloat viewMargin;
@property (nonatomic, copy, nonnull) NSColor * backgroundColor;

@property (nonatomic, assign, getter=isMovable) BOOL movable;
@property (nonatomic, assign, getter=isResizable) BOOL resizable;

// ========================================
// Geometry calculations
- (NSRect) frameRectForContentRect:(NSRect)contentRect;
- (NSRect) contentRectForFrameRect:(NSRect)windowFrame;

- (NSPoint) attachmentPoint;
- (NSPoint) attachmentPointForRect:(NSRect)rect;

@end
