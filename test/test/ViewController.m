//
//  ViewController.m
//  test
//
//  Created by rongjun on 15/4/1.
//  Copyright (c) 2015年 Migoo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height/2)];
    UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(0, image.bounds.size.height-30, image.bounds.size.width,30)];
    lable.text = @"mac1024";
    lable.textColor = [UIColor blackColor];
    lable.backgroundColor = [UIColor blueColor];
    lable.alpha = 0.2;
    lable.font = [UIFont boldSystemFontOfSize:14];
    [image addSubview:lable];
    image.backgroundColor = [UIColor whiteColor];
    image.image = [[UIImage alloc] initWithContentsOfFile:@"white"];
    [self.view addSubview:image];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
