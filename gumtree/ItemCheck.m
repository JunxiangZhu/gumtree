function y = ItemCheck(url)
%Description:This script is used to extract item ad information on Gumtree.
%Author: Junxiang Zhu
%Version: 1.1
% compared with version 1.0, the interested areas are more extracted more
% efficiently.
%Date: 1-Aug-2016
%Email:junxiang.zhu@curtin.edu.au
if nargin ~= 1, error('Wrong input argument.'); end

str = webread(url);

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
patern_price = '<div class="j-ad-price.*?</div>';
result_price = regexp(str,patern_price,'match')';
for i = 1:length(result_price)
    kk = regexprep(result_price{i},'\s{2,}','');
    kk = regexprep(kk,'<.*?>','');
    result_price{i} = regexprep(kk,'\s','/');
end

%location (new version)
patern_location = '<div class="ad-listing__location">.*?</div>';
result_location = regexp(str,patern_location,'match')';
for i = 1:length(result_location)
    kk = regexprep(result_location{i},'\s{2,}','');
    result_location{i} = regexprep(kk,'<.*?>','');
end

%
% link for each item
patern_link = '<a itemprop="url".*?">';
result_link = regexp(str,patern_link,'match')';
for i = 1:length(result_link)
    ind1 = strfind(result_link{i},'"/');
    result_link{i} = ['http://www.gumtree.com.au' result_link{i}(ind1+1:end-2)];
end
result_link = unique(result_link,'stable');

%
result = [result_title,result_price,result_location,result_link];

if nargout==1, y=result; elseif nargout==0, disp(result); end

end

