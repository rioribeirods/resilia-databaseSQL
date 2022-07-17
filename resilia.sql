CREATE DATABASE resilia_banco;
USE resilia_banco;

CREATE TABLE cursos (
	id int AUTO_INCREMENT PRIMARY KEY,
    nome varchar(100) NOT NULL,
    tipo varchar(100) NOT NULL  
);

CREATE TABLE turmas (
	id int AUTO_INCREMENT PRIMARY KEY,
	numero int NOT NULL,
    nome_turma varchar(100) NOT NULL,
    cursos_id int NOT NULL,
    FOREIGN KEY (cursos_id) REFERENCES cursos(id)
);

CREATE TABLE alunos (
	id int AUTO_INCREMENT PRIMARY KEY,
    cpf varchar(14) NOT NULL,
    nome varchar(100) NOT NULL,
    data_nascimento date NOT NULL,
    turmas_id int NOT NULL,
    FOREIGN KEY (turmas_id) REFERENCES turmas(id)
); 

ALTER TABLE alunos 
ADD email varchar(255) NOT NULL;

INSERT INTO cursos (nome, tipo) VALUES 
('Back-End', 'EAD'),
('Front-End', 'EAD'), 
('DataScience', 'Presencial');

-- Tentei inserir os alunos primeiro, e  deu erro. Tentei inserir as turmas primeiro e deu erro também, depois de alguns minutos percebi que era necessário primeiro ter o cursos_id para depois ter o turmas_id, então inseri valores na tabela cursos e assim funcionou.

INSERT INTO turmas (numero, nome_turma, cursos_id) VALUES
(40, 'turma back end 1', 1),
(40, 'turma front end 1', 2),
(20, 'turma datascience 1', 3);

INSERT INTO alunos (cpf, nome, data_nascimento, turmas_id, email) VALUES
('000.000.000-00', 'Rio Ribeiro', '2002-04-02', 3, 'rioribeirozzz@gmail.com'),
('111.111.111-11', 'Gabriela Coelho', '1994-08-07', 1, 'gabcoelho123@hotmail.com'),
('222.222.222-22', 'Milton Rocha', '1989-08-15', 2, 'miltonr789@outlook.com'),
('333.333.333-33', 'Jorge Tavares', '1997-05-13', 3, 'jorge.tavares1@gmail.com'
);

CREATE TABLE entregas (
	aluno_id int NOT NULL,
    modulo int NOT NULL,
	link_repositorio varchar(100) NOT NULL,
    conceito varchar(100),
    foreign key (aluno_id) references alunos(id)
);

INSERT INTO entregas VALUES
(1, 2, 'https://entrega1.com.br/', 'Mais que pronto'),
(2, 3, 'https://entrega2.com.br/', 'Chegando lá'),
(3, 4, 'https://entrega3.com.br/', 'Pronto'),
(4, 5, 'https://entrega4.com.br/', 'Mais que pronto'
);


-- Query i.
SELECT * FROM entregas
	WHERE modulo = 1 AND conceito = 'Mais que pronto';
    
-- Query ii.
SELECT turmas_id AS turma, COUNT(turmas_id) AS alunos_por_turma FROM alunos
	GROUP BY turmas_id;
    
-- Query iii.
SELECT COUNT(conceito) AS quant_de_projetos FROM entregas
	WHERE conceito = 'Ainda não está pronto' OR conceito = 'Chegando lá';
    
-- Query iv.
SELECT turmas_id AS turma, COUNT(conceito) AS quant_de_projetos FROM alunos
	INNER JOIN entregas ON alunos.id = entregas.aluno_id
    WHERE conceito = 'Mais que pronto'
    GROUP BY turmas_id
    ORDER BY quant_de_projetos DESC
    LIMIT 1; 

