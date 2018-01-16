//
//  LevelTable.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/12.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "LevelTableCreator.h"
#import "LevelNode.h"
#import "XMLDictionary.h"

@interface LevelTableCreator()

@end

@implementation LevelTableCreator


-(NSString*)CreateTreeFromLevelXML:(NSString*) filepath
{
    NSString* _levelTable;
    _levelTable= [[NSString alloc] init];
    
    NSArray* levelArray = [self getSortedLevelArrayFromLevelXmlFile:filepath];
    
    NSMutableArray* nodes = [self getLevelNodesFromLevelArray:levelArray];
    
    if (nodes!=nil && nodes.count>0)
    {
        LevelNode* firstLevelNode=nil;
        LevelNode* secondLevelNode=nil;
        LevelNode* thirdLevelNode = nil;
        for (int j=0; j<nodes.count; j++)
        {
            thirdLevelNode = (LevelNode*)nodes[j];
            if (thirdLevelNode.levelId.length==9)
            {
                firstLevelNode = [self getFirstLevelByThirdLevel:thirdLevelNode fromLevelNodes:nodes];
                secondLevelNode = [self getSecondLevelByThirdLevel:thirdLevelNode fromLevelNodes:nodes];
                NSString* strTmp = [NSString stringWithFormat:@"{\"fid\":\"%@\",\"fname\":\"%@\",\"sid\":\"%@\",\"sname\":\"%@\",\"tid\":\"%@\",\"tname\":\"%@\"},",firstLevelNode.levelId,firstLevelNode.name,secondLevelNode.levelId,secondLevelNode.name,thirdLevelNode.levelId,thirdLevelNode.name];
                _levelTable = [_levelTable stringByAppendingString:strTmp];
            }
        }
        _levelTable = [[@"[" stringByAppendingString:[_levelTable substringToIndex:_levelTable.length-1]] stringByAppendingString:@"]"];
    }
    else
    {
        _levelTable=@"";
    }

    //NSLog(@"%@",_levelTable);
    return _levelTable;
}

-(NSMutableArray*)getLevelNodesFromLevelArray:(NSArray*) levelArray
{
    if (levelArray!=nil && levelArray.count>0) {
        NSMutableArray* nodes = [[NSMutableArray alloc] init];
        LevelNode* node = nil;
        for (int i=0; i<levelArray.count; i++) {
            node = [[LevelNode alloc] init];
            node.levelId = (NSString*)levelArray[i][@"pkId"];
            node.name= (NSString*)levelArray[i][@"name"];
            [nodes addObject:node];
        }
        return nodes;
    }
    else
    {
        return nil;
    }
    
}

-(NSArray*)getSortedLevelArrayFromLevelXmlFile:(NSString*)filepath
{
    XMLDictionaryParser* parser = [[XMLDictionaryParser alloc] init];
    NSDictionary* dicLevel = [parser dictionaryWithFile:filepath];
    
    NSMutableArray* levelArr = dicLevel[@"level"];
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pkId" ascending:YES]];
    [levelArr sortUsingDescriptors:sortDescriptors];
    //NSLog(@"%@",levelArr);
    
    return levelArr;
}

-(LevelNode*)getFirstLevelByThirdLevel:(LevelNode*)thirdLevelNode fromLevelNodes:(NSMutableArray*)levelNodes
{
    LevelNode* tmpNode = nil;
    if (thirdLevelNode!=nil && thirdLevelNode.levelId.length==9) {
        NSString* firsLevelNodeLevelId = [thirdLevelNode.levelId substringToIndex:3];
        for (int i=0; i<levelNodes.count; i++) {
            tmpNode = (LevelNode*)levelNodes[i];
            if ([tmpNode.levelId isEqualToString:firsLevelNodeLevelId]) {
                break;
            }
        }
    }
    return tmpNode;
}

-(LevelNode*)getSecondLevelByThirdLevel:(LevelNode*)thirdLevelNode fromLevelNodes:(NSMutableArray*)levelNodes
{
    LevelNode* tmpNode = nil;
    if (thirdLevelNode!=nil && thirdLevelNode.levelId.length==9) {
        NSString* secondLevelNodeLevelId = [thirdLevelNode.levelId substringToIndex:6];
        for (int i=0; i<levelNodes.count; i++) {
            tmpNode = (LevelNode*)levelNodes[i];
            if ([tmpNode.levelId isEqualToString:secondLevelNodeLevelId])
            {
                break;
            }
        }
    }
    return tmpNode;
}

/*-(LevelNode*)createTree:(NSMutableArray*) nodes
{
    LevelNode* root = nil;
    
    for (int i=0; i<nodes.count; i++) {
        LevelNode* iNode = (LevelNode*)nodes[i];
        for (int j=i+1; j<nodes.count; j++) {
            LevelNode* jNode = (LevelNode*)nodes[j];
            if ((jNode.levelId.length-iNode.levelId.length==3) &&([[jNode.levelId substringToIndex:iNode.levelId.length] isEqualToString:iNode.levelId])) {
                if (iNode.childNodes==nil) {
                    iNode.childNodes = [[NSMutableArray alloc] init];
                }
                
                [iNode.childNodes addObject:jNode];
            }
        }
        if (iNode.levelId.length==3) {
            root = iNode;
        }
    }
    
    
    return root;
}

-(void)travel:(LevelNode *)pNode
{
    if (pNode == nil)
    {
        return;
    }
    
    int rowspan =[self getRowSpan:pNode];
    if (rowspan>0) {
        _levelTable =[_levelTable stringByAppendingString:[NSString stringWithFormat:@"<td rowspan=%d>%@</td>",rowspan,pNode.name]];
    }
    else
    {
        _levelTable =[_levelTable stringByAppendingString:[NSString stringWithFormat:@"<td>%@</td>",pNode.name]];
    }
    
    if (pNode.childNodes==nil) {
        _levelTable=[_levelTable stringByAppendingString:@"</tr><tr>"];
    }
    
    for (int i=0 ;i<pNode.childNodes.count; i++)
    {
        LevelNode *tmp = pNode.childNodes[i];
        [self travel:tmp];
    }
}

-(int)getRowSpan:(LevelNode*)node
{
    if (node.levelId.length==3)
    {
        int rownum=0;
        for (int i=0; i<node.childNodes.count; i++) {
            LevelNode* tmpNode = (LevelNode*)node.childNodes[i];
            rownum+= tmpNode.childNodes.count;
        }
        return rownum;
    }
    else if (node.levelId.length==6)
    {
        return (int)node.childNodes.count;
    }
    else
    {
        return 0;
    }
}*/

@end
