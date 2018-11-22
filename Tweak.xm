
//  Created by JunesiPhone on 11/11/2017.
//  Copyright © 2017 JunesiPhone. All rights reserved.

@interface UIVisualEffectView (easywayout)
@property (nonatomic, retain) UIView *contentView;
@end

@interface UITextSelectionView : UIView
@end

@interface UIWebFormAccessory : UIView
@end

%hook UIKBRenderConfig
	- (bool)lightKeyboard{
		return NO;
	}
%end

%hook UIWebFormAccessory
	- (void)layoutSubviews{
		if([self.subviews[0].subviews[0].subviews[0].subviews count] > 1){
			if([self.subviews[0].subviews[0].subviews[0].subviews[1] isKindOfClass:[UIVisualEffectView class]]){
				UIVisualEffectView *visual = self.subviews[0].subviews[0].subviews[0].subviews[1];
				visual.contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9f];
			}
		}
	}
%end

%hook UITextSelectionView
	- (id)caretViewColor{
		return [UIColor lightGrayColor];
	}
%end

%hook UIDevice
- (long long)_keyboardGraphicsQuality {
	return 10; //default 100 - 10 is black
}
%end

%ctor
{
	NSArray *args = [[NSClassFromString(@"NSProcessInfo") processInfo] arguments];
	NSUInteger count = args.count;
	if (count != 0) {
		NSString *executablePath = args[0];
		if (executablePath) {
			NSString *processName = [executablePath lastPathComponent];
			BOOL isSpringBoard = [processName isEqualToString:@"SpringBoard"];
			BOOL isApplication = [executablePath rangeOfString:@"/Application"].location != NSNotFound;
			if (isSpringBoard || isApplication) {
				%init;
			}
		}
	}
}