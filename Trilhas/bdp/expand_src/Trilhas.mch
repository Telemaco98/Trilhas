/* Trilhas
 * Author: Shirley Ohara
 * Creation date: 27/05/2019
 */
MACHINE
    Trilhas

SETS
    PIECES ; PLAYERS = { player_1 , player_2 }

PROPERTIES
    card ( PIECES ) = 18

ABSTRACT_VARIABLES
    board , pieces_w , pieces_b , has_moinho

INVARIANT
    board : PIECES >+> 0 .. 23 &
    pieces_w <: PIECES & card ( pieces_w ) = card ( PIECES ) / 2 &
    pieces_b <: PIECES & card ( pieces_b ) = card ( PIECES ) / 2 &
    has_moinho : BOOL

INITIALISATION
    board := {} ||
    ANY xx , yy
    WHERE xx <: PIECES & yy <: PIECES &
        card ( xx ) = 9 & card ( yy ) = 9 &
        xx /\ yy = {}
    THEN pieces_w , pieces_b := xx , yy
    END ||
    has_moinho := FALSE

OPERATIONS
    playing_piece ( pl , pi , po ) =
        PRE  pl : PLAYERS & pi : PIECES &
            ( pl = player_1 => pi : pieces_w ) &
            ( pl = player_2 => pi : pieces_b ) &
             po : 0 .. 23 &
             pi /: dom ( board ) & po /: ran ( board )
        THEN board := board \/ { pi |-> po }

        END ;

    moving_piece ( pl , pi , po ) =
        PRE pl : PLAYERS & pi : PIECES & po : 0 .. 23 &
            ( pl = player_1 => pi : pieces_w ) &
            ( pl = player_2 => pi : pieces_b ) &
            dom ( board ) = PIECES & po /: ran ( board )
        THEN board := board <+ { pi |-> po }
        END ;

    verifying_moinho ( pp , pi , po ) =
        PRE pp : PLAYERS & pi : PIECES & po : 0 .. 23 &
            pi : dom ( board ) & has_moinho = FALSE
        THEN
            // se esta em uma posição par então é uma quina
            IF ( board ( pi ) mod 2 = 0 )
            THEN
                // se a posição da peça estiver [0, 7] então ela pertence a camada 1 
                IF ( board ( pi ) < 8 )
                THEN
                    IF ( // olho para a direita (operação de +)
                        ( board ( pi ) + 1 : ran ( board ) & ( board ( pi ) + 2 ) mod 8 : ran ( board ) &
                           ( pi : pieces_w &
                               dom ( board |> { board ( pi ) + 1 , ( board ( pi ) + 2 ) mod 8 } ) <: pieces_w ) or
                            ( pi : pieces_b &
                               dom ( board |> { board ( pi ) + 1 , ( board ( pi ) + 2 ) mod 8 } ) <: pieces_b ) )

                       or

                       // olho para a esquerda (operação de -)
                       ( ( board ( pi ) - 1 ) mod 8 : ran ( board ) & ( board ( pi ) - 2 ) mod 8 : ran ( board ) &
                        ( ( pi : pieces_w &
                            dom ( board |> { ( board ( pi ) - 1 ) mod 8 , ( board ( pi ) - 2 ) mod 8 } ) <: pieces_w ) or
                         ( pi : pieces_b &
                             dom ( board |> { ( board ( pi ) - 1 ) mod 8 , ( board ( pi ) - 2 ) mod 8 } ) <: pieces_b ) ) ) )
                    THEN has_moinho := TRUE
                    END
                ELSE
                    // se a posição da peça estiver [8, 15] então ela pertence a camada 2
                    IF ( board ( pi ) >= 8 & board ( pi ) < 16 )
                    THEN
                        IF ( // olho para a direita (operação de +)
                            ( board ( pi ) + 1 : ran ( board ) & ( board ( pi ) + 2 ) mod 8 + 8 : ran ( board ) &
                               ( pi : pieces_w &
                                   dom ( board |> { board ( pi ) + 1 , ( board ( pi ) + 2 ) mod 8 + 8 } ) <: pieces_w ) or
                                ( pi : pieces_b &
                                   dom ( board |> { board ( pi ) + 1 , ( board ( pi ) + 2 ) mod 8 + 8 } ) <: pieces_b ) )

                           or

                           // olho para a esquerda (operação de -)
                           ( ( board ( pi ) - 1 ) mod 8 + 8 : ran ( board ) & ( board ( pi ) - 2 ) mod 8 + 8 : ran ( board ) &
                            ( ( pi : pieces_w &
                                dom ( board |> { ( board ( pi ) - 1 ) mod 8 + 8 , ( board ( pi ) - 2 ) mod 8 + 8 } )
                                    <: pieces_w ) or
                             ( pi : pieces_b &
                                dom ( board |> { ( board ( pi ) - 1 ) mod 8 + 8 , ( board ( pi ) - 2 ) mod 8 + 8 } )
                                    <: pieces_w ) ) ) )
                        THEN has_moinho := TRUE
                        END

                    // se não, então ela está entre [16, 23] e pertence a camada 3
                    ELSE
                        IF ( // olho para a direita (operação de +)
                            ( board ( pi ) + 1 : ran ( board ) & ( board ( pi ) + 2 ) mod 8 + 16 : ran ( board ) &
                               ( pi : pieces_w &
                                   dom ( board |> { board ( pi ) + 1 , ( board ( pi ) + 2 ) mod 8 + 16 } ) <: pieces_w ) or
                                ( pi : pieces_b &
                                   dom ( board |> { board ( pi ) + 1 , ( board ( pi ) + 2 ) mod 8 + 16 } ) <: pieces_b ) )

                            or

                            // olho para a esquerda (operação de -)
                            ( ( board ( pi ) - 1 ) mod 8 + 16 : ran ( board ) & ( board ( pi ) - 2 ) mod 8 + 16 : ran ( board ) &
                                ( ( pi : pieces_w &
                                    dom ( board |> { ( board ( pi ) - 1 ) mod 8 + 16 , ( board ( pi ) - 2 ) mod 8 + 16 } ) <: pieces_w ) or
                                 ( pi : pieces_b &
                                    dom ( board |> { ( board ( pi ) - 1 ) mod 8 + 16 , ( board ( pi ) - 2 ) mod 8 + 16 } ) <: pieces_b ) ) ) )
                        THEN has_moinho := TRUE
                        END
                    END
                END

        // está em uma posição ímpar, é meio
        ELSE
            // se a posição da peça estiver [0, 7] então ela pertence a camada 1 
            IF ( board ( pi ) < 8 )
            THEN
                IF ( // olha pra direita (+ 1) e olha pra esquerda (- 1) para ver se as peças são do mesmo set
                    ( ( board ( pi ) + 1 ) mod 8 : ran ( board ) & ( board ( pi ) - 1 ) mod 8 : ran ( board ) &
                        ( ( pi : pieces_w &
                            dom ( board |> { ( board ( pi ) + 1 ) mod 8 , ( board ( pi ) - 1 ) mod 8 } ) <: pieces_w ) or
                         ( pi : pieces_b &
                            dom ( board |> { ( board ( pi ) + 1 ) mod 8 , ( board ( pi ) - 1 ) mod 8 } ) <: pieces_b ) ) )

                    or

                    // olha pras duas camadas de dentro (+ 8, + 16)
                    ( board ( pi ) + 8 : ran ( board ) & board ( pi ) + 16 : ran ( board ) &
                        ( ( pi : pieces_w &
                            dom ( board |> { ( board ( pi ) + 8 ) , ( board ( pi ) + 16 ) } ) <: pieces_w ) or
                         ( pi : pieces_b &
                            dom ( board |> { ( board ( pi ) + 8 ) , ( board ( pi ) + 16 ) } ) <: pieces_b ) ) ) )
                THEN has_moinho := TRUE
                END
            ELSE
                // se a posição da peça estiver [8, 15] então ela pertence a camada 2
                IF ( board ( pi ) >= 8 & board ( pi ) < 16 )
                THEN
                    IF ( // olha pra direita (+ 1) e olha pra esquerda (- 1) para ver se as peças são do mesmo set
                        ( ( board ( pi ) + 1 ) mod 8 + 8 : ran ( board ) & ( board ( pi ) - 1 ) mod 8 + 8 : ran ( board ) &
                            ( ( pi : pieces_w &
                                dom ( board |> { ( board ( pi ) + 1 ) mod 8 + 8 , ( board ( pi ) - 1 ) mod 8 + 8 } ) <: pieces_w ) or
                             ( pi : pieces_b &
                                dom ( board |> { ( board ( pi ) + 1 ) mod 8 + 8 , ( board ( pi ) - 1 ) mod 8 + 8 } ) <: pieces_b ) ) )

                         or

                        // olha para a camada de dentro (+ 8) e para a camada de fora (-8)
                        ( board ( pi ) - 8 : ran ( board ) & board ( pi ) + 8 : ran ( board ) &
                            ( ( pi : pieces_w &
                                dom ( board |> { board ( pi ) - 8 , board ( pi ) + 8 } ) <: pieces_w ) or
                             ( pi : pieces_b &
                                dom ( board |> { board ( pi ) - 8 , board ( pi ) + 8 } ) <: pieces_b ) ) ) )
                    THEN has_moinho := TRUE
                    END

                // se não, então ela está entre [16, 23] e pertence a camada 3
                ELSE
                    IF ( // olha pra direita (+ 1) e olha pra esquerda (- 1) para ver se as peças são do mesmo set
                        ( ( board ( pi ) + 1 ) mod 8 + 16 : ran ( board ) & ( board ( pi ) - 1 ) mod 8 + 16 : ran ( board ) &
                            ( ( pi : pieces_w &
                                dom ( board |> { ( board ( pi ) + 1 ) mod 8 + 16 , ( board ( pi ) - 1 ) mod 8 + 16 } ) <: pieces_w ) or
                             ( pi : pieces_b &
                                dom ( board |> { ( board ( pi ) + 1 ) mod 8 + 16 , ( board ( pi ) - 1 ) mod 8 + 16 } ) <: pieces_b ) ) )

                        or

                        // olha para as duas camdas de fora (-8, -16)
                        ( board ( pi ) - 8 : ran ( board ) & board ( pi ) - 16 : ran ( board ) &
                            ( ( pi : pieces_w &
                                dom ( board |> { ( board ( pi ) - 8 ) , ( board ( pi ) - 16 ) } ) <: pieces_w ) or
                             ( pi : pieces_b &
                                dom ( board |> { ( board ( pi ) - 8 ) , ( board ( pi ) - 16 ) } ) <: pieces_b ) ) ) )
                    THEN has_moinho := TRUE
                    END
                END
            END
        END
    END
END
