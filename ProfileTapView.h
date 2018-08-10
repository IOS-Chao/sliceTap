//
//  ProfileTapView.h
//  ZHLY
//
//  Created by 黄超 on 2018/5/25.
//  Copyright © 2018年 Mr LAI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeDirectModel;
@interface ProfileTapView : UIView
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,assign)BOOL isEqualization;

@property(nonatomic,copy)void(^clickTapBlock)(NSString *title);
@property(nonatomic,copy)void(^clickTapWithModelBlock)(HomeDirectModel *model);
@end
