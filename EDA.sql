select * 
from layoffs_staging;

-- Exploratory Data Analysis

select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging;

-- some companies have maximum laid off percentage as 1 which means that they went all out of business
-- these companies are mostly start ups 
select * 
from layoffs_staging
where percentage_laid_off=1
order by funds_raised_millions desc;

-- companies that have biggest layoffs

select company,sum(total_laid_off)
from layoffs_staging
group by company
order by 2 desc;

select min(`date`),max(`date`)
from layoffs_staging;

-- by location

select industry,sum(total_laid_off)
from layoffs_staging
group by industry
order by 2 desc;

-- by year

select year(`date`),sum(total_laid_off)
from layoffs_staging
group by year(`date`)
order by 1 desc;

select stage,sum(total_laid_off)
from layoffs_staging
group by stage
order by 2 desc;

select company,avg(percentage_laid_off)
from layoffs_staging
group by company
order by 1 desc;

-- per year layoffs of each company using CTEs
with rolling_total as (
select SUBSTRING(`date`,1,7) as `month`, 
sum(total_laid_off) as total_off
from layoffs_staging
where SUBSTRING(`date`,1,7) is not null
group by `month`
order by 1 asc
)
select `month`,
 total_off,
sum(total_off) over(order by `month`) as rolling_total
from rolling_total;

select company, year(`date`), sum(total_laid_off)
from layoffs_staging
group by company, year(`date`)
order by 3 desc;

with company_year(company, years, total_laid_off) as(
select company, year(`date`), sum(total_laid_off)
from layoffs_staging
group by company, year(`date`)
),
company_year_rank as (
select *, 
dense_rank() over(partition by years order by total_laid_off desc) as ranking
from company_year
where years is not null)

select * 
from company_year_rank
where ranking <=5;

