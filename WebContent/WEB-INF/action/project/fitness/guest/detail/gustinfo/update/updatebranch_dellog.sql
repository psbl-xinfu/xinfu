INSERT INTO cc_branch_dellog(id,name,InputTime,age)
VALUES('1','postgre','2018-01-10 22:00:00',24)
ON conflict(id) 
DO UPDATE SET name = 'postgreOk', InputTime ='2018-02-22 12:00:00