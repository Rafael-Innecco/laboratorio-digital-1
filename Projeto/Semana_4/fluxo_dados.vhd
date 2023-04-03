--------------------------------------------------------------------
-- Arquivo   : fluxo_dados.vcd
-- Projeto   : Experiencia 2 - Um Fluxo de Dados Simples
--------------------------------------------------------------------
-- Descricao :
--    Circuito do fluxo de dados do projeto da disciplina
--
--------------------------------------------------------------------
-- Revisoes  :
--     Data        Versao  Autor             Descricao
--     11/01/2022  1.0     Edson Midorikawa  versao inicial
--     07/01/2023  1.1     Edson Midorikawa  revisao
--     10/02/2023  1.1.1   Edson Midorikawa  arquivo parcial
--     11/03/2023  2.0     Rafael Innecco    Modificacao inicial para projeto
--------------------------------------------------------------------
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity fluxo_dados is
    port (
        clock           : in  std_logic;
        chaves          : in  std_logic_vector (3 downto 0);
        seletor_modo    : in std_logic_vector (2 downto 0);
        -------------------------------------
        zeraC           : in  std_logic; -- novo nome: zeraC -> zeraC
        contaC          : in  std_logic; -- novo nome: contaC -> contaC
        carregaC        : in  std_logic;
        escreveM        : in  std_logic;
        zeraR  	        : in  std_logic;
        registraR       : in std_logic;
        contaT	        : in std_logic;
        contaT2         : in std_logic;
        zeraT           : in std_logic;
        atualizaP       : in std_logic;
        diminuiP_jogada : in std_logic;
        resetaP_jogada  : in std_logic;
        zeraP           : in std_logic;
        registra_modo   : in std_logic;
        -------------------------------------
        igual           : out std_logic;
        fim_jogo        : out std_logic; -- novo sinal: saida do contador de rodada
        jogada_feita    : out std_logic;
        fim_tempo       : out std_logic;
        fim_tempo_2     : out std_logic;
        fim_espera      : out std_logic;
        modo_escrita    : out std_logic;
        -------------------------------------
        db_tem_jogada   : out std_logic; 
        db_contagem     : out std_logic_vector (6 downto 0);
        db_memoria      : out std_logic_vector (3 downto 0);
        db_chaves       : out std_logic_vector (3 downto 0);
        leds            : out std_logic_vector (15 downto 0);
        pontuacao_dec   : out std_logic_vector (11 downto 0);
        -------------------------------------
        clock_interno   : out std_logic;
        buzzer          : out std_logic
    );
end entity;

architecture estrutural of fluxo_dados is
    component comparador_85
        port (
            i_A3   : in  std_logic;
            i_B3   : in  std_logic;
            i_A2   : in  std_logic;
            i_B2   : in  std_logic;
            i_A1   : in  std_logic;
            i_B1   : in  std_logic;
            i_A0   : in  std_logic;
            i_B0   : in  std_logic;
            i_AGTB : in  std_logic;
            i_ALTB : in  std_logic;
            i_AEQB : in  std_logic;
            o_AGTB : out std_logic;
            o_ALTB : out std_logic;
            o_AEQB : out std_logic
        );
    end component;

    component ram_Sx4 is
	  generic (
		 constant S  : integer := 128
			);
	port (       
			 clk          : in  std_logic;
			 endereco     : in  std_logic_vector(natural(ceil(log2(real(S)))) - 1 downto 0);
			 dado_entrada : in  std_logic_vector(3 downto 0);
			 we           : in  std_logic;
			 ce           : in  std_logic;
			 dado_saida   : out std_logic_vector(3 downto 0);
			 next_data    : out std_logic_vector(15 downto 0);
			 last_data    : out std_logic_vector(15 downto 0)
		 );
    end component;

-- Adicionado --
    component registrador_n is
        generic (
            constant N: integer := 8 
        );
        port (
            clock  : in  std_logic;
            clear  : in  std_logic;
            enable : in  std_logic;
            D      : in  std_logic_vector (N-1 downto 0);
            Q      : out std_logic_vector (N-1 downto 0) 
        );
    end component;

    component edge_detector is
        port (
            clock : in std_logic;
            reset : in std_logic;
            sinal : in std_logic;
            pulso : out std_logic
        );
    end component;

    component contador_m is
        generic (
            constant M : integer := 100
        );
        port (
            clock	    : in std_logic;
            zera_as	    : in std_logic;
            zera_s	    : in std_logic;
            conta		: in std_logic;
            Q			: out std_logic_vector(natural(ceil(log2(real(M)))) - 1 downto 0);
            fim		    : out std_logic;
            meio	: out std_logic
        );
    end component;

    component shift_register is
        generic(
            constant N            : integer := 8;
            constant reset_value  : integer := 0
        );
        port (
            clock     : in std_logic;
            clear     : in std_logic;
            enable_l  : in std_logic;
            enable_s  : in std_logic;
            D         : in std_logic_vector(N-1 downto 0);
            Q         : out std_logic_vector(N-1 downto 0)
        );
    end component;

    component contador_modificado is
        generic (
            constant M  : integer := 100;
            constant P1 : integer := 50;
            constant P2 : integer := 25
        );
        port (
            clock    	: in  std_logic;
            zera_as  	: in  std_logic;
            zera_s   	: in  std_logic;
            conta    	: in  std_logic;
            load        : in  std_logic;
            D           : in  std_logic_vector(natural(ceil(log2(real(M))))-1 downto 0);
            Q        	: out std_logic_vector(natural(ceil(log2(real(M))))-1 downto 0);
            fim         : out std_logic;
            ponto_1     : out std_logic;
            ponto_2     : out std_logic
        );
    end component;

    component somador is
        generic (
            size: natural := 8
        );
        port (
            A, B    : in std_logic_vector (size - 1 downto 0);
            S       : in std_logic;
            F       : out std_logic_vector (size-1 downto 0);
            Z       : out std_logic;
            N       : out std_logic;
            Ov      : out std_logic;
            Co      : out std_logic
        );
    end component;

    component hexDecimal is
        port (
            hexa    : in std_logic_vector (3 downto 0);
            Cin     : in std_logic;
            dec     : out std_logic_vector (3 downto 0);
            Cout    : out std_logic
        );
    end component;

    component edge_holder is
        generic(
            constant size : natural := 8
        );
        port (
            clock   : in std_logic;
            reset   : in std_logic;
            entrada : in std_logic_vector (size-1 downto 0);
            saida   : out std_logic_vector (size-1 downto 0)
        );
    end component;

    component somador_decimal is
        generic (
            digits : natural := 3
        );
        port (
            A : in std_logic_vector (4*digits - 1 downto 0);
            B : in std_logic_vector (3 downto 0);
            F : out std_logic_vector (4*digits -1 downto 0)
        );
    end component;

    component seletor_som is
        port (
            clock   : in std_logic;
            toca    : in std_logic_vector(3 downto 0);
            saida   : out std_logic
        );
    end component;

    signal clock_int            : std_logic; -- Sinal de clock interno de 1kHz 
    signal clk_1, clk_2         : std_logic;

    signal s_endereco           : std_logic_vector (6 downto 0);
    signal s_dado         	    : std_logic_vector (3 downto 0);
    signal s_dado_alternativo   : std_logic_vector (3 downto 0);
    signal s_dado_fixo          : std_logic_vector (3 downto 0);
    signal s_not_zera_end       : std_logic;
    signal s_not_escreve  	    : std_logic;
    signal s_chaves       	    : std_logic_vector(3 downto 0);
    signal s_chaveacionada      : std_logic := '0';
    signal modo                 : std_logic_vector(2 downto 0);
    --
    signal primeiro_ponto       : std_logic;
    signal segundo_ponto        : std_logic;
    signal diminui_pontuacao    : std_logic;
    signal p_increment          : std_logic_vector(3 downto 0);

    signal p_entrada, p_saida   : std_logic_vector(11 downto 0);

    signal led_intermediario1   : std_logic_vector(15 downto 0);
    signal led_intermediario2   : std_logic_vector(15 downto 0);
	signal led_intermediario3   : std_logic_vector(15 downto 0);

    signal seletor_mem_fixa     : std_logic;
begin
    clock_generator_1: contador_m
    generic map (M => 50000)
    port map (
        clock   => clock,
        zera_as => '0',
        zera_s => '0',
        conta  => '1',
        Q      => open,
        fim    => open,
        meio   => clk_1
    );
    clock_generator_2: contador_m
    generic map (M => 83333)
    port map (
        clock   => clock,
        zera_as => '0',
        zera_s  => '0',
        conta   => '1',
        Q       => open,
        fim     => open,
        meio    => clk_2
    );

    with modo(2) select clock_int <=
        clk_1 when '0',
        clk_2 when others;

    clock_interno <= clock_int;

    -- sinais de controle ativos em alto
    -- sinais dos componentes ativos em baixo
    s_not_escreve  <= (not escreveM);

    s_chaveacionada <= chaves(3) or chaves(2) or chaves(1) or chaves(0);

    contador_endereco: contador_modificado
    generic map (
        M => 68
    )
    port map (
        clock => clock_int,
        zera_as => zeraC,
        zera_s => '0',
        conta => contaC,
        load => carregaC,
        D => std_logic_vector(to_unsigned(4, 7)),
        Q => s_endereco,
        fim => fim_jogo,
        ponto_1 => open,
        ponto_2 => open
    );

    registrador_pontuacao: registrador_n
    generic map (
        N => 12
    )
    port map (
        clock   => clock_int,
        clear   => zeraP,
        enable  => atualizaP,
        D       => p_entrada,
        Q       => p_saida
    );

    diminui_pontuacao <= (primeiro_ponto or segundo_ponto) and diminuiP_jogada;
    incremento_pontuacao: shift_register
    generic map (
        N           => 4,
        reset_value => 4
    )
    port map (
        clock     => clock_int,
        clear     => resetaP_jogada,
        enable_l  => '0',
        enable_s  => diminui_pontuacao,
        D         => "0000",
        Q         => p_increment
    );

    calcula_pontuacao: somador_decimal
    generic map (
        digits => 3
    )
    port map (
        A => p_saida,
        B => p_increment,
        F => p_entrada
    );

    pontuacao_dec <= p_saida;

    comparador_Chaves_Memoria: comparador_85
    port map (
        i_A3   => s_dado(3),
        i_B3   => s_chaves(3),
        i_A2   => s_dado(2),
        i_B2   => s_chaves(2),
        i_A1   => s_dado(1),
        i_B1   => s_chaves(1),
        i_A0   => s_dado(0),
        i_B0   => s_chaves(0),
        i_AGTB => '0',
        i_ALTB => '0',
        i_AEQB => '1',
        o_AGTB => open, -- saidas nao usadas
        o_ALTB => open,
        o_AEQB => igual
    );

    --memoria_jogada_fixa: entity work.ram_Sx4 (ram_mif)  -- usar esta linha para Intel Quartus
    memoria_jogada_fixa: entity work.ram_Sx4 (ram_modelsim) -- usar arquitetura para ModelSim
    generic map (
        S => 128
    )
    port map (
        clk             => clock_int,
        endereco        => s_endereco,
        dado_entrada    => s_chaves,
        we              => '1', -- we ativo em baixo, essa memória nunca é sobrescrita
        ce              => seletor_mem_fixa,
        dado_saida      => s_dado_fixo,
        next_data       => led_intermediario1,
		  last_data       => open
	 );

    memoria_jogada_alternativa: entity work.ram_Sx4 (ram_mif)  -- usar esta linha para Intel Quartus
    --memoria_jogada_alternativa: entity work.ram_Sx4 (ram_modelsim) -- usar arquitetura para ModelSim
    generic map (
        S => 128
    )
    port map (
        clk          => clock_int,
        endereco     => s_endereco,
        dado_entrada => s_chaves,
        we           => s_not_escreve, -- we ativo em baixo
        ce           => modo(1),
        dado_saida   => s_dado_alternativo,
        next_data    => led_intermediario2,
		  last_data    => led_intermediario3
    );

    registrador_modo: registrador_n
    generic map (N => 3)
    port map (
        clock   => clock_int,
        clear   => '0',
        enable  => registra_modo,
        D       => seletor_modo,
        Q       => modo
    );

    detecta_jogada: edge_holder
    generic map (size => 4)
    port map (
        clock   => clock_int,
        reset   => zeraR,
        entrada => chaves,
        saida   => s_chaves
    );

    jogada_feita <= s_chaves(0) or s_chaves(1) or s_chaves(2) or s_chaves(3);

    contador_tempo: contador_modificado -- conta passagem de tempo entre jogadas
    generic map (
        M   => 1000,
        P1  => 750,
        P2  => 500
    )
    port map (
        clock => clock_int,
        zera_as => zeraT,
        zera_s => '0',
        conta => contaT,
        load  => '0',
        D     => std_logic_vector(to_unsigned(0, 11)),
        Q => open,
        fim => fim_tempo,
        ponto_1 => primeiro_ponto,
        ponto_2 => segundo_ponto
    );

    contador_espera: contador_m
    generic map (
        M => 1000
    )
    port map (
        clock   => clock_int,
        zera_as => zeraT,
        zera_s  => '0',
        conta   => contaT,
        Q       => open,
        fim     => fim_espera,
        meio    => open
    );

    contador_tempo2: contador_m
    generic map (
        M => 200
    )
    port map (
        clock   => clock_int,
        zera_as => zeraT,
        zera_s  => '0',
        conta   => contaT2,
        Q       => open,
        fim     => fim_tempo_2,
        meio    => open
    );

    seletor_mem_fixa <= not modo(1); 

    with modo(1) select
        s_dado <=   s_dado_fixo when '1',
                    s_dado_alternativo when others;
    --
    with modo(1 downto 0) select
        leds <= led_intermediario1 when "10",
                led_intermediario2 when "00",
                 led_intermediario3 when others;

    db_contagem <= s_endereco;
    db_memoria  <= s_dado;
    db_chaves   <= s_chaves;
    db_tem_jogada <= s_chaveacionada;

    modo_escrita <= modo(0);

    seletor_nota: seletor_som
    port map (
        clock   => clock,
        toca    => chaves,
        saida   => buzzer
    );
end architecture estrutural;