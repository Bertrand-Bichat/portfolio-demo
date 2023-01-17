SELECT  users.id as id,
        users.created_at as created_at,
        users.updated_at as updated_at,
        null as user_id,
        'User' AS class_type
  FROM users

UNION

SELECT  houses.id as id,
        houses.created_at as created_at,
        houses.updated_at as updated_at,
        houses.user_id as user_id,
        'House' AS class_type
  FROM houses
