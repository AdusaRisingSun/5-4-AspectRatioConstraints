//
//  ViewController.m
//  AspectRatioConstraints
//
//  Created by Adusa on 15/9/10.
//  Copyright (c) 2015年 Adusa. All rights reserved.
//

#import "ViewController.h"
#import "ConstraintsHelper.h"
@interface ViewController ()

@end

@implementation ViewController
{
    UILabel *_label;
    BOOL _isbig;
    //NSMutableArray *_array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor=[UIColor whiteColor];
    UIBarButtonItem *change=[[UIBarButtonItem alloc]initWithTitle:@"change" style:UIBarButtonItemStyleDone target:self action:@selector(change:)];
    self.navigationItem.rightBarButtonItem=change;
    _isbig=NO;
    //_array=[NSMutableArray array];
    [self createLabel];
    [self.view addConstraint:[self smallStyle]];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)createLabel
{
    _label=[[UILabel alloc]init];
    _label.text=@"small";
    _label.textAlignment=NSTextAlignmentCenter;
    _label.textColor=[UIColor redColor];
    _label.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:_label];
    _label.translatesAutoresizingMaskIntoConstraints=NO;
    [_label centerHorizontallyInSuperview];
    [_label centerVerticallyInSuperview];
    [_label constrainWithinSuperviewBounds];
    [_label addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_label(100)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_label)]];
}

-(NSLayoutConstraint*)bigStyle
{
    return [_label aspectConstraint:3.0];
}


-(NSLayoutConstraint*)smallStyle
{
    return [_label aspectConstraint:2.0];
}

-(void)change:(UIBarButtonItem *)item
{
    
    if (!_isbig) {
        [self.view removeMatchingConstraint:[self  smallStyle]];
        [self.view addConstraint:[self bigStyle]];
    }else
    {
        [self.view removeMatchingConstraint:[self bigStyle]];
        [self.view addConstraint:[self smallStyle]];
    }
    _isbig=!_isbig;
    [UIView animateWithDuration:0.5 animations:^(){
        [self.view layoutIfNeeded];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
