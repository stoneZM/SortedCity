//
//  ViewModel.h
//  SortedCity
//
//  Created by stone on 16/7/13.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityModel.h"

@interface ViewModel : NSObject

/**
 按省份个数确定分区数
 */
@property (nonatomic,assign)NSInteger sectionNum;

@property (nonatomic,strong)NSArray* dataArr;
/**
 根据分区确定有几个城市
 */
-(NSInteger)rowNumForSection:(NSInteger)section;
/**

 @param section 分区行

 @return 分区头的标题
 */
-(NSString*)titleForSection:(NSInteger)section;
/**

 @param section 分区数
 @param row     分区里的行号
 @return 所在分区的每一个行的城市名称
 */

-(NSString*)titleForRowInSection:(NSInteger)section  row:(NSInteger)row;


/**
 获取排列好的城市
 */
-(NSString*)titleForrow:(NSInteger)row;
-(NSInteger)rowNum;
@end
