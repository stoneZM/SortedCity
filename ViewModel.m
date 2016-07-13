//
//  ViewModel.m
//  地区列表展示
//
//  Created by stone on 16/7/13.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ViewModel.h"

@implementation ViewModel


-(NSArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [CityModel getAllCitiesBySorted];
    }
    return _dataArr;
}
-(NSInteger)sectionNum{
    return self.dataArr.count;
}

-(CityModel*)modelForSection:(NSInteger)section{
    return  self.dataArr[section];
}

/**
 根据分区确定有几个城市
 */
-(NSInteger)rowNumForSection:(NSInteger)section{

    return [self modelForSection:section].subCities.count;
}

/**

 @param section 分区行

 @return 分区头的标题
 */
-(NSString*)titleForSection:(NSInteger)section{
    return [self modelForSection:section].provinceName;
}
/**

 @param section 分区数
 @param row     分区里的行号
 @return 所在分区的每一个行的城市名称
 */

-(NSString*)titleForRowInSection:(NSInteger)section  row:(NSInteger)row{
    SubCityModel* model = [self modelForSection:section].subCities[row];
    return model.cityName;
}


-(NSArray*)models{
    return [CityModel getAllCitiesBySorted];
}

-(NSString *)titleForrow:(NSInteger)row{
    SubCityModel* model = self.dataArr[row];
    return model.cityName;
}
-(NSInteger)rowNum{
    return self.dataArr.count;
}

@end
