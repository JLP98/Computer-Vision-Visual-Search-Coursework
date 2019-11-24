%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% cvpr_visualsearch.m
%% Skeleton code provided as part of the coursework assessment
%%
%% This code will load in all descriptors pre-computed (by the
%% function cvpr_computedescriptors) from the images in the MSRCv2 dataset.
%%
%% It will pick a descriptor at random and compare all other descriptors to
%% it - by calling cvpr_compare.  In doing so it will rank the images by
%% similarity to the randomly picked descriptor.  Note that initially the
%% function cvpr_compare returns a random number - you need to code it
%% so that it returns the Euclidean distance or some other distance metric
%% between the two descriptors it is passed.
%%
%% (c) John Collomosse 2010  (J.Collomosse@surrey.ac.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom
function F = visualSearchTest(imgNum)

close all;

%% Edit the following line to the folder you unzipped the MSRCv2 dataset to
DATASET_FOLDER = '~/msrc/MSRC_ObjCategImageDatabase_v2';

%% Folder that holds the results...
DESCRIPTOR_FOLDER = '~/descriptors';
%% and within that folder, another folder to hold the descriptors
%% we are interested in working with
DESCRIPTOR_SUBFOLDER='globalRGBhisto';

%% 1) Load all the descriptors into "ALLFEAT"
%% each row of ALLFEAT is a descriptor (is an image)

ALLFEAT=[];
ALLFILES=cell(1,0);
ctr=1;
allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));
for filenum=1:length(allfiles)
    fname=allfiles(filenum).name;
    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);
    img=double(imread(imgfname_full))./255;
    thesefeat=[];
    featfile=[DESCRIPTOR_FOLDER,'/',DESCRIPTOR_SUBFOLDER,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
    load(featfile,'F');
    ALLFILES{ctr}=imgfname_full;
    ALLFEAT=[ALLFEAT ; F];
    ctr=ctr+1;
end

%% 2) Pick an image at random to be the query
NIMG=size(ALLFEAT,1);% number of images in collection
queryimg = imgNum;
queryCategory = imageCategory(queryimg);
categorySize = recallSizes(queryCategory);

%1-32: Flowers
%33-62: Signs
%63-96: Ducks/Geese/Swans
%97-126: Books
%127-156: Benches/Chairs
%157-180: Cats
%181-210: Dogs
%211-240: Streets
%241-270: Water 1
%271-300: People
%301-330: Fields
%331-351: Water 2
%352-381: Trees
%382-411: Houses/Castles
%412-441: Planes
%442-471: Cows
%472-501: Selfies
%502-531: Cars
%532-561: Bikes
%562-591: Sheep

%% 3) Compute the distance of image to the query
dst=[];
for i=1:NIMG
    candidate=ALLFEAT(i,:);
    query=ALLFEAT(queryimg,:);
    thedst=cvpr_compare(query,candidate);
    dst=[dst ; [thedst i]];
end
dst=sortrows(dst,1);  % sort the results

%% 4) Visualise the results
%% These may be a little hard to see using imgshow
%% If you have access, try using imshow(outdisplay) or imagesc(outdisplay)

SHOW=15; % Show top 15 results
dst=dst(1:SHOW,:);
folderPath = '~/msrc/MSRC_ObjCategImageDatabase_v2/Images/';
precisionCounter = -1;
for i=1:size(dst,1)
   currentFile = ALLFILES{dst(i,2)};
   filenameSplit = split(currentFile, folderPath);
   filename = filenameSplit(2);
   fileCategorySplit = split(filename, '_');
   fileCategory = fileCategorySplit(1);
   if (char(fileCategory) == queryCategory)
       precisionCounter = precisionCounter + 1;
   end    
end
precision = precisionCounter / (SHOW-1);
recall = precisionCounter / categorySize;

F = [precision recall];
return;
end