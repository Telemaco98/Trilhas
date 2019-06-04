/* Trilhas_M
 * Author: ohara
 * Creation date: 03/06/2019
 */
MACHINE
    Trilhas_M
    
INCLUDES 
    Trilhas
 
VARIABLES
    last_player

INVARIANT
    last_player : PLAYERS
    
INITIALISATION
    last_player := player_2
    
    
OPERATIONS 
    play_piece (pl, pi, po) =
        PRE  pl: PLAYERS & pl /= last_player & pi : PIECES &
            (pl = player_1 =>  pi : pieces_w) & 
            (pl = player_2 =>  pi : pieces_b) & 
             po : 0..23 &
             pi /: dom(board) & po /: ran(board)
        THEN playing_piece(pl, pi, po) || last_player := pl
        END;
        
    move_piece (pl, pi, po) =
        PRE pl: PLAYERS & pl /= last_player & 
            pi : PIECES & po : 0..23 &
            (pl = player_1 =>  pi : pieces_w) & 
            (pl = player_2 =>  pi : pieces_b) & 
            dom(board) = PIECES & po /: ran(board)
        THEN moving_piece(pl, pi, po) || last_player := pl
        END

END
