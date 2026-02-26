--Trabalho realizado por Victor Hugo Rodrigues Silva e José Antônio dos Santos Filho.

-- 1. Tabela LOCALIZAÇÃO
CREATE TABLE [LOCALIZAÇÃO] (
    [IdLocalizacao] INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY para auto-incremento
    [CEP] NVARCHAR(10),
    [Logradouro] NVARCHAR(255),
    [Cidade] NVARCHAR(255),
    [Estado] NVARCHAR(2),
    [GeoLocalizacao] NVARCHAR(255)
);

-- 2. Tabela CLIENTE
CREATE TABLE [CLIENTE] (
    [IdCliente] INT IDENTITY(1,1) PRIMARY KEY,
    [Nome] NVARCHAR(255) NOT NULL,
    [Email] NVARCHAR(255) UNIQUE NOT NULL,
    [SenhaHash] NVARCHAR(255) NOT NULL,
    [DataNascimento] DATE,
    [Celular] NVARCHAR(20)
);

-- 3. Tabela BARBEARIA
CREATE TABLE [BARBEARIA] (
    [IdBarbearia] INT IDENTITY(1,1) PRIMARY KEY,
    [NomeBarbearia] NVARCHAR(255) NOT NULL,
    [IdLocalizacao] INT,
    -- Definição da Chave Estrangeira
    CONSTRAINT FK_BARBEARIA_LOCALIZACAO FOREIGN KEY ([IdLocalizacao])
        REFERENCES [LOCALIZAÇÃO]([IdLocalizacao])
);

-- 4. Tabela CALENDÁRIO
CREATE TABLE [CALENDÁRIO] (
    [IdCalendario] INT IDENTITY(1,1) PRIMARY KEY,
    [DiaDisponivel] NVARCHAR(20),
    [HorarioDisponivel] NVARCHAR(50),
    [DiasFechados] NVARCHAR(255),
    [IdBarbearia] INT,
    -- Definição da Chave Estrangeira
    CONSTRAINT FK_CALENDARIO_BARBEARIA FOREIGN KEY ([IdBarbearia])
        REFERENCES [BARBEARIA]([IdBarbearia])
);

-- 5. Tabela BARBEIRO
CREATE TABLE [BARBEIRO] (
    [IdBarbeiro] INT IDENTITY(1,1) PRIMARY KEY,
    [Nome] NVARCHAR(255) NOT NULL,
    [Email] NVARCHAR(255) UNIQUE,
    [Celular] NVARCHAR(20),
    [IdBarbearia] INT,
    -- Definição da Chave Estrangeira
    CONSTRAINT FK_BARBEIRO_BARBEARIA FOREIGN KEY ([IdBarbearia])
        REFERENCES [BARBEARIA]([IdBarbearia])
);

-- 6. Tabela PRODUTO
CREATE TABLE [PRODUTO] (
    [IdProduto] INT IDENTITY(1,1) PRIMARY KEY,
    [Nome] NVARCHAR(255) NOT NULL,
    [Validade] DATE,
    [Quantidade] INT,
    [Valor] DECIMAL(10, 2), -- Usando DECIMAL para precisão monetária
    [IdBarbearia] INT,
    -- Definição da Chave Estrangeira
    CONSTRAINT FK_PRODUTO_BARBEARIA FOREIGN KEY ([IdBarbearia])
        REFERENCES [BARBEARIA]([IdBarbearia])
);

-- 7. Tabela SERVIÇO
CREATE TABLE [SERVIÇO] (
    [IdServico] INT IDENTITY(1,1) PRIMARY KEY,
    [NomeServico] NVARCHAR(255) NOT NULL,
    [ValorServico] DECIMAL(10, 2), -- Usando DECIMAL para precisão monetária
    [IdBarbearia] INT,
    -- Definição da Chave Estrangeira
    CONSTRAINT FK_SERVICO_BARBEARIA FOREIGN KEY ([IdBarbearia])
        REFERENCES [BARBEARIA]([IdBarbearia])
);

-- 8. Tabela AGENDAMENTO
CREATE TABLE [AGENDAMENTO] (
    [IdAgendamento] INT IDENTITY(1,1) PRIMARY KEY,
    [DataHora] DATETIME NOT NULL,
    [Status] NVARCHAR(50),
    [IdCliente] INT,
    [IdBarbeiro] INT,
    [IdBarbearia] INT,
    -- Definição das Chaves Estrangeiras
    CONSTRAINT FK_AGENDAMENTO_CLIENTE FOREIGN KEY ([IdCliente])
        REFERENCES [CLIENTE]([IdCliente]),
    CONSTRAINT FK_AGENDAMENTO_BARBEIRO FOREIGN KEY ([IdBarbeiro])
        REFERENCES [BARBEIRO]([IdBarbeiro]),
    CONSTRAINT FK_AGENDAMENTO_BARBEARIA FOREIGN KEY ([IdBarbearia])
        REFERENCES [BARBEARIA]([IdBarbearia])
);

-- 9. Tabela AGENDAMENTO_SERVIÇO (Tabela de ligação N:M)
CREATE TABLE [AGENDAMENTO_SERVIÇO] (
    [IdAgendamento] INT,
    [IdServico] INT,
    -- Definição da Chave Primária Composta
    PRIMARY KEY ([IdAgendamento], [IdServico]),
    -- Definição das Chaves Estrangeiras
    CONSTRAINT FK_AGENDAMENTOSERVICO_AGENDAMENTO FOREIGN KEY ([IdAgendamento])
        REFERENCES [AGENDAMENTO]([IdAgendamento]),
    CONSTRAINT FK_AGENDAMENTOSERVICO_SERVICO FOREIGN KEY ([IdServico])
        REFERENCES [SERVIÇO]([IdServico])
);