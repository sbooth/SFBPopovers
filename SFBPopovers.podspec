Pod::Spec.new do |s|
	s.name					= "SFBPopovers"
	s.version				= "1.0.0"
	s.summary				= "A framework implementing customizable popover windows."
	s.description			= <<-DESC
This framework implements popover windows- windows that, to the user, logically belong to another window and are visually attached to the parent window.

An `SFBPopover` has a customizable appearance including border thickness, color, and radius, attachment point, and arrow appearance.
							DESC
	s.homepage				= "https://github.com/sbooth/SFBPopovers"
	s.license				= { :type => "MIT", :file => "COPYING" }
	s.author				= { "Stephen F. Booth" => "me@sbooth.org" }
	s.social_media_url		= "http://twitter.com/sbooth"
	s.platform				= :osx, "10.7"
	s.source       			= { :git => "https://github.com/sbooth/SFBPopovers.git", :tag => "1.0.0" }
	s.source_files  		= "SFBPopover.{h,m}", "SFBPopoverWindow.{h,m}", "SFBPopoverWindowFrame.{h,m}"
	s.public_header_files 	= "SFBPopover.h"
	s.requires_arc 			= true
end
