//
//  ConstraintsHelper.h
//  ManageConstraints
//
//  Created by Adusa on 15/9/8.
//  Copyright (c) 2015年 Adusa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ConstraintsHelper)
-(BOOL)constraint:(NSLayoutConstraint*)constraint1 matches:(NSLayoutConstraint*)constraint2;
-(NSLayoutConstraint*)constraintMatchingConstraint:(NSLayoutConstraint*)aConstraint;
-(void)removeMatchingConstraint:(NSLayoutConstraint *)aConstraint;
-(void)removeMatchingConstraints:(NSArray *)anArray;

-(NSArray *)constraintsLimitingViewToSuperviewBounds;
-(void)constrainWithinSuperviewBounds;
-(void)addSubviewAndConstrainToBounds:(UIView *)view;

-(NSArray *)sizeConstraints:(CGSize)aSize;
-(NSArray *)positionConstraints:(CGPoint)aPoint;
-(void)constrainSize:(CGSize)aSize;
-(void)constrainPosition:(CGPoint)aPoint;

-(void)centerHorizontallyInSuperview;
-(void)centerVerticallyInSuperview;
-(NSLayoutConstraint*)centerXConstraint;
-(NSLayoutConstraint*)centerYConstraint;

-(NSLayoutConstraint *)aspectConstraint:(CGFloat)aspectRatio;
-(void)constrainAspectRatio:(CGFloat)aspectRatio;
@end
