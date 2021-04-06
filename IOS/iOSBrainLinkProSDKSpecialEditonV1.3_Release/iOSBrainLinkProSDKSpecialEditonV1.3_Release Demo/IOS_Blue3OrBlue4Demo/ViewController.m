//
//  ViewController.m
//  IOS_Blue4Demo
//
//  Created by Macrotellect-iOSDev on 2019/8/8.
//  Copyright © 2019 Macrotellect-iOSDev. All rights reserved.
//

#import "ViewController.h"
#import "FactoryViewController.h"
#import "LookLineChatViewController.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *conSumTf;

@end

@implementation ViewController
- (IBAction)gotoData:(id)sender {
    
    BOOL isPres = NO;
    NSArray *arr;
    NSLog(@"=====textView:%@",_textView.text);
    if(_textView.text && ![_textView.text isEqualToString:@""]){
        NSString *str = _textView.text ;
         arr = [str componentsSeparatedByString:@","];
        
        if(arr && arr.count < 0){
            isPres = YES;
        }
    }else{
        isPres = YES;
    }
   
    if(isPres){
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"请输入设备名，以中文逗号分割" preferredStyle:UIAlertControllerStyleAlert];
        //默认只有标题 没有操作的按钮:添加操作的按钮 UIAlertAction
        
        
        //添加确定
        UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull   action) {
            NSLog(@"确定");
        }];
        //设置`确定`按钮的颜色
        [sureBtn setValue:[UIColor redColor] forKey:@"titleTextColor"];
        //将action添加到控制器
        
        [alertVc addAction :sureBtn];
        //展示
        [self presentViewController:alertVc animated:YES completion:nil];
        return;
    }
   
    
    
    if(_conSumTf.text && ![_conSumTf.text  isEqualToString:@""] ){
        FactoryViewController *fc = [[FactoryViewController alloc] init];
        fc.modalPresentationStyle= UIModalPresentationFullScreen;
        NSString *checkedNumString = _conSumTf.text;
        checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
        if(checkedNumString.length <= 0) {
            if([_conSumTf.text intValue] > 0 && [_conSumTf.text intValue] < 8){
                fc.devSum = [_conSumTf.text intValue];
                 fc.deviceNames = arr;
                [self presentViewController:fc animated:YES completion:nil];
                return;
            }
        }
        
    }
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"请输入的纯数字(大于0小于7)" preferredStyle:UIAlertControllerStyleAlert];
    //默认只有标题 没有操作的按钮:添加操作的按钮 UIAlertAction
    
    
    //添加确定
    UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull   action) {
        NSLog(@"确定");
    }];
    //设置`确定`按钮的颜色
    [sureBtn setValue:[UIColor redColor] forKey:@"titleTextColor"];
    //将action添加到控制器
    
    [alertVc addAction :sureBtn];
    //展示
    [self presentViewController:alertVc animated:YES completion:nil];
   
}
- (IBAction)goToChart:(id)sender {
    
    BOOL isPres = NO;
      NSArray *arr;
      if(_textView.text && ![_textView.text isEqualToString:@""]){
          NSString *str = _textView.text ;
           arr = [str componentsSeparatedByString:@","];
          
          if(arr && arr.count < 0){
              isPres = YES;
          }
      }else{
          isPres = YES;
      }
     
      if(isPres){
          UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"请输入设备名，以中文逗号分割" preferredStyle:UIAlertControllerStyleAlert];
          //默认只有标题 没有操作的按钮:添加操作的按钮 UIAlertAction
          
          
          //添加确定
          UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull   action) {
              NSLog(@"确定");
          }];
          //设置`确定`按钮的颜色
          [sureBtn setValue:[UIColor redColor] forKey:@"titleTextColor"];
          //将action添加到控制器
          
          [alertVc addAction :sureBtn];
          //展示
          [self presentViewController:alertVc animated:YES completion:nil];
          return;
      }
     
      
      
      if(_conSumTf.text && ![_conSumTf.text  isEqualToString:@""] ){
          LookLineChatViewController *ll = [[LookLineChatViewController alloc] init];
          ll.modalPresentationStyle= UIModalPresentationFullScreen;
          NSString *checkedNumString = _conSumTf.text;
          checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
          if(checkedNumString.length <= 0) {
              if([_conSumTf.text intValue] > 0 && [_conSumTf.text intValue] < 8){
                  ll.devSum = [_conSumTf.text intValue];
                   ll.deviceNames = arr;
                  [self presentViewController:ll animated:YES completion:nil];
                  return;
              }
          }
          
      }
      
      UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"请输入的纯数字(大于0小于7)" preferredStyle:UIAlertControllerStyleAlert];
      //默认只有标题 没有操作的按钮:添加操作的按钮 UIAlertAction
      
      
      //添加确定
      UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull   action) {
          NSLog(@"确定");
      }];
      //设置`确定`按钮的颜色
      [sureBtn setValue:[UIColor redColor] forKey:@"titleTextColor"];
      //将action添加到控制器
      
      [alertVc addAction :sureBtn];
      //展示
      [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
