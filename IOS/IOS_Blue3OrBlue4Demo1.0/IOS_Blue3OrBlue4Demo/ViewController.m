//
//  ViewController.m
//  IOS_HZLBlue4.0Demo
//
//  Created by 方亮 on 2018/6/24.
//  Copyright © 2018年 macrotellect. All rights reserved.
//

#import "ViewController.h"
#import "FactoryViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)getData:(id)sender {
     FactoryViewController *ff = [[FactoryViewController alloc] init];
     ff.modalPresentationStyle = UIModalPresentationFullScreen;
     [self presentViewController:ff animated:YES completion:nil];
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
