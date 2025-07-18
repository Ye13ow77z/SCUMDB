-- 选择数据库
USE moviesdata;

-- 修复图片路径中的双斜杠问题
UPDATE allmovies SET image = REPLACE(image, '//', '/') WHERE image LIKE '%//%';

-- 验证修复结果
SELECT id, name, image FROM allmovies WHERE image LIKE '%//%' LIMIT 10;