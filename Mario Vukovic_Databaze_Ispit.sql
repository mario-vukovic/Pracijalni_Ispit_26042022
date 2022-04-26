CREATE DATABASE Kolekcija
GO

USE Kolekcija
GO

CREATE TABLE GlazbeniDiskovi(
Id INT PRIMARY KEY IDENTITY(1,1),
Autor NVARCHAR (50) NOT NULL,
Album NVARCHAR (50) NOT NULL,
Zanr NVARCHAR (20),
)

CREATE TABLE Filmovi(
Id INT PRIMARY KEY IDENTITY(1,1),
Naziv NVARCHAR (50) NOT NULL,
Zanr NVARCHAR (20)
)

CREATE TABLE Prijatelji(
Id INT PRIMARY KEY IDENTITY(1,1),
Ime NVARCHAR (50) NOT NULL,
Prezime NVARCHAR (50) NOT NULL,
)

CREATE TABLE Posudba(
Id INT PRIMARY KEY IDENTITY(1,1),
IdPrijatelja INT FOREIGN KEY REFERENCES Prijatelji(Id),
IdGlazbenogDiska INT FOREIGN KEY REFERENCES GlazbeniDiskovi(Id),
IdFilma INT FOREIGN KEY REFERENCES Filmovi(Id),
DatumPosudbe DATE NOT NULL,
DatumPovratka DATE
)

INSERT INTO GlazbeniDiskovi
(Autor, Album, Zanr) VALUES
('Disturbed', 'Indestructible', 'Metal'),
('AC/DC', 'High Voltage', 'Rock'),
('The Pretty Reckless', 'Going to Hell', 'Hard Rock')

INSERT INTO Filmovi
(Naziv, Zanr) VALUES
('Umri muski 3', 'Akcijski'),
('Saw IV', 'Horor'),
('Star Wars: A new hope', 'Sci-fi')

INSERT INTO Prijatelji
(Ime, Prezime) VALUES
('Pero', 'Peric'),
('Ivana', 'Ivancic'),
('Luka', 'Lukic')

INSERT INTO Posudba
(IdPrijatelja, IdGlazbenogDiska, IdFilma, DatumPosudbe, DatumPovratka) VALUES
(1, 1, NULL, '2022-04-12', NULL),
(3, 2, 3, '2022-03-14', NULL),
(2, NULL, 1, '2022-01-06', '2022-01-20')

SELECT 
Prijatelji.Ime, 
Prijatelji.Prezime, 
GlazbeniDiskovi.Album AS PosudjeniAlbum, 
GlazbeniDiskovi.Autor AS AutorPosudjenogAlbuma, 
Filmovi.Naziv AS PosudjeniFilm, 
DATEDIFF (DAY, DatumPosudbe, GETDATE()) AS BrojPosudjenihDana
FROM Posudba

INNER JOIN Prijatelji ON
Posudba.IdPrijatelja = Prijatelji.Id
INNER JOIN GlazbeniDiskovi ON
Posudba.IdGlazbenogDiska = GlazbeniDiskovi.Id
LEFT OUTER JOIN Filmovi ON
Posudba.IdFilma = Filmovi.Id

WHERE DatumPovratka IS NULL 

UPDATE Posudba
SET DatumPovratka = GETDATE()
WHERE DatumPovratka IS NULL