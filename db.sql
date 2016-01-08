CREATE TABLE IF NOT EXISTS posts(
  id serial PRIMARY KEY,
  created timestamp NOT NULL,
  content text NOT NULL
);

GRANT ALL ON posts TO postgres;

INSERT INTO posts (created, content) VALUES (now(), '# My first Swift blog.');
