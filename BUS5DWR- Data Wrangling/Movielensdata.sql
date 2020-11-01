select * from dbo.movielens_links
select * from dbo.movielens_movies
select * from dbo.movielens_ratings
select * from dbo.movielens_tags
/* Q1 */
select count(DISTINCT userid) as num_of_users_contributing_tags
from dbo.movielens_tags where
tag IS NOT NULL;
/* */
select genres from dbo.movielens_movies where genres like '%|%|%' 
select count(distinct tags.userid) from movielens_tags as tags left join movielens_ratings as rat 
on tags.userId=rat.userId
and tags.movieId=rat.movieId
where rat.rating is null
select * from movielens_ratings where movieId = 4194
/* Q2 */
with c as (
select genres,LEN(genres)-LEN(REPLACE(genres,'|',''))+1) As no_of_genres from dbo.movielens_movies
) 
select count(no_of_genres) as no_movies_with_3_genres
from c where no_of_genres=3;
/* */
with c as (
select genres,(LEN(genres)-LEN(REPLACE(genres,'|',''))+1) As no_of_genres from dbo.movielens_movies
) 
select count(no_of_genres) as no_movies_with_3_genres
from c where no_of_genres=3;
with d as (
select * from (
select genres,movieid,(LEN(genres)-LEN(REPLACE(genres,'|',''))+1) As no_of_genres from dbo.movielens_movies 
where  genres not like '%(%)%')a
) select count(movieId) as no_movies_with_3_genres
from d where no_of_genres=3;


/* Q3 */
select count( DISTINCT userid) from 
dbo.movielens_ratings where 
rating not like '_' and rating not like '_.0' 
/* */
/* Q4 */
select title as repeated_titles 
from dbo.movielens_movies 
group by title
having count(title)>1;
/* */
select genres from dbo.movielens_movies where title like  'St%'

/* Q5 */
 with y as (
 select  SUBSTRING(title,len(title)-4,4) as year2 
 from dbo.movielens_movies 
 where title like '%(____)'
 ) select count(year2) as num_movies_within_1985_1995
 from y where 
 year2 between 1985 and 1995;
 /* */
 
 /* 6*/
SELECT top 5 movieId,title
FROM dbo.movielens_movies
WHERE movieId IN (
SELECT movieId  
FROM dbo.movielens_movies
WHERE movieId NOT IN (
SELECT movieId FROM dbo.movielens_ratings));
/* */

/* Q7 */
with d as (
select count(DISTINCT movieid) As no_of_movies ,userId from dbo.movielens_tags 
group by userId having ((count( distinct movieid)>=3))
) 
select count(userId) as users_tagging_three_or_more_movies
from d where no_of_movies>=3;
/* */

/* Q8 */
select top 5 b.title as Title,count(a.rating) as Num_Ratings 
from dbo.movielens_ratings a
join dbo.movielens_movies b 
on a.movieId=b.movieId
group by Title 
order by count(*) DESC;
/* */ 

/* Q9 */
SELECT top 5 tag as TAG,count(DISTINCT userId) as No_OF_Users 
FROM dbo.movielens_tags 
group by TAG order by No_OF_Users DESC;
/* */

/* Q10 */
select top 3 a.title as Title,
CAST(AVG(b.rating) as DECIMAL(10,2)) as Average_Rating
from dbo.movielens_movies a 
join dbo.movielens_ratings b
on a.movieId=b.movieId 
where a.genres like '%Mystery%' 
group by Title having count(b.rating)>= 5 
order by Average_Rating DESC;
/* */

/* Q11 */
select top 5 value as Genres,count(distinct tag) as Tag_count 
from dbo.movielens_movies a 
JOIN dbo.movielens_tags b 
ON a.movieId=b.movieId
cross apply string_split(genres,'|')
group by value 
order by Tag_count DESC;
/* */

/* Q12*/
with x as (
select b.title as Title, count(rating) as V,
CAST(avg(rating) as DECIMAL(10,2)) as R,
 (select Cast(avg(rating) as DECIMAL(10,2)) 
 from dbo.movielens_ratings) as C
 from dbo.movielens_ratings a 
 join dbo.movielens_movies b
 on a.movieId=b.movieId join
 dbo.movielens_tags z on
 a.movieId=z.movieId 
 where tag='funny' group by b.title
 ) select top 5 title as Title, 
 CAST((V*R+10*C)/(V+10) as DECIMAL(10,2)) as Weighted_Average 
 from x 
 order by Weighted_Average DESC;
 /* */
