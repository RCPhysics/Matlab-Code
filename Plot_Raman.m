clear
i=1;
k=1;

%Select and Load raw spectrum data.
my_files = uigetfile('*.txt', 'MultiSelect', 'on');
n = numel(my_files); 
spectra_matrix = [];  
    %Preloads the Matrix - Can be improved on if size of final array is known.
for i = 1:n
    my_data = importdata(char(my_files(i))); 
    %char is needed to convert from cell data to character strings
    spectra_matrix = [spectra_matrix my_data]; 
    %concatenates the matrices together
end


figure
hold on
g = n*2;
spectra_matrix = flip(spectra_matrix); 
%Use if Renishaw data is in reverse order
for k = 1:2:g
    ii = k+1;
    Y = msbackadj(spectra_matrix(:, k), spectra_matrix(:, ii));
    %This function requires x-data to be in order from smallest to largest.
    %See flip command above
    plot(spectra_matrix(:, k), Y);
end

clear g i ii k n 
%Removes index variables.  Comment out the above line if errors occur to
%find the step they occur on.