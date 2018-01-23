//
//  JFKGAproveController.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/16.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "JFKGAproveController.h"
#import "SQLiteManager.h"
#import "JFKGEvaluateController.h"
#import "EnProcessInfo.h"

@interface JFKGAproveController()
{
    NSString* _aproveItemName;
    NSString* _questionid;
    NSString* _fklevel;
}

//@property (nonatomic,strong) UIImageView * camorrorImageview;
@property (strong, nonatomic) UIImagePickerController *picker;

@end

@implementation JFKGAproveController


//通过相册摄像头获取证据(并用传过来的aproveitemid命名)
- (void)getAproveByAproveItemId:(NSString*)aproveitemid andQuestionId:(NSString*)mquestionid andFKLevel:(NSString*)fklevel
{
    _aproveItemName=aproveitemid;//将名字保存到变量中，save时用
    _questionid=mquestionid;
    _fklevel=fklevel;
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请选择图片来源" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    //从照相机拍照
    __weak typeof(self) weakSelf = self;
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            weakSelf.picker = [[UIImagePickerController alloc] init];
            weakSelf.picker.delegate = weakSelf;//设置UIImagePickerController的代理，同时要遵循UIImagePickerControllerDelegate，UINavigationControllerDelegate协议
            weakSelf.picker.allowsEditing = YES;//设置拍照之后图片是否可编辑，如果设置成可编辑的话会在代理方法返回的字典里面多一些键值。PS：如果在调用相机的时候允许照片可编辑，那么用户能编辑的照片的位置并不包括边角。
            weakSelf.picker.sourceType = UIImagePickerControllerSourceTypeCamera;//UIImagePicker选择器的数据来源，UIImagePickerControllerSourceTypeCamera说明数据来源于摄像头
            [weakSelf.currentVC presentViewController:weakSelf.picker animated:YES completion:nil];
            
        }
        else
        {
            //如果当前设备没有摄像头
            [MBProgressHUD showError:@"哎呀，当前设备没有摄像头。"];
        }
    }];
    
    //从手机相册选取
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            weakSelf.picker = [[UIImagePickerController alloc]init];
            weakSelf.picker.delegate = weakSelf;
            weakSelf.picker.allowsEditing = YES;//是否可以对原图进行编辑
            weakSelf.picker.modalPresentationStyle = UIModalPresentationCurrentContext;
                                          
            //设置图片选择器的数据来源为 手机相册
            weakSelf.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [weakSelf.currentVC presentViewController:weakSelf.picker animated:YES completion:nil];
        }
        else
        {
            [MBProgressHUD showError:@"图片库不可用"];
        }
    }];
    
    //取消
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    alertC.popoverPresentationController.sourceView = self.currentVC.view;
    alertC.popoverPresentationController.sourceRect = self.currentVC.view.frame;
    [alertC addAction:cameraAction];
    [alertC addAction:photoAction];
    [alertC addAction:cancelAction];
    
    //判断设备类型，是否为ipad
    [self.currentVC presentViewController:alertC animated:YES completion:nil];
    
}

#pragma mark - UIImagePickerControllerDelegate
#pragma mark - 拍照/选择图片结束
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];//编辑后的图片
    
    //设置image的尺寸
    CGSize imagesize = image.size;
    imagesize.height = 200;
    imagesize.width = 200;
    
    //对图片大小进行压缩
    //image = [self imageWithImage:image scaledToSize:imagesize];
    NSData *imageData = UIImageJPEGRepresentation(image,0.008);
    
    UIImage *compressionImage = [UIImage imageWithData:imageData];
    /*if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImageWriteToSavedPhotosAlbum(compressionImage, nil, nil, nil);//把图片存到图片库
        _camorrorImageview.image = compressionImage;
    }
    else
    {
        _camorrorImageview.image = compressionImage;
    }*/
    
    NSString* imageN = [_aproveItemName stringByAppendingString:@".jpg"];
    [self saveImage:compressionImage withName:imageN];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize

{
    
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    // UIImage对象 -> NSData对象
    NSData *imageData = UIImagePNGRepresentation(currentImage);
    // 获取沙盒目录
    NSString *aprovepath=[GlobalUtil getAprovePath];
    NSFileManager* fileM = [NSFileManager defaultManager];
    if (![fileM fileExistsAtPath:aprovepath])
    {
        [fileM createDirectoryAtPath:aprovepath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *fullPath = [aprovepath stringByAppendingPathComponent:imageName];
    
    if ([self saveAproveItemToDB]) {
        // 将图片写入文件
        [imageData writeToFile:fullPath atomically:NO];
        
        //处理页面证据
        JFKGEvaluateController* evaluateC = [[JFKGEvaluateController alloc]init];
        NSString* strQuesAprove=[evaluateC getQuestionAproveByThirdLevelId:_fklevel];
        NSString* scriptStr = [NSString stringWithFormat:@"showLevelAprove(%@);",strQuesAprove];
        //NSLog(@"%@",strQuesAprove);
        [self.webView evaluateJavaScript:scriptStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            NSLog(@"response: %@ error: %@", response, error);
        }];
    }
    else
    {
        NSString* scriptStr = [NSString stringWithFormat:@"showAlertMessage(%@);",@"添加证据失败"];
        [self.webView evaluateJavaScript:scriptStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            NSLog(@"response: %@ error: %@", response, error);
        }];
    }
}

#pragma mark - 取消拍照/选择图片
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)saveAproveItemToDB
{
    NSString* newAttachmentPath=[[NSString alloc]init];
    NSString* strQureySql = [NSString stringWithFormat:@"SELECT attachmentpath FROM tbl_ass_process WHERE fkQuestionid='%@';",_questionid];
    NSArray* attachpathArray = [[SQLiteManager shareInstance] querySQL:strQureySql];
    if (attachpathArray!=nil)
    {
        if(attachpathArray.count==1)//有答题纪录
        {
            NSString* tmpAttachPath = attachpathArray[0][@"attachmentpath"];
            if (tmpAttachPath.length>0) {
                newAttachmentPath = [NSString stringWithFormat:@"%@%@%@",tmpAttachPath,@",",_aproveItemName];
            }
            else
            {
                newAttachmentPath=_aproveItemName;
            }
        
            NSString* strUpdateSql = [NSString stringWithFormat:@"UPDATE tbl_ass_process SET attachmentpath='%@' WHERE fkQuestionid='%@';",newAttachmentPath,_questionid];
            return [[SQLiteManager shareInstance] execSQL:strUpdateSql];
        }
        else if(attachpathArray.count==0)//新作答，无答题纪录
        {
            EnProcessInfo* process = [[EnProcessInfo alloc] initWithfkQuestionid:_questionid andAttachmentPath:_aproveItemName andAnswer:@""];
            return [process insertSelfToDB];
        }
    }
    
    return false;
}

@end
