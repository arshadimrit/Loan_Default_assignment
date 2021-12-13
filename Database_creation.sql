# Enable Local Loading
SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 'ON';
SHOW GLOBAL VARIABLES LIKE 'local_infile';

# Create Database
DROP DATABASE bank_1999;
CREATE DATABASE bank_1999;
USE bank_1999;

# Now we need to create and load the tables now

# account Table
CREATE TABLE account_t(
	account_id INT,
    district_id INT,
    `date` DATE,
    frequency VARCHAR(20)
);

LOAD DATA LOCAL
INFILE '~/Desktop/Data_science/Datasets/WeCloudData_Client_Project_only_assessment/data/account.asc'
INTO TABLE account_t
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(account_id, district_id, frequency, @c4)
SET `date` = STR_TO_DATE(@c4, '%y%m%d');
 
# client Table
CREATE TABLE client_t(
	client_id INT,
    gender VARCHAR(10),
	birth_date DATE,
	district_id INT
);

LOAD DATA LOCAL
INFILE '~/Desktop/Data_science/Datasets/WeCloudData_Client_Project_only_assessment/data/client.asc'
INTO TABLE client_t
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(client_id, @c2, district_id)
SET gender = if(SUBSTR(@c2, 3, 2) > 50, 'female', 'male'),
birth_date = if(SUBSTR(@c2, 3, 2) > 50, 
	CONCAT_WS('-', CONCAT('19', SUBSTR(@c2, 1, 2)), SUBSTR(@c2, 3, 2) - 50, SUBSTR(@c2, 5, 2)),
	STR_TO_DATE(CONCAT('19', @c2), '%Y%m%d'));

# disposition Table
CREATE TABLE disposition_t(
	disp_id INT,
	client_id INT,
	account_id INT,
	type VARCHAR(20)
);

LOAD DATA LOCAL
INFILE '~/Desktop/Data_science/Datasets/WeCloudData_Client_Project_only_assessment/data/disp.asc'
INTO TABLE disposition_t
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

# permanent order Table
CREATE TABLE perm_order_t(
	order_id INT,
	account_id INT,
	bank_to VARCHAR(5),
	account_to INT,
	amount DECIMAL(20, 2),
	k_symbol VARCHAR(20)
);

LOAD DATA LOCAL
INFILE '~/Desktop/Data_science/Datasets/WeCloudData_Client_Project_only_assessment/data/order.asc'
INTO TABLE perm_order_t
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

# transaction Table
CREATE TABLE transaction_t(
	trans_id INT,
	account_id INT,
	`date` DATE,
	type VARCHAR(20),
	operation VARCHAR(20),
	amount INT,
	balance INT,
	k_symbol VARCHAR(20),
	bank VARCHAR(20),
	account INT
);

LOAD DATA LOCAL
INFILE '~/Desktop/Data_science/Datasets/WeCloudData_Client_Project_only_assessment/data/trans.asc'
INTO TABLE transaction_t
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(trans_id, account_id, @c3, type, operation, amount, balance, k_symbol, bank, account)
SET `date` = STR_TO_DATE(@c3, '%y%m%d');

# loan Table
CREATE TABLE loan_t(
	loan_id INT,
	account_id INT,
	`date` DATE,
	amount INT,
	duration INT,
	payments DECIMAL(20, 2),
	status VARCHAR(10)
);

LOAD DATA LOCAL
INFILE '~/Desktop/Data_science/Datasets/WeCloudData_Client_Project_only_assessment/data/loan.asc'
INTO TABLE loan_t
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

# credit card Table
CREATE TABLE card_t(
	card_id INT,
	disp_id INT,
	type VARCHAR(20),
	issued DATE
);

LOAD DATA LOCAL
INFILE '~/Desktop/Data_science/Datasets/WeCloudData_Client_Project_only_assessment/data/card.asc'
INTO TABLE card_t
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(card_id, disp_id, type, @c4)
SET issued = STR_TO_DATE(@c4, '%y%m%d %H:%i:%s');

# demographic Table
CREATE TABLE demographic_t(
	district_id INT,
	A2 VARCHAR(20),
	A3 VARCHAR(20),
	A4 INT,
	A5 INT,
	A6 INT,
	A7 INT,
	A8 INT,
	A9 INT,
	A10 DECIMAL(10, 1),
	A11 INT,
	A12 DECIMAL(2, 2),
	A13 DECIMAL(2, 2),
	A14 INT,
	A15 INT,
	A16 INT
);

LOAD DATA LOCAL
INFILE '~/Desktop/Data_science/Datasets/WeCloudData_Client_Project_only_assessment/data/district.asc'
INTO TABLE demographic_t
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
