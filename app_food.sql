-- TẠO DATABASE
CREATE DATABASE app_food

-- TABLE user
CREATE TABLE `user`(
	user_id INT PRIMARY KEY AUTO_INCREMENT,
	
	full_name VARCHAR(255),
	email VARCHAR(255),
	password VARCHAR(255)
)

-- TABLE food_type
CREATE TABLE food_type(
	type_id INT PRIMARY KEY AUTO_INCREMENT,
	
	type_name VARCHAR(255)
)

-- TABLE food
CREATE TABLE food (
	food_id INT PRIMARY KEY AUTO_INCREMENT,
	
	food_name VARCHAR(255),
	image VARCHAR (255),
	price FLOAT,
	`desc` VARCHAR(255),
	type_id INT,
	
	FOREIGN KEY(type_id) REFERENCES food_type(type_id)
)

-- TABLE order
CREATE TABLE `order`(
	order_id INT PRIMARY KEY AUTO_INCREMENT,
	
	user_id INT,
	food_id INT,
	amount INT,
	code VARCHAR(255),
	arr_sub_id VARCHAR(255),
	
	FOREIGN KEY(user_id) REFERENCES `user`(user_id),
	FOREIGN KEY(food_id) REFERENCES food(food_id)
)

-- TABLE sub_food
CREATE TABLE sub_food(
	sub_id INT PRIMARY KEY AUTO_INCREMENT,
	
	sub_name VARCHAR(255),
	sub_price FLOAT,
	food_id INT,
	
	FOREIGN KEY(food_id) REFERENCES food(food_id)
)

-- TABLE restaurant
CREATE TABLE restaurant(
	res_id INT PRIMARY KEY AUTO_INCREMENT,
	
	res_name VARCHAR(255),
	image VARCHAR(255),
	`desc` VARCHAR(255)
)

-- TABLE rate_res
CREATE TABLE rate_res(
	rate_res_id INT PRIMARY KEY AUTO_INCREMENT,
	
	user_id INT,
	res_id INT,
	amount INT,
	date_rate DATETIME,
	
	FOREIGN KEY(user_id) REFERENCES `user`(user_id),
	FOREIGN KEY(res_id) REFERENCES restaurant(res_id)
)

-- TABLE like_res
CREATE TABLE like_res(
	like_res_id INT PRIMARY KEY AUTO_INCREMENT,
	user_id INT,
	res_id INT,
	date_like DATETIME,
	
	FOREIGN KEY(user_id) REFERENCES `user`(user_id),
	FOREIGN KEY(res_id) REFERENCES restaurant(res_id)
)

-- Data user
INSERT INTO `user` (full_name, email, password) VALUES 
					('Nguyen Le Minh Thanh','thanh@gmail.com','1234'),
					('Vu Minh Dat','dat@gmail.com','1234'),
					('Le Thai Trung Tin','tin@gmail.com','1234'),
					('Dang Viet Minh Man','man@gmail.com','1234'),
					('Son Thi Ai Nhu','nhu@gmail.com','1234'),
					('Nguyen Hoang Long','long@gmail.com','1234'),
					('Nguyen Phuong Uyen','uyen@gmail.com','1234')
SELECT * FROM `user`

-- Data food
INSERT INTO food (food_name, image, price, `desc`) VALUES
					('Gỏi cuốn','image gỏi cuốn',7000,'gỏi cuốn tôm thịt'),
					('Gỏi khô bò','image gỏi khô bò',40000,'Gỏi khô bò'),
					('Gỏi ngó sen','image gỏi ngó sen',50000,'Gỏi ngó sen'),
					('Nem nướng','image nem nướng',50000,'Nem nướng nha trang'),
					('Bánh canh','image bánh canh',35000,'Bánh canh bánh gạo')
SELECT * FROM food

-- Data order
INSERT INTO `order`(user_id, food_id, amount, code, arr_sub_id) VALUES
					(1, 2, 5, 'BC', 1),
					(2, 4, 2, 'GKB', 1),
					(3, 3, 5, 'GC', 1),
					(2, 2, 2, 'BC', 1),
					(2, 1, 3, 'NN', 1),
					(4, 2, 2, 'BC', 1),
					(4, 5, 1, 'GNS', 1)
SELECT * FROM `order`


-- Data restaurant
INSERT INTO restaurant(res_name, image, `desc`) VALUES
						('Nhà hàng NEW','image nhà hàng NEW','Nhà hàng mới'),
						('Nhà hàng OLD','image nhà hàng OLD','Nhà hàng cũ'),
						('Nhà hàng bình dân','image nhà hàng bình dân','Nhà hàng bình dân'),
						('Nhà hàng michelin','image nhà hàng michelin','Nhà hàng michelin'),
						('Nhà hàng Nhật','image nhà hàng Nhật','Nhà hàng Nhật')
SELECT * FROM restaurant

-- Data rate_res
INSERT INTO rate_res(user_id, res_id, amount, date_rate) VALUES
					(1, 1, 4, '2024-12-07'),
					(2, 2, 4, '2024-12-07'),
					(1, 2, 2, '2024-12-07'),
					(2, 2, 3, '2024-12-07'),
					(3, 3, 1, '2024-12-07'),
					(2, 4, 4, '2024-12-07'),
					(5, 5, 4, '2024-12-07'),
					(5, 5, 4, '2024-12-07'),
					(5, 1, 2, '2024-12-07'),
					(3, 2, 3, '2024-12-07'),
					(3, 2, 1, '2024-12-07'),
					(3, 3, 4, '2024-12-07')
SELECT * FROM rate_res


-- Data like_res
INSERT INTO like_res(user_id, res_id, date_like) VALUES
					(1, 1, '2024-12-07'),
					(1, 1, '2024-12-07'),
					(2, 3, '2024-12-07'),
					(2, 3, '2024-12-07'),
					(3, 3, '2024-12-07'),
					(4, 3, '2024-12-07'),
					(4, 3, '2024-12-07'),
					(1, 2, '2024-12-07'),
					(2, 2, '2024-12-07'),
					(5, 2, '2024-12-07'),
					(6, 4, '2024-12-07')
SELECT * FROM like_res

-- Tìm 5 người đã like nhà hàng nhiều nhất
-- SELECT * FROM like_res
SELECT COUNT(like_res.user_id) AS 'Tổng số lượt like của người dùng' ,`user`.user_id, `user`.full_name,`user`.email,`user`.password FROM like_res
INNER JOIN `user` ON like_res.user_id = `user`.user_id
GROUP BY like_res.user_id
ORDER BY `Tổng số lượt like của người dùng` DESC
LIMIT 5

-- Tìm 2 nhà hàng có lượt like nhiều nhất
-- SELECT * FROM rate_res
SELECT COUNT(rate_res.res_id) AS 'Số lượng like của nhà hàng', restaurant.res_id, restaurant.res_name, restaurant.image, restaurant.`desc` FROM rate_res
INNER JOIN restaurant ON rate_res.res_id = restaurant.res_id
GROUP BY rate_res.res_id
ORDER BY `Số lượng like của nhà hàng` DESC
LIMIT 2

--Tìm người đã đặt hàng nhiều nhất.
-- SELECT * FROM `order`
SELECT COUNT(`order`.user_id) AS 'Số lượng đặt hàng của người dùng', `user`.user_id, `user`.full_name, `user`.email, `user`.`password` FROM `order`
INNER JOIN `user` ON `user`.user_id = `order`.user_id
GROUP BY `order`.user_id
ORDER BY `Số lượng đặt hàng của người dùng` DESC
LIMIT 1

-- Tìm người dùng không hoạt động trong hệ thống (không đặt hàng, không like, không đánh giá nhà hàng).
-- SELECT * FROM `user`
SELECT `user`.user_id, `user`.full_name, `user`.email, `user`.`password` FROM `user`
LEFT JOIN `order` ON `order`.user_id = `user`.user_id 
LEFT JOIN like_res ON like_res.user_id = `user`.user_id 
LEFT JOIN rate_res ON rate_res.user_id = `user`.user_id 

WHERE `order`.order_id IS NULL AND like_res.like_res_id IS NULL AND rate_res.rate_res_id IS NULL










