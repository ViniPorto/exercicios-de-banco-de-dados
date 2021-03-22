-- resolução sobre programação em DB
-- acadêmico: Vinícius Leinate Porto

drop database if exists trabalhoA1p4VAA;
create database trabalhoA1p4VAA;
use trabalhoA1p4VAA;

-- QUESTÃO 1 

create table clienteUsuario(
	id int not null auto_increment,
    nome varchar(80),
    fone varchar(50),
    cpf varchar(20),
    nomeFiador varchar(80),
    foneFiador varchar(50),
    cpfFiador varchar (20),
    primary key(id)
);

create table imovel(
	id int not null auto_increment,
    tipo varchar(50),
    situacao varchar(45),
    endereco varchar(255),
    bairro varchar(80),
    cidade varchar(80),
    estado varchar(2),
    descricao varchar(255),
    nomeProprietario varchar(80),
    cpfProprietario varchar(20),
    foneProprietario varchar(50),
    primary key(id)
);

create table corretor(
    id int not null auto_increment,
    nome varchar(80),
    fone varchar(50),
    cpf varchar(20),
    foneCelular varchar(50),
    salarioBase float,
    salarioTotal float,
    primary key(id)
);

create table aluguel(
	id int not null auto_increment,
    imovel_id int,
    clienteUsuario_id int,
    dataAluguel date,
	valorAluguelInicial float,
    valorAluguelFinal float,
    valorImobiliaria float,
    dataDisponivelAluguel date,
    numContrato int,
    formaPagto varchar(100),
    primary key(id),
    foreign key(imovel_id) references imovel(id),
    foreign key(clienteUsuario_id) references clienteUsuario(id)
);

create table comissaoAluguel(
	id int not null auto_increment,
    corretor_id int,
    aluguel_id int,
    valorComissao float,
    primary key(id),
    foreign key(corretor_id) references corretor(id),
    foreign key(aluguel_id) references aluguel(id)
);

-- FIM DA QUESTÃO 1

delimiter $
create trigger validarVenda after insert
on comissaoAluguel
for each row
begin
    update imovel set situacao = 'alugado'
    where id = (select imovel_id from aluguel where id = new.aluguel_id);
end $
delimiter ;

-- QUESTÃO 2

delimiter $
create procedure incluir_imoveis(in tipox varchar(50), in situacaox varchar(45),  in enderecox varchar(255), in bairrox varchar(80), in cidadex varchar(80), in estadox varchar(2), descricaox varchar(255), in nomeProprietariox varchar(80), in cpfProprietariox varchar(50), in foneProprietariox varchar(20))
begin
	insert into imovel(tipo, situacao, endereco, bairro, cidade, estado, descricao, nomeProprietario, cpfProprietario, foneProprietario) values
	(tipox, situacaox, enderecox, bairrox, cidadex, estadox, descricaox, nomeProprietariox, cpfProprietariox, foneProprietariox);
end $
delimiter ;

call incluir_imoveis('apartamento', 'indisponivel', 'Rua Avelino', 'Vila Nova', 'Imaginópolis', 'RS', '4 dormitórios (1 suíte), sala social de estar/jantar,cozinha ampla com armários embutidos em L e mesa de jantar, área de churrasqueira com salão para festas, 2 varandas, jardim e 2 vagas de garagem.', 'Kaci Atherton','574.306.750-34','999868888');
call incluir_imoveis('apartamento', 'indisponivel', 'Rua Braga', 'Branco', 'Nova Imaginópolis', 'SP', 'Residência com 5 suítes, assim dividida: Parte superior: 4 suítes. Parte inferiror: suíte de hóspedes ou escritório, lavabo, sala, banheiro auxiliar, maravilhosa piscina.', 'Usaamah Pierce','571.306.750-34','999868881');
call incluir_imoveis('casa', 'indisponivel', 'Rua Tiradentes', 'Centro', 'Joaçaba', 'SC','terreno 15x20, ótima localização, totalmente terraplano, valor inbox', 'Usaamah Piercing','471.306.750-34','999888881');
call incluir_imoveis('casa', 'indisponivel', 'Rua Getulio Vargas', 'Centro', 'Joaçaba', 'SC', 'Imóvel em ótimo estado com 2 dormitórios e mezanino/dormitório p 3 pessoas e espera pronta p mais 1 WC. Posição solar ótima e pátio grande com muros e gramado.', 'Iqrah Riddle','574.376.750-34','999968881');
call incluir_imoveis('casa', 'indisponivel', 'Rua Frei Estanislau', 'Velha', 'Blumenau', 'SC', 'Casa sobrado geminado com 3 dorm ( sendo 1 suíte ). Sala TV e jantar integradas. Lavabo na parte inferior e banheiro social na parte superior. Área de festas com churrasqueira e banheiro, 2 vagas cobertas. Portão eletrônico.', 'Milena Cook','574.302.750-34','999822881');
call incluir_imoveis('apartamento', 'indisponivel', 'Rua Alameda', 'Centro', 'Blumenau', 'SC', 'Belíssimo apartamento com 02 dormitórios, sendo 01 suíte, sala estar/jantar, cozinha, bwc, área de serviço, sacada com churrasqueira, vaga de garagem.', '','','');
call incluir_imoveis('apartamento', 'indisponivel', 'Rua Leao Branco', 'Novo Horizonte', 'Velha Fronteira', 'PR', 'Casa NOVA com 02 dormitórios, sendo 02 suítes, lavabo, sala, cozinha, área de serviço, varanda com churrasqueira, sacada, amplo quintal e garagem coberta.', 'Catherine Spence','774.306.750-39','999868883');
call incluir_imoveis('casa', 'indisponivel', 'Rua Derby', 'Smoke', 'Cigarrópolis', 'SP', 'Apartamento novo, com 02 dormitórios, sendo 01 suíte com persianas integradas, cozinha, sala, área de serviço, sacada com churrasqueira e 01 vaga de garagem coberta. Prédio com portão eletrônico, interfone.', 'Scott Chung','574.306.750-39','99986887');

-- FIM DA QUESTÃO 2

-- QUESTÃO 3

delimiter $
create procedure incluir_clientesUsuarios(in nomex varchar(80), in fonex varchar(50), in cpfx varchar(20), in nomeFiadorx varchar(80), in foneFiadorx varchar(50), in cpfFiadorx varchar(20))
begin
    insert into clienteusuario(nome, fone, cpf, nomeFiador, foneFiador, cpfFiador) values
    (nomex, fonex, cpfx, nomeFiadorx, foneFiadorx, cpfFiadorx);
end $
delimiter ;

call incluir_clientesUsuarios('André de Souza', '98888-8880', '111.111.111-11', 'Rogério Skylab', '98888-8896', '111.111.111-27');
call incluir_clientesUsuarios('Leandro Pushowsky', '98888-8881', '111.111.111-12', 'Jair Bolsonaro', '98888-8897', '111.111.111-28');
call incluir_clientesUsuarios('Andressa Matos', '98888-8882','111.111.111-13', 'Heberbt Richners', '98888-8898', '111.111.111-29');
call incluir_clientesUsuarios('Mateus Fernandes', '98888-8883', '111.111.111-14', 'Ronaldo Fenômeno', '98888-8899', '111.111.111-30');
call incluir_clientesUsuarios('Fernando Vera', '98888-8895', '111.111.111-26', 'Ricardo Iseckson dos Santos Leite', '98888-8900', '111.111.111-31');

-- FIM DA QUESTÃO 3

-- QUESTÃO 4

delimiter $
create procedure incluir_corretor(in nomex varchar(80), in cpfx varchar(20), in foneCelularx varchar(50), in salarioBasex float, in salarioTotalx float)
begin
    insert into corretor(nome, cpf, foneCelular, salarioBase, salarioTotal) values
    (nomex, cpfx, foneCelularx, salarioBasex, salarioTotalx);
end $
delimiter ;

call incluir_corretor('Ricardo Dias', '111.111.111-16', '98888-8885', 9000.00, 8000.00);
call incluir_corretor('Gabriel Jesus', '111.111.111-17', '98888-8886', 10000.00, 9500.00);
call incluir_corretor('Tony Hawk', '111.111.111-18', '98888-8887', 7000.00, 5000.00);
call incluir_corretor('Galvão Bueno', '111.111.111-19', '98888-8888', 15000.00, 13500.00);
call incluir_corretor('Otto von Bismarck', '111.111.111-20', '98888-8889', 6000.00, 3500.00);

-- FIM DA QUESTÃO 4

-- QUESTÃO 5

delimiter $
create procedure disponibilizar_aluguel(in imovel_idx int, in valor_aluguelx FLOAT, in Data_Dispx date)
begin

	insert into aluguel(imovel_id, valorAluguelInicial, dataDisponivelAluguel) values
	(imovel_idx, valor_aluguelx, Data_Dispx);
    
    update imovel set situacao = 'Disponivel' where id = imovel_idx;
    
end $
delimiter ;

call disponibilizar_aluguel(1, 400.00, '2020-01-03');
call disponibilizar_aluguel(2, 450.00, '2020-03-03');
call disponibilizar_aluguel(3, 600.00, '2020-03-03');
call disponibilizar_aluguel(4, 850.00, '2020-04-03');
call disponibilizar_aluguel(5, 2000.00, '2020-05-03');
call disponibilizar_aluguel(6, 4500.00, '2020-05-03');
call disponibilizar_aluguel(7, 5600.00, '2020-06-03');


-- FIM DA QUESTÃO 5

-- QUESTÃO 6

create view view_imov_disp as select tipo, endereco, bairro, cidade, estado, descricao from imovel where situacao = 'Disponivel';

select * from view_imov_disp;

-- FIM DA QUESTÃO 6

-- QUESTÃO 7

delimiter $
create procedure registrar_aluguel(in idx int, in imovel_idx int, in clienteUsuario_idx int, in dataAluguelx date, in valorAluguelFinalx float, in numContratox int, in formaPagtox varchar(100), in corretor_idx int)
begin
    declare valorImobiliariax float default 0;
    declare valorComissaox float default 0;
    set valorImobiliariax = (valorAluguelFinalx / 100) * 5;
    set valorComissaox = (valorAluguelFinalx / 100) * 2;
    update aluguel set clienteUsuario_id = clienteUsuario_idx where id = idx;
    update aluguel set dataAluguel = dataAluguelx where id = idx;
    update aluguel set valorAluguelFinal = valorAluguelFinalx where id = idx;
    update aluguel set valorImobiliaria = valorImobiliariax where id = idx;
    update aluguel set numContrato = numContratox where id = idx;
    update aluguel set formaPagto = formaPagtox where id = idx;
    
    insert into comissaoAluguel(corretor_id, aluguel_id, valorComissao) values
    (corretor_idx, idx, valorComissaox);
    
end $
delimiter ;

call registrar_aluguel(1, 1, 1, '2020-03-21', 2000.00, 1, 'Carnê', 1);
call registrar_aluguel(2, 2, 2, '2019-06-22', 3000.00, 2, 'Carnê', 2);
call registrar_aluguel(3, 3, 3, '2020-03-21', 4000.00, 3, 'À vista em dinheiro', 5);
call registrar_aluguel(4, 4, 4, '2020-05-21', 5000.00, 4, 'À vista em dinheiro', 1);
call registrar_aluguel(5, 5, 5, '2019-09-29', 6000.00, 5, 'À vista em dinheiro', 1);

-- FIM DA QUESTÃO 7

-- QUESTÃO 8

select * from imovel where situacao  = 'Disponivel';

-- FIM DA QUESTÃO 8

-- QUESTÃO 9 -

select Sum(valorImobiliaria) as 'Valor Recebido Imobiliaria' from aluguel where Month(dataAluguel) = 3 and Year(dataAluguel) = 2020;

-- FIM DA QUESTÃO 9

-- QUESTÃO 10 -

Select 
	Sum(A.valorComissao) as 'Valor Recebido Imobiliaria'
From 
	comissaoAluguel A, aluguel B, corretor C
Where 
	A.aluguel_id = B.id and
	A.corretor_id = C.id and
    C.nome = 'Ricardo Dias' and
    Year(B.dataAluguel) = 2020;

-- FIM DA QUESTÃO 10
