function y = SingItemCheck(str)
%Description:This script is used to extract information of a single item
% so plese input content between <li>...</li>. Attention single item
%Author: Junxiang Zhu
%Version: 1.1
%Date: 26-May-2016
%Email:junxiang.zhu@curtin.edu.au
if nargin ~= 1, error('Wrong input argument.'); end

% exatract title
patern_title = '<span itemprop="name">\s*.*?</span>';
result_title = char(regexp(str,patern_title,'match'));
if ~isempty(result_title)
    result_title = regexprep(result_title,'\s{2,}','');%eliminate blank
    result_title = regexprep(result_title,'&#034;','"');%turn error into "
    result_title = regexprep(result_title,'&#039;','?');%turn error into ?
    result_title = regexprep(result_title,'&amp;','&');%turn error into &
    result_title = char(result_title);% extract information needed
    result_title = result_title(23:end-7);
else
    result_title={repmat('-',1,6)};
end
result_title = {result_title};

% extract price
patern_price = '<div class="rs-ad-field rs-ad-price">\s*.*?</div>';
result_price = regexp(str,patern_price,'match');
result_price = regexprep(result_price,'\s{2,}','');%eliminate blank
result_price = char(result_price);
if length(result_price) == 43
    result_price = repmat('-',1,6);
else
    ind = strfind(result_price,'</');
    result_price = result_price(119:ind(1)-1);
end
result_price = {result_price};

% %date
% patern_date = '<div class="rs-ad-date">.*?</div>';
% result_date = regexp(str,patern_date,'match');
% result_date = regexprep(result_date,'\s{2,}','');%eliminate blank
% result_date = char(result_date);
% result_date = result_date(25:end-6);
% result_date = {result_date};


%location (new version)
patern_location = '<div class="rs-ad-location-area">.*?<div class="rs-ad-date">';
result_location = regexp(str,patern_location,'match');
result_location = char(result_location);
result_location = regexprep(result_location,'\s{2,}',''); %eliminate continuous space
ind1 = strfind(result_location,'<');
ind2 = strfind(result_location,'>');
if isempty(strfind(result_location,'suburb'))
    result_location = [result_location(ind2(1)+1:ind1(2)-1) '/------' ];
else
    result_location = [result_location(ind2(1)+1:ind1(2)-1) '/' result_location(ind2(5)+1:ind1(6)-1)];
end
result_location = {result_location};
    
% link for each item
patern_link = '<a itemprop="url".*?">';
result_link = regexp(str,patern_link,'match');
result_link = char(unique(result_link,'stable'));
ind1 = strfind(result_link,'"/');
result_link = ['http://www.gumtree.com.au' result_link(ind1+1:end-2)];
result_link = {result_link};

%
result = [result_title,result_price,result_location,result_link];

if nargout==1, y=result; elseif nargout==0, disp(result); end

end