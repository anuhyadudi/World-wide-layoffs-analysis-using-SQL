SELECT 
    *
FROM
    layoffs;

CREATE TABLE layoffs_staging LIKE layoffs;

insert layoffs_staging
select * from layoffs;

-- remove duplicates

SELECT * FROM(SELECT company, industry, total_laid_off,`date`,
		ROW_NUMBER() OVER (
			PARTITION BY company, industry, total_laid_off,`date`) AS row_num
	FROM 
		layoffs_staging
	)duplicates
    where row_num>1;
-- check for oda
SELECT 
    *
FROM
    layoffs_staging
WHERE
    company = 'Oda';

SELECT *
FROM (
	SELECT company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) AS row_num
	FROM 
		layoffs_staging
) duplicates
WHERE 
	row_num > 1;
WITH DELETE_CTE AS 
(
SELECT *
FROM (
	SELECT company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) AS row_num
	FROM 
		layoffs_staging
) duplicates
WHERE 
	row_num > 1
)
DELETE
FROM DELETE_CTE;

-- standardize data
SELECT 
    *
FROM
    layoffs_staging;
;

SELECT DISTINCT
    industry
FROM
    layoffs_staging
ORDER BY industry;

SELECT 
    *
FROM
    layoffs_staging
WHERE
    industry IS NULL OR industry = ''
ORDER BY industry;

SELECT 
    *
FROM
    layoffs_staging
WHERE
    company LIKE 'Bally%';

SELECT 
    *
FROM
    layoffs_staging
WHERE
    company LIKE 'airbnb%';


UPDATE layoffs_staging 
SET 
    industry = NULL
WHERE
    industry = '';

SELECT 
    t1.industry, t2.industry
FROM
    layoffs_staging t1
        JOIN
    layoffs_staging t2 ON t1.company = t2.company
WHERE
    (t1.industry IS NULL)
        AND t2.industry IS NOT NULL;

UPDATE layoffs_staging t1
        JOIN
    layoffs_staging t2 ON t1.company = t2.company 
SET 
    t1.industry = t2.industry
WHERE
    (t1.industry IS NULL)
        AND t2.industry IS NOT NULL;

select distinct industry
from layoffs_staging
order by industry;

select distinct industry from layoffs_staging
where industry like 'Crypto%';

update layoffs_staging
set industry = 'Crypto'
where industry like 'Crypto%';

select distinct country
from layoffs_staging;

UPDATE layoffs_staging
SET country = TRIM(TRAILING '.' FROM country);

select * 
from layoffs_staging;

UPDATE layoffs_staging
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

alter table layoffs_staging
modify column `date` DATE;

select * 
from layoffs_staging
where total_laid_off is null;

select * 
from layoffs_staging
where total_laid_off is null 
and percentage_laid_off is null;

delete from layoffs_staging
where total_laid_off is null 
and percentage_laid_off is null;

select * 
from layoffs_staging;