// Copyright (c) 2023 Nightwind

@import UIKit;

// Hardcoded offsets for the locations
#define kSubtitlePadding 102
#define kTimeFontSize 80
#define kDateFontSize 22

// Interfaces for the three classes relating to the items around the clock (date, battery charging text, etc.)
@interface CSProminentSubtitleDateView : UIView
@end

@interface CSProminentEmptyElementView : UIView
@end

@interface CSProminentTextElementView : UIView
@end

// Inspired from: https://www.reddit.com/r/TweakBounty/comments/18gvc7l/comment/kd95qej/?utm_source=share&utm_medium=web2x&context=3
%hook SBFLockScreenDateView

+ (UIFont *)timeFont {
    return [UIFont systemFontOfSize:kTimeFontSize weight:UIFontWeightThin];
}
- (UIFont *)customTimeFont {
    return [UIFont systemFontOfSize:kTimeFontSize weight:UIFontWeightThin];
}
- (void)setCustomTimeFont:(UIFont *)customTimeFont {
    %orig([UIFont systemFontOfSize:kTimeFontSize weight:UIFontWeightThin]);
}

%end

// Time text
%hook CSProminentTimeView

// Changing positioning
- (CGRect)frame {
	CGRect orig = %orig;
	return CGRectMake(orig.origin.x, 5, orig.size.width, orig.size.height);
}

- (void)setFrame:(CGRect)frame {
	%orig(CGRectMake(frame.origin.x, 5, frame.size.width, frame.size.height));
}

// Changing font
- (UIFont *)primaryFont {
    return [UIFont systemFontOfSize:kTimeFontSize weight:UIFontWeightThin];
}

- (void)setPrimaryFont:(UIFont *)primaryFont {
    %orig([UIFont systemFontOfSize:kTimeFontSize weight:UIFontWeightThin]);
}

%end

// Date text
%hook CSProminentSubtitleDateView

// Changing positioning
- (CGRect)frame {
	CGRect orig = %orig;
	return CGRectMake(orig.origin.x, kSubtitlePadding, orig.size.width, orig.size.height);
}

- (void)setFrame:(CGRect)frame {
	%orig(CGRectMake(frame.origin.x, kSubtitlePadding, frame.size.width, frame.size.height));
}

// Changing font
- (void)didMoveToWindow {
	%orig;

	UILabel *textLabel = [self valueForKey:@"_textLabel"];
	[textLabel setFont:[UIFont systemFontOfSize:kDateFontSize weight:UIFontWeightRegular]];
}

%end

// Miscellaneous text hooks
%hook CSProminentEmptyElementView

// Changing positioning
- (CGRect)frame {
	CGRect orig = %orig;
	return CGRectMake(orig.origin.x, kSubtitlePadding, orig.size.width, orig.size.height);
}

- (void)setFrame:(CGRect)frame {
	%orig(CGRectMake(frame.origin.x, kSubtitlePadding, frame.size.width, frame.size.height));
}

%end

%hook CSProminentTextElementView

// Changing positioning
- (CGRect)frame {
	if (![self isKindOfClass:%c(CSProminentTimeView)]) {
		CGRect orig = %orig;
		return CGRectMake(orig.origin.x, kSubtitlePadding, orig.size.width, orig.size.height);
	} else return %orig;
}

- (void)setFrame:(CGRect)frame {
	if (![self isKindOfClass:%c(CSProminentTimeView)]) {
		%orig(CGRectMake(frame.origin.x, kSubtitlePadding, frame.size.width, frame.size.height));
	} else %orig;
}

%end