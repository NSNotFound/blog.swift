CREATE TABLE IF NOT EXISTS posts(
  id serial PRIMARY KEY,
  created timestamp NOT NULL,
  content text NOT NULL
  );

GRANT ALL ON posts TO postgres;
GRANT USAGE ON SCHEMA PUBLIC TO postgres;

INSERT INTO posts (created, content) VALUES (now(), 'Hello World!');
