% test program
[FileName,PathName] = uigetfile('*.txt','Open Old Standing Frame Data');
% PathName = handles.PathName;
% FileName = handles.FileName;
OldStandingFrameFile = [PathName FileName];
HeaderFid = fopen(OldStandingFrameFile);
for i = 1:4;tline = fgets(HeaderFid);end;
tline = fgets(HeaderFid);
Header = sscanf(tline, '%s', [1, inf]);
M1 = csvread(OldStandingFrameFile,5,0);
%
[FileName,PathName] = uigetfile('*.txt','Open New Standing Frame Data');
% PathName = handles.PathName;
% FileName = handles.FileName;
NewStandingFrameFile = [PathName FileName];
M2 = csvread(NewStandingFrameFile,5,0);

% C = strsplit(Header);
VariableName = regexp(Header,',','split')
Difference = M1-M2;
mean(Difference);
