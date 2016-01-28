//
//  ViewController.m
//  CMuneBarDemo
//
//  Created by macairwkcao on 16/1/28.
//  Copyright © 2016年 CWK. All rights reserved.
//

#import "ViewController.h"

#import "CMuneBar.h"

@interface ViewController ()<CMuneBarDelegate>
@property(nonatomic,weak)CMuneBar *muneBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",nil];
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    [segmentedControl setFrame:CGRectMake(20, 100, self.view.frame.size.width-40, 30)];
    [segmentedControl addTarget:self action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 0;
    [self.view addSubview:segmentedControl];
    
    CMuneBar *muneBar = [[CMuneBar alloc] initWithItems:@[@"gallery",@"dropbox",@"camera",@"draw"] size:CGSizeMake(50, 50) type:kMuneBarTypeRadLeft];
    muneBar.delegate = self;
    muneBar.center = CGPointMake(150, 480);
    [self.view addSubview:muneBar];
    self.muneBar = muneBar;
}

-(void)didClicksegmentedControlAction:(UISegmentedControl *)segmentedControl{
    if (self.muneBar.isShow) {
        [self.muneBar hideItems];
    }
    self.muneBar.type = segmentedControl.selectedSegmentIndex;
}

-(void)muneBarselected:(NSInteger)index{
    NSLog(@"%@",@(index));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
