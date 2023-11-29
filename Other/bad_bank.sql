DROP DATABASE IF EXISTS bad_bank;
CREATE DATABASE bad_bank;
USE bad_bank;

CREATE TABLE users (
    user_id         INT AUTO_INCREMENT,
    user_name       VARCHAR(32),
    user_balance    DECIMAL(16,3), -- checked on insert, update
    PRIMARY KEY (user_id)
);

INSERT INTO users(user_name, user_balance)
    VALUES('Ben Link', 0.000),
          ('John Lennon', 3000.500),
          ('Tom Scott', 10.000);

SOURCE transfer_money.sql;
SOURCE ensure_non_negative.sql;

SELECT * FROM users;

CALL transferMoney(3, 1, 20.000);

SELECT * FROM users;

