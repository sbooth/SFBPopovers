//
// Copyright (c) 2011 - 2021 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/SFBPopovers
// MIT license
//

#import <Cocoa/Cocoa.h>

#import "SFBPopoverWindow.h"

/// A class that does the work of drawing the popover window
@interface SFBPopoverWindowFrame : NSView

// MARK: Properties

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


// MARK: Geometry calculations

/// Returns the popover's frame rectangle for @c contentRect
/// @param contentRect The content rectangle
/// @return The popover's frame rectangle
- (NSRect)frameRectForContentRect:(NSRect)contentRect;
/// Returns the popover's content rectangle for @c windowFrame
/// @param windowFrame The popover's window frame rectangle
/// @return The popover's content rectangle
- (NSRect)contentRectForFrameRect:(NSRect)windowFrame;

/// Returns the popover window's attachment point (arrowhead position) for @c self.bounds
@property (nonatomic, readonly) NSPoint attachmentPoint;
/// Returns the popover window's attachment point (arrowhead position) for @c rect
/// @param rect The bounding rectangle expressed in the view's own coordinate system
/// @return The popover's attachment point
- (NSPoint)attachmentPointForRect:(NSRect)rect;

@end
