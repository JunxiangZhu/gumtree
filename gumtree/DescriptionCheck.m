function y = detailcheck(url)

if nargin ~= 1, error('Wrong input argument.'); end

str = webread(url);
patern_detail = '<div id="ad-description".*?</div>';
rst = regexp(str,patern_detail,'match');
if ~isempty(rst)
    temp = rst{1};
    temp = regexprep(temp,'\s{2,}','');
    item_infor = regexp(temp,'>.*?<','match')';
    item_infor = regexprep(item_infor,'<','');
    item_infor = regexprep(item_infor,'&#39;','’'); %replace error with '''
else
    item_infor = {'NaN'};
end

if nargout==1, y=item_infor; elseif nargout==0, disp(item_infor); end

end
