DROP TABLE players;
DROP TABLE inventory;

CREATE TABLE inventory(
  id SERIAL PRIMARY KEY,
  potions VARCHAR(255),
  weapon VARCHAR(255),
  armour VARCHAR(255)
);

CREATE TABLE players(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  race VARCHAR(255),
  class VARCHAR(255),
  health INT,
  inventory_id INT REFERENCES inventory(id)
);
