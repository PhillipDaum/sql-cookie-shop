-- CREATING DATABASE TABLES
-- In stock items
CREATE TABLE inventory (
	sku VARCHAR PRIMARY KEY, 
  	title VARCHAR,
  	cost MONEY,
  	in_stock_quantity INT,
	description VARCHAR,
  	info VARCHAR,
  	image VARCHAR
);

INSERT INTO inventory (sku, title, cost, in_stock_quantity, description, info, image)
VALUES 
	('002', 'Poppy Seeds Bites', 2.00, 124, 'A tasty cookie with little dots', 'cookie string cookie', 'a922d20'),
    ('006', 'Chocolate Chips', 2.00, 14, 'Lots of peoples favorite cookie', 'contains nuts sometimes', '2d30e09'),
    ('009', 'Nuts & Caramel Bites', 2.00, 45, 'Ooey, Gooey, nuty, and chewy', 'contains nuts', '23d0883');

-- Images of the cookies, maybe more images or all website images later  
 CREATE TABLE images (
 	id VARCHAR PRIMARY KEY,
   	url VARCHAR
 );
 
 INSERT INTO images (id, url)
 VALUES 
 	('a922d20', 'https://static.wixstatic.com/media/f61af8_c622ee508f0e4b12ad92bce8daf7d5d3~mv2.png/v1/fill/w_500,h_500,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/f61af8_c622ee508f0e4b12ad92bce8daf7d5d3~mv2.png'),
    ('2d30e09', 'https://static.wixstatic.com/media/f61af8_5d1d2a6ef4e54f2abe7983d46c920090~mv2_d_4600_4600_s_4_2.jpg/v1/fill/w_774,h_774,al_c,q_85,usm_0.66_1.00_0.01/f61af8_5d1d2a6ef4e54f2abe7983d46c920090~mv2_d_4600_4600_s_4_2.jpg'),
    ('23d0883', 'https://static.wixstatic.com/media/f61af8_353b9c005467422b80eefb54a30d80d4~mv2.png/v1/fill/w_500,h_500,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/f61af8_353b9c005467422b80eefb54a30d80d4~mv2.png');

-- Users
CREATE TABLE users (
    id VARCHAR PRIMARY KEY,
    full_name VARCHAR,
    date_joined DATE,
    phone VARCHAR,
    email VARCHAR,
    address_line_1 VARCHAR,
    address_line_2 VARCHAR,
    city VARCHAR,
    state VARCHAR,
    zip VARCHAR
);

INSERT INTO users (id, full_name, date_joined, phone, email, address_line_1, address_line_2, city, state, zip)
VALUES
    ('14ed063c', 'Phil Philliam', '2024-12-10', '(555) 555-5555', 'phil@philli.am', '1 Unit Ave', 'APT 0', 'Petoria', 'PA', '00001'),
    ('5c9jh352', 'Bob Barker', '2024-12-16', '(555) 126-4685', 'bob@priceisright.com', '245 Price Dr', NULL, 'Hollywood', 'CA', '90210'),
    ('9d28a71', 'Nancy Nancia', '2024-11-17', '(555) 523-3765', 'nancy@monopoly.game', '345 Park Place', 'APT 20', 'New York', 'NY', '20468');

-- Carts
CREATE TABLE carts (
    id VARCHAR PRIMARY KEY,
    user_id VARCHAR,
    sku VARCHAR,
    quantity INT
);

INSERT INTO carts (id, user_id, sku, quantity)
VALUES
    ('12412', '5c9jh352', '002', 3),
    ('14263', '5c9jh352', '006', 12),
    ('14325', '5c9jh352', '009', 1);
    

-- MODIFYING
-- Changing price and SKU instead of name so something shows in in the queries later
UPDATE inventory
SET sku = '001', cost = 10.00
WHERE sku = '002'; 

DELETE FROM users
WHERE id = '14ed063c';

-- adding dates to the orders in cart so something shows up in the query 
ALTER TABLE carts
ADD date DATE;

UPDATE carts
SET date = '2024-12-24' 
WHERE id = '12412' OR id = '14263';

UPDATE carts
SET date = '2025-2-11'
WHERE id = '14325';

-- adding order id to carts so I can query specific orders
ALTER TABLE carts
ADD order_id VARCHAR;

UPDATE carts
SET order_id = '001'
WHERE id = '12412' OR id = '14263';

UPDATE carts
set order_id = '002'
WHERE id = '14325';

-- adding price to the carts table
ALTER TABLE carts
ADD price_at_purchase MONEY;

UPDATE carts
SET price_at_purchase = 2.00;



-- QUERIES
SELECT * FROM inventory
WHERE in_stock_quantity > 10;

SELECT * FROM inventory
WHERE cost::NUMERIC > 5.00;

SELECT * FROM carts
WHERE date > '2025-1-1';

SELECT order_id
FROM carts
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT order_id FROM carts
WHERE sku = '001';

SELECT sku, SUM(quantity)
FROM carts
GROUP BY sku;

SELECT order_id, SUM(quantity)
FROM carts
GROUP BY order_id;

SELECT order_id, SUM(quantity * price_at_purchase) AS total_cost
FROM carts
GROUP BY order_id
ORDER BY total_cost DESC
LIMIT 1;