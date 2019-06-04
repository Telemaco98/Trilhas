Normalised(
THEORY MagicNumberX IS
  MagicNumber(Machine(Trilhas))==(3.5)
END
&
THEORY UpperLevelX IS
  First_Level(Machine(Trilhas))==(Machine(Trilhas));
  Level(Machine(Trilhas))==(0)
END
&
THEORY LoadedStructureX IS
  Machine(Trilhas)
END
&
THEORY ListSeesX IS
  List_Sees(Machine(Trilhas))==(?)
END
&
THEORY ListUsesX IS
  List_Uses(Machine(Trilhas))==(?)
END
&
THEORY ListIncludesX IS
  Inherited_List_Includes(Machine(Trilhas))==(?);
  List_Includes(Machine(Trilhas))==(?)
END
&
THEORY ListPromotesX IS
  List_Promotes(Machine(Trilhas))==(?)
END
&
THEORY ListExtendsX IS
  List_Extends(Machine(Trilhas))==(?)
END
&
THEORY ListVariablesX IS
  External_Context_List_Variables(Machine(Trilhas))==(?);
  Context_List_Variables(Machine(Trilhas))==(?);
  Abstract_List_Variables(Machine(Trilhas))==(?);
  Local_List_Variables(Machine(Trilhas))==(has_moinho,pieces_b,pieces_w,board);
  List_Variables(Machine(Trilhas))==(has_moinho,pieces_b,pieces_w,board);
  External_List_Variables(Machine(Trilhas))==(has_moinho,pieces_b,pieces_w,board)
END
&
THEORY ListVisibleVariablesX IS
  Inherited_List_VisibleVariables(Machine(Trilhas))==(?);
  Abstract_List_VisibleVariables(Machine(Trilhas))==(?);
  External_List_VisibleVariables(Machine(Trilhas))==(?);
  Expanded_List_VisibleVariables(Machine(Trilhas))==(?);
  List_VisibleVariables(Machine(Trilhas))==(?);
  Internal_List_VisibleVariables(Machine(Trilhas))==(?)
END
&
THEORY ListInvariantX IS
  Gluing_Seen_List_Invariant(Machine(Trilhas))==(btrue);
  Gluing_List_Invariant(Machine(Trilhas))==(btrue);
  Expanded_List_Invariant(Machine(Trilhas))==(btrue);
  Abstract_List_Invariant(Machine(Trilhas))==(btrue);
  Context_List_Invariant(Machine(Trilhas))==(btrue);
  List_Invariant(Machine(Trilhas))==(board: PIECES >+> 0..23 & pieces_w <: PIECES & card(pieces_w) = card(PIECES)/2 & pieces_b <: PIECES & card(pieces_b) = card(PIECES)/2 & has_moinho: BOOL)
END
&
THEORY ListAssertionsX IS
  Expanded_List_Assertions(Machine(Trilhas))==(btrue);
  Abstract_List_Assertions(Machine(Trilhas))==(btrue);
  Context_List_Assertions(Machine(Trilhas))==(btrue);
  List_Assertions(Machine(Trilhas))==(btrue)
END
&
THEORY ListCoverageX IS
  List_Coverage(Machine(Trilhas))==(btrue)
END
&
THEORY ListExclusivityX IS
  List_Exclusivity(Machine(Trilhas))==(btrue)
END
&
THEORY ListInitialisationX IS
  Expanded_List_Initialisation(Machine(Trilhas))==(board:={} || @(xx,yy).(xx <: PIECES & yy <: PIECES & card(xx) = 9 & card(yy) = 9 & xx/\yy = {} ==> pieces_w,pieces_b:=xx,yy) || has_moinho:=FALSE);
  Context_List_Initialisation(Machine(Trilhas))==(skip);
  List_Initialisation(Machine(Trilhas))==(board:={} || ANY xx,yy WHERE xx <: PIECES & yy <: PIECES & card(xx) = 9 & card(yy) = 9 & xx/\yy = {} THEN pieces_w,pieces_b:=xx,yy END || has_moinho:=FALSE)
END
&
THEORY ListParametersX IS
  List_Parameters(Machine(Trilhas))==(?)
END
&
THEORY ListInstanciatedParametersX END
&
THEORY ListConstraintsX IS
  List_Context_Constraints(Machine(Trilhas))==(btrue);
  List_Constraints(Machine(Trilhas))==(btrue)
END
&
THEORY ListOperationsX IS
  Internal_List_Operations(Machine(Trilhas))==(playing_piece,moving_piece,verifying_moinho);
  List_Operations(Machine(Trilhas))==(playing_piece,moving_piece,verifying_moinho)
END
&
THEORY ListInputX IS
  List_Input(Machine(Trilhas),playing_piece)==(pl,pi,po);
  List_Input(Machine(Trilhas),moving_piece)==(pl,pi,po);
  List_Input(Machine(Trilhas),verifying_moinho)==(pp,pi,po)
END
&
THEORY ListOutputX IS
  List_Output(Machine(Trilhas),playing_piece)==(?);
  List_Output(Machine(Trilhas),moving_piece)==(?);
  List_Output(Machine(Trilhas),verifying_moinho)==(?)
END
&
THEORY ListHeaderX IS
  List_Header(Machine(Trilhas),playing_piece)==(playing_piece(pl,pi,po));
  List_Header(Machine(Trilhas),moving_piece)==(moving_piece(pl,pi,po));
  List_Header(Machine(Trilhas),verifying_moinho)==(verifying_moinho(pp,pi,po))
END
&
THEORY ListOperationGuardX END
&
THEORY ListPreconditionX IS
  List_Precondition(Machine(Trilhas),playing_piece)==(pl: PLAYERS & pi: PIECES & (pl = player_1 => pi: pieces_w) & (pl = player_2 => pi: pieces_b) & po: 0..23 & pi/:dom(board) & po/:ran(board));
  List_Precondition(Machine(Trilhas),moving_piece)==(pl: PLAYERS & pi: PIECES & po: 0..23 & (pl = player_1 => pi: pieces_w) & (pl = player_2 => pi: pieces_b) & dom(board) = PIECES & po/:ran(board));
  List_Precondition(Machine(Trilhas),verifying_moinho)==(pp: PLAYERS & pi: PIECES & po: 0..23 & pi: dom(board) & has_moinho = FALSE)
END
&
THEORY ListSubstitutionX IS
  Expanded_List_Substitution(Machine(Trilhas),verifying_moinho)==(pp: PLAYERS & pi: PIECES & po: 0..23 & pi: dom(board) & has_moinho = FALSE | board(pi) mod 2 = 0 ==> (board(pi)<8 ==> (board(pi)+1: ran(board) & (board(pi)+2) mod 8: ran(board) & (pi: pieces_w & dom(board|>{board(pi)+1,(board(pi)+2) mod 8}) <: pieces_w) or (pi: pieces_b & dom(board|>{board(pi)+1,(board(pi)+2) mod 8}) <: pieces_b) or ((board(pi)-1) mod 8: ran(board) & (board(pi)-2) mod 8: ran(board) & (pi: pieces_w & dom(board|>{(board(pi)-1) mod 8,(board(pi)-2) mod 8}) <: pieces_w or (pi: pieces_b & dom(board|>{(board(pi)-1) mod 8,(board(pi)-2) mod 8}) <: pieces_b))) ==> has_moinho:=TRUE [] not(board(pi)+1: ran(board) & (board(pi)+2) mod 8: ran(board) & (pi: pieces_w & dom(board|>{board(pi)+1,(board(pi)+2) mod 8}) <: pieces_w) or (pi: pieces_b & dom(board|>{board(pi)+1,(board(pi)+2) mod 8}) <: pieces_b) or ((board(pi)-1) mod 8: ran(board) & (board(pi)-2) mod 8: ran(board) & (pi: pieces_w & dom(board|>{(board(pi)-1) mod 8,(board(pi)-2) mod 8}) <: pieces_w or (pi: pieces_b & dom(board|>{(board(pi)-1) mod 8,(board(pi)-2) mod 8}) <: pieces_b)))) ==> skip) [] not(board(pi)<8) ==> (board(pi)>=8 & board(pi)<16 ==> (board(pi)+1: ran(board) & (board(pi)+2) mod 8+8: ran(board) & (pi: pieces_w & dom(board|>{board(pi)+1,(board(pi)+2) mod 8+8}) <: pieces_w) or (pi: pieces_b & dom(board|>{board(pi)+1,(board(pi)+2) mod 8+8}) <: pieces_b) or ((board(pi)-1) mod 8+8: ran(board) & (board(pi)-2) mod 8+8: ran(board) & (pi: pieces_w & dom(board|>{(board(pi)-1) mod 8+8,(board(pi)-2) mod 8+8}) <: pieces_w or (pi: pieces_b & dom(board|>{(board(pi)-1) mod 8+8,(board(pi)-2) mod 8+8}) <: pieces_w))) ==> has_moinho:=TRUE [] not(board(pi)+1: ran(board) & (board(pi)+2) mod 8+8: ran(board) & (pi: pieces_w & dom(board|>{board(pi)+1,(board(pi)+2) mod 8+8}) <: pieces_w) or (pi: pieces_b & dom(board|>{board(pi)+1,(board(pi)+2) mod 8+8}) <: pieces_b) or ((board(pi)-1) mod 8+8: ran(board) & (board(pi)-2) mod 8+8: ran(board) & (pi: pieces_w & dom(board|>{(board(pi)-1) mod 8+8,(board(pi)-2) mod 8+8}) <: pieces_w or (pi: pieces_b & dom(board|>{(board(pi)-1) mod 8+8,(board(pi)-2) mod 8+8}) <: pieces_w)))) ==> skip) [] not(board(pi)>=8 & board(pi)<16) ==> (board(pi)+1: ran(board) & (board(pi)+2) mod 8+16: ran(board) & (pi: pieces_w & dom(board|>{board(pi)+1,(board(pi)+2) mod 8+16}) <: pieces_w) or (pi: pieces_b & dom(board|>{board(pi)+1,(board(pi)+2) mod 8+16}) <: pieces_b) or ((board(pi)-1) mod 8+16: ran(board) & (board(pi)-2) mod 8+16: ran(board) & (pi: pieces_w & dom(board|>{(board(pi)-1) mod 8+16,(board(pi)-2) mod 8+16}) <: pieces_w or (pi: pieces_b & dom(board|>{(board(pi)-1) mod 8+16,(board(pi)-2) mod 8+16}) <: pieces_b))) ==> has_moinho:=TRUE [] not(board(pi)+1: ran(board) & (board(pi)+2) mod 8+16: ran(board) & (pi: pieces_w & dom(board|>{board(pi)+1,(board(pi)+2) mod 8+16}) <: pieces_w) or (pi: pieces_b & dom(board|>{board(pi)+1,(board(pi)+2) mod 8+16}) <: pieces_b) or ((board(pi)-1) mod 8+16: ran(board) & (board(pi)-2) mod 8+16: ran(board) & (pi: pieces_w & dom(board|>{(board(pi)-1) mod 8+16,(board(pi)-2) mod 8+16}) <: pieces_w or (pi: pieces_b & dom(board|>{(board(pi)-1) mod 8+16,(board(pi)-2) mod 8+16}) <: pieces_b)))) ==> skip))) [] not(board(pi) mod 2 = 0) ==> (board(pi)<8 ==> ((board(pi)+1) mod 8: ran(board) & (board(pi)-1) mod 8: ran(board) & (pi: pieces_w & dom(board|>{(board(pi)+1) mod 8,(board(pi)-1) mod 8}) <: pieces_w or (pi: pieces_b & dom(board|>{(board(pi)+1) mod 8,(board(pi)-1) mod 8}) <: pieces_b)) or (board(pi)+8: ran(board) & board(pi)+16: ran(board) & (pi: pieces_w & dom(board|>{board(pi)+8,board(pi)+16}) <: pieces_w or (pi: pieces_b & dom(board|>{board(pi)+8,board(pi)+16}) <: pieces_b))) ==> has_moinho:=TRUE [] not((board(pi)+1) mod 8: ran(board) & (board(pi)-1) mod 8: ran(board) & (pi: pieces_w & dom(board|>{(board(pi)+1) mod 8,(board(pi)-1) mod 8}) <: pieces_w or (pi: pieces_b & dom(board|>{(board(pi)+1) mod 8,(board(pi)-1) mod 8}) <: pieces_b)) or (board(pi)+8: ran(board) & board(pi)+16: ran(board) & (pi: pieces_w & dom(board|>{board(pi)+8,board(pi)+16}) <: pieces_w or (pi: pieces_b & dom(board|>{board(pi)+8,board(pi)+16}) <: pieces_b)))) ==> skip) [] not(board(pi)<8) ==> (board(pi)>=8 & board(pi)<16 ==> ((board(pi)+1) mod 8+8: ran(board) & (board(pi)-1) mod 8+8: ran(board) & (pi: pieces_w & dom(board|>{(board(pi)+1) mod 8+8,(board(pi)-1) mod 8+8}) <: pieces_w or (pi: pieces_b & dom(board|>{(board(pi)+1) mod 8+8,(board(pi)-1) mod 8+8}) <: pieces_b)) or (board(pi)-8: ran(board) & board(pi)+8: ran(board) & (pi: pieces_w & dom(board|>{board(pi)-8,board(pi)+8}) <: pieces_w or (pi: pieces_b & dom(board|>{board(pi)-8,board(pi)+8}) <: pieces_b))) ==> has_moinho:=TRUE [] not((board(pi)+1) mod 8+8: ran(board) & (board(pi)-1) mod 8+8: ran(board) & (pi: pieces_w & dom(board|>{(board(pi)+1) mod 8+8,(board(pi)-1) mod 8+8}) <: pieces_w or (pi: pieces_b & dom(board|>{(board(pi)+1) mod 8+8,(board(pi)-1) mod 8+8}) <: pieces_b)) or (board(pi)-8: ran(board) & board(pi)+8: ran(board) & (pi: pieces_w & dom(board|>{board(pi)-8,board(pi)+8}) <: pieces_w or (pi: pieces_b & dom(board|>{board(pi)-8,board(pi)+8}) <: pieces_b)))) ==> skip) [] not(board(pi)>=8 & board(pi)<16) ==> ((board(pi)+1) mod 8+16: ran(board) & (board(pi)-1) mod 8+16: ran(board) & (pi: pieces_w & dom(board|>{(board(pi)+1) mod 8+16,(board(pi)-1) mod 8+16}) <: pieces_w or (pi: pieces_b & dom(board|>{(board(pi)+1) mod 8+16,(board(pi)-1) mod 8+16}) <: pieces_b)) or (board(pi)-8: ran(board) & board(pi)-16: ran(board) & (pi: pieces_w & dom(board|>{board(pi)-8,board(pi)-16}) <: pieces_w or (pi: pieces_b & dom(board|>{board(pi)-8,board(pi)-16}) <: pieces_b))) ==> has_moinho:=TRUE [] not((board(pi)+1) mod 8+16: ran(board) & (board(pi)-1) mod 8+16: ran(board) & (pi: pieces_w & dom(board|>{(board(pi)+1) mod 8+16,(board(pi)-1) mod 8+16}) <: pieces_w or (pi: pieces_b & dom(board|>{(board(pi)+1) mod 8+16,(board(pi)-1) mod 8+16}) <: pieces_b)) or (board(pi)-8: ran(board) & board(pi)-16: ran(board) & (pi: pieces_w & dom(board|>{board(pi)-8,board(pi)-16}) <: pieces_w or (pi: pieces_b & dom(board|>{board(pi)-8,board(pi)-16}) <: pieces_b)))) ==> skip))));
  Expanded_List_Substitution(Machine(Trilhas),moving_piece)==(pl: PLAYERS & pi: PIECES & po: 0..23 & (pl = player_1 => pi: pieces_w) & (pl = player_2 => pi: pieces_b) & dom(board) = PIECES & po/:ran(board) | board:=board<+{pi|->po});
  Expanded_List_Substitution(Machine(Trilhas),playing_piece)==(pl: PLAYERS & pi: PIECES & (pl = player_1 => pi: pieces_w) & (pl = player_2 => pi: pieces_b) & po: 0..23 & pi/:dom(board) & po/:ran(board) | board:=board\/{pi|->po});
  List_Substitution(Machine(Trilhas),playing_piece)==(board:=board\/{pi|->po});
  List_Substitution(Machine(Trilhas),moving_piece)==(board:=board<+{pi|->po});
  List_Substitution(Machine(Trilhas),verifying_moinho)==(IF board(pi) mod 2 = 0 THEN IF board(pi)<8 THEN IF board(pi)+1: ran(board) & (board(pi)+2) mod 8: ran(board) & (pi: pieces_w & dom(board|>{board(pi)+1,(board(pi)+2) mod 8}) <: pieces_w) or (pi: pieces_b & dom(board|>{board(pi)+1,(board(pi)+2) mod 8}) <: pieces_b) or ((board(pi)-1) mod 8: ran(board) & (board(pi)-2) mod 8: ran(board) & (pi: pieces_w & dom(board|>{(board(pi)-1) mod 8,(board(pi)-2) mod 8}) <: pieces_w or (pi: pieces_b & dom(board|>{(board(pi)-1) mod 8,(board(pi)-2) mod 8}) <: pieces_b))) THEN has_moinho:=TRUE END ELSE IF board(pi)>=8 & board(pi)<16 THEN IF board(pi)+1: ran(board) & (board(pi)+2) mod 8+8: ran(board) & (pi: pieces_w & dom(board|>{board(pi)+1,(board(pi)+2) mod 8+8}) <: pieces_w) or (pi: pieces_b & dom(board|>{board(pi)+1,(board(pi)+2) mod 8+8}) <: pieces_b) or ((board(pi)-1) mod 8+8: ran(board) & (board(pi)-2) mod 8+8: ran(board) & (pi: pieces_w & dom(board|>{(board(pi)-1) mod 8+8,(board(pi)-2) mod 8+8}) <: pieces_w or (pi: pieces_b & dom(board|>{(board(pi)-1) mod 8+8,(board(pi)-2) mod 8+8}) <: pieces_w))) THEN has_moinho:=TRUE END ELSE IF board(pi)+1: ran(board) & (board(pi)+2) mod 8+16: ran(board) & (pi: pieces_w & dom(board|>{board(pi)+1,(board(pi)+2) mod 8+16}) <: pieces_w) or (pi: pieces_b & dom(board|>{board(pi)+1,(board(pi)+2) mod 8+16}) <: pieces_b) or ((board(pi)-1) mod 8+16: ran(board) & (board(pi)-2) mod 8+16: ran(board) & (pi: pieces_w & dom(board|>{(board(pi)-1) mod 8+16,(board(pi)-2) mod 8+16}) <: pieces_w or (pi: pieces_b & dom(board|>{(board(pi)-1) mod 8+16,(board(pi)-2) mod 8+16}) <: pieces_b))) THEN has_moinho:=TRUE END END END ELSE IF board(pi)<8 THEN IF (board(pi)+1) mod 8: ran(board) & (board(pi)-1) mod 8: ran(board) & (pi: pieces_w & dom(board|>{(board(pi)+1) mod 8,(board(pi)-1) mod 8}) <: pieces_w or (pi: pieces_b & dom(board|>{(board(pi)+1) mod 8,(board(pi)-1) mod 8}) <: pieces_b)) or (board(pi)+8: ran(board) & board(pi)+16: ran(board) & (pi: pieces_w & dom(board|>{board(pi)+8,board(pi)+16}) <: pieces_w or (pi: pieces_b & dom(board|>{board(pi)+8,board(pi)+16}) <: pieces_b))) THEN has_moinho:=TRUE END ELSE IF board(pi)>=8 & board(pi)<16 THEN IF (board(pi)+1) mod 8+8: ran(board) & (board(pi)-1) mod 8+8: ran(board) & (pi: pieces_w & dom(board|>{(board(pi)+1) mod 8+8,(board(pi)-1) mod 8+8}) <: pieces_w or (pi: pieces_b & dom(board|>{(board(pi)+1) mod 8+8,(board(pi)-1) mod 8+8}) <: pieces_b)) or (board(pi)-8: ran(board) & board(pi)+8: ran(board) & (pi: pieces_w & dom(board|>{board(pi)-8,board(pi)+8}) <: pieces_w or (pi: pieces_b & dom(board|>{board(pi)-8,board(pi)+8}) <: pieces_b))) THEN has_moinho:=TRUE END ELSE IF (board(pi)+1) mod 8+16: ran(board) & (board(pi)-1) mod 8+16: ran(board) & (pi: pieces_w & dom(board|>{(board(pi)+1) mod 8+16,(board(pi)-1) mod 8+16}) <: pieces_w or (pi: pieces_b & dom(board|>{(board(pi)+1) mod 8+16,(board(pi)-1) mod 8+16}) <: pieces_b)) or (board(pi)-8: ran(board) & board(pi)-16: ran(board) & (pi: pieces_w & dom(board|>{board(pi)-8,board(pi)-16}) <: pieces_w or (pi: pieces_b & dom(board|>{board(pi)-8,board(pi)-16}) <: pieces_b))) THEN has_moinho:=TRUE END END END END)
END
&
THEORY ListConstantsX IS
  List_Valuable_Constants(Machine(Trilhas))==(?);
  Inherited_List_Constants(Machine(Trilhas))==(?);
  List_Constants(Machine(Trilhas))==(?)
END
&
THEORY ListSetsX IS
  Set_Definition(Machine(Trilhas),PIECES)==(?);
  Context_List_Enumerated(Machine(Trilhas))==(?);
  Context_List_Defered(Machine(Trilhas))==(?);
  Context_List_Sets(Machine(Trilhas))==(?);
  List_Valuable_Sets(Machine(Trilhas))==(PIECES);
  Inherited_List_Enumerated(Machine(Trilhas))==(?);
  Inherited_List_Defered(Machine(Trilhas))==(?);
  Inherited_List_Sets(Machine(Trilhas))==(?);
  List_Enumerated(Machine(Trilhas))==(PLAYERS);
  List_Defered(Machine(Trilhas))==(PIECES);
  List_Sets(Machine(Trilhas))==(PIECES,PLAYERS);
  Set_Definition(Machine(Trilhas),PLAYERS)==({player_1,player_2})
END
&
THEORY ListHiddenConstantsX IS
  Abstract_List_HiddenConstants(Machine(Trilhas))==(?);
  Expanded_List_HiddenConstants(Machine(Trilhas))==(?);
  List_HiddenConstants(Machine(Trilhas))==(?);
  External_List_HiddenConstants(Machine(Trilhas))==(?)
END
&
THEORY ListPropertiesX IS
  Abstract_List_Properties(Machine(Trilhas))==(btrue);
  Context_List_Properties(Machine(Trilhas))==(btrue);
  Inherited_List_Properties(Machine(Trilhas))==(btrue);
  List_Properties(Machine(Trilhas))==(card(PIECES) = 18 & PIECES: FIN(INTEGER) & not(PIECES = {}) & PLAYERS: FIN(INTEGER) & not(PLAYERS = {}))
END
&
THEORY ListSeenInfoX END
&
THEORY ListANYVarX IS
  List_ANY_Var(Machine(Trilhas),?)==((Var(xx) == SetOf(atype(PIECES,?,?))),(Var(yy) == SetOf(atype(PIECES,?,?))));
  List_ANY_Var(Machine(Trilhas),playing_piece)==(?);
  List_ANY_Var(Machine(Trilhas),moving_piece)==(?);
  List_ANY_Var(Machine(Trilhas),verifying_moinho)==(?)
END
&
THEORY ListOfIdsX IS
  List_Of_Ids(Machine(Trilhas)) == (PIECES,PLAYERS,player_1,player_2 | ? | has_moinho,pieces_b,pieces_w,board | ? | playing_piece,moving_piece,verifying_moinho | ? | ? | ? | Trilhas);
  List_Of_HiddenCst_Ids(Machine(Trilhas)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(Trilhas)) == (?);
  List_Of_VisibleVar_Ids(Machine(Trilhas)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(Trilhas)) == (?: ?)
END
&
THEORY SetsEnvX IS
  Sets(Machine(Trilhas)) == (Type(PIECES) == Cst(SetOf(atype(PIECES,"[PIECES","]PIECES")));Type(PLAYERS) == Cst(SetOf(etype(PLAYERS,0,1))))
END
&
THEORY ConstantsEnvX IS
  Constants(Machine(Trilhas)) == (Type(player_1) == Cst(etype(PLAYERS,0,1));Type(player_2) == Cst(etype(PLAYERS,0,1)))
END
&
THEORY VariablesEnvX IS
  Variables(Machine(Trilhas)) == (Type(has_moinho) == Mvl(btype(BOOL,?,?));Type(pieces_b) == Mvl(SetOf(atype(PIECES,?,?)));Type(pieces_w) == Mvl(SetOf(atype(PIECES,?,?)));Type(board) == Mvl(SetOf(atype(PIECES,?,?)*btype(INTEGER,?,?))))
END
&
THEORY OperationsEnvX IS
  Operations(Machine(Trilhas)) == (Type(verifying_moinho) == Cst(No_type,etype(PLAYERS,?,?)*atype(PIECES,?,?)*btype(INTEGER,?,?));Type(moving_piece) == Cst(No_type,etype(PLAYERS,?,?)*atype(PIECES,?,?)*btype(INTEGER,?,?));Type(playing_piece) == Cst(No_type,etype(PLAYERS,?,?)*atype(PIECES,?,?)*btype(INTEGER,?,?)))
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
