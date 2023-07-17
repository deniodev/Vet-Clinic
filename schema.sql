/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id INT GENERATED BY DEFAULT AS IDENTITY,
  name VARCHAR(50),
  date_of_birth DATE,
  escape_attempts INT,
  neutered BOOLEAN,
  weight_kg DECIMAL(4,2),
  PRIMARY KEY (id)  
);

ALTER TABLE animals ADD species VARCHAR(100);

CREATE TABLE owners(
  id INT GENERATED BY DEFAULT AS IDENTITY,
  full_name VARCHAR(100),
  age INT,
  PRIMARY KEY (id)
);

CREATE TABLE species(
  id INT GENERATED BY DEFAULT AS IDENTITY,
  name VARCHAR(100),
  PRIMARY KEY (id)
);

CREATE SEQUENCE IF NOT EXISTS animals_id_seq;

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD species_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_species_id
FOREIGN KEY (species_id)
REFERENCES species(id)
ON DELETE CASCADE;

ALTER TABLE animals ADD owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_owner_id
FOREIGN KEY (owner_id)
REFERENCES owners(id)
ON DELETE CASCADE;

CREATE TABLE vets(
  id INT GENERATED BY DEFAULT AS IDENTITY,
  name VARCHAR(100),
  age INT,
  date_of_graduation DATE,
  PRIMARY KEY (id)
);

CREATE TABLE specializations(
  species_id INT REFERENCES species(id),
  vet_id INT REFERENCES vets(id),
  PRIMARY KEY(species_id,vet_id)
);

CREATE TABLE visits(
  id INT GENERATED BY DEFAULT AS IDENTITY,
  animal_id INT REFERENCES animals(id),
  vet_id INT REFERENCES vets(id),
  date DATE,
  PRIMARY KEY (id)
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

ALTER TABLE visits
RENAME COLUMN date TO date_of_visit;

CREATE INDEX animals_index ON visits(animals_id);
CREATE INDEX vets_index ON visits(vets_id);
CREATE INDEX vets_index_asc ON owners(email ASC);