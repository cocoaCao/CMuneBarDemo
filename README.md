# CMuneBarDemo
近期在学习动画，为了巩固，写了这一个demo和大家分享
用法很简单：

1.导入头文件 #import "CMuneBar.h"

2.创建

CMuneBar *muneBar = [[CMuneBar alloc] initWithItems:@[@"gallery",@"dropbox",@"camera",@"draw"] size:CGSizeMake(50, 50) type:kMuneBarTypeRadLeft];


3.设置代理muneBar.delegate = self;

4.添加到视图 [self.view addSubview:muneBar];


在这里我提供了十种样式
`typedef NS_OPTIONS(NSUInteger, MuneBarType){

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
`};

具体演示效果看这；

