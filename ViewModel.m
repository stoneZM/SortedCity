//
//  ViewModel.m
//  地区列表展示
//
//  Created by stone on 16/7/13.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ViewModel.h"

@interface ViewModel()

@property (nonatomic,strong)NSDictionary* dic;

@end

@implementation ViewModel

-(NSArray *)allCitiesName{
    NSArray* arr = [CityModel getallCities];
    NSMutableArray* names = [NSMutableArray new];
    for (SubCityModel* model in arr) {
        [names addObject:model.cityName];
    }
    if (_allCitiesName == nil) {
        _allCitiesName = [NSArray arrayWithArray:names];
    }
    return _allCitiesName;
}

-(NSDictionary *)dic{
    if (_dic == nil) {
        _dic = [CityModel getAllCitiesBySorted];
    }
    return _dic;
}
-(NSArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = self.dic[@"sortedCity"];
    }
    return _dataArr;
}
-(NSArray *)index{
    if (_index == nil) {
        _index = [NSArray arrayWithArray:self.dic[@"index"]];
    }
    return _index;
}

-(NSInteger)sectionNum{
    return self.index.count;
}

-(SubCityModel*)modelForRowInSection:(NSInteger)section row:(NSInteger)row{
   SubCityModel* model = self.dataArr[section][row];
    return model;
}

/**
 根据分区确定有几个城市
 */
-(NSInteger)rowNumForSection:(NSInteger)section{

    NSArray* arr = [NSArray arrayWithArray:self.dataArr[section]];
    return arr.count;
}

/**

 @param section 分区行

 @return 分区头的标题
 */
-(NSString*)indexForSection:(NSInteger)section{
    return self.index[section];
}
/**

 @param section 分区数
 @param row     分区里的行号
 @return 所在分区的每一个行的城市名称
 */

-(NSString*)titleForRowInSection:(NSInteger)section  row:(NSInteger)row{

    return [self modelForRowInSection:section row:row].cityName;
}



-(NSString *)titleForrow:(NSInteger)row{
    SubCityModel* model = self.dataArr[row];
    return model.cityName;
}
-(NSInteger)rowNum{
    return self.dataArr.count;
}

@end
