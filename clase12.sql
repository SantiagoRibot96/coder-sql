USE gammer;

CREATE TABLE IF NOT EXISTS new_class (
	id_level INT NOT NULL,
    id_class INT NOT NULL,
    descripcion varchar(200) NOT NULL,
    PRIMARY KEY (id_class,id_level)
);

CREATE TABLE IF NOT EXISTS new_level_game (
	id_level INT NOT NULL,
    descripcion VARCHAR(200) NOT NULL,
    PRIMARY KEY (id_level)
);

INSERT INTO new_class VALUES	(17, 10, 'Adventure Other'),
								(15, 1, 'Spy Other'),
								(17, 20, 'British Comedy'),
								(17, 30, 'Adventure'),
								(14, 1, ''),
								(18, 1, '');

INSERT INTO new_level_game		(SELECT DISTINCT id_level, 'New Level'
								FROM new_class
								WHERE id_level NOT IN (
														SELECT id_level
														FROM level_game));

