BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "chefs" (
	"chef_id"	INTEGER,
	"name"	TEXT NOT NULL,
	"speciality"	TEXT NOT NULL,
	"contact"	TEXT,
	"email"	TEXT UNIQUE,
	"hired_at"	DATE NOT NULL,
	PRIMARY KEY("chef_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "dishes" (
	"dish_id"	INTEGER,
	"name"	TEXT NOT NULL,
	"description"	TEXT,
	"price"	REAL NOT NULL,
	"chef_id"	INTEGER,
	PRIMARY KEY("dish_id" AUTOINCREMENT),
	FOREIGN KEY("chef_id") REFERENCES "chefs"("chef_id")
);
CREATE TABLE IF NOT EXISTS "order_items" (
	"order_item_id"	INTEGER,
	"order_id"	INTEGER,
	"dish_id"	INTEGER,
	"quantity"	INTEGER NOT NULL,
	"price"	REAL NOT NULL,
	PRIMARY KEY("order_item_id" AUTOINCREMENT),
	FOREIGN KEY("dish_id") REFERENCES "dishes"("dish_id"),
	FOREIGN KEY("order_id") REFERENCES "orders"("order_id")
);
CREATE TABLE IF NOT EXISTS "orders" (
	"order_id"	INTEGER,
	"user_id"	INTEGER,
	"order_date"	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"total_amount"	REAL NOT NULL,
	"status"	TEXT NOT NULL CHECK("status" IN ('pending', 'completed', 'cancelled')),
	PRIMARY KEY("order_id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "users"("user_id")
);
CREATE TABLE IF NOT EXISTS "users" (
	"user_id"	INTEGER,
	"name"	TEXT NOT NULL,
	"email"	TEXT NOT NULL UNIQUE,
	"phone"	TEXT NOT NULL,
	"address"	TEXT NOT NULL,
	"password"	TEXT NOT NULL,
	"created_at"	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY("user_id" AUTOINCREMENT)
);
INSERT INTO "chefs" VALUES (1,'Chef Mario','Italian Cuisine','1122334455','mario@outlook.com','2023-01-15');
INSERT INTO "chefs" VALUES (2,'Chef Pierre','French Cuisine','9988776655','pierre@yahoo.com','2022-06-10');
INSERT INTO "dishes" VALUES (1,'Spaghetti Carbonara','Classic Italian pasta dish with creamy sauce and pancetta.',15.99,1);
INSERT INTO "dishes" VALUES (2,'Beef Bourguignon','French stew with tender beef and red wine sauce.',19.99,2);
INSERT INTO "dishes" VALUES (3,'Margherita Pizza','Simple pizza with fresh tomato sauce, mozzarella, and basil.',12.99,1);
INSERT INTO "dishes" VALUES (4,'Coq au Vin','French braised chicken in red wine sauce.',17.99,2);
INSERT INTO "order_items" VALUES (1,1,1,2,15.99);
INSERT INTO "order_items" VALUES (2,1,3,1,12.99);
INSERT INTO "order_items" VALUES (3,2,2,1,19.99);
INSERT INTO "order_items" VALUES (4,2,4,1,17.99);
INSERT INTO "orders" VALUES (1,1,'2024-11-29 18:57:59',35.97,'completed');
INSERT INTO "orders" VALUES (2,2,'2024-11-29 18:57:59',29.98,'pending');
INSERT INTO "users" VALUES (1,'Nada','Nada@outlook.com','1234567890','Jnoub','password123','2024-11-29 18:57:59');
INSERT INTO "users" VALUES (2,'Mohammad Hamadani','Mohammad@yahoo.com','9876543210','Beirut','securepass456','2024-11-29 18:57:59');
COMMIT;
