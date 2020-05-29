DROP TABLE inventory;
DROP TABLE players;

CREATE TABLE players(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  race VARCHAR(255),
  class VARCHAR(255),
  health INT,
  inventory_id INT REFERENCES inventory(id)
);

CREATE TABLE inventory(
  id SERIAL PRIMARY KEY,
  potions VARCHAR(255),
  weapon VARCHAR(255),
  armour VARCHAR(255)
);
