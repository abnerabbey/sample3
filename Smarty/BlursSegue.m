//
//  BlursSegue.m
//  Test ModalBlur
//
//  Created by Abner Abbey on 19/08/14.
//  Copyright (c) 2014 Abner Abbey. All rights reserved.
//

#import "BlursSegue.h"
#import "UIImageEffects.h"

@implementation BlursSegue

- (void)perform
{
    UIViewController *sourceController = self.sourceViewController;
    UIViewController *destinationController = self.destinationViewController;
    
    UIView *sourceView = sourceController.view;
    UIView *destinationView = destinationController.view;
    destinationView.backgroundColor = [UIColor clearColor];
    
    UIImageView *blurredImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, sourceView.frame.size.height, sourceView.frame.size.width, 0.0)];
    blurredImageView.clipsToBounds = YES;
    blurredImageView.contentMode = UIViewContentModeBottom;
    UIGraphicsBeginImageContextWithOptions(sourceView.frame.size, YES, [[UIScreen mainScreen] scale]);
    [sourceView drawViewHierarchyInRect:sourceView.frame afterScreenUpdates:NO];
    UIImage *sourceViewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //UIImage *blurredImage = [UIImageEffects imageByApplyingExtraLightEffectToImage:sourceViewImage];
    UIImage *blurredImage = [UIImageEffects imageByApplyingLightEffectToImage:sourceViewImage];
    //UIImage *blurredImage = [UIImageEffects imageByApplyingDarkEffectToImage:sourceViewImage];
    blurredImageView.image = blurredImage;
    [sourceView addSubview:blurredImageView];
    
    destinationView.center = destinationController.view.center;
    blurredImageView.frame = sourceView.frame;
    
    [blurredImageView removeFromSuperview];
    [destinationView removeFromSuperview];
    [destinationView insertSubview:blurredImageView atIndex:0];
    
    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:destinationController];
    [sourceController presentViewController:nv animated:YES completion:nil];
























}

@end
