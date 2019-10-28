USE MASTER;
GO
CREATE DATABASE EMPRESA;
GO
USE EMPRESA;
GO
CREATE TABLE ESTADO (
    UF CHAR(2) NOT NULL PRIMARY KEY,
    NOMEESTADO VARCHAR (50) NOT NULL
);
GO
CREATE TABLE CLIENTE (
	CODIGOCLIENTE INT NOT NULL PRIMARY KEY,
	NOMECLIENTE VARCHAR (20),
	SEXO CHAR (1),
    IDADE INT,
	UFCLIENTE CHAR (2),
    FOREIGN KEY (UFCLIENTE) REFERENCES  ESTADO (UF)
);
GO
CREATE TABLE PEDIDO (
	CODIGOPEDIDO INT NOT NULL PRIMARY KEY,
	CODIGOCLIENTE INT NOT NULL,
	DATAPEDIDO DATETIME,
    FOREIGN KEY (CODIGOCLIENTE) REFERENCES  CLIENTE (CODIGOCLIENTE)
);
GO
CREATE TABLE FORNECEDOR(
	CODIGOFORNECEDOR INT NOT NULL PRIMARY KEY,
	NOMEFORNCEDOR VARCHAR (30),
	CIDADEFORNCEDOR VARCHAR (20),
	UFFORNCEDOR CHAR (2),
    FOREIGN KEY(UFFORNCEDOR) REFERENCES ESTADO (UF)
);
GO
CREATE TABLE PRODUTO (
    CODIGOPRODUTO INT NOT NULL PRIMARY KEY,
    CODIGOFORNECEDOR INT NOT NULL,
    NOMEPRODUTO VARCHAR(255),
    DESCRICAOPRODUTO VARCHAR (255),
    UNIDADE VARCHAR (4),
	PRECO INT,
    DATACADASTRO DATE NULL DEFAULT NULL,
    FOREIGN KEY(CODIGOFORNECEDOR) REFERENCES  FORNECEDOR (CODIGOFORNECEDOR)
);
GO
CREATE TABLE ITENSPEDIDO (
	CODIGOPEDIDO INT NOT NULL,
	CODIGOPRODUTO INT NOT NULL,
	QTDPEDIDO INT,
	SUBTOTAL INT,
    FOREIGN KEY(CODIGOPEDIDO) REFERENCES  PEDIDO (CODIGOPEDIDO),
    FOREIGN KEY(CODIGOPRODUTO) REFERENCES  PRODUTO (CODIGOPRODUTO)
);
GO
CREATE TABLE REPRESENTANTE (
    CODIGOREPRESENTANTE INT NOT NULL PRIMARY KEY,
    NOMEREPRESENTANTE VARCHAR (150),
    SEXO CHAR(1),
    UFREPRESENTANTE CHAR(2),
     FOREIGN KEY(UFREPRESENTANTE) REFERENCES  ESTADO (UF)
);
GO
CREATE TABLE REPRESENTANTEFORNECEDOR (
    CODIGOREPRESENTANTE INT,
    CODIGOFORNECEDOR INT,
    FOREIGN KEY(CODIGOREPRESENTANTE) REFERENCES REPRESENTANTE (CODIGOREPRESENTANTE),
    FOREIGN KEY(CODIGOFORNECEDOR) REFERENCES  FORNECEDOR (CODIGOFORNECEDOR)
)
GO
CREATE TABLE ESTOQUE (
	CODIGOESTOQUE INT NOT NULL PRIMARY KEY,
    CODIGOPRODUTO INT,
	QTDESTOQUE INT,
	ESTOQUEMINIMO INT,
    DATAVALIDADE DATE  NULL DEFAULT NULL,
    FOREIGN KEY(CODIGOPRODUTO) REFERENCES  PRODUTO (CODIGOPRODUTO)
);
CREATE TABLE TELEFONE (
    CODIGOCLIENTE INT NULL DEFAULT NULL,
    CODIGOREPRESENTANTE INT NULL DEFAULT NULL,
    CODIGOFORNECEDOR INT NULL DEFAULT NULL,
    DDD VARCHAR(3),
    TELEFONECLIENTE VARCHAR (10),
    FOREIGN KEY (CODIGOCLIENTE) REFERENCES  CLIENTE (CODIGOCLIENTE),
    FOREIGN KEY (CODIGOREPRESENTANTE) REFERENCES REPRESENTANTE (CODIGOREPRESENTANTE),
    FOREIGN KEY (CODIGOFORNECEDOR) REFERENCES  FORNECEDOR (CODIGOFORNECEDOR),
);


GO
CREATE  TABLE departamento (
  codDepto INT NOT NULL PRIMARY KEY,
  nome VARCHAR(45) NULL DEFAULT NULL,
  gerente INT NULL DEFAULT NULL,
  dataGerente DATE NULL DEFAULT NULL,
  totalsal DECIMAL(12,2) NULL DEFAULT NULL
);
GO
CREATE TABLE empregado (
  codEmp INT NOT NULL PRIMARY KEY,
  nome VARCHAR(45) NULL DEFAULT NULL,
  dataNasc DATE NULL DEFAULT NULL,
  endereco VARCHAR(90) NULL DEFAULT NULL,
  sexo CHAR(1) NULL DEFAULT NULL,
  salario DECIMAL(10,2) NULL DEFAULT NULL,
  codSuperv INT NULL DEFAULT NULL,
  codDepto INT NULL DEFAULT NULL,
  FOREIGN KEY(codDepto) REFERENCES departamento(codDepto)
);
GO
CREATE  TABLE dependente (
  codEmp INT NOT NULL,
  nome VARCHAR(45) NOT NULL DEFAULT '',
  sexo CHAR(1) NULL DEFAULT NULL,
  dataNasc DATE NULL DEFAULT NULL,
  relacao VARCHAR(20) NULL DEFAULT NULL,
  FOREIGN KEY(codEmp) REFERENCES empregado(codEmp)
);
GO
CREATE  TABLE projeto (
  codProj INT NOT NULL PRIMARY KEY,
  titulo VARCHAR(45) NULL DEFAULT NULL,
  codDepto INTEGER NULL DEFAULT NULL,
  FOREIGN KEY (codDepto) REFERENCES departamento (codDepto)
);

GO
CREATE TABLE trabalhaem (
  horas INT NULL DEFAULT NULL,
  empregado_codEmp INT NOT NULL,
  projeto_codProj INT NOT NULL,
  FOREIGN KEY (empregado_codEmp) REFERENCES empregado (codEmp),
  FOREIGN KEY (projeto_codProj) REFERENCES projeto (codProj)
);

use EMPRESA;
go
INSERT INTO departamento VALUES (5,'Pesquisa',2,'1988-05-22',0);
go
INSERT INTO departamento VALUES (4,'Administracao',4,'1985-01-01',0);
go
INSERT INTO departamento VALUES (1,'Direcao',7,'1981-06-19',0);
go
INSERT INTO empregado VALUES (1,'Joao da Silva','1955-01-09','Rua dos Camelos, 23','M',30000,2,5);
go
INSERT INTO empregado VALUES (2,'Horacio Bagual','1970-10-10','Av. dos Tapejaras, 90','M',40000,7,5);
go
INSERT INTO empregado VALUES (3,'Ana Bacana','1980-06-20','Av. Atacama, 10 apto 22','F',25000,4,4);
go
INSERT INTO empregado VALUES (4,'Antonio Pestana','1990-04-13','Rod. Imigrantes, 1940','M',45000,7,4);
go
INSERT INTO empregado VALUES (5,'Maria Antonia Real','1982-11-14','Rua Petropolis, 13','F',38000,2,5);
go
INSERT INTO empregado VALUES (6,'Ada Maria Lovelace','1965-10-15','Rua dos Ingleses, 1020','F',25000,2,5);
go
INSERT INTO empregado VALUES (8,'Joaquina Pasqualini','1968-08-17','Rua dos Ingleses, 1010','F',25000,4,4);
go
INSERT INTO empregado VALUES (7,'Jaime Bonde','1958-01-01','Rua dos Ingleses, 1010','M',70000,null,1);
go
INSERT INTO projeto VALUES (1,'Transmogrifador',5);
go
INSERT INTO projeto VALUES (2,'Cama Hiperbarica',5);
go
INSERT INTO projeto VALUES (3,'Emissor de Raios Z',5);
go
INSERT INTO projeto VALUES (10,'Gestao dos 80/20',4);
go
INSERT INTO projeto VALUES (20,'Business Inteligence',1);
go
INSERT INTO projeto VALUES (30,'Bonus para Inventores',4);
go
INSERT INTO trabalhaEm VALUES (32.5,1,1);
go
INSERT INTO trabalhaEm VALUES (7.5,1,2);
go
INSERT INTO trabalhaEm VALUES (40,5,3);
go
INSERT INTO trabalhaEm VALUES (20,6,1);
go
INSERT INTO trabalhaEm VALUES (20,6,2);
go
INSERT INTO trabalhaEm VALUES (10,2,2);
go
INSERT INTO trabalhaEm VALUES (10,2,3);
go
INSERT INTO trabalhaEm VALUES (10,2,10);
go
INSERT INTO trabalhaEm VALUES (10,2,20);
go
INSERT INTO trabalhaEm VALUES (30,3,30);
go
INSERT INTO trabalhaEm VALUES (10,3,10);
go
INSERT INTO trabalhaEm VALUES (35,8,10);
go
INSERT INTO trabalhaEm VALUES (5,8,30);
go
INSERT INTO trabalhaEm VALUES (20,4,30);
go
INSERT INTO trabalhaEm VALUES (15,4,20);
go
INSERT INTO trabalhaEm VALUES (0,7,20);
go
INSERT INTO trabalhaEm VALUES (15,1,3);
go
INSERT INTO dependente VALUES (2,'Joana Bagual','F','1986-05-05','Filha');
go
INSERT INTO dependente VALUES (2,'Pedro Bagual','M','1983-10-25','Filho');
go
INSERT INTO dependente VALUES (2,'Alice Bagual','F','1958-05-03','Esposa');
go
INSERT INTO dependente VALUES (3,'Maximo Bacana','M','1942-02-28','Esposo');
go
INSERT INTO dependente VALUES (1,'Jagunco da Silva','M','1978-01-01','Filho');
go
INSERT INTO dependente VALUES (1,'Jaqueline da Silva','F','1978-12-31','Filha');
go
INSERT INTO dependente VALUES (1,'Joana da Silva','F','1957-05-05','Esposa');

USE EMPRESA;
GO
CREATE PROCEDURE dbo.nomeDependentes @codigoEmpregado int 
as select d.nome as "Nome Dependente", d.relacao as "Relação Dependente", e.nome as "Nome Empregado"
from empregado as e inner join dependente as d on d.codEmp = e.codEmp
where e.codEmp = (@codigoEmpregado);

execute nomeDependentes 3

//////////////////////////////////////////////////////////////////////////////////////////

use empresa
go
create procedure dbo.maiorSalario 
as select b.nome as "Nome", b.salario as "Salario"
from empregado as b 
where b.salario = (select max(salario) from empregado)


execute maiorSalario

//////////////////////////////////////////////////////////////////////////////////////////

use empresa
go
create procedure dbo.menorSalario 
as select b.nome as "Nome", b.salario as "Salario"
from empregado as b 
where b.salario = (select min(salario) from empregado)


execute menorSalario

//////////////////////////////////////////////////////////////////////////////////////////

use empresa
go
create procedure dbo.somaSalario
as select sum(salario) as "Soma" from empregado

execute somaSalario

//////////////////////////////////////////////////////////////////////////////////////////

use empresa
go
create procedure dbo.empProj @codEmpr int
as select b.nome as "Nome", c.titulo as "Projeto" from trabalhaem as a
inner join empregado as b on a.empregado_codEmp = b.codEmp
inner join projeto as c on a.projeto_codProj = c.codProj
where b.codEmp = (@codEmpr)

execute empProj 1

//////////////////////////////////////////////////////////////////////////////////////////

use empresa
go
create trigger alertaAlteracao
on empregado
after update
as print ('Um campo foi alterado')

update empregado set salario = 35000 where codEmp = 1

//////////////////////////////////////////////////////////////////////////////////////////

alter table projeto add data_atualizacao date

use EMPRESA
go
create trigger atualizaDataProjetoAlterado
on projeto after update
as declare @codigoProjeto int
select @codigoProjeto = codProj from inserted
update projeto set data_atualizacao = getdate() where codProj = @codigoProjeto
go

select * from projeto
update projeto set codDepto = 1 where codProj = 1 

//////////////////////////////////////////////////////////////////////////////////////////

alter table empregado add data_atualizacao date

use EMPRESA
go
create trigger atualizaDataEmpregadoAlterado
on empregado after update
as declare @codigoEmpregado int
select @codigoEmpregado = codEmp from inserted
update empregado set data_atualizacao = getdate() where codEmp = @codigoEmpregado
go

select * from empregado
update empregado set salario = 43000 where codEmp = 2

//////////////////////////////////////////////////////////////////////////////////////////

use EMPRESA
go
create trigger registroAlterado
on empregado after update
as declare @codigoEmpregado int
select @codigoEmpregado = codEmp from inserted
select * from empregado where codEmp = @codigoEmpregado

//////////////////////////////////////////////////////////////////////////////////////////

use EMPRESA
go
create trigger registroAlterado
on empregado after update
as declare @codigoEmpregado int
select @codigoEmpregado = codEmp from inserted

//////////////////////////////////////////////////////////////////////////////////////////

use EMPRESA
go
create trigger registroAlteradoInfo
on empregado after update
as declare @codigoEmpregado int
select @codigoEmpregado = codEmp from inserted
print ('Um registro foi alterado')
select nome as "Nome", salario as "Salario" from empregado where codEmp = @codigoEmpregado

update empregado set salario = 83000 where codEmp = 2