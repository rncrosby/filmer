//
//  recorderView.m
//  HD Destruction
//
//  Created by Robert Crosby on 8/29/17.
//  Copyright © 2017 Robert Crosby. All rights reserved.
//

#import "recorderView.h"

@interface recorderView ()

@end

@implementation recorderView

-(bool)prefersStatusBarHidden {
    return YES;
}


- (void)viewDidLoad {
    isStart = YES;
    scannedDrives = [[NSMutableArray alloc] init];
    clipCount = 0;
    [super viewDidLoad];
    [self prepareCamera];
    [References cornerRadius:recordingButton radius:recordingButton.frame.size.width/2];
    [References borderColor:recordingButton color:[UIColor whiteColor]];
    [scannedDriveCollectionView setBackgroundColor:[UIColor clearColor]];
    isRecording = FALSE;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSURL *documentsURL = [NSURL fileURLWithPath:documentsDirectory];
    for (NSString *file in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error]) {
        [[NSFileManager defaultManager] removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:file] error:&error];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareCamera {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    // create camera with standard settings
    recorder = [[LLSimpleCamera alloc] init];
    
    // camera with video recording capability
    recorder =  [[LLSimpleCamera alloc] initWithVideoEnabled:YES];
    
    // camera with precise quality, position and video parameters.
    recorder = [[LLSimpleCamera alloc] initWithQuality:AVCaptureSessionPresetHigh
                                              position:LLCameraPositionRear
                                          videoEnabled:YES];
    [recorder start];
    // attach to the view
    [recorder attachToViewController:self withFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [self.view sendSubviewToBack:recorder.view];
}

- (IBAction)done:(id)sender {
    [self mergeAll];
    movieTitleView.hidden = NO;
    [UIView animateWithDuration:0.4 animations:^(void) {
        movieTitleView.alpha = 1;
        [movieTitle becomeFirstResponder];
    }];
}

- (IBAction)startRecording:(id)sender {
    if (isRecording == FALSE) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSURL *documentsURL = [NSURL fileURLWithPath:documentsDirectory];
        outputURL = [[documentsURL URLByAppendingPathComponent:[NSString stringWithFormat:@"asdfg%i",clipCount]] URLByAppendingPathExtension:@"mov"];
        [recorder startRecordingWithOutputUrl:outputURL];
        if (isStart == YES) {
            recorderTime = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                            target:self
                                                          selector:@selector(incrementTime)
                                                          userInfo:nil
                                                           repeats:YES];
            isStart = NO;
        }

        
        [UIView animateWithDuration:0.3 animations:^(){
            [References cornerRadius:recordingButton radius:4.0];
        }];
        isRecording = TRUE;
        [References fadeButtonColor:recordingButton color:[UIColor whiteColor]];
    } else {
        [recorder stopRecording:^(LLSimpleCamera *camera, NSURL *outputURLVideo, NSError *error){
            isRecording = FALSE;
            [References fadeButtonColor:recordingButton color:[References colorFromHexString:@"#e74c3c"]];
            driveObject *drive = [[driveObject alloc] initWithType:[NSString stringWithFormat:@"asdfg_%i",clipCount] andTime:recorderTimeInt];
            [scannedDrives addObject:drive];
            clipCount++;
            drivesScanned.text = [NSString stringWithFormat:@"%i",clipCount];
            [scannedDriveCollectionView reloadData];
            [UIView animateWithDuration:0.3 animations:^(){
                [References cornerRadius:recordingButton radius:recordingButton.frame.size.width/2];
            }];
        }];
    }
}

-(void)incrementTime {
    if (isRecording == TRUE) {
        recorderTimeInt++;
        currentTime.text = [self timeFormatted:recorderTimeInt];
    }
    
}

-(bool)textFieldShouldReturn:(UITextField *)textField {
        [textField resignFirstResponder];
    if ([self renameFileFrom:@"movie.mp4" to:[NSString stringWithFormat:@"%@.mp4",textField.text]] == YES) {
        NSURL *finalURL = [NSURL fileURLWithPath:[outputURL.absoluteString stringByReplacingOccurrencesOfString:@"movie.mp4" withString:[NSString stringWithFormat:@"%@.mp4",textField.text]]];
        [self playFinal:finalURL];
        movieOverlay.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^(void) {
            movieOverlay.alpha = 0.7;
        }];
    } else {
        NSLog(@"error");
    }
    


    return YES;
}

- (BOOL)renameFileFrom:(NSString*)oldName to:(NSString *)newName
{
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask, YES) objectAtIndex:0];
    NSString *oldPath = [documentDir stringByAppendingPathComponent:oldName];
    NSString *newPath = [documentDir stringByAppendingPathComponent:newName];
    
    NSFileManager *fileMan = [NSFileManager defaultManager];
    NSError *error = nil;
    if (![fileMan moveItemAtPath:oldPath toPath:newPath error:&error])
    {
        NSLog(@"Failed to move '%@' to '%@': %@", oldPath, newPath, [error localizedDescription]);
        return NO;
    }
    return YES;
}

- (NSString *)timeFormatted:(int)totalSeconds{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d",minutes, seconds];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)mergeAll {
    //Create the AVMutable composition to add tracks
    AVMutableComposition* composition = [[AVMutableComposition alloc]init];
    //Create the mutable composition track with video media type. You can also create the tracks depending on your need if you want to merge audio files and other stuffs.
    AVMutableCompositionTrack* composedTrack = [composition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSURL *documentsURL = [NSURL fileURLWithPath:documentsDirectory];
    for (int a = clipCount-1; a >=0 ; a--) {
        NSURL *videoURL = [[documentsURL URLByAppendingPathComponent:[NSString stringWithFormat:@"asdfg%i",a]] URLByAppendingPathExtension:@"mov"];
            AVURLAsset* video = [[AVURLAsset alloc]initWithURL:videoURL options:nil];
        
        [composedTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, video.duration)
                               ofTrack:[[video tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0]
                                atTime:kCMTimeZero error:nil];
        AVAssetTrack *assetVideoTrack = [video tracksWithMediaType:AVMediaTypeVideo].lastObject;
            [composedTrack setPreferredTransform:assetVideoTrack.preferredTransform];
    }
    NSString* myDocumentPath= [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"movie.mp4"]];
    
    NSURL *url = [[NSURL alloc] initFileURLWithPath: myDocumentPath];
    
    //Check if the file exists then delete the old file to save the merged video file.
    if([[NSFileManager defaultManager]fileExistsAtPath:myDocumentPath])
    {
        [[NSFileManager defaultManager]removeItemAtPath:myDocumentPath error:nil];
    }
    
    // Create the export session to merge and save the video
    AVAssetExportSession*exporter = [[AVAssetExportSession alloc]initWithAsset:composition presetName:AVAssetExportPresetHighestQuality];
    exporter.outputURL=url;
    outputURL = url;
    exporter.outputFileType=@"com.apple.quicktime-movie";
    exporter.shouldOptimizeForNetworkUse=YES;
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        switch([exporter status])
        {
            case AVAssetExportSessionStatusFailed:
                NSLog(@"Failed to export video");
                break;
            case AVAssetExportSessionStatusCancelled:
                NSLog(@"export cancelled");
                break;
            case AVAssetExportSessionStatusCompleted:
                //Here you go you have got the merged video :)
                NSLog(@"Merging completed");
                break;
            default:
                break;
        }
        
    }];
}

-(void)playFinal:(NSURL*)url{
    AVAsset *avAsset = [AVAsset assetWithURL:url];
    AVPlayerItem *avPlayerItem =[[AVPlayerItem alloc]initWithAsset:avAsset];
    _avPlayer = [[AVPlayer alloc]initWithPlayerItem:avPlayerItem];
    AVPlayerLayer *avPlayerLayer =[AVPlayerLayer playerLayerWithPlayer:_avPlayer];
    [avPlayerLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [avPlayerLayer setFrame:[[UIScreen mainScreen] bounds]];
    [moviePlayerView.layer addSublayer:avPlayerLayer];
    //Config player
    [_avPlayer seekToTime:kCMTimeZero];
    [_avPlayer play];
    [_avPlayer setVolume:0.0f];
    [_avPlayer setActionAtItemEnd:AVPlayerActionAtItemEndNone];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[_avPlayer currentItem]];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerStartPlaying)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
}

- (void)playerStartPlaying
{
    [_avPlayer play];
}
- (IBAction)restart:(id)sender {
    currentTime.text = @"00:00";
    [recorderTime invalidate];
    isStart = YES;
    recorderTimeInt = 0;
    [scannedDriveCollectionView reloadData];
    [scannedDrives removeAllObjects];
    clipCount = 0;
    [super viewDidLoad];
    isRecording = FALSE;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSURL *documentsURL = [NSURL fileURLWithPath:documentsDirectory];
    for (NSString *file in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error]) {
        [[NSFileManager defaultManager] removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:file] error:&error];
    }
}

- (IBAction)share:(id)sender {
}

- (IBAction)save:(id)sender {
}

- (IBAction)deleteMovie:(id)sender {

    [UIView animateWithDuration:0.5 animations:^(void) {
        movieOverlay.alpha = 0.0;
        movieTitleView.alpha = 0.0;
    } completion:^(bool finished) {
            movieOverlay.hidden = YES;
        movieTitleView.hidden = YES;
    }];
    currentTime.text = @"00:00";
    drivesScanned.text = @"0";
    [recorderTime invalidate];
    isStart = YES;
    recorderTimeInt = 0;
    [scannedDriveCollectionView reloadData];
    [scannedDrives removeAllObjects];
    clipCount = 0;
    [super viewDidLoad];
    isRecording = FALSE;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSURL *documentsURL = [NSURL fileURLWithPath:documentsDirectory];
    for (NSString *file in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error]) {
        [[NSFileManager defaultManager] removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:file] error:&error];
    }
}

@end

