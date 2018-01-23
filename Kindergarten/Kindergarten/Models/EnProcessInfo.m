//
//  EnProcessInfo.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/17.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "EnProcessInfo.h"
#import "SQLiteManager.h"

@implementation EnProcessInfo

@synthesize fkQuestionid=_fkQuestionid;
@synthesize attachmentpath=_attachmentpath;
@synthesize answer=_answer;

-(instancetype)initWithfkQuestionid:(NSString *)mFKQuestionid andAttachmentPath:(NSString*)mattachmentpath andAnswer:(NSString *)manswer
{
    if (self = [super init]) {
        self.fkQuestionid = mFKQuestionid;
        self.attachmentpath = mattachmentpath;
        self.answer = manswer;
    }
    return self;
}
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(BOOL)insertSelfToDB{
    //插入对象的SQL语句
    NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO 'tbl_ass_process' (fkQuestionid,attachmentpath,answer) VALUES ('%@','%@','%@');",self.fkQuestionid,self.attachmentpath,self.answer];
    return [[SQLiteManager shareInstance] execSQL:insertSQL];
}
+(NSArray *)allProcessInfoFromDB{
    //查询表中所有数据的SQL语句
    NSString *SQL = @"SELECT fkQuestionid,attachmentpath,answer FROM 'tbl_ass_process'";
    //取出数据库用户表中所有数据
    NSArray *allProcessDictArr = [[SQLiteManager shareInstance] querySQL:SQL];
    NSLog(@"%@",allProcessDictArr);
    //将字典数组转化为模型数组
    NSMutableArray *modelArrM = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in allProcessDictArr) {
        [modelArrM addObject:[[EnProcessInfo alloc] initWithDict:dict]];
    }
    return modelArrM;
}

-(BOOL)deleteAttachmentPathByQuestionId:(NSString*)mquestionid andNeedDeletedAttachmentPath:(NSString*)attachmentPath
{
    NSString* newAttachmentPath=[[NSString alloc]init];
    NSString* strQureySql = [NSString stringWithFormat:@"SELECT attachmentpath FROM tbl_ass_process WHERE fkQuestionid='%@';",mquestionid];
    NSArray* attachpathArray = [[SQLiteManager shareInstance] querySQL:strQureySql];
    if (attachpathArray!=nil)
    {
        if(attachpathArray.count==1)//有答题纪录
        {
            NSString* oldAttachPath = attachpathArray[0][@"attachmentpath"];
            if (oldAttachPath.length>0) {
                newAttachmentPath = [self getNewAttachmentPathByReplace:attachmentPath andOldAttachmentPath:oldAttachPath];
            }
            else
            {
                //nothing
            }
            
            NSString* strUpdateSql = [NSString stringWithFormat:@"UPDATE tbl_ass_process SET attachmentpath='%@' WHERE fkQuestionid='%@';",newAttachmentPath,mquestionid];
            return [[SQLiteManager shareInstance] execSQL:strUpdateSql];
        }
        else if(attachpathArray.count==0)//新作答，无答题纪录
        {
            //删除证据，必有纪录
        }
    }
    
    return false;
}

-(NSString*)getNewAttachmentPathByReplace:(NSString*)deleteedPath andOldAttachmentPath:(NSString*)oldAttamentPath
{
    NSString* newAttachmentPath = [[NSString alloc]init];
    
    NSArray* attachmentArr = [oldAttamentPath componentsSeparatedByString:@","];
    
    if (attachmentArr.count==1) //只有一个证据
    {
        return @"";
    }
    else
    {
        for (int i=0; i<attachmentArr.count; i++)
        {
            if (![attachmentArr[i] isEqualToString:deleteedPath])
            {
                newAttachmentPath = [newAttachmentPath stringByAppendingString:attachmentArr[i]];
                newAttachmentPath = [newAttachmentPath stringByAppendingString:@","];
            }
        }
    
        return [newAttachmentPath substringToIndex:newAttachmentPath.length-1];
    }
}

//将答案保存到数据库中，如果存在该纪录则更新，不存在则插入
+(BOOL)saveQuestionAnswer:(NSDictionary*)dicQuesAns
{
    if(dicQuesAns!=nil&&dicQuesAns.count>0)
    {
        for (NSString* key in dicQuesAns) {
            if ([self isExist:key])//更新
            {
                NSString* strUpdateSql = [NSString stringWithFormat:@"UPDATE tbl_ass_process SET answer='%@' WHERE fkQuestionid='%@';",dicQuesAns[key],key];
                if (![[SQLiteManager shareInstance] execSQL:strUpdateSql])
                {
                    return false;
                };
            }
            else//插入
            {
                EnProcessInfo* process = [[EnProcessInfo alloc] initWithfkQuestionid:key andAttachmentPath:@"" andAnswer:dicQuesAns[key]];
                if (![process insertSelfToDB]) {
                    return false;
                }
            }
        }
    }
    return true;
}

//判断试题是否存在纪录，根据questionid
+(BOOL)isExist:(NSString*)questionid
{
    NSString* strSql = [NSString stringWithFormat:@"SELECT count(1) isexist FROM tbl_ass_process WHERE fkQuestionid='%@';",questionid];
    NSArray* retArr = [[SQLiteManager shareInstance] querySQL:strSql];
    if (retArr!=nil&& [retArr[0][@"isexist"] isEqualToString:@"1"]) {
        return true;
    }
    else
    {
        return false;
    }
}

//判断试题是否已完成（有无答案），根据questionid
+(BOOL)isFinished:(NSString*)questionid
{
    NSString* strSql = [NSString stringWithFormat:@"SELECT answer isfinished FROM tbl_ass_process WHERE fkQuestionid='%@';",questionid];
    NSArray* retArr = [[SQLiteManager shareInstance] querySQL:strSql];
    if (retArr!=nil && retArr.count>0)
    {
        NSString* strFinish =(NSString*)retArr[0][@"isfinished"];
        if(strFinish!=nil && strFinish.length>0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    else
    {
        return false;
    }
}

//将答案文件转化成json数据
+(NSString*)toJsonProcessInfo
{
    //查询表中所有数据的SQL语句
    NSString *SQL = @"SELECT fkQuestionid,attachmentpath,answer FROM 'tbl_ass_process' WHERE LENGTH(answer)>0";
    //取出数据库用户表中所有有答案的数据
    NSArray *allProcessDictArr = [[SQLiteManager shareInstance] querySQL:SQL];
    NSArray* outputArray = [self toOutputArray:allProcessDictArr];
    if(outputArray!=nil && outputArray.count>0)
    {
        NSData *data = [NSJSONSerialization dataWithJSONObject:outputArray options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        if (data == nil) {
            return nil;
        }
        
        NSString* strOutput =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return strOutput;
    }
    return nil;
}

+(NSArray*)toOutputArray:(NSArray*)realArray
{
    if (realArray!=nil && realArray.count>0) {
        NSMutableArray* outputArray = [[NSMutableArray alloc] init];
    
        NSMutableArray* tmpAttachmentArray;
        for (int i=0; i<realArray.count; i++) {
            NSMutableDictionary* dicProcess = [[NSMutableDictionary alloc] init];
            tmpAttachmentArray = [[NSMutableArray alloc] init];
            NSString* strAttachment = realArray[i][@"attachmentpath"];
            if (strAttachment!=nil && strAttachment.length>0) {
                NSArray* attachments = [strAttachment componentsSeparatedByString:@","];
                for (int j=0; j<attachments.count; j++) {
                    NSString* newAttach = [attachments[j] stringByAppendingString:@".jpg"];
                    [tmpAttachmentArray addObject:newAttach];
                }
            }
            [dicProcess setObject:[GlobalUtil jsonStringWithObject:tmpAttachmentArray] forKey:@"attachmentpath"];
            [dicProcess setObject:realArray[i][@"fkQuestionid"] forKey:@"fkQuestionid"];
            [dicProcess setObject:realArray[i][@"answer"] forKey:@"answer"];
            [outputArray addObject:dicProcess];
        }
        return outputArray;
    }
    else
    {
        return nil;
    }
}

@end
