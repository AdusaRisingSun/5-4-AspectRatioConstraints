//
//  ConstraintsHelper.m
//  ManageConstraints
//
//  Created by Adusa on 15/9/8.
//  Copyright (c) 2015年 Adusa. All rights reserved.
//

#import "ConstraintsHelper.h"

@implementation UIView (ConstraintsHelper)
#pragma mark constraints management
-(BOOL)constraint:(NSLayoutConstraint *)constraint1 matches:(NSLayoutConstraint *)constraint2
{
    if (constraint1.firstItem!=constraint2.firstItem) {
        return NO;
    }
    if (constraint1.secondItem !=constraint2.secondItem) {
        return NO;
    }
    if (constraint1.firstAttribute!=constraint2.firstAttribute) {
        return NO;
    }
    if (constraint1.secondAttribute!=constraint2.secondAttribute) {
        return NO;
    }
    if (constraint1.relation!=constraint2.relation) {
        return NO;
    }
    if (constraint1.multiplier!=constraint2.multiplier) {
        return NO;
    }
    if (constraint1.constant!=constraint2.constant) {
        return NO;
    }
    return YES;
}

-(NSLayoutConstraint*)constraintMatchingConstraint:(NSLayoutConstraint *)aConstraint
{
    for (NSLayoutConstraint*constraint in self.constraints) {
        if ([self constraint:constraint matches:aConstraint]) {
            return constraint;
        }
    }
    for (NSLayoutConstraint*constraint in self.superview.constraints) {
        if ([self constraint:constraint matches:aConstraint]) {
            return constraint;
        }
    }
    return nil;
}

-(void)removeMatchingConstraint:(NSLayoutConstraint *)aConstraint
{
    NSLayoutConstraint *match=[self constraintMatchingConstraint:aConstraint];
    if (match) {
        [self removeConstraint:match];
        [self.superview removeConstraint:match];
    }
}

-(void)removeMatchingConstraints:(NSArray *)anArray
{
    for (NSLayoutConstraint *constraint in anArray) {
        [self removeMatchingConstraint:constraint];
    }
}
#pragma mark constrain in superview
-(NSArray *)constraintsLimitingViewToSuperviewBounds
{
    NSMutableArray *array=[NSMutableArray array];
    
    [array addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.superview attribute:NSLayoutAttributeRight multiplier:1.0f constant:0.0f]];
    [array addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.superview attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f]];
    [array addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]];
    [array addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    
    return array;
}

-(void)constrainWithinSuperviewBounds
{
    if (!self.superview) {
        return;
    }
    [self.superview addConstraints:[self constraintsLimitingViewToSuperviewBounds]];
}
-(void)addSubviewAndConstrainToBounds:(UIView *)view
{
    [self addSubview:view];
    view.translatesAutoresizingMaskIntoConstraints=NO;
    [self constrainWithinSuperviewBounds];
}
#pragma mark fix size and position
-(NSArray *)sizeConstraints:(CGSize)aSize
{
    NSMutableArray *array=[NSMutableArray array];
    [array addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[self(theWidth@750)]" options:0 metrics:@{@"theWidth":@(aSize.width)} views:NSDictionaryOfVariableBindings(self)]];
    [array addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[self(theHeight@750)]" options:0 metrics:@{@"theHeight":@(aSize.height)} views:NSDictionaryOfVariableBindings(self)]];

    return array;
}

-(NSArray *)positionConstraints:(CGPoint)aPoint
{
    if (!self.superview) {
        return nil;
    }
    NSMutableArray *mutableArray=[NSMutableArray array];
    [mutableArray addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeft multiplier:1.0f constant:aPoint.x]];
    [mutableArray addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:aPoint.y]];
    return mutableArray;
}

-(void)constrainSize:(CGSize)aSize
{
    [self addConstraints:[self sizeConstraints:aSize]];
}

-(void)constrainPosition:(CGPoint)aPoint
{
    if (!self.superview) {
        return;
    }
    [self.superview addConstraints:[self positionConstraints:aPoint]];
}

#pragma mark center in superview
-(void)centerHorizontallyInSuperview
{
    if (!self.superview) {
        return;
    }
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
}

-(NSLayoutConstraint*)centerXConstraint
{
    if (!self.superview) {
        return nil;
    }
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0];
}

-(void)centerVerticallyInSuperview
{
    if (!self.superview) {
        return;
    }
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0]];
}

-(NSLayoutConstraint*)centerYConstraint
{
    if (!self.superview) {
        return nil;
    }
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0];
}
#pragma mark aspect ratio
-(NSLayoutConstraint *)aspectConstraint:(CGFloat)aspectRatio
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:aspectRatio constant:0.0f];
}
-(void)constrainAspectRatio:(CGFloat)aspectRatio
{
    [self addConstraint:[self aspectConstraint:aspectRatio]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
