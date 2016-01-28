//
//  MuneBar.h
//  WKMuneController
//
//  Created by macairwkcao on 16/1/26.
//  Copyright © 2016年 CWK. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_OPTIONS(NSUInteger, MuneBarType){
    kMuneBarTypeRadLeft = 0,
    kMuneBarTypeRadRight,
    kMuneBarTypeLineTop,
    kMuneBarTypeLineBottom,
    kMuneBarTypeLineLeft,
    kMuneBarTypeLineRight,
    kMuneBarTypeRoundTop,
    kMuneBarTypeRoundBottom,
    kMuneBarTypeRoundLeft,
    kMuneBarTypeRoundRight,
};

@protocol CMuneBarDelegate <NSObject>

@optional
-(void)muneBarselected:(NSInteger)index;
@optional
-(void)muneBarShow;
@optional
-(void)muneBarHide;

@end


@interface CMuneBar : UIView

@property(nonatomic,strong)NSArray *itemsImages;

@property(nonatomic,strong)NSArray *itemsHeighightedImages;


@property(nonatomic,weak)id <CMuneBarDelegate> delegate;

@property(nonatomic,assign)MuneBarType type;

@property(nonatomic,assign)BOOL isShow;


/**
 *  初始化函数
 *
 *  @param itemsImages 图片数组
 *  @param size        尺寸
 *
 *  @return 
 */
-(instancetype)initWithItems:(NSArray *)itemsImages itemsHeighightedImages:(NSArray *)itemsHeighightedImages size:(CGSize)size type:(MuneBarType)type;
/**
 *  显示菜单
 */
-(void)showItems;
/**
 *  隐藏菜单
 */
-(void)hideItems;


@end
