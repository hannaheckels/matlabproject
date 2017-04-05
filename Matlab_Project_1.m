username = input('Please enter a username:\n','s');
FileName = input('Input the name of the file you would like to\n load, please include any extensions, such as .txt,\n .mat, etc.\n', 's');
while(exist(FileName,'file') ~=2 )
    FileName = input('The file could not be found, or it does not exist.\n Try again with a new file.\n','s');
end
file = load(FileName);
%.mat file is converted to a more versatile file
if strfind(FileName, '.mat') > 0
    file = cell2mat(file);
    file = struct2cell(file);
end
%is matrix the right size (1x1), if not,
%matrix is converted to a 1x1 matrix
s = size(file);
if s(1)~=1 && s(2)~=1
    newFile = reshape(file, s(1)*s(2),1);
end
 
continueProgram = true;
while continueProgram
    mtitle = sprintf('What would you like to do today?');
    choice = menu(mtitle, {'Resest your username.','Load new data file.','Clear data from memory','Set output filename and load data to file','Plot histogram','Plot Histogram Fit','Plot probability plots.','Regression of y on x.','Find probability given x or z.','Find x or z given the probability.','Exit'});
    switch choice
        case 1
            %set username
            username = input('Please enter a new username:\n','s');
        case 2
            newFile = input('Please enter the name of the file you would like to test now.\n','s');
        case 3
            clearvars -except continueProgram
        case 4
           
            disp('Press ctrl+c to end program')
        case 5
            %plot histogram
            histogram(newFile)
        case 6
            %plot histogram fit
            histfit(newFile)
        case 7
            probplot(newFile)
        case 8
            mtitle7 = sprintf('What type of regression\n would you like to plot?');
            b = menu(mtitle7, 'Linear Regression', 'Polynomial Regression');
            switch b
                %linear regression
                case 1
                    x = file(:,1); %sets x as first column of data set
                    y = file(:,2); %sets y as second column of data set
                    l = polyfit(x,y,1);
                    yfit = polyval(l,x);
                    plot(x, yfit);
                %polynomial regression
                case 2
                    x = file(:,1); %sets x as first column of data set
                    y = file(:,2); %sets y as second column of data set
                    l = polyfit(x,y,3);
                    yfit = polyval(l,x);
                    plot(x, yfit);
            end
        case 9
            %is user inputting an x or z value?
            mtitle2 = sprintf('Are you entering a z or x value?');
            h = menu(mtitle2, 'z-value', 'x-value');
            mtitle3 = sprintf('In your best judgment, is this data\n normally distributed?');
            n = menu(mtitle3, 'yes', 'no');
            switch n
                case 1
                    switch h
                        case 1
                            z = input('\nPlease enter the z value:\n');
                            q = normcdf(z, 0, 1);
                            q1 = q*100;
                            fprintf('The probability at the given z value is %.2f', q1);
                        case 2
                            x= input('\nPlease enter the x value:\n');
                            q = normcdf(x, avg, stdev);
                            q1 = q*100;
                            fprintf('The probability at the given x value is %.2f', q1);
                    end
                case 2
                    disp('The data is not normally distributed, the\n program is now returning to the main menu.');
            end
        case 10
            mtitle6 = sprintf('Are you trying to solve for a z or x value from\n from the probability?');
            k = menu(mtitle6, 'z value', 'x value');
            mtitle3 = sprintf('In your best judgment, is this data\n normally distributed?');
            n = menu(mtitle3, 'yes', 'no');
            switch n
                case 1
                    p = input('\nPlease input the proabability (as a whole number):\n');
                    if p > 1 && p <= 100
                        p = p/100;
                        switch k
                            case 1
                                z = norminv(p, 0, 1);
                                fprintf('The z value that is found by the given\n probability is %.2f.',z);
                            case 2
                                x = norminv(p, avg, stdev);
                                fprintf('The x value that is found by the given\n probability is %.2f.',x);
                        end
                    elseif p > 100
                        disp('Probability input cannot be greater than 100. The program is now returning to the main menu.')
                    end
                case 2
                    disp('The data is not normally distributed, the\n program is now returning to the main menu.');
            end
        case 11
            continueProgram = false;
        otherwise
            continueProgram = false;
    end
    
end
fclose all;
clear 

