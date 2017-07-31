

function plot_confusion_matrix(mat)

    N = max(size(mat));

    imagesc(mat);            %# Create a colored plot of the matrix values
    colormap(flipud(gray));  %# Change the colormap to gray (so higher values are
                             %#   black and lower values are white)

    textStrings = num2str(mat(:),'%0.2f');  %# Create strings from the matrix values
    textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding

    %% ## New code: ###
    idx = find(strcmp(textStrings(:), '0.00'));
    textStrings(idx) = {'   '};
    %% ################

    [x,y] = meshgrid(1:N);   %# Create x and y coordinates for the strings
    hStrings = text(x(:),y(:),textStrings(:),...      %# Plot the strings
                    'HorizontalAlignment','center');
    midValue = mean(get(gca,'CLim'));  %# Get the middle value of the color range
    textColors = repmat(mat(:) > midValue,1,3);  %# Choose white or black for the
                                                 %#   text color of the strings so
                                                 %#   they can be easily seen over
                                                 %#   the background color
    set(hStrings,{'Color'},num2cell(textColors,2));  %# Change the text colors

    set(gca,'XTick',1:N,...                         %# Change the axes tick marks
            'XTickLabel',{'1','2','3','4','5','6','7','8','9','10','11'},...  %#   and tick labels
            'YTick',1:N,...
            'YTickLabel',{'1','2','3','4','5','6','7','8','9','10','11'},...
            'TickLength',[0 0]);

end