/* Trilhas
 * Author: Shirley Ohara
 * Creation date: 27/05/2019
 */
MACHINE
    Trilhas
    
SETS
    PIECES; PLAYERS = {player_1, player_2}; METHODS = {play, move, remove}

PROPERTIES
    card(PIECES) = 18
    
VARIABLES
    board, pieces_w, pieces_b, last_piece, removed_pieces, p_moinho, updated, mtds_available

INVARIANT
    board : PIECES >+> 0..23 &
    updated : dom(board) +-> BOOL &
    pieces_w <: PIECES & card(pieces_w) = card(PIECES)/2 &
    pieces_b <: PIECES & card(pieces_b) = card(PIECES)/2 &
    last_piece : PIECES &
    removed_pieces <: PIECES &
    p_moinho <: PIECES &
    mtds_available <: METHODS
    
INITIALISATION
    board := {} || updated := {} || p_moinho := {} || removed_pieces := {} || mtds_available := {play, move} ||
    ANY xx, yy, zz
    WHERE xx <: PIECES & yy <: PIECES &
        card(xx) = 9 & card(yy) = 9 &
        xx /\ yy = {} & zz : PIECES
    THEN pieces_w, pieces_b, last_piece := xx, yy, zz
    END
    
OPERATIONS
    play_piece (pi, po) =
        PRE play : mtds_available &
            dom(board) = dom(updated) &
            pi : PIECES & pi /: dom(board) & pi /: removed_pieces &
            (last_piece : pieces_w) <=> (pi : pieces_b) &
            po: 0..23 & po /: ran(board) & 
            (removed_pieces \/ dom(board) /= PIECES)
        THEN 
            board := board \/ {pi |-> po} || 
            last_piece := pi ||
            updated := {}
        END;

    /**
     * This operation choose a random piece and "say" if it is on moinho
     */
    update_p_moinho =
        PRE dom(board) /= dom(updated)
        THEN 
            ANY xx WHERE (xx : dom(board) & xx /: dom(updated))
            THEN 
                 // se esta em uma posição par então é uma quina
                IF (board(xx) mod 2 = 0)                      
                THEN 
                    // se a posição da peça estiver [0, 7] então ela pertence a camada 0 
                    IF (board(xx) < 8)
                    THEN 
                        IF (// olho para a direita (operação de +)
                            (board(xx) + 1 : ran (board) & (board(xx) + 2) mod 8 : ran (board) & 
                               ((xx : pieces_w & 
                                   dom (board |> {board(xx) + 1, (board(xx) + 2) mod 8}) <: pieces_w) or
                                (xx : pieces_b & 
                                   dom (board |> {board(xx) + 1, (board(xx) + 2) mod 8}) <: pieces_b)))
                           
                           or
                           
                           // olho para a esquerda (operação de -)
                           (((((8 + (board(xx) - 1)) mod 8) : ran (board))) & ((((8 + (board(xx) - 2)) mod 8) : ran (board))) &
                          
                            ((xx : pieces_w & dom (board |> {
                                         ((8 + (board(xx) - 1)) mod 8),((8 + (board(xx) - 2)) mod 8)}) <: pieces_w) or
                             (xx : pieces_b & dom (board |> {
                                         ((8 + (board(xx) - 1)) mod 8),((8 + (board(xx) - 2)) mod 8)}) <: pieces_b))) )
                        THEN 
                            IF (xx = last_piece)
                            THEN p_moinho := p_moinho \/ {xx} || updated := updated <+ {xx |-> TRUE} || mtds_available := {remove}
                            ELSE p_moinho := p_moinho \/ {xx} || updated := updated <+ {xx |-> TRUE}
                            END
                        ELSE
                            IF (xx = last_piece)
                            THEN p_moinho := p_moinho - {xx} || updated := updated <+ {xx |-> TRUE} || mtds_available := {play, move}
                            ELSE p_moinho := p_moinho - {xx} || updated := updated <+ {xx |-> TRUE}
                            END
	                    END
                    ELSE
                        // se a posição da peça estiver [8, 15] então ela pertence a camada 1
                        IF (board(xx) >= 8 & board(xx) < 16)
                        THEN
                            IF (// olho para a direita (operação de +)
                                (board(xx) + 1 : ran (board) & (board(xx) + 2) mod 8 + 8: ran (board) & 
                                   ((xx : pieces_w & 
                                       dom (board |> {board(xx) + 1, (board(xx) + 2) mod 8 + 8}) <: pieces_w) or
                                    (xx : pieces_b & 
                                       dom (board |> {board(xx) + 1, (board(xx) + 2) mod 8 + 8}) <: pieces_b)))
                               
                               or
                               
                               // olho para a esquerda (operação de -)
                               ((board(xx) - 1) mod 8 + 8 : ran (board) & (board(xx) - 2) mod 8 + 8: ran (board) &
                                ((xx : pieces_w & 
                                    dom (board |> {(board(xx) - 1) mod 8 + 8, (board(xx) - 2) mod 8 + 8}) <: pieces_w) or
                                 (xx : pieces_b & 
                                    dom (board |> {(board(xx) - 1) mod 8 + 8, (board(xx) - 2) mod 8 + 8}) <: pieces_b))))
                            THEN 
                                IF (xx = last_piece)
                                THEN p_moinho := p_moinho \/ {xx} || updated := updated <+ {xx |-> TRUE} || mtds_available := {remove}
                                ELSE p_moinho := p_moinho \/ {xx} || updated := updated <+ {xx |-> TRUE}
                                END
                            ELSE
                                IF (xx = last_piece)
                                THEN p_moinho := p_moinho - {xx} || updated := updated <+ {xx |-> TRUE} || mtds_available := {play, move}
                                ELSE p_moinho := p_moinho - {xx} || updated := updated <+ {xx |-> TRUE}
                                END
	                        END
                                
                        // se não, então ela está entre [16, 23] e pertence a camada 2
                        ELSE
                            IF (// olho para a direita (operação de +)
                                (board(xx) + 1 : ran (board) & (board(xx) + 2) mod 8 + 16: ran (board) & 
                                   (xx : pieces_w & 
                                       dom (board |> {board(xx) + 1, (board(xx) + 2) mod 8 + 16}) <: pieces_w) or
                                    (xx : pieces_b & 
                                       dom (board |> {board(xx) + 1, (board(xx) + 2) mod 8 + 16}) <: pieces_b))
                                
                                or
                                
                                // olho para a esquerda (operação de -)
                                ((board(xx) - 1) mod 8 + 16 : ran(board) & (board(xx) - 2) mod 8 + 16: ran(board) &
                                    ((xx : pieces_w & 
                                        dom (board |> {(board(xx) - 1) mod 8 + 16, (board(xx) - 2) mod 8 + 16}) <: pieces_w) or
                                     (xx : pieces_b & 
                                        dom (board |> {(board(xx) - 1) mod 8 + 16, (board(xx) - 2) mod 8 + 16}) <: pieces_b))))
                            THEN 
                                IF (xx = last_piece)
                                THEN p_moinho := p_moinho \/ {xx} || updated := updated <+ {xx |-> TRUE} || mtds_available := {remove}
                                ELSE p_moinho := p_moinho \/ {xx} || updated := updated <+ {xx |-> TRUE}
                                END
                            ELSE
                                IF (xx = last_piece)
                                THEN p_moinho := p_moinho - {xx} || updated := updated <+ {xx |-> TRUE} || mtds_available := {play, move}
                                ELSE p_moinho := p_moinho - {xx} || updated := updated <+ {xx |-> TRUE}
                                END
	                        END
                        END
                    END
                
	            // está em uma posição ímpar, é meio
	            ELSE
	                // se a posição da peça estiver [0, 7] então ela pertence a camada 0
	                IF (board(xx) < 8)                                  
	                THEN
	                    IF (// olha pra direita (+ 1) e olha pra esquerda (- 1) para ver se as peças são do mesmo set
	                        ( (board(xx) + 1) mod 8 : ran (board) & 
	                            
	                          (( ((8 + (board(xx) - 1)) mod 8) : ran (board))) &
	                       
	                          ((xx : pieces_w & dom (board |> {
	                                       (board(xx) + 1) mod 8, ((8 + (board(xx) - 1)) mod 8)}) <: pieces_w) or
	                           (xx : pieces_b & dom (board |> {
	                                       (board(xx) + 1) mod 8, ((8 + (board(xx) - 1)) mod 8)}) <: pieces_b)))
	                 
	                        or
	    
	                        // olha pras duas camadas de dentro (+ 8, + 16)
	                        (board(xx) + 8: ran (board) & board(xx) + 16 : ran (board) &
	                            ((xx : pieces_w & 
	                                dom (board |> {(board(xx) + 8), (board(xx) + 16)}) <: pieces_w) or
	                             (xx : pieces_b & 
	                                dom (board |> {(board(xx) + 8), (board(xx) + 16)}) <: pieces_b))))
                        THEN 
                            IF (xx = last_piece)
                            THEN p_moinho := p_moinho \/ {xx} || updated := updated <+ {xx |-> TRUE} || mtds_available := {remove}
                            ELSE p_moinho := p_moinho \/ {xx} || updated := updated <+ {xx |-> TRUE}
                            END
                        ELSE
                            IF (xx = last_piece)
                            THEN p_moinho := p_moinho - {xx} || updated := updated <+ {xx |-> TRUE} || mtds_available := {play, move}
                            ELSE p_moinho := p_moinho - {xx} || updated := updated <+ {xx |-> TRUE}
                            END
	                        END
	                ELSE
	                    // se a posição da peça estiver [8, 15] então ela pertence a camada 1
	                    IF (board(xx) >= 8 & board(xx) < 16)
	                    THEN
	                        IF (// olha pra direita (+ 1) e olha pra esquerda (- 1) para ver se as peças são do mesmo set
	                            ((board(xx) + 1) mod 8 + 8 : ran (board) & (board(xx) - 1) mod 8 + 8: ran (board) &
	                                ((xx : pieces_w & 
	                                    dom (board |> {(board(xx) + 1) mod 8 + 8, (board(xx) - 1) mod 8 + 8}) <: pieces_w) or 
	                                 (xx : pieces_b & 
	                                    dom (board |> {(board(xx) + 1) mod 8 + 8, (board(xx) - 1) mod 8 + 8}) <: pieces_b)))
	                         
	                             or 
	                        
	                            // olha para a camada de dentro (+ 8) e para a camada de fora (-8)
	                            (board(xx) - 8: ran (board) & board(xx) + 8 : ran (board) &
	                                ((xx : pieces_w & 
	                                    dom (board |> {board(xx) - 8, board(xx) + 8}) <: pieces_w) or 
	                                 (xx : pieces_b & 
	                                    dom (board |> {board(xx) - 8, board(xx) + 8}) <: pieces_b))))
                            THEN 
                                IF (xx = last_piece)
                                THEN p_moinho := p_moinho \/ {xx} || updated := updated <+ {xx |-> TRUE} || mtds_available := {remove}
                                ELSE p_moinho := p_moinho \/ {xx} || updated := updated <+ {xx |-> TRUE}
                                END
                            ELSE
                                IF (xx = last_piece)
                                THEN p_moinho := p_moinho - {xx} || updated := updated <+ {xx |-> TRUE} || mtds_available := {play, move}
                                ELSE p_moinho := p_moinho - {xx} || updated := updated <+ {xx |-> TRUE}
                                END
	                        END
	    
	                    // se não, então ela está entre [16, 23] e pertence a camada 2
	                    ELSE
	                        IF (// olha pra direita (+ 1) e olha pra esquerda (- 1) para ver se as peças são do mesmo set
	                            ((board(xx) + 1) mod 8 + 16 : ran (board) & (board(xx) - 1) mod 8 + 16: ran (board) &
	                                ((xx : pieces_w & 
	                                    dom (board |> {(board(xx) + 1) mod 8 + 16, (board(xx) - 1) mod 8 + 16}) <: pieces_w) or 
	                                 (xx : pieces_b & 
	                                    dom (board |> {(board(xx) + 1) mod 8 + 16, (board(xx) - 1) mod 8 + 16}) <: pieces_b))) 
	                     
	                            or
	                            
	                            // olha para as duas camdas de fora (-8, -16)
	                            (board(xx) - 8: ran (board) & board(xx) -16 : ran (board) &
	                                ((xx : pieces_w & 
	                                    dom (board |> {(board(xx) - 8), (board(xx) - 16)}) <: pieces_w) or
	                                 (xx : pieces_b & 
	                                    dom (board |> {(board(xx) - 8), (board(xx) - 16)}) <: pieces_b))))
                            THEN 
                                IF (xx = last_piece)
                                THEN p_moinho := p_moinho \/ {xx} || updated := updated <+ {xx |-> TRUE} || mtds_available := {remove}
                                ELSE p_moinho := p_moinho \/ {xx} || updated := updated <+ {xx |-> TRUE}
                                END
                            ELSE
                                IF (xx = last_piece)
                                THEN p_moinho := p_moinho - {xx} || updated := updated <+ {xx |-> TRUE} || mtds_available := {play, move}
                                ELSE p_moinho := p_moinho - {xx} || updated := updated <+ {xx |-> TRUE}
                                END
	                        END
	                    END
	                END
	            END
	        END
	    END;

    /**
     * Move a piece that already exists in the board.
     * This operation just can be available if all pieces already 
     * in the board or in the removed set
     */
    move_piece (pi, po) =
        PRE move : mtds_available &
            dom(board) = dom(updated) &
            pi : PIECES & pi : dom(board) & pi /: removed_pieces &
            (last_piece : pieces_w) <=> (pi : pieces_b) &z
            po : 0..23 & po /: ran(board) &
            
            (((pi : pieces_w & card(dom(board) /\ pieces_w) > 3) or
              (pi : pieces_b & card(dom(board) /\ pieces_b) > 3)) =>
            
              // Se ele for uma quina, só pode mover para esquerda ou direita
              (((board(pi) mod 2 = 0) => //
                 po : {(board(pi) + 1), (((8 + (board(pi) - 1)) mod 8) + (8 * (board(pi)/8)))}) &
             
              // Se a peça a ser movida estiver em no meio e pertence a camada 0 [0, 7]
              ((board(pi) mod 2 = 1 & (board(pi)/8) = 0) => 
                 po : {(board(pi) + 1) mod 8, ((8 + (board(pi) - 1)) mod 8), (board(pi) + 8)}) &
             
              // Se a peça a ser movida estiver em no meio e pertence a camada 1 [8, 15]
              ((board(pi) mod 2 = 1 & (board(pi)/8) = 1) => 
                 po : {(board(pi) - 1), (((board(pi) + 1) mod 8) + (8 * (board(pi)/8))), (board(pi) + 8), (board(pi) - 8)}) &

              // Se a peça a ser movida estiver em no meio e pertence a camada 2 [16, 23]
              ((board(pi) mod 2 = 1 & (board(pi)/8) = 2) => 
                 po : {(board(pi) - 1), (((board(pi) + 1) mod 8) + (8 * (board(pi)/8))), (board(pi) - 8)})) ) &

            (last_piece : pieces_w) <=> (pi : pieces_b) &
            (removed_pieces \/ dom(board) = PIECES)
        THEN board := (board <+ {pi |-> po}) || 
             last_piece := pi ||
             updated := {}
        END;
    
    /*
     * Removing a oponent piece of the board
     */
    remove_piece (pp) =
        PRE remove : mtds_available &
            last_piece : p_moinho &
            dom(board) = dom(updated) &
            pp : PIECES & pp : dom(board) & pp /: removed_pieces & pp /= last_piece &
            (last_piece : pieces_w) <=> (pp : pieces_b) &
                
            ((pp : pieces_w) => (pp : p_moinho <=> (!xx . ((xx : pieces_w & xx : dom(board)) => xx : p_moinho)))) &
            ((pp : pieces_b) => (pp : p_moinho <=> (!xx . ((xx : pieces_b & xx : dom(board)) => xx : p_moinho))))
        THEN updated := updated - {pp |-> TRUE} || 
             board := board - {pp |-> board(pp)} || 
             p_moinho := p_moinho - {pp} ||
             removed_pieces := removed_pieces \/ {pp} ||
             mtds_available := {play, move}
        END
END