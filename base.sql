
-- owners table
CREATE TABLE IF NOT EXISTS owners (
  id SERIAL PRIMARY KEY NOT NULL
);

-- brains of looking_at_the_moon table
CREATE TABLE IF NOT EXISTS brains (
  id SERIAL PRIMARY KEY NOT NULL
);

-- looking_at_the_moon table
CREATE TABLE IF NOT EXISTS looking_at_the_moon (
  id SERIAL PRIMARY KEY NOT NULL,
  CONSTRAINT fk_brain_id
    FOREIGN KEY( id ) 
  REFERENCES brains( id ),
  CONSTRAINT fk_owner_id
    FOREIGN KEY( id )
  REFERENCES owners( id )
);

-- realties for owners table
CREATE TABLE IF NOT EXISTS ownerships (
  CONSTRAINT fk_owner_id
    FOREIGN KEY( id )
  REFERENCES owners( id ),
  CONSTRAINT fk_realty_id
    FOREIGN KEY( id )
  REFERENCES realties( id )
);

CREATE TABLE IF NOT EXISTS realties (
  id SERIAL PRIMARY KEY NOT NULL
);