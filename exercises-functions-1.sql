
DROP TABLE IF EXISTS  LOCACAO;
DROP TABLE IF EXISTS  RESERVA;
DROP TABLE IF EXISTS  DVD;
DROP TABLE IF EXISTS  STATUS;
DROP TABLE IF EXISTS  FILME;
DROP TABLE IF EXISTS  CATEGORIA;
DROP TABLE IF EXISTS  CLIENTE;


CREATE TABLE  CLIENTE
   (    CODCLIENTE serial, 
    	NOME_CLIENTE VARCHAR(30) NOT NULL, 
    	ENDERECO VARCHAR(50) NOT NULL, 
    	TELEFONE VARCHAR(12) NOT NULL, 
    	DATA_NASC DATE NOT NULL, 
    	CPF VARCHAR(11) NOT NULL, 
     	CONSTRAINT PK_CLIENTE PRIMARY KEY (CODCLIENTE),
	CONSTRAINT CPF_UNIQUE UNIQUE (CPF)
   );

CREATE TABLE  CATEGORIA 
   (    CODCATEGORIA serial, 
    	NOME_CATEGORIA VARCHAR(100) NOT NULL, 
     	CONSTRAINT CATEGORIA_PK PRIMARY KEY (CODCATEGORIA), 
     	CONSTRAINT CHECK_NOME_CATEGORIA CHECK ( NOME_CATEGORIA in ('drama','terror','ação','aventura','comédia'))
   );

CREATE TABLE  FILME 
   (    CODFILME serial, 
    	CODCATEGORIA int, 
    	NOME_FILME VARCHAR(100) NOT NULL, 
    	DIARIA numeric(10,2) NOT NULL, 
     	CONSTRAINT PK_FILME PRIMARY KEY (CODFILME), 
     	CONSTRAINT FK_FIL_CAT FOREIGN KEY (CODCATEGORIA)
      		REFERENCES  CATEGORIA (CODCATEGORIA)
		ON DELETE NO ACTION ON UPDATE CASCADE
   );

CREATE TABLE  STATUS 
   (    CODSTATUS SERIAL, 
    	NOME_STATUS VARCHAR(30) NOT NULL, 
     	CONSTRAINT PK_STATUS PRIMARY KEY (CODSTATUS),
     	CONSTRAINT CHECK_NOME_STATUS CHECK ( NOME_STATUS in ('reservado','disponível','indisponível','locado'))

   );

CREATE TABLE  DVD 
   (    CODDVD SERIAL, 
    	CODFILME int NOT NULL, 
    	CODSTATUS int NOT NULL, 
     	CONSTRAINT PK_DVD PRIMARY KEY (CODDVD), 
     	CONSTRAINT FK_DVD_FIL FOREIGN KEY (CODFILME)
      		REFERENCES  FILME (CODFILME) ON UPDATE CASCADE, 
     	CONSTRAINT FK_DVD_STA FOREIGN KEY (CODSTATUS)
      		REFERENCES  STATUS (CODSTATUS) ON UPDATE CASCADE
   );

CREATE TABLE  LOCACAO 
   (    CODLOCACAO SERIAL, 
    	CODDVD int NOT NULL, 
    	CODCLIENTE int NOT NULL, 
    	DATA_LOCACAO DATE NOT NULL DEFAULT NOW(), 
    	DATA_DEVOLUCAO DATE, 
     	CONSTRAINT PK_LOCACAO PRIMARY KEY (CODLOCACAO), 
     	CONSTRAINT FK_LOC_DVD FOREIGN KEY (CODDVD)
      		REFERENCES  DVD (CODDVD) ON DELETE SET NULL ON UPDATE CASCADE, 
     	CONSTRAINT FK_LOC_CLI FOREIGN KEY (CODCLIENTE)
      		REFERENCES  CLIENTE (CODCLIENTE) ON DELETE SET NULL ON UPDATE CASCADE
   );

CREATE TABLE  RESERVA 
   (    CODRESERVA SERIAL, 
    	CODDVD int NOT NULL, 
    	CODCLIENTE int NOT NULL, 
 	DATA_RESERVA DATE DEFAULT NOW(), 
    	DATA_VALIDADE DATE NOT NULL, 
     	CONSTRAINT PK_RESERVA PRIMARY KEY (CODRESERVA), 
     	CONSTRAINT FK_RES_DVD FOREIGN KEY (CODDVD)
      		REFERENCES  DVD (CODDVD) ON DELETE SET NULL ON UPDATE CASCADE, 
     	CONSTRAINT FK_RES_CLI FOREIGN KEY (CODCLIENTE)
      		REFERENCES  CLIENTE (CODCLIENTE) ON DELETE SET NULL ON UPDATE CASCADE
   );

--inserts

INSERT INTO STATUS (NOME_STATUS) VALUES ('reservado');
INSERT INTO STATUS (NOME_STATUS) VALUES ('disponível');    
INSERT INTO STATUS (NOME_STATUS) VALUES ('locado');
INSERT INTO STATUS (NOME_STATUS) VALUES ('indisponível');
    
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ('comédia');    
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ( 'aventura');
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ( 'terror');    
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ( 'ação');
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ( 'drama');

INSERT INTO CLIENTE (NOME_CLIENTE,ENDERECO,TELEFONE,DATA_NASC,CPF ) VALUES ('João Paulo', 'rua XV de novembro, n:18', '88119922','05-02-1990','09328457398');
INSERT INTO CLIENTE (NOME_CLIENTE,ENDERECO,TELEFONE,DATA_NASC,CPF ) VALUES ('Maria', 'rua XV de novembro, n:20', '88225422','07-01-1991','93573923168');
INSERT INTO CLIENTE (NOME_CLIENTE,ENDERECO,TELEFONE,DATA_NASC,CPF ) VALUES ('Joana', 'rua XV de novembro, n:10', '99778122','09-07-1980','71398987234');
INSERT INTO CLIENTE (NOME_CLIENTE,ENDERECO,TELEFONE,DATA_NASC,CPF ) VALUES ('Jeferson', 'rua XV de novembro, n:118', '84549922','09-12-1982','02128443298');
INSERT INTO CLIENTE (NOME_CLIENTE,ENDERECO,TELEFONE,DATA_NASC,CPF ) VALUES ('Paula', 'rua XV de novembro, n:128', '82324232','11-04-1970','57398093284');

INSERT INTO FILME (CODCATEGORIA, NOME_FILME,DIARIA ) VALUES (1,'Entrando numa fria', 1.50);    
INSERT INTO FILME (CODCATEGORIA, NOME_FILME,DIARIA ) VALUES (2,'O Hobbit', 3.00);    
INSERT INTO FILME (CODCATEGORIA, NOME_FILME,DIARIA ) VALUES (3,'Sobrenatural 2', 4.50);    
INSERT INTO FILME (CODCATEGORIA, NOME_FILME,DIARIA ) VALUES (5,'Um sonho de liberdade', 1.50);
INSERT INTO FILME (CODCATEGORIA, NOME_FILME,DIARIA ) VALUES (2,'Thor 2', 4.50);
INSERT INTO FILME (CODCATEGORIA, NOME_FILME,DIARIA ) VALUES (4,'Velozes e Furiosos', 1.50);

INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (1,1);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (2,2);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (2,3);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (3,2);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (4,2);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (4,3);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (5,1);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (6,3);

INSERT INTO RESERVA (CODDVD,CODCLIENTE,DATA_RESERVA,DATA_VALIDADE) VALUES(1,2,current_date,(current_date+4)); 
INSERT INTO RESERVA (CODDVD,CODCLIENTE,DATA_RESERVA,DATA_VALIDADE) VALUES(5,1,current_date,(current_date+4)); 
INSERT INTO RESERVA (CODDVD,CODCLIENTE,DATA_RESERVA,DATA_VALIDADE) VALUES(6,2,(current_date-30),(current_date-26)); 
INSERT INTO RESERVA (CODDVD,CODCLIENTE,DATA_RESERVA,DATA_VALIDADE) VALUES(6,3,(current_date-4),(current_date-1)); 
INSERT INTO RESERVA (CODDVD,CODCLIENTE,DATA_RESERVA,DATA_VALIDADE) VALUES(6,1,(current_date-20),(current_date-16)); 

INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) VALUES(1,1,(current_date-30),(current_date-28));
INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) VALUES(2,3,(current_date-25),(current_date-23));
INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) VALUES(1,1,(current_date-1),current_date);
INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) VALUES(3,2,(current_date-1),null); 
INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) VALUES(6,2,current_date,null); 
INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) VALUES(8,2,current_date,null);


-- ==========================================================
-- 1️⃣ list_num_par(a int) - Exibe se cada número de 0 até a-1
-- é par ou ímpar.
-- ==========================================================
CREATE OR REPLACE FUNCTION list_num_par(a int) RETURNS void AS
$$
DECLARE
    x int := 0;
BEGIN
    WHILE x < a LOOP
        IF x % 2 = 0 THEN
            RAISE NOTICE '% é par', x;
        ELSE
            RAISE NOTICE '% é ímpar', x;
        END IF;

        x := x + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- ==========================================================
-- 2️⃣ list_tabuada(num int) - Exibe a tabuada de 0 a 10 para
-- números entre 0 e 9.
-- ==========================================================
CREATE OR REPLACE FUNCTION list_tabuada(num int) RETURNS void AS
$$
DECLARE
    x int := 0;
BEGIN
    IF num >= 0 AND num < 10 THEN
        WHILE x <= 10 LOOP
            RAISE NOTICE '% x % = %', num, x, num * x;
            x := x + 1;
        END LOOP;
    ELSE
        RAISE EXCEPTION 'Numero fora do intervalo (0–9)';
    END IF;
END;
$$ LANGUAGE plpgsql;

-- ==========================================================
-- 3️⃣ list_fatorial(num int) - Exibe o fatorial de num.
-- ==========================================================
CREATE OR REPLACE FUNCTION list_fatorial(num int) RETURNS void AS
$$
DECLARE
    resultado bigint := 1;
    i int;
BEGIN
    IF num < 0 THEN
        RAISE EXCEPTION 'Fatorial não existe para números negativos!';
    END IF;

    FOR i IN 2..num LOOP
        resultado := resultado * i;
    END LOOP;

    RAISE NOTICE '%! = %', num, resultado;
END;
$$ LANGUAGE plpgsql;

-- ==========================================================
-- 4️⃣ del_cliente(cod int) - Exclui cliente e retorna TRUE
-- se excluído ou FALSE se não encontrado.
-- ==========================================================
CREATE OR REPLACE FUNCTION del_cliente(cod int) RETURNS boolean AS
$$
BEGIN
    DELETE FROM cliente
    WHERE codcliente = cod;

    IF FOUND THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- ==========================================================
-- 5️⃣ inserir_cliente(...) - Insere cliente e retorna seu cod.
-- ==========================================================
CREATE OR REPLACE FUNCTION inserir_cliente(
    p_nome varchar,
    p_email varchar,
    p_telefone varchar
) RETURNS integer AS
$$
DECLARE
    v_cod integer;
BEGIN
    INSERT INTO cliente (nome, email, telefone)
    VALUES (p_nome, p_email, p_telefone)
    RETURNING codcliente INTO v_cod;

    RETURN v_cod;
END;
$$ LANGUAGE plpgsql;

-- ==========================================================
-- 6️⃣ insere_cliente(...) - Insere cliente e retorna TRUE.
-- Dispara EXCEPTION se o CPF informado estiver registrado.
-- ==========================================================
CREATE OR REPLACE FUNCTION insere_cliente (
    p_nome VARCHAR,
    p_endereco VARCHAR,
    p_telefone VARCHAR,
    p_data_nasc DATE,
    p_cpf VARCHAR
) RETURNS BOOLEAN AS $$
DECLARE
    v_existente BOOLEAN;
BEGIN
    SELECT EXISTS(SELECT 1 FROM cliente WHERE cpf = p_cpf) INTO v_existente;

    IF v_existente THEN
        RAISE EXCEPTION 'Cliente ja existe com cpf';
    ELSE
        INSERT INTO cliente (nome_cliente, endereco, telefone, data_nasc, cpf)
        VALUES (p_nome, p_endereco, p_telefone, p_data_nasc, p_cpf);
        RETURN TRUE;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- ==========================================================
-- 7️⃣ list_categoria(f_nome_categoria) - Exibe a quantidade
-- de filmes e DVDs para uma categoria específica.
-- ==========================================================
CREATE OR REPLACE FUNCTION list_categoria(f_nome_categoria varchar) RETURNS void AS
$$
DECLARE
    existe boolean;
    total_filmes int;
    total_dvds int;
BEGIN
    SELECT EXISTS (
        SELECT 1 
        FROM categoria 
        WHERE nome_categoria = f_nome_categoria
    ) INTO existe;

    IF NOT existe THEN
        RAISE EXCEPTION 'Não existe essa categoria';
    ELSE
        SELECT COUNT(DISTINCT f.codfilme), COUNT(DISTINCT d.codfilme)
        INTO total_filmes, total_dvds
        FROM filme AS f
        LEFT JOIN dvd AS d ON d.codfilme = f.codfilme
        INNER JOIN categoria AS c ON c.codcategoria = f.codcategoria
        WHERE c.nome_categoria = f_nome_categoria;

        RAISE NOTICE 'Categoria: %, Filmes: %, DVDs: %',
            f_nome_categoria, total_filmes, total_dvds;
    END IF;

END;
$$ LANGUAGE plpgsql;

-- ==========================================================
-- 8️⃣ filme_mais_locado() - Retorna o nome do filme mais locado.
-- ==========================================================
CREATE OR REPLACE FUNCTION filme_mais_locado()
RETURNS varchar AS
$$
DECLARE
    nome_resultado varchar;
BEGIN
    SELECT f.nome_filme
      INTO nome_resultado
      FROM locacao AS l
      INNER JOIN filme AS f ON f.codfilme = l.codfilme
      GROUP BY f.nome_filme
      ORDER BY COUNT(*) DESC
      LIMIT 1;

    RETURN nome_resultado;
END;
$$ LANGUAGE plpgsql;

-- ==========================================================
-- 9️⃣ qtd_dvds_cliente(f_nome_cliente) - Retorna quantos DVDs
-- foram locados por todos clientes com o nome especificado.
-- ==========================================================
CREATE OR REPLACE FUNCTION qtd_dvds_cliente(f_nome_cliente VARCHAR) 
RETURNS integer AS
$$
DECLARE
    total integer;
BEGIN
    SELECT COUNT(*)
      INTO total
      FROM locacao AS l
      INNER JOIN cliente AS c ON c.codcliente = l.codcliente
      WHERE c.nome_cliente = f_nome_cliente;

    RETURN total;
END;
$$ LANGUAGE plpgsql;

-- ==========================================================
-- 🔟 inserir_locacao(f_nome_filme, f_nome_cliente) - Insere
-- uma locação e retorna TRUE (sucesso) ou FALSE (sem DVD).
-- ==========================================================
CREATE OR REPLACE FUNCTION inserir_locacao(f_nome_filme VARCHAR, f_nome_cliente VARCHAR) 
RETURNS boolean AS
$$
DECLARE
    v_codcliente integer;
    v_coddvd integer;
BEGIN
    SELECT codcliente INTO v_codcliente
      FROM cliente
      WHERE nome_cliente = f_nome_cliente
      LIMIT 1;

    IF v_codcliente IS NULL THEN
        RAISE NOTICE 'Cliente "%" não encontrado.', f_nome_cliente;
        RETURN FALSE;
    END IF;

    SELECT d.coddvd
      INTO v_coddvd
      FROM dvd d
      INNER JOIN filme f ON f.codfilme = d.codfilme
      WHERE f.nome_filme = f_nome_filme
        AND d.status = 'disponivel'
      LIMIT 1;

    IF v_coddvd IS NULL THEN
        RETURN FALSE;
    END IF;

    INSERT INTO locacao (codcliente, coddvd, data_locacao) 
    VALUES (v_codcliente, v_coddvd, CURRENT_DATE);

    UPDATE dvd
       SET status = 'locado'
       WHERE coddvd = v_coddvd;

    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;

-- ==========================================================
-- 1️⃣1️⃣ inserir_locacao_ex(f_nome_filme, f_nome_cliente) -
-- Insere locação e gera EXCEPTION se não houver DVD disponível.
-- ==========================================================
CREATE OR REPLACE FUNCTION inserir_locacao_ex(f_nome_filme VARCHAR, f_nome_cliente VARCHAR) 
RETURNS void AS
$$
DECLARE
    v_codcliente integer;
    v_coddvd integer;
BEGIN
    SELECT codcliente INTO v_codcliente
      FROM cliente
      WHERE nome_cliente = f_nome_cliente
      LIMIT 1;

    IF v_codcliente IS NULL THEN
        RAISE EXCEPTION 'Cliente "%" não encontrado.', f_nome_cliente;
    END IF;

    SELECT d.coddvd
      INTO v_coddvd
      FROM dvd d
      INNER JOIN filme f ON f.codfilme = d.codfilme
      WHERE f.nome_filme = f_nome_filme
        AND d.status = 'disponivel'
      LIMIT 1;

    IF v_coddvd IS NULL THEN
        RAISE EXCEPTION 'Nenhum DVD disponível para o filme "%".', f_nome_filme;
    END IF;

    INSERT INTO locacao (codcliente, coddvd, data_locacao) 
    VALUES (v_codcliente, v_coddvd, CURRENT_DATE);

    UPDATE dvd
       SET status = 'locado'
       WHERE coddvd = v_coddvd;

END;
$$ LANGUAGE plpgsql;

-- ==========================================================
-- 1️⃣2️⃣ atualiza_status_dvds() - Altera status para 'disponivel'
-- de DVDs com reserva vencida.
-- ==========================================================
CREATE OR REPLACE PROCEDURE atualiza_status_dvds() AS
$$
BEGIN
    UPDATE dvd d
       SET status = 'disponivel'
      WHERE status = 'reservado'
        AND EXISTS (
            SELECT 1
              FROM reserva r
             WHERE r.coddvd = d.coddvd
             GROUP BY r.coddvd
            HAVING MAX(r.data_validade) < CURRENT_DATE
        );
END;
$$ LANGUAGE plpgsql;

