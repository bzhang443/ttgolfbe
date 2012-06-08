
-- clubs check
select * from clubs where address is null;

select * from clubs where latitude is null or longitude is null;

select * from clubs where logo_url is NULL;

select * from clubs where telephone is null;

select * from clubs where short_name is null or length(short_name) > 18;

-- courses check
select * from courses where designer is null;

select * from courses where name is not null and vip is null;

select * from courses where hole_count is null;

-- select course_id, count(*) from holes group by course_id;

-- holes check
select * from holes where par is null or par=0;

select * from holes where number > 18 or number is null or number =0;

select * from holes 
where yard_black is null 
or yard_gold is null
or yard_blue is null
or yard_white is null
or yard_red is null
;

select * from holes
where (yard_black + yard_gold + yard_blue + yard_white + yard_red) < 100
;

select * from maps 
where lat_left_lower is NULL
or lon_left_lower is null
or lat_right_lower is null
or lon_right_lower is null
or lat_left_higher is null
or lon_left_higher is null
or lat_right_higher is null
or lon_right_higher is NULL
or dim_x is null or dim_x=0 
or dim_y is null or dim_y=0
or url is null or url=''
or poi_green_front is null
or poi_green_front is null
or poi_green_back is null
or poi_tee_black+poi_tee_gold+poi_tee_blue+poi_tee_white+poi_tee_red is null
;

select * from maps where right(url,4)<>'.png';

-- courses without holes
select r.*
from courses r
left join holes h on h.course_id = r.id
where h.id is null
;

select * from courses where club_id is null;

select c.*
from clubs c
left join courses r on r.club_id=c.id
where r.id is null
;

