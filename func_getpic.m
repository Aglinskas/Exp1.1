function y = func_getpic()
stimuli = '/Users/aidas_el_cap/Desktop/Experiment/Stimuli/Faces'; % directory of the faces folder
names = '/Users/aidas_el_cap/Desktop/Experiment/names.txt'; %directory to names.txt

% Read in peoples names from the .txt file
fileID = fopen(names,'r');
C = textscan(fileID,'%q %*q %*d %f','Delimiter',',');
fclose(fileID);
%%%
selected_name = C{1,1}{50,1}; % just an initial value
num_people = length(C{1,1});
%C{1,1} has all the names C{1,1}{2,1} is second one on the list. 1-294
% strcat(lastnames, {', '}, firstnames)

% go in the 'selected' folder and figure out how many pics it has
selected_name2 = strcat(stimuli, {'/'}, selected_name,{'/'}, 'selected' );
B0 = selected_name2{1,1}; %strcat makes a cell, this takes the value from it
B1 = dir(B0); % holds the contents of the directory
% listDir(~[listDir.isdir]).name
%%%% 
%B1(~[B1.isdir]).name
%B1;
num_files2 = size(B1);
%struct2table(B1) gives a table


%fullpath = strcat(selected_name2,{'/'},B1(5).name)
%picture = strcat(stimuli, {'/'}, selected_name)

%%%%%%
% selecting a random name
num_pics = 0;
while num_pics < 1
choose_name = randi([1 num_people],1);
chosen_name = C{1,1}{choose_name};
chosen_path = strcat(stimuli, {'/'}, chosen_name,{'/'}, 'selected' );

% go in the 'selected folder' get random pic

 
path_to_name = chosen_path{1,1};
folder_contents = dir(path_to_name);
num_pics = length(folder_contents(~[folder_contents.isdir]));
end 

% folder_contents(~[folder_contents.isdir]).name lists all the pics
%chosen_path{1,1}(~[chosen_path{1,1}.isdir]).name
select_random_pic_num = randi([3 num_pics + 2],1);

random_pic_name = folder_contents(select_random_pic_num).name;
chosen_pic_path = strcat(chosen_path, {'/'},random_pic_name);
y = chosen_pic_path{1,1};
end