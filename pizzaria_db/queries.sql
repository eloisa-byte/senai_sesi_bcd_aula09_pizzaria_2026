show tables;
SELECT COUNT() AS cliente FROM Clientes;
SELECT COUNT() AS pizza FROM Pizzas;
SELECT SUM(quantidade) FROM Itens_Pedido WHERE pedido_id = 3;
SELECT * from Clientes where cliente_id = 2;
SELECT nome FROM pizzas where pizza_id in (select pizza_id from itens_pedido  where pedido_id = 3);

--Um novo cliente
INSERT INTO Clientes (cliente_id, cep, logradouro, numero, bairro, referencia, telefone) VALUES (Gaspar Oliveira, 13905-620, Rua Alcides Postali, 21, São Dimas, Ao lado da igreja, 19 99898-1141);

--Acrescentar pizza
insert into pizzas (
    nome,
    descricao,
    valor
) values (
    'a moda do chef',
    'molho de tomate, palmito macio em rodelas, coberto com catupiry, frango desfiado, ovos, carne seca, oregano e azeitonas',
    41.90
);


insert into pedidos (cliente_id)
select cliente_id
from clientes
where nome = 'gaspar oliveira';



insert into itens_pedido (
    pedido_id,
    pizza_id,
    quantidade
)
select
    (select max(pedido_id) from pedidos),
    pizza_id,
    2
from pizzas
where nome = 'a moda do chef';


update itens_pedido
set quantidade = 3
where pedido_id = (
    select max(pedido_id) from pedidos
)
and pizza_id = (
    select pizza_id
    from pizzas
    where nome = 'a moda do chef'
);


insert into itens_pedido (
    pedido_id,
    pizza_id,
    quantidade
)
select
    (select max(pedido_id) from pedidos),
    pizza_id,
    1
from pizzas
where nome = 'margherita';

--Verificando
select * from clientes
where nome like '%Gaspar%';

select * from pizzas
where nome like '%chef%';