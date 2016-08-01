
url = ['http://www.gumtree.com.au/s-ad/east-perth/'...
     'laptops/macbook-pro-13-inch-2011/1113870007'];
 
str = urlread(url,'Timeout',10);
patern_detail = '<div id="ad-description".*?</div>';
rst = regexp(str,patern_detail,'match');
temp = rst{1};
temp = regexprep(temp,'\s{2,}','');
item_infor = regexp(temp,'>.*?<','match')';
