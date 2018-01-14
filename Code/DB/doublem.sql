CREATE TABLE manager_account (
    manager_id INTEGER NOT NULL AUTO_INCREMENT,
    username VARCHAR(30) NOT NULL,
    password VARCHAR(30) NOT NULL,
    salt VARCHAR(15) NOT NULL,
    PRIMARY KEY (`manager_id`)
)  ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=LATIN1;

CREATE TABLE category (
    category_id INTEGER NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(30) NOT NULL,
	description VARCHAR(255),
    PRIMARY KEY (`category_id`)
)  ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=LATIN1;

CREATE TABLE product (
    product_id BIGINT NOT NULL AUTO_INCREMENT,
    category_id INTEGER NOT NULL,
    product_name VARCHAR(50) NOT NULL,
    description VARCHAR(2000),
    featured_product BOOLEAN,
    company_name VARCHAR(35),
    buy_price DOUBLE NOT NULL,
    sell_price DOUBLE NOT NULL,
    packaging BOOLEAN,
    video_link VARCHAR(100),
    treshold_max INTEGER,
    treshold_min INTEGER,
    weight DOUBLE,
    dimension VARCHAR(24),
    logistic_price DOUBLE NOT NULL,
    featured_product_date TIMESTAMP,
    created_date DATE,
    updated_date DATE,
    tarif DOUBLE NOT NULL,
    over_stock_days INTEGER,
    percentage_deal DOUBLE NOT NULL,
    season_reup_alert_days INTEGER,
    season_reup_alert_date DATE,
    tags VARCHAR(1000),
    PRIMARY KEY (`product_id`),
    CONSTRAINT product_fk_category FOREIGN KEY (category_id)
        REFERENCES category (category_id)
)  ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=LATIN1; 

CREATE TABLE address (
    address_id BIGINT NOT NULL AUTO_INCREMENT,
    street VARCHAR(150) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(40) NOT NULL,
    zip_code VARCHAR(40),
    country VARCHAR(40) NOT NULL,
    phone_number VARCHAR(40),
    PRIMARY KEY (`address_id`)
)  ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=LATIN1; 

CREATE TABLE users (
    user_id BIGINT NOT NULL AUTO_INCREMENT,
    address_id BIGINT NOT NULL,
    created_date DATE NOT NULL,
    updated_date DATE NOT NULL,
    company_name VARCHAR(100),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    password VARCHAR(50) NOT NULL,
    salt VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    PRIMARY KEY (`user_id`),
    CONSTRAINT user_fk_address FOREIGN KEY (address_id)
        REFERENCES address (address_id)
)  ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=LATIN1; 

/*
salt needed for encrypting discount_code
*/
CREATE TABLE orders (
    order_id BIGINT NOT NULL AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    sell_date DATE NOT NULL,
    sell_price DOUBLE NOT NULL,
    receive_date DATE,
    discount_code VARCHAR(30),
    salt VARCHAR(15),
    order_open BOOLEAN,
    order_cancel BOOLEAN,
    order_return BOOLEAN,
    PRIMARY KEY (`order_id`),
    CONSTRAINT order_fk_user FOREIGN KEY (user_id)
        REFERENCES users (user_id)
)  ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=LATIN1;

CREATE TABLE re_stock_order (
    tracking_number VARCHAR(100) NOT NULL,
    description VARCHAR(200),
    order_date DATE,
    arrive_date DATE,
    PRIMARY KEY (`tracking_number`)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE re_stock_item (
    restock_id BIGINT NOT NULL AUTO_INCREMENT,
    product_id BIGINT NOT NULL,
    tracking_number VARCHAR(100) NOT NULL,
	description VARCHAR(512) NOT NULL,
	username VARCHAR(30) NOT NULL,
    quantity_ordered INTEGER NOT NULL,
    deficient_quantity INTEGER,
    PRIMARY KEY (`restock_id`),
    CONSTRAINT stock_fk_product FOREIGN KEY (product_id)
        REFERENCES product (product_id),
    CONSTRAINT stock_fk_tracking FOREIGN KEY (tracking_number)
        REFERENCES re_stock_order (tracking_number)
)  ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=LATIN1;

CREATE TABLE inventory (
    serial_number VARCHAR(100) NOT NULL,
	product_id BIGINT NOT NULL,
    restock_id BIGINT NOT NULL,
    entry_date DATE NOT NULL,
    exit_date DATE,
    shipped_date DATE,
    receive_date DATE,
    deficient_date DATE,
    return_date DATE,
    warehouse_row VARCHAR(10),
    warehouse_column VARCHAR(10),
    available BOOLEAN NOT NULL,
    PRIMARY KEY (`serial_number`),
    CONSTRAINT inventory_fk_restock FOREIGN KEY (restock_id)
        REFERENCES re_stock_item (restock_id),
    CONSTRAINT inventory_fk_product FOREIGN KEY (product_id)
        REFERENCES product (product_id)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE product_order (
    serial_number VARCHAR(100) NOT NULL,
    order_id BIGINT NOT NULL,
    sell_quantity INTEGER NOT NULL,
    sell_price DOUBLE NOT NULL,
    CONSTRAINT order_fk_product FOREIGN KEY (serial_number)
        REFERENCES inventory (serial_number),
    CONSTRAINT order_fk_order FOREIGN KEY (order_id)
        REFERENCES orders (order_id)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE warehouse (
    warehouse_id BIGINT NOT NULL AUTO_INCREMENT,
    warehouse_name VARCHAR(50) NOT NULL,
    street VARCHAR(150) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(40) NOT NULL,
    zip_code VARCHAR(40),
    country VARCHAR(40) NOT NULL,
    phone_number VARCHAR(40),
    PRIMARY KEY (`warehouse_id`)
)  ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=LATIN1;

CREATE TABLE warehouse_inventory (
    warehouse_id BIGINT NOT NULL,
    serial_number VARCHAR(100) NOT NULL,
    CONSTRAINT inventory_fk_warehouse FOREIGN KEY (warehouse_id)
        REFERENCES warehouse (warehouse_id),
    CONSTRAINT inventory_fk_serialn FOREIGN KEY (serial_number)
        REFERENCES inventory (serial_number)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE administrator (
    admin_id BIGINT NOT NULL AUTO_INCREMENT,
    warehouse_id BIGINT NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    street VARCHAR(150) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(40) NOT NULL,
    zip_code VARCHAR(40),
    country VARCHAR(40) NOT NULL,
    phone_number VARCHAR(40),
    email VARCHAR(100) NOT NULL ,
    password VARCHAR(30) NOT NULL,
    permissions VARCHAR(256) NOT NULL,
    salt VARCHAR(15) NOT NULL,
    PRIMARY KEY (`admin_id`),
    CONSTRAINT admin_fk_warehouse FOREIGN KEY (warehouse_id)
        REFERENCES warehouse (warehouse_id)
)  ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=LATIN1;

CREATE TABLE email_alert (
    alert_id BIGINT NOT NULL AUTO_INCREMENT,
    type_id VARCHAR(50) NOT NULL,
    alert_name VARCHAR(50) NOT NULL,
    property_id BIGINT NOT NULL,
    description VARCHAR(256) NOT NULL,
    created_date DATE NOT NULL,
    PRIMARY KEY (`alert_id`)
)  ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=LATIN1;

CREATE TABLE review (
    review_id BIGINT NOT NULL AUTO_INCREMENT,
    product_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    description BLOB,
    stars INTEGER NOT NULL,
    review_date DATE NOT NULL,
    PRIMARY KEY (`review_id`),
    CONSTRAINT review_fk_product FOREIGN KEY (product_id)
        REFERENCES product (product_id),
    CONSTRAINT review_fk_user FOREIGN KEY (user_id)
        REFERENCES users (user_id)
)  ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=LATIN1;

CREATE TABLE deal (
    deal_id BIGINT NOT NULL AUTO_INCREMENT,
    category_id INTEGER,
    product_id BIGINT,
	deal_name VARCHAR(50) NOT NULL,
	start_date	DATE NOT NULL,
	end_date	DATE NOT NULL,
    PRIMARY KEY (`deal_id`),
    FOREIGN KEY (category_id)
        REFERENCES category (category_id),
    FOREIGN KEY (product_id)
        REFERENCES product (product_id)
)  ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=LATIN1;

/*
Need salt for encrypting discount_code
*/
CREATE TABLE discount_code (
    discount_id BIGINT NOT NULL AUTO_INCREMENT,
    category_id INTEGER NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    discount_name VARCHAR(30) NOT NULL,
    discount_code VARCHAR(30) NOT NULL,
    salt VARCHAR(15) NOT NULL,
    PRIMARY KEY (`discount_id`),
    CONSTRAINT discount_fk_category FOREIGN KEY (category_id)
        REFERENCES category (category_id)
)  ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=LATIN1;

CREATE TABLE affiliated_company (
    company_id BIGINT NOT NULL AUTO_INCREMENT,
    discount_id BIGINT,
    start_affiliated_date DATE NOT NULL,
    end_affiliated_date DATE,
    company_name VARCHAR(30) NOT NULL,
    street VARCHAR(150) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(40) NOT NULL,
    zip_code VARCHAR(40),
    country VARCHAR(40) NOT NULL,
    phone_number VARCHAR(40),
    company_email VARCHAR(100) NOT NULL,
    PRIMARY KEY (`company_id`),
    CONSTRAINT affcompany_fk_discount FOREIGN KEY (discount_id)
        REFERENCES discount_code (discount_id)
)  ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=LATIN1;

CREATE TABLE image (
    image_id BIGINT NOT NULL AUTO_INCREMENT,
    product_id BIGINT NOT NULL,
    image_name VARCHAR(30) NOT NULL,
    url VARCHAR(256) NOT NULL,
    PRIMARY KEY (`image_id`),
    FOREIGN KEY (product_id)
        REFERENCES product (product_id)
)  ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=LATIN1;

