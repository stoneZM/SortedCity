//
//  CityModel.h
//  地区列表展示
//
//  Created by stone on 16/7/13.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject
/**
 省份
 */
@property (nonatomic,strong)NSString* provinceName;
/**
 存放子地区模型的数组
 */
@property (nonatomic,strong)NSArray* subCities;


@property (nonatomic,assign)int      ID;

@property (nonatomic,strong)NSArray* index;
/**
 提供一个方法，获取数据
 */

+(NSArray*)getAllprovincesAndCities;
+(NSDictionary*)getAllCitiesBySorted;
+(NSArray*)getallCities;
@end

/**
 子地区数据模型
 */
@interface SubCityModel : NSObject

@property (nonatomic,strong)NSString* cityName;

@property (nonatomic,assign)int       ID;

@property (nonatomic,assign)NSInteger pID;

@property (nonatomic,assign)NSInteger zipCode;

+(NSArray*)getSubCitiesWithArray:(NSArray*)array;
-(instancetype)initWithDic:(NSDictionary*)dic;

@end