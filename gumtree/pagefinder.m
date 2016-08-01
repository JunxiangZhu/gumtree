%% Initializing the inputs
item_name = 'macbook';
item_name = regexprep(item_name,'\s','+'); % change format to comply with the requirement of Gumtree
url = ['http://www.gumtree.com.au/s-perth/' item_name '/k0l3008303?fromSearchBox=true'];
str = urlread(url,'Timeout',10);

%% Finding the total number of pages
patern_lastpg = '<a class="rs-paginator-btn last".*?>';
temp = char(regexp(str,patern_lastpg,'match'));
ind1 = strfind(temp,'page-');
ind2 = strfind(temp,'/');
temp = temp(ind1+5:ind2(end)-1);
pg_total = str2double(temp);
disp(['Total Page: ' num2str(pg_total)] );

%%
disp('Page-1');
disp(ItemCheck(url))
for i = 2:pg_total
    url_tmp = ['http://www.gumtree.com.au/s-perth/' ...
        item_name '/page-' num2str(i) '/k0l3008303'];
    disp(['page-' num2str(i) ':']);
    disp(ItemCheck(url_tmp));  
end
