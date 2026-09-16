/*
  Trabalho 1 - Microsoft SQL Server
  Banco de dados de estacoes meteorologicas
*/

-- Exercicio 1: criar e selecionar o banco de dados
CREATE DATABASE EstacaoMet;
GO

USE EstacaoMet;
GO

-- Exercicio 2: criar as tabelas
CREATE TABLE Estacoes (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Localizacao VARCHAR(255) NULL
);

CREATE TABLE Sensores (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    EstacaoId INT NOT NULL,
    TipoSensor VARCHAR(50) NOT NULL,
    DataInstalacao DATETIME NOT NULL,
    CONSTRAINT FK_Sensores_Estacoes
        FOREIGN KEY (EstacaoId) REFERENCES Estacoes(Id)
);

CREATE TABLE Medicoes (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    SensorId INT NOT NULL,
    DataHora DATETIME NOT NULL,
    Valor DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_Medicoes_Sensores
        FOREIGN KEY (SensorId) REFERENCES Sensores(Id)
);
GO

-- Exercicio 3: inserir dados iniciais (maximo de 3 por tabela)
INSERT INTO Estacoes (Nome, Localizacao) VALUES
    ('Estacao Central', 'Sao Paulo - Centro'),
    ('Estacao Norte', 'Sao Paulo - Zona Norte'),
    ('Estacao Sul', 'Sao Paulo - Zona Sul');

INSERT INTO Sensores (EstacaoId, TipoSensor, DataInstalacao) VALUES
    (1, 'Temperatura', '2026-08-01T08:00:00'),
    (1, 'Umidade', '2026-08-01T08:30:00'),
    (2, 'Temperatura', '2026-08-02T09:00:00');

INSERT INTO Medicoes (SensorId, DataHora, Valor) VALUES
    (1, '2026-08-10T10:00:00', 24.50),
    (2, '2026-08-10T10:00:00', 65.00),
    (3, '2026-08-10T10:05:00', 22.80);
GO

-- Exercicio 4: corrigir a primeira medicao de umidade (Id = 2)
UPDATE Medicoes
SET Valor = 68.00
WHERE Id = 2;

-- Exercicio 5: excluir a medicao de teste (Id = 3)
DELETE FROM Medicoes
WHERE Id = 3;

-- Exercicio 6: sensores instalados e suas estacoes
SELECT
    s.TipoSensor,
    e.Nome AS NomeEstacao
FROM Sensores AS s
INNER JOIN Estacoes AS e
    ON e.Id = s.EstacaoId;

-- Exercicio 7: todos os sensores, inclusive os que nao possuem medicao
SELECT
    s.Id AS SensorId,
    s.TipoSensor,
    m.Valor
FROM Sensores AS s
LEFT JOIN Medicoes AS m
    ON m.SensorId = s.Id
ORDER BY s.Id, m.DataHora;

-- Exercicio 8: adicionar e preencher o status operacional
ALTER TABLE Sensores
ADD Status VARCHAR(20) NULL;

UPDATE Sensores
SET Status = 'Ativo';
GO
