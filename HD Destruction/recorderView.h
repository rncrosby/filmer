//
//  recorderView.h
//  HD Destruction
//
//  Created by Robert Crosby on 8/29/17.
//  Copyright © 2017 Robert Crosby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <LLSimpleCamera/LLSimpleCamera.h>
#import "References.h"
#import "driveObject.h"

@interface recorderView : UIViewController <UITextFieldDelegate> {
    bool isStart;
    int clipCount;
    NSMutableArray *scannedDrives;
    __weak IBOutlet UICollectionView *scannedDriveCollectionView;
    NSTimer *recorderTime;
    int recorderTimeInt;
    bool isRecording;
    NSURL *outputURL;
    LLSimpleCamera *recorder;
    __weak IBOutlet UIButton *recordingButton;
    __weak IBOutlet UILabel *currentTime;
    __weak IBOutlet UILabel *drivesScanned;
    __weak IBOutlet UIButton *simulateDriveScan;
    __weak IBOutlet UITextField *movieTitle;
    __weak IBOutlet UIScrollView *movieTitleView;
    __weak IBOutlet UIView *moviePlayerView;
    __weak IBOutlet UILabel *movieOverlay;
    
}
@property (nonatomic) AVPlayer *avPlayer;
- (IBAction)done:(id)sender;
- (IBAction)startRecording:(id)sender;
- (IBAction)restart:(id)sender;
- (IBAction)share:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)deleteMovie:(id)sender;

@end

