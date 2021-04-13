//
//  ViewController.m
//  MAC_HZLBlue4.0Demo
//
//  Created by 方亮 on 2018/6/24.
//  Copyright © 2018年 macrotellect. All rights reserved.
//

#import "ViewController.h"
#import "ReciveViewController.h"


@implementation ViewController
- (IBAction)goToRecive:(id)sender {
    [self presentViewControllerAsSheet:[ReciveViewController new]];
}



- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    
    
    
}
-(void)touchesBeganWithEvent:(NSEvent *)event
{
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
