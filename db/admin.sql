select * 
from clubs
where logo_url is null 
or logo_url = 'http://news.funfungolf.com/e/extend/court/images_court/default2.jpg'
;