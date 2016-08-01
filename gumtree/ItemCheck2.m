function y = ItemCheck2(url)

if nargin ~= 1, error('Wrong input argument.'); end

str = webread(url);
patern_item = '<li id="search-result-li.*?</li>';
result_item = regexp(str,patern_item,'match')';
result = cell(length(result_item),4);
for i = 1:length(result_item)
   str_tmp = result_item{i};
   rst = SingItemCheck(str_tmp); 
   result(i,:) = rst; 
end

if nargout==1, y=result; elseif nargout==0, disp(result); end
end