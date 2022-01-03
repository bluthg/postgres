SHOW track_toast;
SET track_toast TO on;
SHOW track_toast;
TABLE pg_stat_toast; -- view exists
CREATE TABLE toast_test (cola TEXT, colb TEXT COMPRESSION lz4, colc TEXT , cold TEXT, cole TEXT);
ALTER TABLE toast_test ALTER colc SET STORAGE EXTERNAL;
ALTER TABLE toast_test ALTER cold SET STORAGE MAIN;
ALTER TABLE toast_test ALTER cole SET STORAGE PLAIN;
INSERT INTO toast_test VALUES (repeat(md5('a'),100), repeat(md5('a'),100), repeat(md5('a'),100), repeat(md5('a'),100), repeat(md5('a'),100) );
SELECT pg_sleep(1); -- give the stats collector some time to send the stats upstream
SELECT attname
	,storagemethod
	,externalized
	,compressmethod
	,compressattempts
	,compresssuccesses
	,compressedsize < originalsize AS compression_works
	, total_time > 0 AS takes_time 
FROM pg_stat_toast WHERE relname = 'toast_test' ORDER BY attname;
SELECT compressattempts=0 AS external_doesnt_compress FROM pg_stat_toast WHERE relname = 'toast_test' AND storagemethod = 'e';
SELECT externalized=0 AS main_doesnt_externalize FROM pg_stat_toast WHERE relname = 'toast_test' AND storagemethod = 'm';
DROP TABLE toast_test;
SELECT count(*) FROM pg_stat_toast WHERE relname = 'toast_test';
