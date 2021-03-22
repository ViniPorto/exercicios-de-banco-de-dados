create database dbProdutos10Jun2020;
use dbProdutos10Jun2020;

create table produto(
	id int not null auto_increment,
    nome varchar(50),
    preco float,
    primary key(id)
);

insert into produto(nome, preco) values
("Maçã", 5.00),
("Limão", 3.50),
("Morango", 4.00),
("Laranja", 2.50);

delimiter $
create procedure calcularValorCompra()
begin
	declare fim integer default 0;
    declare preco_prod float default 0;
    declare valorTotal float default 0;
    -- declarar o cursor
    declare cursorProduto cursor for select preco from produto;
    declare continue handler for not found set fim = 1;
    
    -- abrir o cursor
    open cursorProduto;
	
    -- buscando e manipulando os dados do cursor que é o resultado do select
    meuloop: LOOP
		FETCH cursorProduto into preco_prod;
        if fim then
			leave meuloop;
        end if;
        set valorTotal = valorTotal + preco_prod;
    end LOOP meuloop;
    
    -- fechando o cursor
    close cursorProduto;
    
    -- para mostrar o resultado
    select valorTotal;
end $
delimiter ;		

delimiter $
create procedure calcularValorCompra2(out valorTotal float)
begin
	declare fim integer default 0;
    declare preco_prod float default 0;
		
    -- declarar o cursor
    declare cursorProduto cursor for select preco from produto;
    declare continue handler for not found set fim = 1;
    
    -- abrir o cursor
    open cursorProduto;
	
    -- buscando e manipulando os dados do cursor que é o resultado do select
    
    set valorTotal = 0;
    
    meuloop: LOOP
		FETCH cursorProduto into preco_prod;
        if fim then
			leave meuloop;
        end if;
        set valorTotal = valorTotal + preco_prod;
    end LOOP meuloop;
    
    -- fechando o cursor
    close cursorProduto;
    
    -- para mostrar o resultado
    -- select valorTotal;
end $
delimiter ;	

call calcularValorCompra();	

call calcularValorCompra2(@valorTotal);
select @valorTotal