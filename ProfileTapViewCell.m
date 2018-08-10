//
//  ProfileTapViewCell.m
//  ZHLY
//
//  Created by 黄超 on 2018/5/25.
//  Copyright © 2018年 Mr LAI. All rights reserved.
//

#import "ProfileTapViewCell.h"
@interface ProfileTapViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end
@implementation ProfileTapViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setTitleStr:(NSString *)titleStr{
    
    self.titleLab.text=titleStr;
    [self.titleLab setTextColor:[UIColor blackColor]];
}

-(void)setIsSelected:(BOOL)isSelected{
    if (isSelected) {
        [_titleLab setTextColor:[UIColor colorWithRed:243/255.0 green:67/255.0 blue:94/255.0 alpha:1]];
    }else{
        [_titleLab setTextColor:[UIColor blackColor]];
    }
}



@end
