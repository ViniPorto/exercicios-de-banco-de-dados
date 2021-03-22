-- atividade 2 Vinicius Leinate Porto - 345942
create database bdcidadeViniciusPorto;
use bdcidadeViniciusPorto;

create table cidade(
	idCidade int not null auto_increment,
    nomeCidade varchar(100),
    populacao int,
    primary key(idCidade)
);

create table cidadaos(
	idCidadaos int not null auto_increment,
    idCidade int,
    nomeCidadao varchar(100),
    datanasc DATE,
    primary key(idCidadaos),
    foreign key(idCidade) references cidade(idCidade)
);

delimiter $
create procedure insere_cidade(IN nomex varchar(100), IN populacaox int)
begin
	insert into cidade(nomeCidade, populacao) values
    (nomex, populacaox);
end $
delimiter ;

call insere_cidade('Joaçaba', 30118);
call insere_cidade('Blumenau', 204560);
call insere_cidade('Joinvile', 1020450);
call insere_cidade('São Paulo', 24456890);

delimiter $
create procedure insere_cidadao(IN idCidadex int, IN nomex varchar(100), IN datanascx DATE)
begin
	insert into cidadaos(idCidade, nomeCidadao, datanasc) values
    (idCidadex, nomex, datanascx);
	update cidade set populacao = populacao + 1 where idCidade = idCidadex;
end $
delimiter ;

call insere_cidadao(2, 'Vinicius', '2000-04-25');
call insere_cidadao(1, 'Gabriel', '2000-05-14');
call insere_cidadao(1, 'Mateus', '2000-08-26');

delimiter $
create procedure lista_cidades()
begin
	select nomeCidade, populacao
    from cidade;
end $
delimiter ;

call lista_cidades();

delimiter $
create procedure lista_cidadaos()
begin
	select nomeCidade, nomeCidadao, datanasc
    from cidadaos inner join cidade on (cidadaos.idCidade = cidade.idCidade);
end $
delimiter ;

call lista_cidadaos();

delimiter $
create procedure exclui_cidade(in nomeCidadex varchar(100))
begin
	declare idExcluir int;
    set idExcluir = (select idCidade from cidade where nomeCidade = nomeCidadex);
    delete from cidade where cidade.idCidade = idExcluir;
end $
delimiter ;

call exclui_cidade('São Paulo');

delimiter $
create procedure exclui_cidadao(in nomeCidadaox varchar(100))
begin
	declare idCidadaoExcluir int;
    declare idCidadeExcluir int;
    set idCidadaoExcluir = (select idCidadaos from cidadaos where nomeCidadao = nomeCidadaox);
	set idCidadeExcluir = (select idCidade from cidadaos where nomeCidadao = nomeCidadaox);
    update cidade set populacao = populacao - 1 where cidade.idCidade = idCidadeExcluir;
    delete from cidadaos where cidadaos.idCidadaos = idCidadaoExcluir;
end $
delimiter ;

call exclui_cidadao('Mateus');