-- owners table
CREATE TABLE IF NOT EXISTS owners (
  id serial PRIMARY KEY NOT NULL UNIQUE
);

-- realties for owners table
CREATE TABLE IF NOT EXISTS realties (
  id serial PRIMARY KEY NOT NULL UNIQUE
);

-- ownerships facts for owners table
CREATE TABLE IF NOT EXISTS ownerships (
  fk_owner_id serial NOT NULL,
  FOREIGN KEY( fk_owner_id ) REFERENCES owners( id ),
  fk_realty_id serial NOT NULL,
  FOREIGN KEY( fk_realty_id ) REFERENCES realties( id )
);


-- brains of looking_at_the_moon table
CREATE TABLE IF NOT EXISTS brains (
  id serial PRIMARY KEY NOT NULL UNIQUE
);

-- looking_at_the_moon table
CREATE TABLE IF NOT EXISTS looking_at_the_moon (
  id serial PRIMARY KEY NOT NULL UNIQUE,
  fk_brain_id serial NOT NULL,
  FOREIGN KEY( fk_brain_id ) REFERENCES brains( id ),
  fk_owner_id serial,
  FOREIGN KEY( fk_owner_id ) REFERENCES owners( id )
);

-- states for impulses table
CREATE TABLE IF NOT EXISTS states (
  name varchar(20) PRIMARY KEY NOT NULL
);

-- impulses to characterize looking_at_the_moon table
CREATE TABLE IF NOT EXISTS impulses (
  id serial PRIMARY KEY NOT NULL,
  fk_looking_at_the_moon_id serial NOT NULL,
  FOREIGN KEY( fk_looking_at_the_moon_id ) REFERENCES looking_at_the_moon( id ),
  fk_state_name varchar(20) NOT NULL,
  FOREIGN KEY( fk_state_name ) REFERENCES states( name )
);

-- properties for impulses table
CREATE TABLE IF NOT EXISTS properties (
  fk_impulse_id serial NOT NULL,
  FOREIGN KEY( fk_impulse_id ) REFERENCES impulses( id ),
  name text NOT NULL
);

-- materials for monoliths
CREATE TABLE IF NOT EXISTS materials (
  name text PRIMARY KEY NOT NULL UNIQUE
);

-- monoliths table
CREATE TABLE IF NOT EXISTS monoliths (
  id serial PRIMARY KEY NOT NULL UNIQUE,
  fk_material_name text NOT NULL,
  FOREIGN KEY( fk_material_name ) REFERENCES materials( name )
);

-- dreams of monoliths and brains table
CREATE TABLE IF NOT EXISTS dreams (
  id serial PRIMARY KEY NOT NULL UNIQUE,
  fk_monolith_id serial,
  FOREIGN KEY( fk_monolith_id ) REFERENCES monoliths( id )
);

-- images of dreams table
CREATE TABLE IF NOT EXISTS images (
  id serial PRIMARY KEY NOT NULL UNIQUE,
  is_real boolean NOT NULL,
  fk_image_id serial,
  FOREIGN KEY( fk_image_id ) REFERENCES dreams( id )
);

-- aliens of realties table
-- not the Ridley Scott aliens uWu
CREATE TABLE IF NOT EXISTS aliens (
  id serial PRIMARY KEY NOT NULL UNIQUE,
  fk_realty_id serial NOT NULL,
  FOREIGN KEY( fk_realty_id ) REFERENCES realties( id ) 
);


-- expulsions of aliens from realties
CREATE TABLE IF NOT EXISTS expulsions (
  fk_impulse_id serial NOT NULL,
  FOREIGN KEY( fk_impulse_id ) REFERENCES impulses( id ),
  fk_realty_id serial NOT NULL,
  FOREIGN KEY( fk_realty_id ) REFERENCES realties( id )
);

-- births of dreams by brains
CREATE TABLE IF NOT EXISTS births (
  fk_brain_id serial NOT NULL,
  FOREIGN KEY( fk_brain_id ) REFERENCES brains( id ),
  fk_dream_id serial NOT NULL,
  FOREIGN KEY( fk_dream_id ) REFERENCES dreams( id ),
  probability double precision NOT NULL
);

-- phenomena of dreams by Looking at the Moon
CREATE TABLE IF NOT EXISTS phenomena (
  fk_looking_at_the_moon_id serial NOT NULL,
  FOREIGN KEY( fk_looking_at_the_moon_id ) REFERENCES looking_at_the_moon( id ),
  fk_dream_id serial NOT NULL,
  FOREIGN KEY( fk_dream_id ) REFERENCES dreams( id ),
  probability double precision NOT NULL
);

-- the probability values of both tables should give 1 in total

