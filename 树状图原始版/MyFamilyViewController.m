//
//  MyFamilyViewController.m
//  smarket
//
//  Created by ym on 17/5/9.
//  Copyright © 2017年 飞扬软件. All rights reserved.
//

#import "MyFamilyViewController.h"
#import "MyFamilyView.h"
#import "MyMemberModel.h"
#import "MyMemberView.h"
#import "MemberRectView.h"
#import "ConstantDefine.h"
#import "Masonry.h"
@interface MyFamilyViewController ()
@property(nonatomic,strong)MyFamilyView *view_main;
@property(nonatomic,strong)MyMemberModel *fModel;
@end

@implementation MyFamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    [self createData];
}

-(void)createUI
{
    [self.view addSubview:self.view_main];
}

-(void)createData
{
    self.fModel=[[MyMemberModel alloc]init];
    self.fModel.title=@"root";
    
    
    MyMemberModel *model=[[MyMemberModel alloc]init];
    model.title=@"1";
    [self.fModel.children addObject:model];
    
    MyMemberModel *model11=[[MyMemberModel alloc]init];
    model11.title=@"11";
    [model.children addObject:model11];
    
    MyMemberModel *model12=[[MyMemberModel alloc]init];
    model12.title=@"12";
    [model.children addObject:model12];
    
    MyMemberModel *model13=[[MyMemberModel alloc]init];
    model13.title=@"13";
    [model.children addObject:model13];
    
    MyMemberModel *model111=[[MyMemberModel alloc]init];
    model111.title=@"111";
    [model11.children addObject:model111];
    
    MyMemberModel *model112=[[MyMemberModel alloc]init];
    model112.title=@"112";
    [model11.children addObject:model112];
    
//    for (int i=0;i<100;i++) {
//        MyMemberModel *model111=[[MyMemberModel alloc]init];
//        model111.title=[NSString stringWithFormat:@"111%d",i];
//        [model111.children addObject:model111];
//    }
    
    MyMemberModel *model2=[[MyMemberModel alloc]init];
    model2.title=@"2";
    [self.fModel.children addObject:model2];
    
    MyMemberModel *model21=[[MyMemberModel alloc]init];
    model21.title=@"21";
    [model2.children addObject:model21];
    
//    for (int i=0;i<5;i++) {
//        MyMemberModel *model111=[[MyMemberModel alloc]init];
//        model111.title=[NSString stringWithFormat:@"2%d",i];
//        [model2.children addObject:model111];
//    }
    
    MyMemberModel *model22=[[MyMemberModel alloc]init];
    model22.title=@"22";
    [model2.children addObject:model22];
    
    MyMemberModel *model3=[[MyMemberModel alloc]init];
    model3.title=@"3";
    [self.fModel.children addObject:model3];
    
    MyMemberModel *model4=[[MyMemberModel alloc]init];
    model4.title=@"4";
    [self.fModel.children addObject:model4];
    
    MyMemberModel *model41=[[MyMemberModel alloc]init];
    model41.title=@"41";
    [model4.children addObject:model41];

    MyMemberModel *model5=[[MyMemberModel alloc]init];
    model5.title=@"5";
    [self.fModel.children addObject:model5];
    
    
//    self.fModel.rect=CGRectMake((MainScreenW-HeadWidth)/2, (MainScreenH-HeadHeight-YSpace)/2, self.fModel.children.count*HeadWidth+(self.fModel.children.count-1)*XSpace, HeadHeight+YSpace);
    self.view_main.model=self.fModel;
    

    [self updateView:self.fModel];
}

-(void)updateView:(MyMemberModel*)entity
{
    float maxwidth =[self getWidth:entity];
    NSLog(@"宽:%f,%f",maxwidth,maxwidth/(HeadWidth+XSpace));
    float height = [self getHeight:entity depth:1];
    NSLog(@"高:%f,%f",height,height/(HeadHeight +YSpace));
    if(maxwidth>self.view_main.scrollview.frame.size.width)
    {
        self.view_main.scrollview.contentSize=CGSizeMake(maxwidth+2*XSpace, self.view_main.scrollview.contentSize.height);
    }
    if(height>self.view_main.scrollview.frame.size.height)
    {
        self.view_main.scrollview.contentSize=CGSizeMake(self.view_main.scrollview.contentSize.width,height);
    }
    if(MainScreenW>maxwidth)
    {
    [self addCell:self.fModel x:(MainScreenW-maxwidth)/2 y:MainScreenH-NavigationHeight-HeadHeight-YSpace];
    }else{
       [self addCell:self.fModel x:XSpace y:MainScreenH-NavigationHeight-HeadHeight-YSpace-50];
    }
}

/**
 *  添加单元格
 *
 *  @param entity 当前树状图
 *  @param x      左边坐标
 *  @param y      上边坐标
 @  @reture       返回中点X坐标
 */
-(float)addCell:(MyMemberModel*)entity x:(float)x y:(float)y{
//    float height = [self getHeight:entity depth:1];
    float maxwidth =[self getWidth:entity];
    MemberRectView *rectView=[[MemberRectView alloc]initWithMemberModel:entity];
    rectView.menberView.lb_nick.text=entity.title;
    rectView.frame=CGRectMake(x, y, maxwidth, HeadHeight+YSpace);
    rectView.backgroundColor=[UIColor redColor];
    [self.view_main.scrollview addSubview:rectView];
    
    //添加子元素
    float sh = x;
    float topX = 0.0,bottomX = 0.0;
    for (int i= 0 ; i < entity.children.count ; i++) {
//        float num=y-YSpace-HeadHeight;
        float subcellX = [self addCell:entity.children[i] x:sh y:y-YSpace-HeadHeight];
        if (i == 0) {
            topX = subcellX;
        }else if(i == entity.children.count-1){
            bottomX = subcellX;
        }
        
        sh+=[self getWidth:entity.children[i]];
    }
    
    //画横线

    if (entity.children.count>1)
    {
        
        View *yBranchLine=[[View alloc]initWithFrame:CGRectMake(topX, y-0.5,bottomX-topX, 1)];
        yBranchLine.backgroundColor=[UIColor blackColor];
        [self.view_main.scrollview addSubview:yBranchLine];
    }
    
    
    return maxwidth/2+x;
}


/**
 *  计算最大宽度
 *
 *  @param entity 当前树状图
 *
 *  @return 最高处的高度
 */
-(float)getWidth:(MyMemberModel *)entity{
    int width = 0;
    for (int i= 0 ; i < entity.children.count ; i++) {
        width+=[self getWidth:entity.children[i]];
    }
    return width?width:(HeadWidth + XSpace);
}

/**
 *  获取高度
 *
 *  @param entity 当前树状图
 *  @param v      当前节点深度 1开始
 *
 *  @return 最深的深度
 */
-(float)getHeight:(MyMemberModel *)entity depth:(int)v{
    int maxHeight = v*(HeadHeight+YSpace);
    for (int i= 0 ; i < entity.children.count ; i++) {
        float mw = [self getHeight:entity.children[i] depth:v+1];
        if (mw>maxHeight) {
            maxHeight = mw;
        }
    }
    return maxHeight?maxHeight:(HeadHeight+YSpace);
}



- (MyFamilyView *)view_main {
	if (_view_main == nil) {
        _view_main = [[MyFamilyView alloc] initWithFrame:CGRectMake(0, NavigationHeight, MainScreenW, MainScreenH-NavigationHeight)];
        
	}
	return _view_main;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
