//
//  MyMemberModel.h
//  smarket
//
//  Created by ym on 17/5/9.
//  Copyright © 2017年 飞扬软件. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyMemberModel : NSObject
@property(nonatomic,strong)NSString* title;
//@property(nonatomic,strong)NSMutableArray<MyMemberModel *>* parent;
@property(nonatomic,strong)NSMutableArray<MyMemberModel *>* children;


@end
