//
//  BIDViewController.m
//  MP3_Player
//
//  Created by Zhou, Chao on 11/7/13.
//  Copyright (c) 2013 Zhou, Chao. All rights reserved.
//

#import "BIDViewController.h"

@interface BIDViewController ()

{
    float startTimeA;
    float endTimeB;
    NSMutableArray* timeSlots;
}

@end

@implementation BIDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    timeSlots = [[NSMutableArray alloc] init];

    
    NSURL *url=[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"1" ofType:@"mp3"]];
    NSError *error;
    _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    
    
    if (error) {
        NSLog(@"error in audio player:%@",[error localizedDescription]);
        _processStatus.maximumValue = _audioPlayer.duration;
//        _processTime.text=[NSString stringWithFormat:@"%f",_audioPlayer.duration];
        NSLog(@"test");
        
    }
    else{
        _audioPlayer.delegate=self;
        [_audioPlayer prepareToPlay];
        _processStatus.maximumValue = _audioPlayer.duration;
    }
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString * path = @"/Users/i038954/Documents/Study/English/F6_mp3/199826.F6_71G_en_srt_lrc/F6-71G-en.srt-lrc/MP3-lrc/第1季/Friends.S01E02.The.One.With.The.Sonogram.At.The.End.mg.lrc";
    NSError *aError;
    NSString * lrcContent =[NSString stringWithContentsOfFile:path encoding:NSUTF16LittleEndianStringEncoding error:&aError];
    NSLog(@"%@",aError);
    NSScanner *lrcScanner = [NSScanner scannerWithString:lrcContent];
    while (![lrcScanner isAtEnd]) {
        @autoreleasepool {
            NSString * startTime;
            NSString * content;
            (void)[lrcScanner scanString:@"[" intoString:NULL];
            (void)[lrcScanner scanUpToString:@"]" intoString:&startTime];
            NSArray *timeArray = [startTime componentsSeparatedByString:@":"];
            NSTimeInterval timePosition= [timeArray[0] integerValue]*60+[timeArray[1] floatValue];
            (void)[lrcScanner scanString:@"]" intoString:NULL];
            (void)[lrcScanner scanUpToCharactersFromSet:[NSCharacterSet newlineCharacterSet]  intoString:&content];
            content = [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            NSArray *timeslot = [NSArray arrayWithObjects:[NSNumber numberWithDouble:timePosition],content,nil];
            [timeSlots addObject:timeslot];
            
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playAudio:(UIButton *)sender {
    [_audioPlayer play];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
}

- (void)timerFired
{
    _processTime.text = [NSString stringWithFormat:@"%f",_audioPlayer.currentTime];
    if (_audioPlayer.currentTime >= endTimeB && endTimeB >0){
        _audioPlayer.currentTime = startTimeA;
    }
    
    
}

- (IBAction)slidetouchupinside:(UISlider *)sender {
    [_audioPlayer stop];
    _audioPlayer.currentTime = _processStatus.value;
    [_audioPlayer play];
    
    _processTime.text = [NSString stringWithFormat:@"%f",_processStatus.value];
}



- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}


- (IBAction)stopAudio:(id)sender {
    [_audioPlayer stop];
    [self stopTimer];
//    NSString *term = @"high";
//    
//    if ([UIReferenceLibraryViewController dictionaryHasDefinitionForTerm:term]) {
//        NSLog(@"Term: %@, has definition", term);
//        UIReferenceLibraryViewController *refVC =
//        [[UIReferenceLibraryViewController alloc] initWithTerm:term];
//        [refVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
//        [self presentModalViewController:refVC animated:YES];
//    }
}
- (IBAction)adjustVolume:(UISlider *)sender {
    _audioPlayer.volume = _volumeControl.value;
}
-(void)audioPlayerDidFinishPlaying:
(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self stopTimer];
}
-(void)audioPlayerDecodeErrorDidOccur:
(AVAudioPlayer *)player error:(NSError *)error
{
    [self stopTimer];
}
-(void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
}
-(void)audioPlayerEndInterruption:(AVAudioPlayer *)player
{
}

- (IBAction)processControl:(id)sender {
    if (self.timer)
        [self stopTimer];
}
- (IBAction)setStartTime:(UIButton *)sender {
    _repeaterA.text = [NSString stringWithFormat:@"%f", _audioPlayer.currentTime];
    startTimeA = _audioPlayer.currentTime;
}

- (IBAction)setEndTime:(UIButton *)sender {
    _repeaterB.text = [NSString stringWithFormat:@"%f", _audioPlayer.currentTime];
//    endTimeB = _audioPlayer.currentTime;
    _audioPlayer.currentTime = startTimeA;
}

- (IBAction)repeatSong:(UIButton *)sender {

}
@end
