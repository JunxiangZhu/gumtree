%Description:This script is used to extract item ad information on Gumtree.
%Author: Junxiang Zhu
%Version: 1.0
%Date: 21-May-2016
%Email:junxiang.zhu@curtin.edu.au

% item_name = 'macbook';
% 
% url = ['http://www.gumtree.com.au/s-perth/' item_name '/k0l3008303?fromSearchBox=true'];

str = urlread(url,'Timeout',10);

% exatract title
patern_title = '<span itemprop="name">\s*.*?</span>';
result_title = regexp(str,patern_title,'match');
result_title = result_title';
for i = 1:length(result_title)
result_title{i} = regexprep(result_title{i},'\s{2,}','');%eliminate blank
result_title{i} = regexprep(result_title{i},'&#034;','"');%turn error into "
result_title{i} = regexprep(result_title{i},'&#039;','?');%turn error into ?
result_title{i} = regexprep(result_title{i},'&amp;','&');%turn error into &
result_title{i} = result_title{i}(23:end-7);% extract information needed
end

% extract price
patern_price = '<div class="rs-ad-field rs-ad-price">\s*.*?</div>';
result_price = regexp(str,patern_price,'match');
result_price = result_price';
for i = 1:length(result_price)
result_price{i} = regexprep(result_price{i},'\s{2,}','');%eliminate blank
if length(result_price{i}) == 43
    result_price{i} = ' ---- ';
else
    ind = strfind(result_price{i},'</');
    result_price{i} = result_price{i}(119:ind(1)-1);   
end
end

%date
patern_date = '<div class="rs-ad-date">.*?</div>';
result_date = regexp(str,patern_date,'match');
result_date = result_date';
for i = 1:length(result_date)
result_date{i} = regexprep(result_date{i},'\s{2,}','');%eliminate blank
result_date{i} = result_date{i}(25:end-6);
end

%location (new version)
patern_location = '<div class="rs-ad-location-area">.*?<div class="rs-ad-date">';
result_location = regexp(str,patern_location,'match')';
rst_temp = cell(length(result_location),1);
for i = 1:length(result_location)
    
    temp = result_location{i};
    temp = regexprep(temp,'\s{2,}',''); %eliminate continuous space
    ind1 = strfind(temp,'<');
    ind2 = strfind(temp,'>');
    if isempty(strfind(temp,'suburb'))
        rst_temp{i} = [temp(ind2(1)+1:ind1(2)-1) '/NaN' ];
        
    else
        rst_temp{i} = [temp(ind2(1)+1:ind1(2)-1) '/' temp(ind2(5)+1:ind1(6)-1)];
    end
    
end
result_location = rst_temp;
% link for each item
patern_link = '<a itemprop="url".*?href="/.*?"';
result_link = regexp(str,patern_link,'match');
result_link = result_link';
result_link = result_link(1:2:end,:);
for i = 1:length(result_link)
    ind1 = strfind(result_link{i},'"/');
    result_link{i} = ['http://www.gumtree.com.au' result_link{i}(ind1+1:end-1)];
end

result = [result_title,result_price,result_location]

