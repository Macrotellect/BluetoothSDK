//
//  SystemPublic.h
//  AoHuaProjecte
//
//  Created by yunshang on 16/6/17.
//  Copyright © 2016年 yunshang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SystemPublic : NSObject


+ (SystemPublic *)publicManage;
/*
 *时间转换后格式为：yyyy-MM-dd HH:mm
 */
- (NSString *)timeStampHourMid:(NSString *)strTime;
/*
 *时间转换后格式为：yyyy-MM-dd
 */
- (NSString *)timeStamp:(NSString *)strTime dateFormat:(NSString *)dateFormat;
/*
 *判断字符串是不是数字，是数字返回YES，否返回NO
 */
- (BOOL)isPureNumandCharacters:(NSString *)string;
/*
 *设置Label的行间距
 */
- (void)setLineSpaceWithString:(UILabel *)label;
/*
 *让Plain风格的TableView的区头可以”不悬停”(可以直接百度搜到):
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView tableView:(UITableView *)tableView;
/*
 *8.创建一张实时模糊效果 View (毛玻璃效果)
 *Avilable in iOS 8.0 and later
 *
 */
- (UIVisualEffectView *)effectViewWithFrame:(CGRect)frame;
/*
 *6.对图片进行模糊处理
 */
- (UIImage *)blurWithOriginalImage:(UIImage *)image
                          blurName:(NSString *)name
                            radius:(NSInteger)radius;
/*
 *5.对图片进行滤镜处理
 */
- (UIImage *)filterWithOriginalImage:(UIImage *)image filterName:(NSString *)name;
/*
 *匹配是否为email地址。
 */
- (BOOL)validateEmail:(NSString *)candidate;
/*
 *判断手机号码格式是否正确
 */
- (BOOL)valiMobile:(NSString *)mobile;
/*
 *获取文件的大小。
 */
- (long)getDocumentSize:(NSString *)folderName;
/*
 *1.获取字符串(或汉字)首字母
 */
- (NSString *)firstCharacterWithString:(NSString *)string;
/*
 *2.将字符串数组按照元素首字母顺序进行排序分组
 */
- (NSDictionary *)dictionaryOrderByCharacterWithOriginalArray:(NSArray *)array;
/*
 *3.获取当前时间
 */
- (NSString *)currentDateWithFormat:(NSString *)format;
/*
 *1.磁盘总空间大小
 */
- (CGFloat)diskOfAllSizeMBytes;
/*
 *2.磁盘可用空间大小
 */
- (CGFloat)diskOfFreeSizeMBytes;
/*
 *截取view中某个区域生成一张图片
 */
- (UIImage *)shotWithView:(UIView *)view scope:(CGRect)scope;
/*
 *判断字符串中是否含有某个字符串
 */
- (BOOL)isHaveSpaceInString:(NSString *)string char:(NSString *)chars;
/*
 *判断字符串中是否含有中文
 */
- (BOOL)isHaveChineseInString:(NSString *)string;
/*
 *判断字符串是否全部为数字
 */
- (BOOL)isAllNum:(NSString *)string;
/*
 *压缩图片到指定文件大小
 */
- (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;
/*
 ** lineFrame:     虚线的 frame
 ** length:        虚线中短线的宽度
 ** spacing:       虚线中短线之间的间距
 ** color:         虚线中短线的颜色
 */
- (UIView *)createDashedLineWithFrame:(CGRect)lineFrame
                           lineLength:(int)length
                          lineSpacing:(int)spacing
                            lineColor:(UIColor *)color;
/**
 *  计算上次日期距离现在多久
 *
 *  @param lastTime    上次日期(需要和格式对应)
 *  @param format1     上次日期格式
 *  @param currentTime 最近日期(需要和格式对应)
 *  @param format2     最近日期格式
 *
 *  @return xx分钟前、xx小时前、xx天前
 */
- (NSString *)timeIntervalFromLastTime:(NSString *)lastTime
                        lastTimeFormat:(NSString *)format1
                         ToCurrentTime:(NSString *)currentTime
                     currentTimeFormat:(NSString *)format2;
/*
 *全屏截图
 */
- (UIImage *)shotScreen;

- (NSData *)convertHexStrToData:(NSString *)str;
//产生16位的随机字符
- (NSString *)generate16BitRandomChar;

/**
 *得到本机现在用的语言
 * en-CN 或en  英文  zh-Hans-CN或zh-Hans  简体中文   zh-Hant-CN或zh-Hant  繁体中文    ja-CN或ja  日本  ......
 */
- (NSString*)getPreferredLanguage;

@end
