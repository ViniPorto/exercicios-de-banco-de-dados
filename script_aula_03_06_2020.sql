#Aula 03/06/2020
 create database aula03junho;
 use aula03junho;
 
-- exercício 3

-- criação das tabelas

create table cliente(
	id int not null auto_increment,
    nomeCli varchar(100),
    enderecoCli varchar(100),
    telefoneCli varchar(100),
    primary key(id)
);

create table fornecedor(
	id int not null auto_increment,
    nomeFor varchar(100),
    enderecoFor varchar(100),
    telefoneFor varchar(100),
    primary key(id)
);

create table funcionario(
	id int not null auto_increment,
    nomeFun varchar(100),
    enderecoFun varchar(100),
    telefoneFun varchar(100),
    primary key(id)
);

create table vendedor(
	id int not null auto_increment,
    nomeVen varchar(100),
    enderecoVen varchar(100),
    telefoneVen varchar(100),
    primary key(id)
);

-- criação das stored procedures

-- 1

delimiter $
create procedure insere_pessoa(in tipo varchar(10), in nome varchar(100), in endereco varchar(100), in telefone varchar(100))
begin
	if (tipo) is null then
		select 'descreva o tipo!';
	else
		if (nome) is null then
			select 'insira um nome!';
		else
			case tipo
				when 'cli' then 
					insert into cliente(nomeCli, enderecoCli, telefoneCli) values
					(nome, endereco, telefone);
				when 'for' then 
					insert into fornecedor(nomeFor, enderecoFor, telefoneFor) values
					(nome, endereco, telefone);
				when 'fun' then 
					insert into funcionario(nomeFun, enderecoFun, telefoneFun) values
					(nome, endereco, telefone);
				when 'ven' then 
					insert into vendedor(nomeVen, enderecoVen, telefoneVen) values
					(nome, endereco, telefone);
			end case;
        
		end if; -- fim do if(nome) is null then
    end if ; -- fim do if (tipo) is null then
end $
delimiter ;

-- execução da stored procedure

call insere_pessoa(null, 'Vinicius', 'Getulio', '190'); 
call insere_pessoa('cli', null, 'Getulio', '190');
call insere_pessoa('cli', 'Vinicius', 'Getulio', '190');
call insere_pessoa('fun', 'Armando', 'Tiradentes', '193');
call insere_pessoa('ven', 'Gabriel', 'Arnold Layne', '191');
call insere_pessoa('for', 'Joao', 'Getulio', '195');



