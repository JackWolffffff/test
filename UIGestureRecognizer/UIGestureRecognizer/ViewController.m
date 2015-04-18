//
//  ViewController.m
//  UIGestureRecognizer
//
//  Created by rongjun on 15/4/8.
//  Copyright (c) 2015年 Migoo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
-(void) GestureRecognizer:(UIGestureRecognizer *)sender;

@end
@implementation ViewController

UIImageView * imageView;
- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(GestureRecognizer:)];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GestureRecognizer:)];
    
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic.png"]];
    imageView.frame = CGRectMake(50, 50, 200, 200);
    [imageView addGestureRecognizer:pan];
    [self.view addSubview:imageView];
//    [self.view addGestureRecognizer:pan];
//    [self.view addGestureRecognizer:tap];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) GestureRecognizer:(UIGestureRecognizer *)sender{
    if ([sender isKindOfClass:[UITapGestureRecognizer class]]) {
        NSLog(@"tap");
    } else if([sender isKindOfClass:[UIPanGestureRecognizer class]]){
        NSLog(@"pan");
    }
}




@end

