SELECT
 cl.courseid,
 COUNT(cl.tuid)
FROM
 et_class cl
WHERE
 cl.status=1
GROUP BY
 cl.courseid