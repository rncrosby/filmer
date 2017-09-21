//
//  References.m
//  Hitch for iOS
//
//  Created by Robert Crosby on 11/15/16.
//  Copyright © 2016 Robert Crosby. All rights reserved.
//

#import "References.h"

@interface References ()

@end

@implementation References

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(void)cornerRadius:(UIView *)view radius:(float)radius{
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = YES;
}

+(void)borderColor:(UIView*)view color:(UIColor*)color{
    view.layer.borderWidth = 3;
    
    view.layer.borderColor = color.CGColor;
}

+(CGFloat)screenWidth {
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat wid = screenSize.width;
    return wid;
}

+(CGFloat)screenHeight {
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat high = screenSize.height;
    return high;
}

+(void)bottomshadow:(UIView*)view {
    view.layer.shadowOffset = CGSizeMake(0, 5);
    view.layer.shadowRadius = 5;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = .2;
}
+(void)topshadow:(UIView*)view {
    view.layer.shadowOffset = CGSizeMake(0, -2);
    view.layer.shadowRadius = 5;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = .1;
}
+(void)cardshadow:(UIView*)view {
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowRadius = 7;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = .3;
}
+(void)lightCardShadow:(UIView*)view {
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowRadius = 6;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = .6;
}

+(void)fromoffscreen:(UIView*)view where:(NSString*)where{
    CGRect location = view.frame;
    if ([where isEqualToString:@"BOTTOM"]) {
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y+[self screenHeight], view.frame.size.width, view.frame.size.height);
    }
    if ([where isEqualToString:@"TOP"]) {
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y-[self screenHeight], view.frame.size.width, view.frame.size.height);
    }
    view.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        view.frame = location;
    }];
}

+(void)fromonscreen:(UIView *)view where:(NSString *)where{
    if ([where isEqualToString:@"BOTTOM"]) {
        [UIView animateWithDuration:0.5 animations:^{
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y+[self screenHeight], view.frame.size.width, view.frame.size.height);
        }];
    }
    if ([where isEqualToString:@"TOP"]) {
        [UIView animateWithDuration:0.5 animations:^{
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y-[self screenHeight], view.frame.size.width, view.frame.size.height);
            
        }];
        
    }
}

+(void)justMoveOffScreen:(UIView *)view where:(NSString *)where{
    if ([where isEqualToString:@"BOTTOM"]) {
        [UIView animateWithDuration:0.5 animations:^{
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y+[self screenHeight], view.frame.size.width, view.frame.size.height);
        }];
    }
    if ([where isEqualToString:@"TOP"]) {
        [UIView animateWithDuration:0.5 animations:^{
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y-[self screenHeight], view.frame.size.width, view.frame.size.height);
        }];
    }
}

+(void)justMoveOnScreen:(UIView *)view where:(NSString *)where{
    if ([where isEqualToString:@"BOTTOM"]) {
        view.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y-[self screenHeight], view.frame.size.width, view.frame.size.height);
        }];
    }
    if ([where isEqualToString:@"TOP"]) {
        view.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y+[self screenHeight], view.frame.size.width, view.frame.size.height);
        }];
    }
    
    
}

+(void)fadeThenMove:(UIView *)view where:(NSString *)where{
    [UIView animateWithDuration:0.5 animations:^{
        view.alpha = 0;
    } completion:^(BOOL finished) {
        view.hidden = YES;
        if ([where isEqualToString:@"BOTTOM"]) {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y+[self screenHeight], view.frame.size.width, view.frame.size.height);
            view.alpha = 1;
        }
        if ([where isEqualToString:@"TOP"]) {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y-[self screenHeight], view.frame.size.width, view.frame.size.height);
            view.alpha = 1;
        }
    }];
}

+(void)fadeIn:(UIView *)view{
    view.hidden = NO;
    view.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        view.alpha = 1;
    }];
}
+(void)fadeOut:(UIView *)view{
    [UIView animateWithDuration:1 animations:^{
        view.alpha = 0;
    } completion:^(BOOL complete){
        view.hidden = YES;
    }];
}

+(void)shift:(UIView*)view X:(float)X Y:(float)Y W:(float)W H:(float)H{
    [UIView animateWithDuration:0.5 animations:^{
        view.frame = CGRectMake(X, Y, W, H);
    }];
}

+(void)adjustHeight:(UIView*)view H:(float)H{
    [UIView animateWithDuration:0.5 animations:^{
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y , view.frame.size.width, view.frame.size.height+H);
    }];
}

+(void)moveUp:(UIView*)view yChange:(float)yChange{
    [UIView animateWithDuration:.3 animations:^{
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y-yChange, view.frame.size.width, view.frame.size.height);
    }];
}
+(void)moveDown:(UIView*)view yChange:(float)yChange{
    [UIView animateWithDuration:.3 animations:^{
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y+yChange, view.frame.size.width, view.frame.size.height);
    }];
}

+(void)moveHorizontal:(UIView*)view where:(NSString*)where{
    [UIView animateWithDuration:.3 animations:^{
        if ([where isEqualToString:@"RIGHT"]) {
            view.frame = CGRectMake(view.frame.origin.x+[self screenWidth], view.frame.origin.y, view.frame.size.width, view.frame.size.height);
        }
        if ([where isEqualToString:@"LEFT"]) {
            view.frame = CGRectMake(view.frame.origin.x-[self screenWidth], view.frame.origin.y, view.frame.size.width, view.frame.size.height);
        }
        
    } completion:^(BOOL finished) {
    }];
    
}

+(void)moveBackDown:(UIView*)view frame:(CGRect)frame{
    [UIView animateWithDuration:.3 animations:^{
        view.frame = CGRectMake(frame.origin.x, frame.origin.y-350, frame.size.width, frame.size.height);
    }];
}

+(void)textFieldInset:(UITextField *)text{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, text.frame.size.height)];
    text.leftView = leftView;
    text.leftViewMode = UITextFieldViewModeAlways;
}

+(void)fade:(UIView*)view alpha:(float)alpha {
    [UIView animateWithDuration:.5 animations:^{
        view.alpha = alpha;
    }];
    
}

+(void)blurView:(UIView *)view {
    [view setBackgroundColor:[UIColor clearColor]];
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = view.bounds;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [view addSubview:blurEffectView];
    [view sendSubviewToBack:blurEffectView];
}

+(void)lightblurView:(UIView *)view {
    [view setBackgroundColor:[UIColor clearColor]];
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = view.bounds;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [view addSubview:blurEffectView];
    [view sendSubviewToBack:blurEffectView];
}

+(void)fadeColor:(UIView*)view color:(UIColor*)color{
    UIColor *temp = view.backgroundColor;
    view.layer.backgroundColor = temp.CGColor;
    [view setBackgroundColor:[UIColor clearColor]];
    
    [UIView animateWithDuration:0.5 animations:^{
        view.layer.backgroundColor = color.CGColor;
    } completion:NULL];
}

+(void)fadeButtonTextColor:(UIButton*)view color:(UIColor*)color{
    [UIView animateWithDuration:0.5 animations:^{
        [view setTitleColor:color forState:UIControlStateNormal];
    } completion:NULL];
}

+(void)fadeLabelTextColor:(UILabel*)view color:(UIColor*)color {
    [UIView animateWithDuration:0.5 animations:^{
        [view setTextColor:color];
    } completion:NULL];
}

+(void)fadeButtonText:(UIButton*)view text:(NSString*)text{
    [UIView animateWithDuration:0.5 animations:^{
        [view setTitle:text forState:UIControlStateNormal];
    } completion:NULL];
}

+(void)fadeButtonColor:(UIButton*)view color:(UIColor*)color{
    [UIView animateWithDuration:0.5 animations:^{
        [view setBackgroundColor:color];
    } completion:NULL];
}

+(void)tintUIButton:(UIButton*)button color:(UIColor*)color{
    UIImage *image = [button.currentBackgroundImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [button setImage:image forState:UIControlStateNormal];
    button.tintColor = color;
}

+(NSString *) randomStringWithLength: (int) len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyz";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    
    return randomString;
}

+(NSString *) randomIntWithLength: (int) len {
    NSString *letters = @"0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    
    return randomString;
}

+(void)createLine:(UIView*)superview  xPos:(int)xPos yPos:(int)yPos inFront:(bool)inFront{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(xPos, yPos, 1000, 1)];
    [view setBackgroundColor:[UIColor blackColor]];
    view.alpha = 0.1f;
    [superview addSubview:view];
    if (inFront == TRUE) {
        [superview bringSubviewToFront:view];
    } else {
        [superview sendSubviewToBack:view];
    }
}

+(void)ViewToLine:(UIView*)superview withView:(UIView*)view xPos:(int)xPos yPos:(int)yPos{
    view = [[UIView alloc] initWithFrame:CGRectMake(xPos, yPos, 1000, 1)];
    [view setBackgroundColor:[UIColor blackColor]];
    view.alpha = 0.1;
    [superview addSubview:view];
}

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+(NSString *)backendAddress {
    return @"http://138.197.217.29:5000/";
}

+(void)fadeLabelText:(UILabel*)view newText:(NSString*)newText {
    [UIView transitionWithView:view
                      duration:0.4f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        
                        view.text = newText;
                        
                    } completion:nil];
}

+(void)fadePlaceholderText:(UITextField*)view newText:(NSString*)newText {
    [UIView transitionWithView:view
                      duration:0.4f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        
                        view.placeholder = newText;
                        
                    } completion:nil];
}

+(UIView*)createGradient:(UIColor *)colorA andColor:(UIColor *)colorB withFrame:(CGRect)frame {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = view.bounds;
    gradient.colors = @[(id)colorA.CGColor, (id)colorB.CGColor];
    
    [view.layer insertSublayer:gradient atIndex:0];
    return view;
}

+(CAGradientLayer*)createGradient:(UIColor*)colorA andColor:(UIColor*)colorB{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = CGRectMake(-20,-20, 500, 500);
    gradient.colors = @[(id)colorA.CGColor, (id)colorB.CGColor];
    return gradient;
}

- (UIColor *)getUIColorObjectFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha
{
    // Convert hex string to an integer
    unsigned int hexint = [self intFromHexString:hexStr];
    
    // Create color object, specifying alpha as well
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    
    return color;
}

- (unsigned int)intFromHexString:(NSString *)hexStr
{
    unsigned int hexInt = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    
    // Scan hex value
    [scanner scanHexInt:&hexInt];
    
    return hexInt;
}

+(void)toastMessage:(NSString *)message andView:(UIViewController *)view andClose:(bool)close{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [view presentViewController:alert animated:YES completion:nil];
    
    int duration = 1.5; // duration in seconds
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:^() {
            if (close == TRUE) {
                [view dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    });
}


+(void)parallax:(UIView *)view {
    int parallaxEffect = 100;
    UIInterpolatingMotionEffect *verticalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.y"
     type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(-1*parallaxEffect);
    verticalMotionEffect.maximumRelativeValue = @(parallaxEffect);
    
    // Set horizontal effect
    UIInterpolatingMotionEffect *horizontalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.x"
     type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-1*parallaxEffect);
    horizontalMotionEffect.maximumRelativeValue = @(parallaxEffect);
    
    // Create group to combine both
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    
    // Add both effects to your view
    [view addMotionEffect:group];
}

+(UIColor*)systemColor:(NSString*)color {
    if ([color isEqualToString:@"RED"]) {
        return [self colorFromHexString:@"#FF3B30"];
    }
    if ([color isEqualToString:@"BLUE"]) {
        return [self colorFromHexString:@"#007AFF"];
    }
    if ([color isEqualToString:@"YELLOW"]) {
        return [self colorFromHexString:@"#FFCC00"];
    }
    if ([color isEqualToString:@"ORANGE"]) {
        return [self colorFromHexString:@"#FF9500"];
    }
    if ([color isEqualToString:@"LRED"]) {
        return [self colorFromHexString:@"#FF2D55"];
    }
    if ([color isEqualToString:@"LBLUE"]) {
        return [self colorFromHexString:@"#5AC8FA"];
    } else {
        return [UIColor blackColor];
    }
}

+(void)fullScreenToast:(NSString*)text inView:(UIViewController*)view withSuccess:(BOOL)success andClose:(BOOL)close{
    UILabel *blur = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [self screenWidth], [self screenHeight])];
    [self blurView:blur];
    [blur setAlpha:0];
    [view.view addSubview:blur];
    UITextView *message = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, [self screenWidth], [self screenHeight])];
    [message setEditable:NO];
    message.textContainerInset = UIEdgeInsetsMake(([self screenHeight]/2)-40, 0, [self screenHeight]/2, 0);
    message.textAlignment = NSTextAlignmentCenter;
    [message setText:text];
    [message setTextColor:[UIColor lightGrayColor]];
    [message setFont:[UIFont systemFontOfSize:16.0f]];
    [message setBackgroundColor:[UIColor clearColor]];
    [view.view  addSubview:message];
    [message setAlpha:0];
    [view.view bringSubviewToFront:blur];
    [view.view  bringSubviewToFront:message];
    UIImage *image;
    UIImageView *imageView;
    if (success == YES) {
        image = [[UIImage imageNamed:@"success.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(([self screenWidth]/2)-25, ([self screenHeight]/2)-100, 50, 50)];
         [imageView setImage:image];
    } else {
        image = [[UIImage imageNamed:@"failure.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(([self screenWidth]/2)-25, ([self screenHeight]/2)-100, 50, 50)];
        [imageView setImage:image];
    }
    imageView.tintColor = [UIColor lightGrayColor];
    [imageView setAlpha:0];
    [view.view  addSubview:imageView];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [blur setAlpha:1.0];
    [message setAlpha:1.0];
    [imageView setAlpha:1.0];
    [UIView commitAnimations];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Here your non-main thread.
        [NSThread sleepForTimeInterval:1.0f];
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            [blur setAlpha:0.0];
            [imageView setAlpha:0];
            [message setAlpha:0];
            [UIView commitAnimations];
            if (close == YES) {
                [view dismissViewControllerAnimated:YES completion:nil];
            }
        });
    });
}

+(NSString*)randomizeString:(NSString*)string {
    return string;
}
+(NSString*)normalizeString:(NSString*)string {
    return string;
}


@end

