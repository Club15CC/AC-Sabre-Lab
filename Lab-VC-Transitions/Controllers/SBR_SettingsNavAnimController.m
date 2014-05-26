//
//  SBR_MenuDrilldownAnimation.m
//  Lab-VC-Transitions
//
//  Created by Hari Karam Singh on 20/05/2014.
//  Copyright (c) 2014 Air Craft. All rights reserved.
//

#import "SBR_SettingsNavAnimController.h"
#import "SBR_AnimatedFilterSnapshotView.h"
#import "SBR_BlurOutFilter.h"

@implementation SBR_SettingsNavAnimController
{
    SBR_BlurOutFilter *_filter;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _filter = [SBR_BlurOutFilter new];
    }
    return self;
}


/////////////////////////////////////////////////////////////////////////
#pragma mark - UIViewControllerAnimatedTransitioning
/////////////////////////////////////////////////////////////////////////

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionCtx
{
    //Get references to the view hierarchy
    UIView *contView = [transitionCtx containerView];
    UIViewController *fromVC = [transitionCtx viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionCtx viewControllerForKey:UITransitionContextToViewControllerKey];
    NSTimeInterval duration = [self transitionDuration:transitionCtx];
    
    /////////////////////////////////////////
    // PUSH ANIMATION
    /////////////////////////////////////////

    if (self.operation == UINavigationControllerOperationPush) {
    
        // PRELOAD filter
        // CONSTANTS
        // TEST!
        
        // Grab a snapshot of the destination so we can do gpu fxs
        _filter.filterAmount = 0;
        SBR_AnimatedFilterSnapshotView *toViewSnapshot = [SBR_AnimatedFilterSnapshotView newWithSourceView:toVC.view filter:_filter initDrawCompletion:^(SBR_AnimatedFilterSnapshotView *view) {
        
            // Also fade and shrink the destination
            toViewSnapshot.transform = CGAffineTransformMakeScale(0.7, 0.7);
            toViewSnapshot.alpha = 1.0;
            
            
            [contView addSubview:toViewSnapshot];
            
            // Animate it all in while panning/fading the fromView as well
//            [toViewSnapshot unfilterWithDuration:duration];
            [UIView
             animateWithDuration:duration
             animations:^{
                 
                 toViewSnapshot.transform = CGAffineTransformIdentity;
                 toViewSnapshot.alpha = 1.0;
                 fromVC.view.x -= contView.width;
                 
             } completion:^(BOOL finished) {
                 // Swap the snapshot view
                 [toViewSnapshot removeFromSuperview];
                 [contView addSubview:toVC.view];
                 
                 [transitionCtx completeTransition:YES];
                 
             }];
            
        }]; // END SBR_AnimatedFilterSnapshotView new...
        

    
    /////////////////////////////////////////
    // POP ANIMATION
    /////////////////////////////////////////

    } else if (self.operation == UINavigationControllerOperationPop) {
//        //Add 'to' view to the hierarchy
//        [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
//        
//        //Scale the 'from' view down until it disappears
//        [UIView animateWithDuration:[self transitionDuration:transitionCtx] animations:^{
//            fromViewController.view.transform = CGAffineTransformMakeScale(0.0, 0.0);
//        } completion:^(BOOL finished) {
//            [transitionCtx completeTransition:YES];
//        }];
    }
}

//---------------------------------------------------------------------

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionCtx {
    return 1.4;
}

//---------------------------------------------------------------------

-(void)animationEnded:(BOOL)transitionCompleted {
    self.isInteractive = NO;
}



/////////////////////////////////////////////////////////////////////////
#pragma mark - UIViewControllerInteractiveTransitioning & Interactive API
/////////////////////////////////////////////////////////////////////////

-(void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionCtx {
    //Maintain reference to context
//    _context = transitionCtx;
//    
//    //Get references to view hierarchy
//    UIView *containerView = [transitionCtx containerView];
//    UIViewController *fromViewController = [transitionCtx viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController *toViewController = [transitionCtx viewControllerForKey:UITransitionContextToViewControllerKey];
//    
//    //Insert 'to' view into hierarchy
//    toViewController.view.frame = [transitionCtx finalFrameForViewController:toViewController];
//    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
//    
//    //Save reference for view to be scaled
//    _transitioningView = fromViewController.view;
}

//---------------------------------------------------------------------

- (void)updateWithPercent:(CGFloat)percent
{
    
}




@end
