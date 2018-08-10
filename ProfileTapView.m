//
//  ProfileTapView.m
//  ZHLY
//
//  Created by 黄超 on 2018/5/25.
//  Copyright © 2018年 Mr LAI. All rights reserved.
//

#import "ProfileTapView.h"
#import "ProfileTapViewCell.h"
#import <Masonry/Masonry.h>
#import "Tool.h"
#import "HomeModel.h"
@interface ProfileTapView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,assign)NSInteger selectedRow;
@end

@implementation ProfileTapView

static const int cellSpace= 20;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIView *)bottomView{
    
    if (_bottomView==nil) {
        _bottomView=[[UIView alloc]init];
        [_bottomView setBackgroundColor:[UIColor colorWithRed:243/255.0 green:67/255.0 blue:94/255.0 alpha:1]];

    }
    return _bottomView;
}


-(instancetype)init
{
    if (self=[super init])
    {

    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {

    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder])
    {
        
    }
    return self;
}


-(void)buildUI{
    self.backgroundColor=[UIColor whiteColor];
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];

    if (_isEqualization) {
        flowLayout.minimumInteritemSpacing=0;
        flowLayout.minimumLineSpacing=0;
    }else{
        flowLayout.minimumInteritemSpacing=cellSpace;
        flowLayout.minimumLineSpacing=cellSpace;
    }
    

    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];


    _collectionView.showsHorizontalScrollIndicator=NO;
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
        
    }];
    
    UINib *nib = [UINib nibWithNibName:@"ProfileTapViewCell"
                                bundle: [NSBundle mainBundle]];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"ProfileTapViewCell"];
    
    [_collectionView addSubview:self.bottomView];
    
       __weak typeof(self)wealSelf=self;
    
    NSString *title=@"";
    if ([_titleArr[0]isKindOfClass:[NSString class]]) {
        
        title=_titleArr[0];
        
    }else if ([_titleArr[0]isKindOfClass:[HomeDirectModel class]]){
        
        HomeDirectModel *model=_titleArr[0];
        title=model.name;
        
    }
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(2);
        make.bottom.equalTo(self).mas_offset(0);
        if (self.isEqualization) {
            
            float spaceWidth=(([UIScreen mainScreen].bounds.size.width/self.titleArr.count)-[Tool widthForLabelWithStr:title FontSize:15 Height:20])/2;
            make.left.equalTo(self.collectionView).with.offset(spaceWidth);

//            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width/self.titleArr.count);
        }else{
            make.left.equalTo(wealSelf.collectionView).mas_offset(cellSpace);
        }
        make.width.mas_equalTo([Tool widthForLabelWithStr:title FontSize:15 Height:20]);

    }];
    
    

    
    
    
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
}


-(void)setTitleArr:(NSArray *)titleArr{
    _titleArr=titleArr;
    if (titleArr.count>0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            [self buildUI];
            [self.collectionView reloadData];
        });
     
    }

    
}



#pragma mark -- UICollectionViewDataSource
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.titleArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProfileTapViewCell *cell= (ProfileTapViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier: @"ProfileTapViewCell"forIndexPath:indexPath];
    
    if ([_titleArr[indexPath.row]isKindOfClass:[NSString class]]) {
        
         cell.titleStr=_titleArr[indexPath.row];
        
    }else if ([_titleArr[indexPath.row]isKindOfClass:[HomeDirectModel class]]){
        
        HomeDirectModel *model=_titleArr[indexPath.row];
        cell.titleStr=model.name;
        
    }
    
   
    if (indexPath.row==_selectedRow) {
        
        cell.isSelected=YES;
        
    }else{
        
        cell.isSelected=NO;
        
    }
//    cell.isSelected=YES;
    return cell;
    
}


//头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}


#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    
        if (_isEqualization) {
                return CGSizeMake([UIScreen mainScreen].bounds.size.width/_titleArr.count,self.frame.size.height);

        }else{
    
            NSString *title=@"";
            if ([_titleArr[indexPath.row]isKindOfClass:[NSString class]]) {
                
                title=_titleArr[indexPath.row];
                
            }else if ([_titleArr[indexPath.row]isKindOfClass:[HomeDirectModel class]]){
                
                HomeDirectModel *model=_titleArr[indexPath.row];
                title=model.name;
                
            }
            
                return CGSizeMake([Tool widthForLabelWithStr:title FontSize:15 Height:20]+2,self.frame.size.height);
            
        }
    

}

//定义每个UICollectionView  Section的间距                 注意是整个section！
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (_isEqualization) {
        return UIEdgeInsetsMake(0, 0, 0, 0);//(上,左,下,右)
    }
    return UIEdgeInsetsMake(0, cellSpace, 0, 0);//(上,左,下,右)
}

////定义每个UICollectionView 纵向的间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 0;
//}
////横向距离
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return 0;
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
{
    
    return CGSizeZero;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeZero;
}


#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileTapViewCell *cell = (ProfileTapViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSString *title=@"";
    if ([_titleArr[indexPath.row]isKindOfClass:[NSString class]]) {
        
        title=_titleArr[indexPath.row];
        
    }else if ([_titleArr[indexPath.row]isKindOfClass:[HomeDirectModel class]]){
        
        HomeDirectModel *model=_titleArr[indexPath.row];
        title=model.name;
        
    }
    [self layoutIfNeeded];
       __weak typeof(self)weakSelf=self;
    [UIView animateWithDuration:0.25 animations:^{
        
        [weakSelf.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
                       if (weakSelf.isEqualization) {
                           
                           float spaceWidth=(([UIScreen mainScreen].bounds.size.width/weakSelf.titleArr.count)-[Tool widthForLabelWithStr:title FontSize:15 Height:20])/2;
                           make.left.equalTo(weakSelf.collectionView).with.offset(cell.frame.origin.x+spaceWidth);
                    
            
                       }else{
                           
                   make.left.equalTo(weakSelf.collectionView).with.offset(cell.frame.origin.x);
                       }
            
            
           
            
//           if (weakSelf.isEqualization) {
//
//               make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width/weakSelf.titleArr.count);
//
//           }else{
            
                   make.width.mas_equalTo([Tool widthForLabelWithStr:title FontSize:15 Height:20]);
//           }
            
         
        }];
        [self layoutIfNeeded];
        
    }];
    
    if ([_titleArr[indexPath.row]isKindOfClass:[NSString class]]) {
        
        if (self.clickTapBlock) {
            self.clickTapBlock(_titleArr[indexPath.row]);
        }
    }else if ([_titleArr[indexPath.row]isKindOfClass:[HomeDirectModel class]]){
        
        if (self.clickTapWithModelBlock) {
            self.clickTapWithModelBlock(_titleArr[indexPath.row]);
        }
        
    }
    
   
    
    _selectedRow=indexPath.row;
    
    [self.collectionView reloadData];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}






@end
