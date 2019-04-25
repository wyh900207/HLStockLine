//
//  HLKLineModel.m
//  HLStockLine
//
//  Created by wyh on 2019/4/24.
//  Copyright © 2019 wyh. All rights reserved.
//

#import "HLKLineModel.h"
#import "HLKLineGroupModel.h"

@implementation HLKLineModel

- (NSNumber *)RSV_9
{
    if (!_RSV_9) {
        if([self.NineClocksMinPrice compare:self.NineClocksMaxPrice] == NSOrderedSame) {
            _RSV_9 = @100;
        } else {
            _RSV_9 = @((self.close.floatValue - self.NineClocksMinPrice.floatValue) * 100 / (self.NineClocksMaxPrice.floatValue - self.NineClocksMinPrice.floatValue));
        }
    }
    return _RSV_9;
}
- (NSNumber *)KDJ_K
{
    if (!_KDJ_K) {
        _KDJ_K = @((self.RSV_9.floatValue + 2 * (self.PreviousKlineModel.KDJ_K ? self.PreviousKlineModel.KDJ_K.floatValue : 50) )/3);
    }
    return _KDJ_K;
}

- (NSNumber *)KDJ_D
{
    if(!_KDJ_D) {
        _KDJ_D = @((self.KDJ_K.floatValue + 2 * (self.PreviousKlineModel.KDJ_D ? self.PreviousKlineModel.KDJ_D.floatValue : 50))/3);
    }
    return _KDJ_D;
}
- (NSNumber *)KDJ_J
{
    if(!_KDJ_J) {
        _KDJ_J = @(3*self.KDJ_K.floatValue - 2*self.KDJ_D.floatValue);
    }
    return _KDJ_J;
}

- (NSNumber *)MA7
{
    if([HLStockChartViewConfig isEMALine] == Y_StockChartTargetLineStatusMA)
    {
        if (!_MA7) {
            NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
            if (index >= 6) {
                if (index > 6) {
                    _MA7 = @((self.SumOfLastClose.floatValue - self.ParentGroupModel.models[index - 7].SumOfLastClose.floatValue) / 7);
                } else {
                    _MA7 = @(self.SumOfLastClose.floatValue / 7);
                }
            }
        }
    } else {
        return self.EMA7;
    }
    return _MA7;
}

- (NSNumber *)Volume_MA7
{
    if([HLStockChartViewConfig isEMALine] == Y_StockChartTargetLineStatusMA)
    {
        if (!_Volume_MA7) {
            NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
            if (index >= 6) {
                if (index > 6) {
                    _Volume_MA7 = @((self.SumOfLastVolume.floatValue - self.ParentGroupModel.models[index - 7].SumOfLastVolume.floatValue) / 7);
                } else {
                    _Volume_MA7 = @(self.SumOfLastVolume.floatValue / 7);
                }
            }
        }
    } else {
        return self.Volume_EMA7;
    }
    return _Volume_MA7;
}
- (NSNumber *)Volume_EMA7
{
    if(!_Volume_EMA7) {
        _Volume_EMA7 = @((self.Volume + 3 * self.PreviousKlineModel.Volume_EMA7.floatValue)/4);
    }
    return _Volume_EMA7;
}
//// EMA（N）=2/（N+1）*（C-昨日EMA）+昨日EMA；
- (NSNumber *)EMA7
{
    if(!_EMA7) {
        _EMA7 = @((self.close.floatValue + 3 * self.PreviousKlineModel.EMA7.floatValue)/4);
    }
    return _EMA7;
}

- (NSNumber *)EMA30
{
    if(!_EMA30) {
        _EMA30 = @((2 * self.close.floatValue + 29 * self.PreviousKlineModel.EMA30.floatValue)/31);
    }
    return _EMA30;
}

- (NSNumber *)EMA12
{
    if(!_EMA12) {
        _EMA12 = @((2 * self.close.floatValue + 11 * self.PreviousKlineModel.EMA12.floatValue)/13);
    }
    return _EMA12;
}

- (NSNumber *)EMA26
{
    if (!_EMA26) {
        _EMA26 = @((2 * self.close.floatValue + 25 * self.PreviousKlineModel.EMA26.floatValue)/27);
    }
    return _EMA26;
}

- (NSNumber *)MA30
{
    if([HLStockChartViewConfig isEMALine] == Y_StockChartTargetLineStatusMA)
    {
        if (!_MA30) {
            NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
            if (index >= 29) {
                if (index > 29) {
                    _MA30 = @((self.SumOfLastClose.floatValue - self.ParentGroupModel.models[index - 30].SumOfLastClose.floatValue) / 30);
                } else {
                    _MA30 = @(self.SumOfLastClose.floatValue / 30);
                }
            }
        }
    } else {
        return self.EMA30;
    }
    return _MA30;
}

- (NSNumber *)Volume_MA30
{
    if([HLStockChartViewConfig isEMALine] == Y_StockChartTargetLineStatusMA)
    {
        if (!_Volume_MA30) {
            NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
            if (index >= 29) {
                if (index > 29) {
                    _Volume_MA30 = @((self.SumOfLastVolume.floatValue - self.ParentGroupModel.models[index - 30].SumOfLastVolume.floatValue) / 30);
                } else {
                    _Volume_MA30 = @(self.SumOfLastVolume.floatValue / 30);
                }
            }
        }
    } else {
        return self.Volume_EMA30;
    }
    return _Volume_MA30;
}

- (NSNumber *)Volume_EMA30
{
    if(!_Volume_EMA30) {
        _Volume_EMA30 = @((2 * self.Volume + 29 * self.PreviousKlineModel.Volume_EMA30.floatValue)/31);
    }
    return _Volume_EMA30;
}

- (NSNumber *)MA12
{
    if (!_MA12) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 11) {
            if (index > 11) {
                _MA12 = @((self.SumOfLastClose.floatValue - self.ParentGroupModel.models[index - 12].SumOfLastClose.floatValue) / 12);
            } else {
                _MA12 = @(self.SumOfLastClose.floatValue / 12);
            }
        }
    }
    return _MA12;
}

- (NSNumber *)MA26
{
    if (!_MA26) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 25) {
            if (index > 25) {
                _MA26 = @((self.SumOfLastClose.floatValue - self.ParentGroupModel.models[index - 26].SumOfLastClose.floatValue) / 26);
            } else {
                _MA26 = @(self.SumOfLastClose.floatValue / 26);
            }
        }
    }
    return _MA26;
}

- (NSNumber *)SumOfLastClose
{
    if(!_SumOfLastClose) {
        _SumOfLastClose = @(self.PreviousKlineModel.SumOfLastClose.floatValue + self.close.floatValue);
    }
    return _SumOfLastClose;
}

- (NSNumber *)SumOfLastVolume
{
    if(!_SumOfLastVolume) {
        _SumOfLastVolume = @(self.PreviousKlineModel.SumOfLastVolume.floatValue + self.Volume);
    }
    return _SumOfLastVolume;
}

- (NSNumber *)NineClocksMinPrice
{
    if (!_NineClocksMinPrice) {
        //        if([self.ParentGroupModel.models indexOfObject:self] >= 8)
        //        {
        [self rangeLastNinePriceByArray:self.ParentGroupModel.models condition:NSOrderedDescending];
        //        } else {
        //            _NineClocksMinPrice = @0;
        //        }
    }
    return _NineClocksMinPrice;
}

- (NSNumber *)NineClocksMaxPrice {
    if (!_NineClocksMaxPrice) {
        if([self.ParentGroupModel.models indexOfObject:self] >= 8)
        {
            [self rangeLastNinePriceByArray:self.ParentGroupModel.models condition:NSOrderedAscending];
        } else {
            _NineClocksMaxPrice = @0;
        }
    }
    return _NineClocksMaxPrice;
}


- (NSNumber *)DIF
{
    if(!_DIF) {
        _DIF = @(self.EMA12.floatValue - self.EMA26.floatValue);
    }
    return _DIF;
}

//已验证
-(NSNumber *)DEA
{
    if(!_DEA) {
        _DEA = @(self.PreviousKlineModel.DEA.floatValue * 0.8 + 0.2*self.DIF.floatValue);
    }
    return _DEA;
}

//已验证
- (NSNumber *)MACD
{
    if(!_MACD) {
        _MACD = @(2*(self.DIF.floatValue - self.DEA.floatValue));
    }
    return _MACD;
}

#pragma mark BOLL线

- (NSNumber *)MA20{
    
    if (!_MA20) {
        
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 19) {
            if (index > 19) {
                _MA20 = @((self.SumOfLastClose.floatValue - self.ParentGroupModel.models[index - 20].SumOfLastClose.floatValue) / 20);
            } else {
                _MA20 = @(self.SumOfLastClose.floatValue / 20);
            }
        }
    }
    return _MA20;
    
}

- (NSNumber *)BOLL_MB {
    
    if(!_BOLL_MB) {
        
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 19) {
            
            if (index > 19) {
                _BOLL_MB = @((self.SumOfLastClose.floatValue - self.ParentGroupModel.models[index - 19].SumOfLastClose.floatValue) / 19);
                
            } else {
                
                _BOLL_MB = @(self.SumOfLastClose.floatValue / index);
                
            }
        }
        
        // NSLog(@"lazyMB:\n _BOLL_MB: %@", _BOLL_MB);
        
    }
    
    return _BOLL_MB;
}

- (NSNumber *)BOLL_MD {
    
    if (!_BOLL_MD) {
        
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        
        if (index >= 20) {
            
            _BOLL_MD = @(sqrt((self.PreviousKlineModel.BOLL_SUBMD_SUM.floatValue - self.ParentGroupModel.models[index - 20].BOLL_SUBMD_SUM.floatValue)/ 20));
            
        }
        
    }
    
    // NSLog(@"lazy:\n_BOLL_MD:%@ -- BOLL_SUBMD:%@",_BOLL_MD,_BOLL_SUBMD);
    
    return _BOLL_MD;
}

- (NSNumber *)BOLL_UP {
    if (!_BOLL_UP) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 20) {
            _BOLL_UP = @(self.BOLL_MB.floatValue + 2 * self.BOLL_MD.floatValue);
        }
    }
    
    // NSLog(@"lazy:\n_BOLL_UP:%@ -- BOLL_MD:%@",_BOLL_UP,_BOLL_MD);
    
    return _BOLL_UP;
}

- (NSNumber *)BOLL_DN {
    if (!_BOLL_DN) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 20) {
            _BOLL_DN = @(self.BOLL_MB.floatValue - 2 * self.BOLL_MD.floatValue);
        }
    }
    
    // NSLog(@"lazy:\n_BOLL_DN:%@ -- BOLL_MD:%@",_BOLL_DN,_BOLL_MD);
    
    return _BOLL_DN;
}

- (NSNumber *)BOLL_SUBMD_SUM {
    
    if (!_BOLL_SUBMD_SUM) {
        
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 20) {
            
            _BOLL_SUBMD_SUM = @(self.PreviousKlineModel.BOLL_SUBMD_SUM.floatValue + self.BOLL_SUBMD.floatValue);
            
        }
    }
    
    // NSLog(@"lazy:\n_BOLL_SUBMD_SUM:%@ -- BOLL_SUBMD:%@",_BOLL_SUBMD_SUM,_BOLL_SUBMD);
    
    return _BOLL_SUBMD_SUM;
}

- (NSNumber *)BOLL_SUBMD {
    if (!_BOLL_SUBMD) {
        
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        
        if (index >= 20) {
            
            _BOLL_SUBMD = @((self.close.floatValue - self.MA20.floatValue) * ( self.close.floatValue - self.MA20.floatValue));
            
        }
    }
    
    // NSLog(@"lazy_BOLL_SUBMD: \n MA20: %@ \n close: %@ \n subNum: %f", _MA20, _close, self.close.floatValue - self.MA20.floatValue);
    
    return _BOLL_SUBMD;
}

- (HLKLineModel *)PreviousKlineModel
{
    if (!_PreviousKlineModel) {
        _PreviousKlineModel = [HLKLineModel new];
        _PreviousKlineModel.DIF = @(0);
        _PreviousKlineModel.DEA = @(0);
        _PreviousKlineModel.MACD = @(0);
        _PreviousKlineModel.MA7 = @(0);
        _PreviousKlineModel.MA12 = @(0);
        _PreviousKlineModel.MA26 = @(0);
        _PreviousKlineModel.MA30 = @(0);
        _PreviousKlineModel.EMA7 = @(0);
        _PreviousKlineModel.EMA12 = @(0);
        _PreviousKlineModel.EMA26 = @(0);
        _PreviousKlineModel.EMA30 = @(0);
        _PreviousKlineModel.Volume_MA7 = @(0);
        _PreviousKlineModel.Volume_MA30 = @(0);
        _PreviousKlineModel.Volume_EMA7 = @(0);
        _PreviousKlineModel.Volume_EMA30 = @(0);
        _PreviousKlineModel.SumOfLastClose = @(0);
        _PreviousKlineModel.SumOfLastVolume = @(0);
        _PreviousKlineModel.KDJ_K = @(50);
        _PreviousKlineModel.KDJ_D = @(50);
        
        _PreviousKlineModel.MA20 = @(0);
        _PreviousKlineModel.BOLL_MD = @(0);
        _PreviousKlineModel.BOLL_MB = @(0);
        _PreviousKlineModel.BOLL_DN = @(0);
        _PreviousKlineModel.BOLL_UP = @(0);
        _PreviousKlineModel.BOLL_SUBMD_SUM = @(0);
        _PreviousKlineModel.BOLL_SUBMD = @(0);
        
    }
    return _PreviousKlineModel;
}

- (HLKLineGroupModel *)ParentGroupModel {
    if (!_ParentGroupModel) {
        _ParentGroupModel = [HLKLineGroupModel new];
    }
    return _ParentGroupModel;
}

#pragma mark - Private

//对Model数组进行排序，初始化每个Model的最新9Clock的最低价和最高价
- (void)rangeLastNinePriceByArray:(NSArray<HLKLineModel *> *)models condition:(NSComparisonResult)cond {
    switch (cond) {
        case NSOrderedAscending:
            {
                // 第一个循环结束后，ClockFirstValue为最小值
                for (NSInteger j = 7; j >= 1; j--)
                {
                    NSNumber *emMaxValue = @0;
                    
                    NSInteger em = j;
                    
                    while ( em >= 0 )
                    {
                        if([emMaxValue compare:models[em].high] == cond)
                        {
                            emMaxValue = models[em].high;
                        }
                        em--;
                    }
                    NSLog(@"%f",emMaxValue.floatValue);
                    models[j].NineClocksMaxPrice = emMaxValue;
                }
                //第一个循环结束后，ClockFirstValue为最小值
                for (NSInteger i = 0, j = 8; j < models.count; i++,j++)
                {
                    NSNumber *emMaxValue = @0;
                    
                    NSInteger em = j;
                    
                    while ( em >= i )
                    {
                        if([emMaxValue compare:models[em].high] == cond)
                        {
                            emMaxValue = models[em].high;
                        }
                        em--;
                    }
                    NSLog(@"%f",emMaxValue.floatValue);
                    
                    models[j].NineClocksMaxPrice = emMaxValue;
                }
            }
            break;
        case NSOrderedDescending:
        {
            //第一个循环结束后，ClockFirstValue为最小值
            
            for (NSInteger j = 7; j >= 1; j--)
            {
                NSNumber *emMinValue = @(10000000000);
                
                NSInteger em = j;
                
                while ( em >= 0 )
                {
                    if([emMinValue compare:models[em].low] == cond)
                    {
                        emMinValue = models[em].low;
                    }
                    em--;
                }
                models[j].NineClocksMinPrice = emMinValue;
            }
            
            for (NSInteger i = 0, j = 8; j < models.count; i++,j++)
            {
                NSNumber *emMinValue = @(10000000000);
                
                NSInteger em = j;
                
                while ( em >= i )
                {
                    if([emMinValue compare:models[em].low] == cond)
                    {
                        emMinValue = models[em].low;
                    }
                    em--;
                }
                models[j].NineClocksMinPrice = emMinValue;
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)initWithArray:(NSArray *)arr {
    if (self) {
        _date = arr[0];
        _open = @([arr[1] floatValue]);
        _close = @([arr[2] floatValue]);
        _high = @([arr[3] floatValue]);
        _low = @([arr[4] floatValue]);
        
        _Volume = [arr[5] floatValue];
        self.SumOfLastClose = @(_close.floatValue + self.PreviousKlineModel.SumOfLastClose.floatValue);
        self.SumOfLastVolume = @(_Volume + self.PreviousKlineModel.SumOfLastVolume.floatValue);
        
    }
}

// 废弃不用
- (void)initWithDict:(NSDictionary *)dict {

}

#pragma mark - Public

- (void)initFirstModel {
    _KDJ_K = @(55.27);
    _KDJ_D = @(55.27);
    _KDJ_J = @(55.27);
    
    _EMA7 = _close;
    _EMA12 = _close;
    _EMA26 = _close;
    _EMA30 = _close;
    _NineClocksMinPrice = _low;
    _NineClocksMaxPrice = _high;
    
    [self DIF];
    [self DEA];
    [self MACD];
    [self rangeLastNinePriceByArray:self.ParentGroupModel.models condition:NSOrderedAscending];
    [self rangeLastNinePriceByArray:self.ParentGroupModel.models condition:NSOrderedDescending];
    [self RSV_9];
    [self KDJ_K];
    [self KDJ_D];
    [self KDJ_J];
    
    [self MA20];
    [self BOLL_MD];
    [self BOLL_MB];
    [self BOLL_UP];
    [self BOLL_DN];
    [self BOLL_SUBMD];
    [self BOLL_SUBMD_SUM];
}

- (void)initData {
    [self MA7];
    [self MA12];
    [self MA26];
    [self MA30];
    [self EMA7];
    [self EMA12];
    [self EMA26];
    [self EMA30];
    
    [self DIF];
    [self DEA];
    [self MACD];
    [self NineClocksMaxPrice];
    [self NineClocksMinPrice];
    [self RSV_9];
    [self KDJ_K];
    [self KDJ_D];
    [self KDJ_J];
    
    [self MA20];
    [self BOLL_MD];
    [self BOLL_MB];
    [self BOLL_UP];
    [self BOLL_DN];
    [self BOLL_SUBMD];
    [self BOLL_SUBMD_SUM];
}

@end
