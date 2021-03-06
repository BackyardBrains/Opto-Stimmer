//
//  BYBOptoStimmer.m
//  OptoStimmer
//
//  Created by Greg Gage on 4/17/13.
//  Copyright (c) 2013 Backyard Brains. All rights reserved.
//

#import "BYBOptoStimmer.h"

@implementation BYBOptoStimmer

bool turnCommandActive = NO;

- (BYBOptoStimmer * ) init {
    self.isLoadingParameters = 0;
    self.frequency = [NSNumber numberWithInt:1];
    self.pulseWidth = [NSNumber numberWithInt:392];
    self.duration = [NSNumber numberWithInt:1000.0];
    self.randomMode = [NSNumber numberWithInt:0];
    self.gain = [NSNumber numberWithInt:100];
    
    return self;
}

// delegate bookkeeping
id <BYBOptoStimmerDelegate> delegate;
- (id)delegate {
    return delegate;
}

- (void)setDelegate:(id)newDelegate {
    delegate = newDelegate;
}

- (void) updateSettings {
    NSLog(@"Updating OptoStimmer Settings:");
    NSLog(@"Random Mode: %@", self.randomMode);
    NSLog(@"Frequency: %@", self.frequency);
    NSLog(@"Pulse Width: %@", self.pulseWidth);
    NSLog(@"Duration: %@", self.duration);
    NSLog(@"Gain: %@", self.gain);
    self.gain = [NSNumber numberWithInt:100];
    [delegate optoStimmerHasChangedSettings:self];
}

- (NSString *) getStimulationString  {
    NSString * stimSettings;
    if ([self.randomMode boolValue]){
        stimSettings = [NSString stringWithFormat:@"Randomized for %ims. %i%%", [self.duration intValue], [self.gain intValue] ];
    }else{
        stimSettings = [NSString stringWithFormat:@"%iHz, %ims pulse, for %ims. %i%%", [self.frequency intValue], [self.pulseWidth intValue], [self.duration intValue],100];
    }
    return (stimSettings);
}

- (void) goLeft {
    if (!turnCommandActive){
        if (!turnCommandActive){
            turnCommandActive = YES;
            [self.delegate optoStimmer:self hasMovementCommand: moveLeft];
            [NSTimer scheduledTimerWithTimeInterval:OPTOSTIMMER_TURN_TIMEOUT target:self selector:@selector(turnActiveTimer:) userInfo:nil repeats:NO];
        }
    }
}

- (void) goRight {
    if (!turnCommandActive){
        if (!turnCommandActive){
            turnCommandActive = YES;
            [self.delegate optoStimmer:self hasMovementCommand: moveRight];
            [NSTimer scheduledTimerWithTimeInterval:OPTOSTIMMER_TURN_TIMEOUT target:self selector:@selector(turnActiveTimer:) userInfo:nil repeats:NO];
        }
    }
}

- (void) turnActiveTimer:(NSTimer *)timer {
    turnCommandActive = NO;
}


@end
