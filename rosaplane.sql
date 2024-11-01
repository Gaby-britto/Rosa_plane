CREATE DATABASE rosaplane;
USE rosaplane;

CREATE TABLE destino (
    id_destino INT PRIMARY KEY AUTO_INCREMENT,
    nome_destino VARCHAR(100),
    pais VARCHAR(100),
    descricao VARCHAR(100)
);

INSERT INTO destino (nome_destino, pais, descricao) VALUES
('Bahia', 'Brasil', 'Porto-Seguro'),
('Rio de Janeiro', 'Brasil', 'Ipanema'),
('Rio de Janeiro', 'Brasil', 'Cabo Frio');

CREATE TABLE pacotes (
    id_pacote INT PRIMARY KEY AUTO_INCREMENT,
    id_destino INT,
    nome_pacote VARCHAR(100),
    preco VARCHAR(100),
    data_inicio DATE,
    data_termino DATE,
    FOREIGN KEY (id_destino) REFERENCES destino(id_destino)
);

INSERT INTO pacotes (id_destino, nome_pacote, preco, data_inicio, data_termino) VALUES
(1, 'Pacote para Bahia', 'R$ 1.200,00', '2024-12-01', '2024-12-16'),
(2, 'Conheça o Rio de Janeiro', 'R$ 2.000,00', '2025-01-23', '2025-01-30'),
(3, 'A melhor praia do RJ', 'R$ 600,00', '2024-11-05', '2024-11-08');

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome_cliente VARCHAR(100),
    email VARCHAR(100),
    telefone VARCHAR(100),
    endereco VARCHAR(100)
);

INSERT INTO clientes (nome_cliente, email, telefone, endereco) VALUES
('Gaby', 'gaby@gmail.com', '(11) 97777-7777', 'Itatuba'),
('Ana Bea', 'anaBea@gmail.com', '(11) 98888-8888', 'Jd. Sandra'),
('Rafael', 'rafael@gmail.com', '(11) 99999-9999', 'Taboão da Serra');

CREATE TABLE reservas (
    id_reserva INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    id_pacote INT,
    data_reserva DATE,
    numero_pessoas INT,
    status_reserva ENUM ('Confirmada', 'Pendente', 'Cancelada'),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_pacote) REFERENCES pacotes(id_pacote)
);

INSERT INTO reservas (id_cliente, id_pacote, data_reserva, numero_pessoas, status_reserva) VALUES
(1, 1, '2024-10-25', 2, 'Confirmada'),
(2, 3, '2024-10-30', 3, 'Cancelada'),
(3, 2, '2025-01-01', 5, 'Pendente');

-- Número de pessoas que viajaram conosco
CREATE VIEW visualizar_total_pessoas_viajantes AS
SELECT SUM(numero_pessoas) AS qtdTotal FROM reservas;
SELECT * FROM visualizar_total_pessoas_viajantes;

-- Verificar o email do cliente e o nome
CREATE VIEW clientes_email AS
SELECT clientes.id_cliente, clientes.nome_cliente, clientes.email FROM clientes;
SELECT * FROM clientes_email;

-- Verificar o cliente e dados do seu pedido
CREATE VIEW cliente_pedido AS
SELECT clientes.nome_cliente, reservas.data_reserva, pacotes.nome_pacote, destino.nome_destino 
FROM clientes
INNER JOIN reservas ON clientes.id_cliente = reservas.id_cliente
INNER JOIN pacotes ON pacotes.id_pacote = reservas.id_pacote
INNER JOIN destino ON destino.id_destino = pacotes.id_destino;
SELECT * FROM cliente_pedido;
