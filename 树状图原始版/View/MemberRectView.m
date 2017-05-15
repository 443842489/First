//
//  MemberRectView.m
//  smarket
//
//  Created by ym on 17/5/10.
//  Copyright © 2017年 飞扬软件. All rights reserved.
//

#import "MemberRectView.h"
#import "ConstantDefine.h"
#import "Masonry.h"
@interface MemberRectView()
@property(nonatomic,assign)CGFloat startX;//竖线的参照X坐标
@property(nonatomic,assign)CGFloat leftLineX;
@property(nonatomic,assign)CGFloat rightLineX;
@end
@implementation MemberRectView

-(instancetype)initWithMemberModel:(MyMemberModel*)model;
{
    self = [super init];
    if (self) {
        self.menberView.model=model;
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.startX=0;
    [self addSubview:self.menberView];
    
    [self.menberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(HeadWidth);
        make.height.mas_equalTo(HeadHeight);
    }];
    
    self.yBottomLine=[[View alloc]init];//底部的那根竖线
    self.yBottomLine.backgroundColor=[UIColor blackColor];
    [self addSubview:self.yBottomLine];
    [self.yBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.menberView.mas_bottom);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(YSpace/2);
    }];
    
    if(self.menberView.model.children.count>0)
    {
        //要画竖向分支线(有多少个分支，画多少条竖线。包括分支源头的那根竖线)
        
        View *yFromLine=[[View alloc]init];//源头的那根竖线
        yFromLine.backgroundColor=[UIColor blackColor];
        [self addSubview:yFromLine];
        [yFromLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.bottom.mas_equalTo(self.menberView.mas_top);
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(YSpace/2);
        }];
        
        
        
//        for(int i=0;i<self.menberView.model.children.count;i++)
//        {
//            //分支竖线
//            View *yBranchLine=[[View alloc]init];
//            yBranchLine.backgroundColor=GrayLineColor;
//            
//            MyMemberModel *model=self.menberView.model.children[i];
//            if(model.children.count>0)
//            {
//                
////                yBranchLine.frame=CGRectMake(HeadWidth/2+XSpace/2+i*(HeadWidth+XSpace)+((model.children.count-1)/2)*(HeadHeight+XSpace), 0, 1, YSpace/2);
//                 yBranchLine.frame=CGRectMake(model.children.count*(HeadWidth+XSpace)/2-0.5, 0, 1, YSpace/2);
//                self.startX+=model.children.count*(HeadHeight+XSpace);
//            }else{
//                yBranchLine.frame=CGRectMake(HeadWidth/2+XSpace/2+i*(HeadWidth+XSpace)+self.startX, 0, 1, YSpace/2);
//                self.startX=0;
//            }
//            [self addSubview:yBranchLine];
//
//        }
//        
//        
//        if(self.menberView.model.children.count>1)
//        {
//            //要画横向分支线(只画一根横线)
//            View *xLine=[[View alloc]init];
//            xLine.backgroundColor=GrayLineColor;
//            [self addSubview:xLine];
//            [xLine mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(XSpace/2+HeadWidth/2);
//                make.right.mas_equalTo(-XSpace/2-HeadWidth/2);
//                make.height.mas_equalTo(1);
//                make.bottom.mas_equalTo(yFromLine.mas_top).offset(0.5);
//            }];
//            
//        }
        
        
    }
    
}


- (MyMemberView *)menberView {
	if (_menberView == nil) {
        _menberView = [[MyMemberView alloc] init];
	}
	return _menberView;
}

@end





