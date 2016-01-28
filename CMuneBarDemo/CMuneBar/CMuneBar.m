//
//  MuneBar.m
//  WKMuneController
//
//  Created by macairwkcao on 16/1/26.
//  Copyright © 2016年 CWK. All rights reserved.
//

#import "CMuneBar.h"
#import "CMuneItem.h"

#define kRotationAngle M_PI / 20


@interface CMuneBar()

@property (nonatomic,weak)UIButton *mainButton;

@property(nonatomic,strong)NSArray *items;



@end


@implementation CMuneBar

-(instancetype)initWithItems:(NSArray *)itemsImages itemsHeighightedImages:(NSArray *)itemsHeighightedImages size:(CGSize)size type:(MuneBarType)type{
    self = [super init];
    if (self) {
        self.itemsImages = itemsImages;
        self.itemsHeighightedImages = itemsHeighightedImages;
        self.isShow = NO;
        self.type = type;
        self.frame = CGRectMake(0, 0, size.width, size.height);
        self.layer.cornerRadius = size.width / 2.0;
//        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        [self addSubviews];
    }
    return self;
}

-(void)setImage:(UIImage *)image{
    [self.mainButton setImage:image forState:UIControlStateNormal];
}

-(void)setHighlightedImage:(UIImage *)highlightedImage{
    [self.mainButton setImage:highlightedImage forState:UIControlStateHighlighted];
}

-(void)setTitle:(NSString *)title color:(UIColor *)color{
    [self.mainButton setTitle:title forState:UIControlStateNormal];
    [self.mainButton setTitleColor:color forState:UIControlStateNormal];
}


#pragma mark - 重写父类方法
/**
 *  重写hitTest:withEvent:方法，检查是否点击item
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *result = [super hitTest:point withEvent:event];
    if (self.isShow) {
        for (CMuneItem *item in self.items) {
            CGPoint buttonPoint = [item convertPoint:point fromView:self];
            if ([item pointInside:buttonPoint withEvent:event]) {
                return item;
            }
            
        }
    }
    return result;
}

-(void)setType:(MuneBarType)type{
    _type = type;
}

#pragma mark 私有方法

/**
 *  添加子视图
 */
-(void)addSubviews{
    UIButton *mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [mainButton addTarget:self action:@selector(showItems) forControlEvents:UIControlEventTouchUpInside];
    [mainButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [mainButton setBackgroundColor:[UIColor lightGrayColor]];
    [mainButton setTitle:@"Mune" forState:UIControlStateNormal];
    self.mainButton = mainButton;
    self.mainButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    mainButton.layer.cornerRadius = self.frame.size.width / 2.0;
    mainButton.layer.masksToBounds = YES;

    /**
     *  菜单选项
     */
    [self items];
    
    [self addSubview:_mainButton];
    
}

/**
 *  懒加载菜单选项
 */
-(NSArray *)items{
    if (_items == nil) {
        NSMutableArray *items = [NSMutableArray arrayWithCapacity:self.itemsImages.count];
        for (int i = 0; i < self.itemsImages.count; i++) {
            UIImage *image = [UIImage imageNamed:self.itemsImages[i]];
            UIImage *heighlightImage = [UIImage imageNamed:self.itemsHeighightedImages[i]];

            CMuneItem *item = [CMuneItem muneItemWithSize:CGSizeMake(self.frame.size.width, self.frame.size.height) image:image heightImage:heighlightImage target:self action:@selector(tapItem:)];
            item.tag = 100 + i;
            item.center = self.mainButton.center;
            [self addSubview:item];
            [items addObject:item];
        }
        [self addSubview:_mainButton];
        _items = items;
    }
    return _items;
}

/**
 *  展开item，以MuneBarTypeRound方式展开
 *
 *  @param offsetAngle  根据展开的方向不同，设置不同的偏移角度
 */

-(void)itemShowRoundTypeWithOffsetAngle:(CGFloat)offsetAngle{
    CGFloat count = self.items.count;
    for (CMuneItem *item in self.items) {
        CGFloat angle = [self caculateRoundAngleWithOffsetAngle:offsetAngle index:count];
        [item itemShowWithType:kMuneItemShowTypeRound angle:angle];
        count -- ;
    }
}

-(void)itemShowLineWithOffsetPoint:(CGPoint)point incremenr:(CGSize)increment{
    CGFloat count = self.items.count;

    for (CMuneItem *item in self.items) {
        CGPoint targetPoint = [self caculateLinePointWithOffsetPoint:point increment:increment index:count];
        [item itemShowWithTargetPoint:targetPoint type:kMuneItemShowTypeLine];
        count -- ;
    }
}

/**
 *  展开角度计算，以MuneBarTypeRound方式展开
 *
 *  @param offsetAngle  根据展开的方向不同，设置不同的偏移角度
 *  @param index
 *  @return return angle 每个item偏移的角度
 */

-(CGFloat)caculateRoundAngleWithOffsetAngle:(CGFloat)offsetAngle index:(CGFloat)index{
    CGFloat angle = M_PI / (self.items.count);
    angle = angle * index - angle / 2.0 + offsetAngle;
    return angle;
}

-(CGPoint)caculateLinePointWithOffsetPoint:(CGPoint)offsetPoint increment:(CGSize)increment index:(NSInteger)index{
    CGFloat x = offsetPoint.x;
    CGFloat y = offsetPoint.y;
    x += increment.width * index;
    y += increment.height * index;
    CGPoint point = CGPointMake(x, y);
    return point;
}


#pragma mark - 成员方法
/**
 *  显示菜单
 */
-(void)showItems{
    if (!self.isShow) {
        CGFloat count = self.items.count;
        self.isShow = YES;
        if ([self.delegate respondsToSelector:@selector(muneBarHide)]) {
            [self.delegate muneBarShow];
        }
        switch (self.type) {
            case kMuneBarTypeRadRight:
                for (CMuneItem *item in self.items) {
                    [item itemShowWithType:kMuneItemShowTypeRadRight angle:kRotationAngle * count];
                    count --;
                }
                break;
            case kMuneBarTypeRadLeft:
                for (CMuneItem *item in self.items) {
                    [item itemShowWithType:kMuneItemShowTypeRadLeft angle:kRotationAngle * count];
                    count --;
                }
                break;
            case kMuneBarTypeLineTop:{
                [self itemShowLineWithOffsetPoint:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0) incremenr:CGSizeMake(0, -self.frame.size.height - 10)];
            }
                break;
            case kMuneBarTypeLineBottom:{
                [self itemShowLineWithOffsetPoint:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0) incremenr:CGSizeMake(0, self.frame.size.height + 10)];

            }
                break;
            case kMuneBarTypeLineLeft:{
                [self itemShowLineWithOffsetPoint:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0) incremenr:CGSizeMake(- self.frame.size.height - 10, 0)];
            }
                break;
            case kMuneBarTypeLineRight:{
                [self itemShowLineWithOffsetPoint:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0) incremenr:CGSizeMake(self.frame.size.height + 10, 0)];
            }
                break;
            case kMuneBarTypeRoundTop:{
                [self itemShowRoundTypeWithOffsetAngle:0];
            }
                break;
                
            case kMuneBarTypeRoundBottom:{
                [self itemShowRoundTypeWithOffsetAngle:- M_PI];
            }
                break;
            case kMuneBarTypeRoundLeft:{
                [self itemShowRoundTypeWithOffsetAngle:M_PI / 2.0];

            }
                break;
            case kMuneBarTypeRoundRight:{
                [self itemShowRoundTypeWithOffsetAngle: - M_PI / 2.0];

            }
                break;
            default:
                break;
        }
    }else{
        [self hideItems];
    }
}




/**
 *  隐藏菜单
 */
-(void)hideItems{
    for (CMuneItem *item in self.items) {
        [item itemHide];
    }
    if ([self.delegate respondsToSelector:@selector(muneBarHide)]) {
        [self.delegate muneBarShow];
    }
    self.isShow = NO;
}

#pragma 点击事件
/**
 * 点击item响应
 */
-(void)tapItem:(CMuneItem *)item{
    if ([self.delegate respondsToSelector:@selector(muneBarselected:)]) {
        [self.delegate muneBarselected:item.tag - 100];
    }

}



@end
