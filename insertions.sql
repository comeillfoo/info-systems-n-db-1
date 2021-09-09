-- owners table
INSERT INTO owners ( id ) VALUES ( DEFAULT );

-- realties for owners table
INSERT INTO realties ( id ) VALUES ( DEFAULT );

-- ownerships facts for owners table
CREATE TABLE IF NOT EXISTS ownerships (
  fk_owner_id serial NOT NULL,
  FOREIGN KEY( fk_owner_id ) REFERENCES owners( id ),
  fk_realty_id serial NOT NULL,
  FOREIGN KEY( fk_realty_id ) REFERENCES realties( id )
);


-- brains of looking_at_the_moon table
INSERT INTO brains ( id ) VALUES ( DEFAULT );

-- looking_at_the_moon table
INSERT INTO looking_at_the_moon ( id, fk_brain_id, fk_owner_id ) VALUES ( DEFAULT, SELECT max( id ) FROM brains, SELECT max( id ) FROM owners );

-- states for impulses table
INSERT INTO states ( name )
  VALUES
    ( 'усыплен'              ),
    ( 'совершенно усыплен'   ),
    ( 'пробужден'            ),
    ( 'совершенно пробужден' );

-- impulses to characterize looking_at_the_moon table
INSERT INTO impulses ( id, fk_looking_at_the_moon_id, fk_state_name ) VALUES ( SELECT max( id ) FROM looking_at_the_moon, SELECT name FROM states WHERE name LIKE 'совершенно усыплен' );

-- properties for impulses table
INSERT INTO properties ( fk_impulse_id, name )
  VALUES
    ( SELECT max( id ) FROM impulses, 'привычный'   ),
    ( SELECT max( id ) FROM impulses, 'интуитивный' );

-- materials for monoliths
INSERT INTO materials ( name )
  VALUES
    ( 'кристаллический' ),
    ( 'аморфный'        );

-- monoliths table
INSERT INTO monoliths ( id, fk_material_name ) VALUES ( DEFAULT, SELECT name FROM materials WHERE name LIKE 'кристаллический' );

-- dreams of monoliths and brains table
INSERT INTO dreams ( id, fk_monolith_id ) VALUES ( DEFAULT, SELECT max( id ) FROM monoliths );

-- images of dreams table
INSERT INTO images ( id, is_real, fk_dream_id )
  VALUES
    ( DEFAULT, true, SELECT max( id ) FROM dreams ),
    ( DEFAULT, true, SELECT max( id ) FROM dreams );

-- aliens of realties table
-- not the Ridley Scott aliens uWu
INSERT INTO aliens ( id, fk_realty_id )
  VALUES
    ( DEFAULT, SELECT max( id ) FROM realties ),
    ( DEFAULT, SELECT max( id ) FROM realties );


-- expulsions of aliens from realties
CREATE TABLE IF NOT EXISTS expulsions (
  fk_impulse_id serial NOT NULL,
  FOREIGN KEY( fk_impulse_id ) REFERENCES impulses( id ),
  fk_realty_id serial NOT NULL,
  FOREIGN KEY( fk_realty_id ) REFERENCES realties( id )
);

INSERT INTO expulsions ( fk_impulse_id, fk_realty_id, is_success )
  VALUES (
    SELECT max( id ) FROM impulses,
    SELECT max( id ) FROM realties,
    CASE SELECT fk_state_name FROM impulses WHERE id = ( SELECT max( id ) FROM impulses )
      WHEN LIKE '%пробужден'
      THEN true 
      ELSE false 
    END
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