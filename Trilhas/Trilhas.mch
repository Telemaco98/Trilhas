/* Trilhas
 * Author: Shirley Ohara
 * Creation date: 27/05/2019
 */
MACHINE
    Trilhas
    
SETS
    PIECES; PLAYERS = {player_1, player_2}; METHODS = {play, move, remove, v_last}

PROPERTIES
    card(PIECES) = 18
    
VARIABLES
    board, pieces_w, pieces_b, last_piece, removed_pieces, mtds_available

INVARIANT
    board : PIECES >+> 0..23 &
    pieces_w <: PIECES & card(pieces_w) = card(PIECES)/2 &
    pieces_b <: PIECES & card(pieces_b) = card(PIECES)/2 &
    last_piece : PIECES &
    removed_pieces <: PIECES &
    mtds_available <: METHODS
    
INITIALISATION
    board := {} ||
    ANY xx, yy, zz
    WHERE xx <: PIECES & yy <: PIECES &
        card(xx) = 9 & card(yy) = 9 &
        xx /\ yy = {} & zz : PIECES
    THEN pieces_w, pieces_b, last_piece := xx, yy, zz
    END ||
    removed_pieces := {} ||
    mtds_available := {play, move}
    
OPERATIONS
    play_piece (pi, po) =
        PRE play : mtds_available &
            removed_pieces = {} &
            pi : PIECES & pi /: dom(board) &
            po: 0..23 & po /: ran(board)
        THEN 
            board := board \/ {pi |-> po} || 
            last_piece := pi ||
            mtds_available := {v_last}
        END;

    /**
     * Verify if the last piece played has on moinho
     */
    verify_last =
        PRE v_last : mtds_available & 
            last_piece : dom (board)
        THEN 
            // se esta em uma posição par então é uma quina
            IF (board(last_piece) mod 2 = 0)                      
            THEN 
                // se a posição da peça estiver [0, 7] então ela pertence a camada 1 
                IF (board(last_piece) < 8)
                THEN 
                    IF (// olho para a direita (operação de +)
                        (board(last_piece) + 1 : ran (board) & (board(last_piece) + 2) mod 8 : ran (board) & 
                           (last_piece : pieces_w & 
                               dom (board |> {board(last_piece) + 1, (board(last_piece) + 2) mod 8}) <: pieces_w) or
                            (last_piece : pieces_b & 
                               dom (board |> {board(last_piece) + 1, (board(last_piece) + 2) mod 8}) <: pieces_b))
                       
                       or
                       
                       // olho para a esquerda (operação de -)
                       (((((8 + (board(last_piece) - 1)) mod 8) : ran (board))) & ((((8 + (board(last_piece) - 1)) mod 8) : ran (board))) &
                      
                        ((last_piece : pieces_w & dom (board |> {
                                     ((8 + (board(last_piece) - 1)) mod 8),
                                     ((8 + (board(last_piece) - 2)) mod 8)}) <: pieces_w) or
                         (last_piece : pieces_b & dom (board |> {
                                     ((8 + (board(last_piece) - 1)) mod 8),
                                     ((8 + (board(last_piece) - 2)) mod 8)}) <: pieces_b))) )
                    THEN mtds_available := {remove}
                    ELSE mtds_available := {play, move}
                    END
                ELSE
                    // se a posição da peça estiver [8, 15] então ela pertence a camada 2
                    IF (board(last_piece) >= 8 & board(last_piece) < 16)
                    THEN
                        IF (// olho para a direita (operação de +)
                            (board(last_piece) + 1 : ran (board) & (board(last_piece) + 2) mod 8 + 8: ran (board) & 
                               (last_piece : pieces_w & 
                                   dom (board |> {board(last_piece) + 1, (board(last_piece) + 2) mod 8 + 8}) <: pieces_w) or
                                (last_piece : pieces_b & 
                                   dom (board |> {board(last_piece) + 1, (board(last_piece) + 2) mod 8 + 8}) <: pieces_b))
                           
                           or
                           
                           // olho para a esquerda (operação de -)
                           ((board(last_piece) - 1) mod 8 + 8 : ran (board) & (board(last_piece) - 2) mod 8 + 8: ran (board) &
                            ((last_piece : pieces_w & 
                                dom (board |> {(board(last_piece) - 1) mod 8 + 8, (board(last_piece) - 2) mod 8 + 8}) 
                                    <: pieces_w) or
                             (last_piece : pieces_b & 
                                dom (board |> {(board(last_piece) - 1) mod 8 + 8, (board(last_piece) - 2) mod 8 + 8}) 
                                    <: pieces_w))))
                        THEN mtds_available := {remove}
                        ELSE mtds_available := {play, move}
                        END
                            
                    // se não, então ela está entre [16, 23] e pertence a camada 3
                    ELSE
                        IF (// olho para a direita (operação de +)
                            (board(last_piece) + 1 : ran (board) & (board(last_piece) + 2) mod 8 + 16: ran (board) & 
                               (last_piece : pieces_w & 
                                   dom (board |> {board(last_piece) + 1, (board(last_piece) + 2) mod 8 + 16}) <: pieces_w) or
                                (last_piece : pieces_b & 
                                   dom (board |> {board(last_piece) + 1, (board(last_piece) + 2) mod 8 + 16}) <: pieces_b))
                            
                            or
                            
                            // olho para a esquerda (operação de -)
                            ((board(last_piece) - 1) mod 8 + 16 : ran(board) & (board(last_piece) - 2) mod 8 + 16: ran(board) &
                                ((last_piece : pieces_w & 
                                    dom (board |> {(board(last_piece) - 1) mod 8 + 16, (board(last_piece) - 2) mod 8 + 16}) <: pieces_w) or
                                 (last_piece : pieces_b & 
                                    dom (board |> {(board(last_piece) - 1) mod 8 + 16, (board(last_piece) - 2) mod 8 + 16}) <: pieces_b))))
                        THEN mtds_available := {remove}
                        ELSE mtds_available := {play, move}
                        END
                    END
                END
            
        // está em uma posição ímpar, é meio
        ELSE
            // se a posição da peça estiver [0, 7] então ela pertence a camada 1 
            IF (board(last_piece) < 8)                                  
            THEN
                IF (// olha pra direita (+ 1) e olha pra esquerda (- 1) para ver se as peças são do mesmo set
                    ( (board(last_piece) + 1) mod 8 : ran (board) & 
                        
                      (( ((8 + (board(last_piece) - 1)) mod 8) : ran (board))) &
                   
                      ((last_piece : pieces_w & dom (board |> {(board(last_piece) + 1) mod 8, 
                                   ((8 + (board(last_piece) - 1)) mod 8)}) <: pieces_w) or
                       (last_piece : pieces_b & dom (board |> {(board(last_piece) + 1) mod 8, 
                                   ((8 + (board(last_piece) - 1)) mod 8)}) <: pieces_b)))
             
                    or

                    // olha pras duas camadas de dentro (+ 8, + 16)
                    (board(last_piece) + 8: ran (board) & board(last_piece) + 16 : ran (board) &
                        ((last_piece : pieces_w & 
                            dom (board |> {(board(last_piece) + 8), (board(last_piece) + 16)}) <: pieces_w) or
                         (last_piece : pieces_b & 
                            dom (board |> {(board(last_piece) + 8), (board(last_piece) + 16)}) <: pieces_b))))
                THEN mtds_available := {remove}
                ELSE mtds_available := {play, move}
                END
            ELSE
                // se a posição da peça estiver [8, 15] então ela pertence a camada 2
                IF (board(last_piece) >= 8 & board(last_piece) < 16)
                THEN
                    IF (// olha pra direita (+ 1) e olha pra esquerda (- 1) para ver se as peças são do mesmo set
                        ((board(last_piece) + 1) mod 8 + 8 : ran (board) & (board(last_piece) - 1) mod 8 + 8: ran (board) &
                            ((last_piece : pieces_w & 
                                dom (board |> {(board(last_piece) + 1) mod 8 + 8, (board(last_piece) - 1) mod 8 + 8}) <: pieces_w) or 
                             (last_piece : pieces_b & 
                                dom (board |> {(board(last_piece) + 1) mod 8 + 8, (board(last_piece) - 1) mod 8 + 8}) <: pieces_b)))
                     
                         or 
                    
                        // olha para a camada de dentro (+ 8) e para a camada de fora (-8)
                        (board(last_piece) - 8: ran (board) & board(last_piece) + 8 : ran (board) &
                            ((last_piece : pieces_w & 
                                dom (board |> {board(last_piece) - 8, board(last_piece) + 8}) <: pieces_w) or 
                             (last_piece : pieces_b & 
                                dom (board |> {board(last_piece) - 8, board(last_piece) + 8}) <: pieces_b))))
                    THEN mtds_available := {remove}
                    ELSE mtds_available := {play, move}
                    END

                // se não, então ela está entre [16, 23] e pertence a camada 3
                ELSE
                    IF (// olha pra direita (+ 1) e olha pra esquerda (- 1) para ver se as peças são do mesmo set
                        ((board(last_piece) + 1) mod 8 + 16 : ran (board) & (board(last_piece) - 1) mod 8 + 16: ran (board) &
                            ((last_piece : pieces_w & 
                                dom (board |> {(board(last_piece) + 1) mod 8 + 16, (board(last_piece) - 1) mod 8 + 16}) <: pieces_w) or 
                             (last_piece : pieces_b & 
                                dom (board |> {(board(last_piece) + 1) mod 8 + 16, (board(last_piece) - 1) mod 8 + 16}) <: pieces_b))) 
                 
                        or
                        
                        // olha para as duas camdas de fora (-8, -16)
                        (board(last_piece) - 8: ran (board) & board(last_piece) -16 : ran (board) &
                            ((last_piece : pieces_w & 
                                dom (board |> {(board(last_piece) - 8), (board(last_piece) - 16)}) <: pieces_w) or
                             (last_piece : pieces_b & 
                                dom (board |> {(board(last_piece) - 8), (board(last_piece) - 16)}) <: pieces_b))))
                    THEN mtds_available := {remove}
                    ELSE mtds_available := {play, move}
                    END
                END
            END
        END
    END;
    
    move_piece (pi, po) =
        PRE move : mtds_available &
            pi : PIECES & 
            pi /: removed_pieces &
            po : 0..23 &
            dom(board) = PIECES & 
            po /: ran(board) &
            (last_piece : pieces_w) <=> (pi : pieces_b)
        THEN board := (board <+ {pi |-> po}) || 
             last_piece := pi ||
             mtds_available := {v_last}
        END;
    
    /*
     * Removing a oponent piece of the board
     */
    remove_piece (pi) =
        PRE remove : mtds_available &
            pi : PIECES & pi : dom(board) & pi /: removed_pieces &
            (last_piece : pieces_w) <=> (pi : pieces_b) // TODO pre-condições 
        THEN board := board - {pi |-> board(pi)} || 
             mtds_available := {play, move}
        END
END