CREATE TABLE IF NOT EXISTS posts(
  id serial PRIMARY KEY,
  created timestamp NOT NULL,
  content text NOT NULL
);

GRANT ALL ON posts TO postgres;

INSERT INTO posts (created, content) VALUES (now(), '# My first Swift blog.');

CREATE TABLE IF NOT EXISTS users {
  id serial PRIMARY KEY,
  nickname varchar(20) NOT NULL,
  email varchar(32) NOT NULL,
  username varchar(20) NOT NULL,
  password varchar(32) NOT NULL,
  reset_token varchar(32)
}

GRANT ALL ON users to postgres;
