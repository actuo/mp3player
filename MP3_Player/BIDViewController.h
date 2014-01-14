//
//  BIDViewController.h
//  MP3_Player
//
//  Created by Zhou, Chao on 11/7/13.
//  Copyright (c) 2013 Zhou, Chao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface BIDViewController : UIViewController <AVAudioPlayerDelegate>
@property(strong,nonatomic)AVAudioPlayer* audioPlayer;
- (IBAction)playAudio:(UIButton *)sender;
- (IBAction)stopAudio:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *volumeControl;
- (IBAction)adjustVolume:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UISlider *processStatus;
- (IBAction)processControl:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *processTime;
@property  (weak,nonatomic) NSTimer*    timer;
- (IBAction)setStartTime:(UIButton *)sender;
- (IBAction)setEndTime:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *repeaterA;
@property (weak, nonatomic) IBOutlet UILabel *repeaterB;



- (IBAction)repeatSong:(UIButton *)sender;
- (void)stopTimer;
- (void)timerFired;

- (IBAction)slidetouchupinside:(UISlider *)sender;


@end
