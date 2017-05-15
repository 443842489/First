//
//  MemberRectView.h
//  smarket
//
//  Created by ym on 17/5/10.
//  Copyright © 2017年 飞扬软件. All rights reserved.
//

#import "View.h"
#import "MyMemberView.h"
#import "MyMemberModel.h"
@interface MemberRectView : View
@property(nonatomic,strong)MyMemberView *menberView;
@property(nonatomic,strong)View * yBottomLine;

-(instancetype)initWithMemberModel:(MyMemberModel*)model;
@end
