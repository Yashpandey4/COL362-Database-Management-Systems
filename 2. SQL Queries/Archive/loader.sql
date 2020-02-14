CREATE TABLE Author (
    AuthorId int,
    name text
);

CREATE TABLE Citation (
    Paper1Id int,
    Paper2Id int
);

CREATE TABLE Paper (
    PaperId int,
    Title text,
    year int,
    VenueId int
);

CREATE TABLE PaperByAuthors (
    PaperId int,
    AuthorId int
);

CREATE TABLE Venue (
    VenueId int,
    name text,
    type text
);

COPY Author
FROM '/home/pratyush/Desktop/Assn1/dataset/Author.tsv' DELIMITER E'\t';

COPY Citation
FROM '/home/pratyush/Desktop/Assn1/dataset/Citation.tsv' DELIMITER E'\t';

COPY Paper
FROM '/home/pratyush/Desktop/Assn1/dataset/Paper.tsv' DELIMITER E'\t';

COPY PaperByAuthors
FROM '/home/pratyush/Desktop/Assn1/dataset/PaperByAuthors.tsv' DELIMITER E'\t';

COPY Venue
FROM '/home/pratyush/Desktop/Assn1/dataset/Venue.tsv' DELIMITER E'\t';
