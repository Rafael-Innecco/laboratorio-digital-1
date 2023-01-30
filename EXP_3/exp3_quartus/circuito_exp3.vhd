library ieee;
use ieee.std_logic_1164.all;

entity circuito_exp3 is
    port (
        clock        : in std_logic;
        reset        : in std_logic;
        iniciar      : in std_logic;
        chaves       : in std_logic_vector (3 downto 0);
        pronto       : out std_logic;
		db_contaC	 : out std_logic;
		db_zeraC	 : out std_logic;
		db_fimC		 : out std_logic;
		db_zeraR	 : out std_logic;
		db_registraR : out std_logic;
        db_igual     : out std_logic;
        db_iniciar   : out std_logic;
        db_contagem  : out std_logic_vector (6 downto 0);
        db_memoria   : out std_logic_vector (6 downto 0);
        db_chaves    : out std_logic_vector (6 downto 0);
        db_estado    : out std_logic_vector (6 downto 0)
    );
end entity;

architecture estrutural of circuito_exp3 is

    component fluxo_dados
        port (
            clock              : in  std_logic;
            zeraC              : in  std_logic;
            contaC             : in  std_logic;
            escreveM           : in  std_logic;
            zeraR              : in  std_logic;
            registraR          : in std_logic;
            chaves             : in  std_logic_vector (3 downto 0);
            chavesIgualMemoria : out std_logic;
            fimC               : out std_logic;
            db_contagem        : out std_logic_vector (3 downto 0);
            db_memoria         : out std_logic_vector (3 downto 0);
            db_chaves          : out std_logic_vector(3 downto 0)
        );
    end component;

    component unidade_controle
        port (
            clock     : in  std_logic; 
            reset     : in  std_logic; 
            iniciar   : in  std_logic;
            fimC      : in  std_logic;
            zeraC     : out std_logic;
            contaC    : out std_logic;
            zeraR     : out std_logic;
            registraR : out std_logic;
            pronto    : out std_logic;
            db_estado : out std_logic_vector(3 downto 0)
        );
    end component;

    component hexa7seg
        port (
            hexa    : in std_logic_vector (3 downto 0);
            sseg    : out std_logic_vector (6 downto 0)
        );
    end component;

    signal contaC, registraR, zeraC, zeraR, fimC, chavesIgualMemoria: std_logic := '0';
    signal db_chaveshex, db_contagemhex, db_memoriahex, db_estadohex: std_logic_vector (3 downto 0) := "0000";
begin
    fluxo_dadosFD: fluxo_dados
        port map (
            clock => clock,
            zeraC => zeraC,
            contaC => contaC,
            escreveM => '0',
            zeraR => zeraR,
            registraR => registraR,
            chaves => chaves,
            chavesIgualMemoria => chavesIgualMemoria,
            fimC => fimC,
            db_contagem => db_contagemhex,
            db_memoria => db_memoriahex,
            db_chaves => db_chaveshex
        );
    --

   

    unidade_controleUC: unidade_controle
        port map (
            clock => clock,
            reset => reset,
            iniciar => iniciar,
            fimC => fimC,
            zeraC => zeraC,
            contaC => contaC,
            zeraR => zeraR,
            registraR => registraR,
            pronto => pronto,
            db_estado => db_estadohex

        ); 
    --
	hex7estado: hexa7seg
		port map( 
			hexa => db_estadohex,
			sseg => db_estado
		);
	--
    hex7chaves: hexa7seg
        port map (
            hexa => db_chaveshex,
            sseg => db_chaves
        );
    --

    hex7contagem: hexa7seg
        port map (
            hexa => db_contagemhex,
            sseg => db_contagem
        );
    --

    hex7memoria: hexa7seg
        port map (
            hexa => db_memoriahex,
            sseg => db_memoria
        );
    --

    db_igual   <= chavesIgualMemoria;
    db_iniciar <= iniciar;
	db_zeraC   <= zeraC;
	db_contaC  <= contaC;
	db_fimC    <= fimC;
	db_zeraR   <= zeraR;
	db_registraR <= registraR;
end architecture estrutural;