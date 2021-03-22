-- A1P3
-- Vinicius Leinate Porto

-- criação do banco de dados

create database exercicioa1p3;
use exercicioa1p3;

-- criação da tabela veiculo

create table veiculo(
	id int not null auto_increment,
    proprietario varchar(100),
    placa varchar(15),
    primary key(id)
);

-- criação da tabela infração de trânsito

create table infracaodetransito(
	id int not null auto_increment,
    nomeInfracao varchar(100),
    penalidade varchar(100),
    multa decimal(10, 2),
    tipo varchar(15),
    numPontos int,
    primary key(id)
);

-- criação da tabela infração de trânsito

create table registro(
    idInfracao int not null,
    idVeiculo int not null,
    dataRegistro date,
    horaRegistro TIME,
    localInfracao varchar(100),
    foreign key(idInfracao) references infracaodetransito(id),
    foreign key(idVeiculo) references veiculo(id)
);

-- inserção de valores em infração de trânsito

insert into infracaodetransito(id, nomeInfracao, penalidade, multa, tipo, numPontos) values
("1", "dirigir embriagado", "Suspensão do direto de dirigir e detenção de 6 meses a 3 anos", "957.69", "gravíssima", "7"),
("2", "Carro sem placa ou sem licenciamento", "Apreensão do veículo", "191.54", "gravíssima", "7"),
("3", "Estacionar em fila dupla", "Remoção do veículo", "127.69", "grave", "5"),
("4", "Não usar cinto de segurança", "Retenção do veículo até colocação do cinto de segurança", "127.69", "grave", "5"),
("5", "Parar na rua ou na estrada por falta de combustível", "Remoção do veículo", "85.13", "média", "4"),
("6", "Usar placas diferentes das autorizadas pela Contran", "Retenção do veículo para regularização e apreensão das placas irregulares", "85.13", "média", "4"),
("7", "Estacionar longe da calçada(entre 50cm e 1 metro)", "Não tem", "53.2", "leve", "3"),
("8", "Dirigir sem atenção", "Não tem", "53.2", "leve", "3");

-- inserção de valores em veiculo

insert into veiculo(id, placa, proprietario) values
("1", "abc-1111", "Ana"),
("2", "abc-2222", "Pedro"),
("3", "abc-3333", "João"),
("4", "abc-4444", "Regina"),
("5", "abc-5555", "Eduardo");

-- inserção de valores em registro

insert into registro(idVeiculo, idInfracao, dataRegistro, horaRegistro, localInfracao) values
("5", "6", "2013-04-20", "17:43:00", "av 23"),
("4", "3", "2015-07-20", "16:33:00", "av 55"),
("4", "7", "2010-11-20", "22:45:00", "rua 258"),
("3", "1", "2010-01-20", "11:15:00", "rua 147"),
("3", "4", "2005-11-20", "07:55:00", "av 78"),
("2", "3", "2018-10-20", "13:09:00", "rua 456"),
("1", "2", "2001-11-20", "09:00:00", "rua 123");

-- Quantidade de pontos, o tipo, a multa e a penalidade da infração "Não usar o cinto de segurança"

select numPontos, tipo, multa, penalidade as 'Não usar o cinto de segurança'
from infracaodetransito
where id = '1';

-- Valor total que o veículo com placa "abc-1111" deve ao estado

select sum(multa) as 'Quantidade em R$ que o veículo com placa ABC-1111 deve ao estado'
from infracaodetransito inner join registro on (infracaodetransito.id = registro.idInfracao)
						inner join veiculo on (registro.idVeiculo = veiculo.id)
where placa = 'ABC-1111';

-- Pontos que o veículo do proprietário "Eduardo" possui

select sum(numPontos) as 'Quantidade de pontos que o proprietário Eduardo possui'
from infracaodetransito inner join registro on (infracaodetransito.id = registro.idInfracao)
						inner join veiculo on (registro.idVeiculo = veiculo.id)
where proprietario = 'Eduardo';

-- Dados das multas registradas do proprietário do veículo "abc-3333"

select numPontos, tipo, multa, penalidade, dataRegistro, horaRegistro, localInfracao as 'Dados das multas registradas do proprietário do veículo abc-3333'
from infracaodetransito inner join registro on (infracaodetransito.id = registro.idInfracao)
						inner join veiculo on (registro.idVeiculo = veiculo.id)
where placa ='ABC-3333';

-- Valor total recebido pelo departamento de trânsito em multas no ano de 2010

select sum(multa) as 'Valor total recebido pelo departamento de trânsito em multas no ano de 2010'
from infracaodetransito inner join registro on (infracaodetransito.id = registro.idInfracao)
where year (dataRegistro) = '2010';