myaddress = 'dingding41102.test@gmail.com';
mypassword = 'junxiang';

setpref('Internet','E_mail',myaddress);
setpref('Internet','SMTP_Server','smtp.gmail.com');
setpref('Internet','SMTP_Username',myaddress);
setpref('Internet','SMTP_Password',mypassword);

props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', ...
                  'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');

item_name = 'mac';
item_name_url = regexprep(item_name,'\s*','+');
url = ['http://www.gumtree.com.au/s-perth/'...
    item_name_url '/k0l3008303?fromSearchBox=true'];
rst0 = ItemCheck(url);
rst0 = rst0(6:end,1:end)
ind = 1;
while true
    rst1 = ItemCheck(url);
    rst1 = rst1(6:end,1:end);
    cpr = ismember(rst1,rst0);
    if (sum(diff(sum(cpr))) == 0) && (sum(all(cpr,2)) > 19) && (sum(cpr(:))~=100)
        tmp_url = rst1{1,4};
        infor = detailcheck(tmp_url);
        sendmail('dingding41102@gmail.com','New tiem',...
            ['Hi Junxiang,' 10 10 'We found a new item for you. Hope you like it.' ...
            10 10  '"' 10 rst1{1,1} 10 10  rst1{1,2} 10 10  rst1{1,3}...
            10 10  rst1{1,4} 10 '"' 10 10 'Kind Regards,' 10 10 'kaka' 10 ...
            repmat('_',1,40) 10; infor; repmat('_',1,40)]);
        disp(repmat('-',1,20))
        disp(rst1(1:end,1:end))
        rst0 = rst1;
    else
        tmp = sprintf('[%d attempt @%s]@ %s \n---------------------',ind,datestr(now),url);
        disp(tmp)
        ind = ind+1;
    end
    pause(20)
end