-- Relatório que mostra todos os pedidos e o nome de cada cliente
SELECT * FROM pedidos;
SELECT p.*, c.nome  FROM pedidos p INNER JOIN clientes c
ON p.cliente_id = c.cliente_id;
-- Salvar a consulta como uma VIEW / Relatório
CREATE VIEW vw_pedidos1 AS
SELECT p.*, c.nome  FROM pedidos p INNER JOIN clientes c
ON p.cliente_id = c.cliente_id;
-- Para ver o resultado
SELECT * FROM vw_pedidos1;

--relatório que mostre todos os pedidos, itens, nome dos - clientes e nome das pizzas
CREATE VIEW vw_relatório as
SELECT p.*, i.*, c.nome, pi.nome FROM pedidos p INNER JOIN clientes c ON p.cliente_id = c.cliente_id INNER JOIN itens_pedido i ON p.pedido_id = i.pedido_id INNER JOIN pizzas pi ON i.pizza_id = pi.pizza_id;

-- Acrescente uma coluna chamada subtotal que seja o calculo do preco - unitário da pizza vezes a quantidade
CREATE VIEW vw_tabela_subtotal as
CREATE TABLE IF NOT EXISTS subtotal (id INT NOT NULL AUTO_INCREMENT, id_pedido INT NOT NULL, id_produto INT NOT NULL, quantidade INT NOT NULL, preco_unitario DECIMAL(10, 2) NOT NULL, valor_subtotal DECIMAL(10, 2) GENERATED ALWAYS AS (quantidade * preco_unitario) STORED, PRIMARY KEY (id));

--Agrupe os pedidos e calcule o valor total
CREATE VIEW vw_valor_total_pedidos as
SELECT p.pedido_id, c.nome AS cliente, SUM(ip.valor * ip.quantidade) AS valor_total FROM pedidos p INNER JOIN clientes c ON p.cliente_id = c.cliente_id INNER JOIN itens_pedido ip ON p.pedido_id = ip.pedido_id GROUP BY p.pedido_id, c.nome;

-- Agrupe os pedidos e conte quantas pizzas cada pedido possui
CREATE VIEW vw_quantidade_pizzas as
SELECT p.pedido_id, c.nome AS cliente, SUM(ip.quantidade) AS quantidade_pizzas FROM pedidos p INNER JOIN clientes c ON p.cliente_id = c.cliente_id INNER JOIN itens_pedido ip ON p.pedido_id = ip.pedido_id GROUP BY p.pedido_id, c.nome;