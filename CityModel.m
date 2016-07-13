//
//  CityModel.m
//  地区列表展示
//
//  Created by stone on 16/7/13.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "CityModel.h"


@implementation CityModel

/**
 提供获取数据模型的类方法
 */
+(NSArray *)getAllprovincesAndCities{
    NSMutableArray* allModels = [NSMutableArray new];
    NSArray* arr = [NSArray arrayWithArray:[self getPlist]];
    for (NSDictionary* dic in arr) {
        CityModel* model = [[CityModel alloc]initWithDic:dic];
        [allModels addObject:model];
    }
    //进行排序操作
    NSArray* sorted =  [allModels sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        CityModel* model1 = obj1;
        CityModel* model2 = obj2;
        NSString* ch1 = [self transformCharacter:model1.provinceName];
        NSString* ch2 = [self transformCharacter:model2.provinceName];

        if (ch1 > ch2) {
            return NSOrderedDescending;
        }else if(ch1 < ch2)return NSOrderedAscending;
        else return NSOrderedSame;
    }];

    return sorted;
}
/**
 @return  获取所有没有经过排序的子城市
 */
+(NSArray*)getallCities{

    NSMutableArray* allCities = [[NSMutableArray alloc]init];
    NSArray* allProvinces = [NSArray arrayWithArray:[self getPlist]];
    for (NSDictionary* dic in allProvinces) {
        CityModel* model = [[CityModel alloc]initWithDic:dic];
        [allCities addObjectsFromArray:model.subCities];
    }
    return allCities;

}
/**
 对所有子城市进行分类排序
 */
+(NSArray*)getAllCitiesBySorted{

    NSMutableArray* allCity = [[self getallCities] mutableCopy];
    //    NSMutableArray *array = [[NSMutableArray alloc] init];
    //
    //    for(int i='A';i<='Z';i++)
    //    {
    //        NSMutableArray *rulesArray = [[NSMutableArray alloc] init];
    //
    //        NSString *str1=[NSString stringWithFormat:@"%c",i];
    //        for(int j=0;j < allCity.count;j++)
    //        {
    //            SubCityModel* model = allCity[j];
    //            if([[self transformCharacter:model.cityName] isEqualToString:str1])
    //            {
    //                [rulesArray addObject:model];
    //                [allCity removeObject:model];
    //                j--;
    //
    //            }
    //        }
    //        if (rulesArray.count != 0) {
    //            [array addObject:rulesArray];
    //        }
    //    }
    //进行排序操作

    NSArray* sorted =  [allCity sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        SubCityModel* model1 = obj1;
        SubCityModel* model2 = obj2;
        NSString* ch1 = [self transformCharacter:model1.cityName];
        NSString* ch2 = [self transformCharacter:model2.cityName];

        if (ch1 > ch2) {
            return NSOrderedDescending;
        }else if(ch1 < ch2)return NSOrderedAscending;
        else return NSOrderedSame;
    }];
    NSLog(@"%ld",sorted.count);
    return sorted;

}

/**
 属性的懒加载
 */
-(NSArray *)subCities{
    if (_subCities == nil) {
        _subCities = [NSArray new];
    }
    return _subCities;
}
/**
 获取plist文件中的数组
 */
+(NSArray*)getPlist{
    NSString* plistPath = [[NSBundle mainBundle]pathForResource:@"Provineces" ofType:@"plist"];
    NSArray* allProvience = [NSArray arrayWithContentsOfFile:plistPath];
    return allProvience;
}

/**
 提供一个初始化器，获取一个模型省的对象
 */
-(instancetype)initWithDic:(NSDictionary*)dic{

    if (self = [super init]) {
        self.provinceName = dic[@"ProvinceName"];
        self.ID = [dic[@"ID"] intValue];
        self.subCities = [SubCityModel getSubCitiesWithArray:dic[@"cities"]];
    }
    return self;
}

/**
 汉字转化为拼音，并返回首字母
 */
+(NSString *)transformCharacter:(NSString*)sourceStr
{
    //先将原字符串转换为可变字符串
    NSMutableString *ms = [NSMutableString stringWithString:sourceStr];

    if (ms.length) {
        //将汉字转换为拼音
        CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformToLatin, NO);
        //将拼音的声调去掉
        CFStringTransform((__bridge CFMutableStringRef)ms, 0,kCFStringTransformStripDiacritics,NO);
        //将字符串所有字母大写
        NSString *upStr = [ms uppercaseString];
        //截取首字母
        NSString *firstStr = [upStr substringToIndex:1];
        return firstStr;
    }
    return @"#";
}
@end


@implementation SubCityModel

+(NSArray*)getSubCitiesWithArray:(NSArray*)array{
    NSMutableArray* subCities = [NSMutableArray new];
    for (int i = 0; i < array.count; i++) {
        SubCityModel* model = [[SubCityModel alloc]initWithDic:array[i]];
        [subCities addObject:model];
    }
    return [subCities copy];
}

-(instancetype)initWithDic:(NSDictionary*)dic
{
    if (self = [super init]) {
        self.cityName = dic[@"CityName"];
        self.ID = [dic[@"ID"] intValue];
        self.pID = [dic[@"PID"] integerValue];
        self.zipCode = [dic[@"ZipCode"] integerValue];
    }
    return self;
}


@end