//
//  LookLineChatViewController.h
//  蓝牙4.0测试
//
//  Created by Macrotellect-iOSDev on 2018/5/9.
//  Copyright © 2018年 Macrotellect-iOSDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookLineChatViewController : UIViewController
@property (nonatomic,strong) NSMutableArray *attention;//专注度数据
@property (nonatomic,strong) NSMutableArray *meditation;//放松度数据

@property(nonatomic,assign)int devSum;
@property(nonatomic,copy)NSArray *deviceNames;

@end
