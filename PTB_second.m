% Clear the workspace
close all;
clear all;
Screen('Preference', 'SkipSyncTests', 1); % disable if script crashes. 
sca;

%% Experiment Parameters
subjID = input('input participant number ','s')
numBlocks = 13; % how many blocks to run in experiment if 13 = all blocks will be presented in a random order, if less, a random subset of tasks will be selected
numTrials = 3; % number of faces to be shown per block
param_ISI = 1; % InterStimulusInterval: 1=Fixed ; 2 = Random between min and max values ; 3 optseq2 (not added yet)
    param_fixedISI = 0.1; % if fixed specify seconds     %default 2 seconds, for debugging 0.1s 
    param_randISI_min = 1;  % if option 2 is chosen; enter min max ISI                                             
    param_randISI_max = 3;                                              
param_stimTime = 1; % time that a face is on-screen. stimus-on Time 1 = Fixed Time ; 2 = random between min, max; 3 = Optseq (not added yet)
param_stimtimeFixed = 0.1;
    param_randStimTime_min = 1;
    param_randStimTime_max = 3;
instruct_time = 7 %time in seconds that instructions are on the screen    
t_fixCross = 0.1 % time that fixation cross is on the screen
%ISI = [zeros(numTrials,1)]; % this is where interstimulus intervals will be kept; we can randomly choose them every time, or decide them in advance based on opseq2; and feed them into myTrials(numTrials).ISI 
% random ISI's
%For ISI_counter = 1:numtrials
totalTrials = numTrials * numBlocks; 
%% Conditions & Tasks
%Task 1,1 is the task prompt
%Task 1,2 is task instructions
% git_test
Task{1,1} = 'What colour is the persons hair?'; %Control or baseline
Task{1,2} = '1 = Blond\n2 = Dark\n3 = Other\n4 = Person has no hair';
Task{2,1} = 'How old were you when you first heard of this person?'; %episodic
Task{2,2} = '1 = less than 10 years old\n2 = between 10 and 15y/o\n3 = between 16 and now\n4 = never seen the person before';
Task{3,1} = 'How attractive do you find this person?';
Task{3,2} = '1 = very attractive\n2 = attractive\n3= average\n4 = not really attractive';
Task{4,1} = 'How friendly does this person look?';
Task{4,2} = '1 = very friendly\n2 = friendly\n3 = not really friendly\n4 = would not approach';
Task{5,1} = 'How trustworthy does this person look?';
Task{5,2} = '1 = very\n2 = quite\n3 = not really\n4 = not at all';
Task{6,1} = 'Do you associate this person more with positive or negative emotions?';
Task{6,2} = '1 = Very postive\n2 = somewhat positive\n3 = somewhat negative\n4 = negative ';
Task{7,1} = 'Have you seen this person before'; % semantic access 1
Task{7,2} = '1 = Yes, I have\n2 = No, never seen them before';
Task{8,1} = 'If asked to write an essay about this person\nhow much could you write about them?';%semantic access 2
Task{8,2} = '1 = None\n2 = Sentence\n3 = Paragraph\n4 = Page';
Task{9,1} = 'How common is this persons name?'
Task{9,2} = '1 = Very common\n2 = not very common\n3 = First time hearing this name\n4 = I don-t know this persons name'
Task{10,1} = 'How many facts can you remember about this person'
Task{10,2} = '1 = five or more\n2 = two or three\n3 = just their name\n4 = dont know the person'
Task{11,1} = 'Who is this person?'
Task{11,2} = '1 = TV/Movie persona\n2 = Singer/Musician\n3 = Politian/Businessman\n4 = other/dont know'
Task{12,1} = 'How familiar is this persons face to you?'
Task{12,2} = '1 = would not confuse it with anyone else\n2= quit distinct\n3 = confusable\n4 = would easily confuse'
Task{13,1} = 'Considering all the information available to you, is this a good person'
Task{13,2} = '1 = this is a good person\n2 = this is not a good person'
%Task{,} = 
%Task = Task'; 


%Task{1,1} = 'What colour is the persons hair?'; %Control condition
%Task{1,2} = 'Blond = 1, Dark = 2 , Other = 3, Person has no hair = 4';
%Task{2,1} = 'How old were you when you first heard of this person?'; %episodic
%Task{2,2} = '1 = less than 10 years old; 2 = between 10 and 15y/o, 3 = between 16 and now; 4 = never seen the person';
%Task{3,1} = 'How attractive do you find this person?';
%Task{3,2} = '1 = very, 2 = not bad, 3= average, 4 = not really attractive';
%Task{4,1} = 'How friendly does this person look?';
%Task{4,2} = '1=friendly, 2=less friendly, 3=not really friendly, 4=would not approach';
%Task{5,1} = 'How trustworthy does this person look?';
%Task{5,2} = '1 = very, 2 = quite, 3 = not really, 4 = not at all';
%Task{6,1} = 'Do you associate this person more with positive or negative emotions?';
%Task{6,2} = '1 = Very postive, 2 = somewhat positive, 3 = somewhat negative, 4 = negative ';
%Task{7,1} = 'Have you seen this person before'; % semantic access 1
%Task{7,2} = '1=Yes, I have ; 4=Nope, never seen them before';
%Task{8,1} = 'If asked to write an essay about this person, how much could you write about them?';%semantic access 2
%Task{8,2} = '1=None, 2=Sentence, 3=Paragraph, 4=Page';
%Task{9,1} = 'How common is this persons name?'
%Task{9,2} = '1 = Very common, 2 = not very common, 3 = First time hearing this name, 4 = I don-t know this persons name'
%Task{10,1} = 'How many facts can you remember about this person'
%Task{10,2} = '1 = five or more, 2 = two or three, 3 = just their name, 4 = dont know the person'
%Task = Task';
%% load random pics for the experiment
for pic_num = 1 : totalTrials; % was numTrials
myTrials(pic_num).filenames = func_getpic;
end
myTrials.filenames; %adds them to myTrials. later when pic is to be presented, it is taken from myTrials.
%% Set up KbCheck and keyboard related things
% CheetSheet: KeyCodes = 89, 90,91,92 correspond to some other numbers than 1,2,3,4 on keyboard. 40 is Enter/Return, 41 is escape
enabledKeyes = [30;31;32;33;40;41];
keyNames = KbName('KeyNames');
RestrictKeysForKbCheck(enabledKeyes);
%% Set up InterStimulusInterval
%%%
if param_ISI == 1; %if fixed ISI is chosen
    ISI = param_fixedISI;
for counter_ISI = 1 : totalTrials;
myTrials(counter_ISI).ISI = param_fixedISI;
end
elseif  param_ISI == 2;   
minISI = param_randISI_min; % in seconds
maxISI = param_randISI_max;
ISI = linspace(minISI,maxISI,totalTrials)';
ISI = Shuffle(ISI);
for counter_ISI = 1 : totalTrials;
myTrials(counter_ISI).ISI = ISI(counter_ISI);
end
elseif param_ISI == 3;
  error('Optseq functionality not added yet, sorry') 
end

%add the ISI's to myTrials, where they will be called from for the
%presentation



%% Stimulus-on time
%StimTime = ones(numTrials,1) * 3
if param_stimTime == 1;
   StimTime = param_stimtimeFixed;
   for counter_StimTime = 1 : totalTrials;
       myTrials(counter_StimTime).StimTime = StimTime;
   end
elseif param_stimTime == 2
minStim = param_randStimTime_min; % in seconds
maxStim = param_randStimTime_max;
StimTime = linspace(minStim,maxStim,totalTrials)';
StimTime = Shuffle(StimTime);
for counter_StimTime = 1 : totalTrials;
    myTrials(counter_StimTime).StimTime = StimTime(counter_StimTime);
end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PTB CODE

% set up defaults
PsychDefaultSetup(2);

% Get the screen numbers
screens = Screen('Screens');

% Draw to the external screen if avaliable
screenNumber = max(screens);

% Define black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;
inc = white - grey;

% Open an on screen window
%Takes over the screen
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

% Set up alpha-blending for smooth (anti-aliased) lines
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

%theImageLocation = [PsychtoolboxRoot 'PsychDemos' filesep...
 %   'AlphaImageDemo' filesep 'konijntjes1024x768.jpg'];
%theImage = imread(theImageLocation);

randTask = randperm(length(Task)); %this is where task vector is randomized
%%  BLOCKS here
% Beginning of a block, task instructions, fixation cross
for expBlock = 1 : numBlocks
    CurrentTask_num = randTask(expBlock);
    CurrentTask{1,1} = Task(CurrentTask_num);
    CurrentTask{1,2} = Task(CurrentTask_num,2);
    taskName = CurrentTask{1,1}{1,1};
    taskIntruct = CurrentTask{1,2}{1,1}
% Task Name
Screen('TextSize', window, 28);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, taskName, 'center', 'center', white);
% Task instructions
Screen('TextSize', window, 24);
Screen('TextFont', window, 'Courier');
lower_third = screenYpixels / 3 * 2;
cCenter = xCenter - length(taskIntruct);
%DrawFormattedText(window, taskIntruct, 'center', lower_third, white); % %centers nicely - not justified
DrawFormattedText(window, taskIntruct, cCenter, lower_third, white);

%xCenter
%DrawFormattedText(window, 'What movies have they been in?', 'center', screenYpixels * 0.15, [1 0 0]);
Screen('Flip', window);
WaitSecs(instruct_time); % length of time that task and instructions are on the screen
fixCrossDimPix = 40;

% Now we set the coordinates (these are all relative to zero we will let
% the drawing routine center the cross in the cent1er of our monitor for us)
xCoords = [-fixCrossDimPix fixCrossDimPix 0 0];
yCoords = [0 0 -fixCrossDimPix fixCrossDimPix];
allCoords = [xCoords; yCoords];

% Set the line width for our fixation cross
lineWidthPix = 4;
%
% Draw the fixation cross in white, set it to the center of our screen and
% set good quality antialiasing
Screen('DrawLines', window, allCoords,lineWidthPix, white, [xCenter yCenter], 2);

% Flip to the screen
Screen('Flip', window);
WaitSecs(t_fixCross); % Time that fixation cross is on the screen
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ExpStart = GetSecs;
%% EXPERIMENTAL RUN. 1 loop of code below = 1 trial

  % specify number of iterations
%for numBlocks * numTrials - 4 = 1 : numBlocks * numTrials
for ExpTrial = expBlock * numTrials - (numTrials - 1) : expBlock * numTrials; % code that matches blocks, trials, and trials per block
theImageLocation = myTrials(ExpTrial).filenames % gets picture from myTrials
theImage = imread(theImageLocation);

% Get the size of the image
[s1, s2, s3] = size(theImage);

% Here we check if the image is too big to fit on the screen and abort if
% it is. See ImageRescaleDemo to see how to rescale an image.
if s1 > screenYpixels || s2 > screenYpixels
    disp('ERROR! Image is too big to fit on the screen');
    sca;
    return;
end

% Make the image into a texture
imageTexture = Screen('MakeTexture', window, theImage);

% Draw the image to the screen, unless otherwise specified PTB will draw
% the texture full size in the cente41232r of the screen. We first draw the
% image in its correct orientation.
Screen('DrawTexture', window, imageTexture, [], [], 0);

% Flip to the screen
Screen('Flip', window); % the image is now on the screen
timePresented = GetSecs - ExpStart;
t_presented = GetSecs;
myTrials(ExpTrial).time_presented = timePresented;
[secs, keyCode, deltaSecs] = KbWait;
t_pressed = GetSecs;
PressedKey = keyNames{find(keyCode,'1')}
myTrials(ExpTrial).response = PressedKey;
myTrials(ExpTrial).RT = t_pressed - t_presented;
myTrials(ExpTrial).ExpBlock = expBlock;
myTrials(ExpTrial).TaskName = taskName;
myTrials(ExpTrial).taskIntruct = taskIntruct;
% Wait for two seconds
%WaitSecs(myTrials(ExpTrial).stimTime); % STIMULUS-ON TIME
WaitSecs(myTrials(ExpTrial).StimTime); %stimulus is on the screen for a time period specified in myTrials
% Now fill the screen GREY
Screen('FillRect', window, grey); % screen  is now blanc
% Flip to the screen
Screen('Flip', window);

% Wait for two seconds
WaitSecs(myTrials(ExpTrial).ISI); % screen is black for a period of time specified in myTrials.ISI
ExpTrial = ExpTrial+1
end
end
%writetable(struct2table(myTrials),strcat(num2str(subjID), '.csv')) % after all loops are finished. Save myTrials as csv
save('myTrials','subjID');
% Clear the screen
sca;
