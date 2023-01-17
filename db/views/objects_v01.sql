SELECT  users.id as id,
        users.created_at as created_at,
        users.updated_at as updated_at,
        users.full_name as name,
        null as address,
        null as user_id,
        'User' AS class_type
  FROM users

UNION

SELECT  houses.id as id,
        houses.created_at as created_at,
        houses.updated_at as updated_at,
        houses.name as name,
        houses.address as address,
        houses.user_id as user_id,
        'House' AS class_type
  FROM houses
