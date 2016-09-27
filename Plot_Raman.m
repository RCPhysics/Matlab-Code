clear
i=1;
k=1;

%Select filenames to be loaded.
my_files = uigetfile('*.txt', 'MultiSelect', 'on');
n = numel(my_files); 

%Preloads the Matrix - Can be improved on if size of final array is known.
spectra_matrix = [];  

%Import Data into Matlab and Concatenate into a single matrix
for i = 1:n
    %importdata imports data from each file listed in my_files.
    %the char function converts the name from type cell to type string
    my_data = importdata(char(my_files(i))); 
    %concatenates the matrices together
    spectra_matrix = [spectra_matrix my_data]; 
    
end

%Prepare the first figure environment
my_substance = char(inputdlg('What substance is this?', 'User Input'));
figure
hold on
title(sprintf('Raman Spectra for %s', my_substance));
xlabel('Wavenumbers (cm^{-1})');
ylabel('Intensity (A. U.)');



%The flip function should be used if raw data is in reverse order
spectra_matrix = flip(spectra_matrix);
g = n*2;

%This loop removes the background from the spectra and plots them
for k = 1:2:g
    ii = k+1;
    %msbackadj requires x-axis data to be in order from smallest to largest.
    %See flip command above
    Y = msbackadj(spectra_matrix(:, k), spectra_matrix(:, ii));
    plot(spectra_matrix(:, k), Y);
end

%Prepare environment for second figure
figure
hold on
title(sprintf('Average Raman Spectrum for %s', my_substance));
xlabel('Wavenumbers (cm^{-1})');
ylabel('Intensity (A. U.)');

%extract intensity values from the main matrix
inten = spectra_matrix(:, 2:2:end);

%Average intensity values together
avg_inten = mean(inten, 2);

%Correct intensity baseline
avg_Y = msbackadj(spectra_matrix(:,1), avg_inten);

plot(spectra_matrix(:,1), avg_Y);


%Removes index variables.  Comment out this line if errors occur to
%find the step they occur on.
clear g i ii k n 
