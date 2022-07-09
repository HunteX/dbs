CREATE TABLE prod.order_status
(
    id    INT GENERATED ALWAYS AS IDENTITY,
    value VARCHAR(32) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE prod.manufacturer
(
    id      INT GENERATED ALWAYS AS IDENTITY,
    name    VARCHAR(128) NOT NULL,
    phone   BIGINT       NOT NULL,
    address VARCHAR(128) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE prod.supplier
(
    id    INT GENERATED ALWAYS AS IDENTITY,
    name  VARCHAR(128) NOT NULL,
    phone BIGINT       NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE prod.customer_address
(
    id        INT GENERATED ALWAYS AS IDENTITY,
    postIndex VARCHAR(8)   NOT NULL,
    country   VARCHAR(128) NOT NULL,
    region    VARCHAR(128),
    city      VARCHAR(128),
    street    VARCHAR(128) NOT NULL,
    building  VARCHAR(16)  NOT NULL,
    apartment VARCHAR(8),
    PRIMARY KEY (id)
);

CREATE TABLE prod.product_category
(
    id   INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(128) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE prod.customer
(
    id         INT GENERATED ALWAYS AS IDENTITY,
    firstname  VARCHAR(128),
    secondname VARCHAR(128),
    middlename VARCHAR(128),
    phone      BIGINT       NOT NULL,
    email      VARCHAR(128) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE prod.customer__customer_address
(
    id                  INT GENERATED ALWAYS AS IDENTITY,
    customer_id         INT NOT NULL,
    customer_address_id INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES prod.customer (id),
    CONSTRAINT fk_customer_address FOREIGN KEY (customer_address_id) REFERENCES prod.customer_address (id)
);

CREATE TABLE prod.product
(
    id              INT GENERATED ALWAYS AS IDENTITY,
    name            VARCHAR(128)  NOT NULL,
    supplier_id     INT           NOT NULL,
    manufacturer_id INT           NOT NULL,
    isinstock       BIT           NOT NULL,
    description     VARCHAR(2048) NOT NULL,
    photoUrl        VARCHAR(512)  NOT NULL,
    code            VARCHAR(10)   NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_supplier FOREIGN KEY (supplier_id) REFERENCES prod.supplier (id),
    CONSTRAINT fk_manufacturer FOREIGN KEY (manufacturer_id) REFERENCES prod.manufacturer (id)
);

CREATE TABLE prod.product__product_category
(
    id          INT GENERATED ALWAYS AS IDENTITY,
    product_id  INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES prod.product (id),
    CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES prod.product_category (id)
);

CREATE TABLE prod.order
(
    id              INT GENERATED ALWAYS AS IDENTITY,
    created         TIMESTAMP     NOT NULL,
    order_status_id INT           NOT NULL,
    customer_id     INT           NOT NULL,
    address         VARCHAR(1024) NOT NULL,
    finished        TIMESTAMP,
    comment         VARCHAR(256),
    PRIMARY KEY (id),
    CONSTRAINT fk_order_status FOREIGN KEY (order_status_id) REFERENCES prod.order_status (id),
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES prod.customer (id)
);

CREATE TABLE prod.order_item
(
    id         INT GENERATED ALWAYS AS IDENTITY,
    quantity   INT   NOT NULL,
    order_id   INT   NOT NULL,
    product_id INT   NOT NULL,
    price      MONEY NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES prod.order (id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES prod.product (id)
);

CREATE TABLE prod.price
(
    id         INT GENERATED ALWAYS AS IDENTITY,
    value      MONEY NOT NULL,
    product_id INT   NOT NULL,
    discount   MONEY NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES prod.product (id)
);