Normalised(
THEORY MagicNumberX IS
  MagicNumber(Machine(Trilhas_M))==(3.5)
END
&
THEORY UpperLevelX IS
  First_Level(Machine(Trilhas_M))==(Machine(Trilhas_M));
  Level(Machine(Trilhas_M))==(0)
END
&
THEORY LoadedStructureX IS
  Machine(Trilhas_M)
END
&
THEORY ListSeesX IS
  List_Sees(Machine(Trilhas_M))==(?)
END
&
THEORY ListUsesX IS
  List_Uses(Machine(Trilhas_M))==(?)
END
&
THEORY ListIncludesX IS
  Inherited_List_Includes(Machine(Trilhas_M))==(Trilhas);
  List_Includes(Machine(Trilhas_M))==(Trilhas)
END
&
THEORY ListPromotesX IS
  List_Promotes(Machine(Trilhas_M))==(?)
END
&
THEORY ListExtendsX IS
  List_Extends(Machine(Trilhas_M))==(?)
END
&
THEORY ListVariablesX IS
  External_Context_List_Variables(Machine(Trilhas_M))==(?);
  Context_List_Variables(Machine(Trilhas_M))==(?);
  Abstract_List_Variables(Machine(Trilhas_M))==(?);
  Local_List_Variables(Machine(Trilhas_M))==(last_player);
  List_Variables(Machine(Trilhas_M))==(last_player,has_moinho,pieces_b,pieces_w,board);
  External_List_Variables(Machine(Trilhas_M))==(last_player,has_moinho,pieces_b,pieces_w,board)
END
&
THEORY ListVisibleVariablesX IS
  Inherited_List_VisibleVariables(Machine(Trilhas_M))==(?);
  Abstract_List_VisibleVariables(Machine(Trilhas_M))==(?);
  External_List_VisibleVariables(Machine(Trilhas_M))==(?);
  Expanded_List_VisibleVariables(Machine(Trilhas_M))==(?);
  List_VisibleVariables(Machine(Trilhas_M))==(?);
  Internal_List_VisibleVariables(Machine(Trilhas_M))==(?)
END
&
THEORY ListInvariantX IS
  Gluing_Seen_List_Invariant(Machine(Trilhas_M))==(btrue);
  Gluing_List_Invariant(Machine(Trilhas_M))==(btrue);
  Abstract_List_Invariant(Machine(Trilhas_M))==(btrue);
  Expanded_List_Invariant(Machine(Trilhas_M))==(board: PIECES >+> 0..23 & pieces_w <: PIECES & card(pieces_w) = card(PIECES)/2 & pieces_b <: PIECES & card(pieces_b) = card(PIECES)/2 & has_moinho: BOOL);
  Context_List_Invariant(Machine(Trilhas_M))==(btrue);
  List_Invariant(Machine(Trilhas_M))==(last_player: PLAYERS)
END
&
THEORY ListAssertionsX IS
  Abstract_List_Assertions(Machine(Trilhas_M))==(btrue);
  Expanded_List_Assertions(Machine(Trilhas_M))==(btrue);
  Context_List_Assertions(Machine(Trilhas_M))==(btrue);
  List_Assertions(Machine(Trilhas_M))==(btrue)
END
&
THEORY ListCoverageX IS
  List_Coverage(Machine(Trilhas_M))==(btrue)
END
&
THEORY ListExclusivityX IS
  List_Exclusivity(Machine(Trilhas_M))==(btrue)
END
&
THEORY ListInitialisationX IS
  Expanded_List_Initialisation(Machine(Trilhas_M))==(board:={} || @(xx,yy).(xx <: PIECES & yy <: PIECES & card(xx) = 9 & card(yy) = 9 & xx/\yy = {} ==> pieces_w,pieces_b:=xx,yy) || has_moinho:=FALSE;last_player:=player_2);
  Context_List_Initialisation(Machine(Trilhas_M))==(skip);
  List_Initialisation(Machine(Trilhas_M))==(last_player:=player_2)
END
&
THEORY ListParametersX IS
  List_Parameters(Machine(Trilhas_M))==(?)
END
&
THEORY ListInstanciatedParametersX IS
  List_Instanciated_Parameters(Machine(Trilhas_M),Machine(Trilhas))==(?)
END
&
THEORY ListConstraintsX IS
  List_Constraints(Machine(Trilhas_M),Machine(Trilhas))==(btrue);
  List_Context_Constraints(Machine(Trilhas_M))==(btrue);
  List_Constraints(Machine(Trilhas_M))==(btrue)
END
&
THEORY ListOperationsX IS
  Internal_List_Operations(Machine(Trilhas_M))==(play_piece,move_piece);
  List_Operations(Machine(Trilhas_M))==(play_piece,move_piece)
END
&
THEORY ListInputX IS
  List_Input(Machine(Trilhas_M),play_piece)==(pl,pi,po);
  List_Input(Machine(Trilhas_M),move_piece)==(pl,pi,po)
END
&
THEORY ListOutputX IS
  List_Output(Machine(Trilhas_M),play_piece)==(?);
  List_Output(Machine(Trilhas_M),move_piece)==(?)
END
&
THEORY ListHeaderX IS
  List_Header(Machine(Trilhas_M),play_piece)==(play_piece(pl,pi,po));
  List_Header(Machine(Trilhas_M),move_piece)==(move_piece(pl,pi,po))
END
&
THEORY ListOperationGuardX END
&
THEORY ListPreconditionX IS
  List_Precondition(Machine(Trilhas_M),play_piece)==(pl: PLAYERS & pl/=last_player & pi: PIECES & (pl = player_1 => pi: pieces_w) & (pl = player_2 => pi: pieces_b) & po: 0..23 & pi/:dom(board) & po/:ran(board));
  List_Precondition(Machine(Trilhas_M),move_piece)==(pl: PLAYERS & pl/=last_player & pi: PIECES & po: 0..23 & (pl = player_1 => pi: pieces_w) & (pl = player_2 => pi: pieces_b) & dom(board) = PIECES & po/:ran(board))
END
&
THEORY ListSubstitutionX IS
  Expanded_List_Substitution(Machine(Trilhas_M),move_piece)==(pl: PLAYERS & pl/=last_player & pi: PIECES & po: 0..23 & (pl = player_1 => pi: pieces_w) & (pl = player_2 => pi: pieces_b) & dom(board) = PIECES & po/:ran(board) & pl: PLAYERS & pi: PIECES & po: 0..23 & (pl = player_1 => pi: pieces_w) & (pl = player_2 => pi: pieces_b) & dom(board) = PIECES & po/:ran(board) | board:=board<+{pi|->po} || last_player:=pl);
  Expanded_List_Substitution(Machine(Trilhas_M),play_piece)==(pl: PLAYERS & pl/=last_player & pi: PIECES & (pl = player_1 => pi: pieces_w) & (pl = player_2 => pi: pieces_b) & po: 0..23 & pi/:dom(board) & po/:ran(board) & pl: PLAYERS & pi: PIECES & (pl = player_1 => pi: pieces_w) & (pl = player_2 => pi: pieces_b) & po: 0..23 & pi/:dom(board) & po/:ran(board) | board:=board\/{pi|->po} || last_player:=pl);
  List_Substitution(Machine(Trilhas_M),play_piece)==(playing_piece(pl,pi,po) || last_player:=pl);
  List_Substitution(Machine(Trilhas_M),move_piece)==(moving_piece(pl,pi,po) || last_player:=pl)
END
&
THEORY ListConstantsX IS
  List_Valuable_Constants(Machine(Trilhas_M))==(?);
  Inherited_List_Constants(Machine(Trilhas_M))==(?);
  List_Constants(Machine(Trilhas_M))==(?)
END
&
THEORY ListSetsX IS
  Set_Definition(Machine(Trilhas_M),PLAYERS)==({player_1,player_2});
  Context_List_Enumerated(Machine(Trilhas_M))==(?);
  Context_List_Defered(Machine(Trilhas_M))==(?);
  Context_List_Sets(Machine(Trilhas_M))==(?);
  List_Valuable_Sets(Machine(Trilhas_M))==(PIECES);
  Inherited_List_Enumerated(Machine(Trilhas_M))==(PLAYERS);
  Inherited_List_Defered(Machine(Trilhas_M))==(PIECES);
  Inherited_List_Sets(Machine(Trilhas_M))==(PIECES,PLAYERS);
  List_Enumerated(Machine(Trilhas_M))==(?);
  List_Defered(Machine(Trilhas_M))==(?);
  List_Sets(Machine(Trilhas_M))==(?);
  Set_Definition(Machine(Trilhas_M),PIECES)==(?)
END
&
THEORY ListHiddenConstantsX IS
  Abstract_List_HiddenConstants(Machine(Trilhas_M))==(?);
  Expanded_List_HiddenConstants(Machine(Trilhas_M))==(?);
  List_HiddenConstants(Machine(Trilhas_M))==(?);
  External_List_HiddenConstants(Machine(Trilhas_M))==(?)
END
&
THEORY ListPropertiesX IS
  Abstract_List_Properties(Machine(Trilhas_M))==(btrue);
  Context_List_Properties(Machine(Trilhas_M))==(btrue);
  Inherited_List_Properties(Machine(Trilhas_M))==(card(PIECES) = 18 & PIECES: FIN(INTEGER) & not(PIECES = {}) & PLAYERS: FIN(INTEGER) & not(PLAYERS = {}));
  List_Properties(Machine(Trilhas_M))==(btrue)
END
&
THEORY ListSeenInfoX END
&
THEORY ListANYVarX IS
  List_ANY_Var(Machine(Trilhas_M),play_piece)==(?);
  List_ANY_Var(Machine(Trilhas_M),move_piece)==(?)
END
&
THEORY ListOfIdsX IS
  List_Of_Ids(Machine(Trilhas_M)) == (? | PIECES,PLAYERS,player_1,player_2 | last_player | has_moinho,pieces_b,pieces_w,board | play_piece,move_piece | ? | included(Machine(Trilhas)) | ? | Trilhas_M);
  List_Of_HiddenCst_Ids(Machine(Trilhas_M)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(Trilhas_M)) == (?);
  List_Of_VisibleVar_Ids(Machine(Trilhas_M)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(Trilhas_M)) == (?: ?);
  List_Of_Ids(Machine(Trilhas)) == (PIECES,PLAYERS,player_1,player_2 | ? | has_moinho,pieces_b,pieces_w,board | ? | playing_piece,moving_piece,verifying_moinho | ? | ? | ? | Trilhas);
  List_Of_HiddenCst_Ids(Machine(Trilhas)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(Trilhas)) == (?);
  List_Of_VisibleVar_Ids(Machine(Trilhas)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(Trilhas)) == (?: ?)
END
&
THEORY SetsEnvX IS
  Sets(Machine(Trilhas_M)) == (Type(PLAYERS) == Cst(SetOf(etype(PLAYERS,0,1)));Type(PIECES) == Cst(SetOf(atype(PIECES,"[PIECES","]PIECES"))))
END
&
THEORY ConstantsEnvX IS
  Constants(Machine(Trilhas_M)) == (Type(player_2) == Cst(etype(PLAYERS,0,1));Type(player_1) == Cst(etype(PLAYERS,0,1)))
END
&
THEORY VariablesEnvX IS
  Variables(Machine(Trilhas_M)) == (Type(board) == Mvl(SetOf(atype(PIECES,?,?)*btype(INTEGER,?,?)));Type(pieces_w) == Mvl(SetOf(atype(PIECES,?,?)));Type(pieces_b) == Mvl(SetOf(atype(PIECES,?,?)));Type(has_moinho) == Mvl(btype(BOOL,?,?));Type(last_player) == Mvl(etype(PLAYERS,?,?)))
END
&
THEORY OperationsEnvX IS
  Operations(Machine(Trilhas_M)) == (Type(move_piece) == Cst(No_type,etype(PLAYERS,?,?)*atype(PIECES,?,?)*btype(INTEGER,?,?));Type(play_piece) == Cst(No_type,etype(PLAYERS,?,?)*atype(PIECES,?,?)*btype(INTEGER,?,?)))
END
&
THEORY TCIntRdX IS
  predB0 == OK;
  extended_sees == KO;
  B0check_tab == KO;
  local_op == OK;
  abstract_constants_visible_in_values == KO;
  project_type == SOFTWARE_TYPE;
  event_b_deadlockfreeness == KO;
  variant_clause_mandatory == KO;
  event_b_coverage == KO;
  event_b_exclusivity == KO;
  genFeasibilityPO == KO
END
)
