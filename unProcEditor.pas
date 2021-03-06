unit unProcEditor;

interface

uses
  Classes,
  TntClasses,
  Types,
  Forms,

  ecSyntAnal,
  ecSyntMemo,
  ecMemoStrings;

procedure EditorDoHomeKey(Ed: TSyntaxMemo);
procedure EditorInsertBlankLineAboveOrBelow(Ed: TSyntaxMemo; ABelow: boolean);
procedure EditorPasteAndSelect(Ed: TSyntaxMemo);

procedure EditorExtendSelectionByLexer_All(Ed: TSyntaxMemo; var Err: string);
procedure EditorExtendSelectionByLexer_HTML(Ed: TSyntaxMemo);
procedure EditorExtendSelectionByOneLine(Ed: TSyntaxMemo);
procedure EditorExtendSelectionByPosition(Ed: TSyntaxMemo;
  AOldStart, AOldLength, ANewStart, ANewLength: integer);

procedure EditorSplitLinesByPosition(Ed: TSyntaxMemo; nCol: Integer);
procedure EditorScrollToSelection(Ed: TSyntaxMemo; NSearchOffsetY: Integer);
procedure EditorCenterSelectedLines(Ed: TSyntaxMemo);
function EditorDeleteSelectedLines(Ed: TSyntaxMemo): Integer;
function EditorEOL(Ed: TSyntaxMemo): Widestring;
procedure EditorToggleStreamComment(Ed: TSyntaxMemo; s1, s2: string; CmtMLine: boolean);
procedure EditorFillBlockRect(Ed: TSyntaxMemo; SData: Widestring; bKeep: boolean);
function EditorCurrentLexerForPos(Ed: TSyntaxMemo; NPos: integer): string;
function EditorCurrentLexerHasTemplates(Ed: TSyntaxMemo): boolean;

function EditorTokenString(Ed: TSyntaxMemo; TokenIndex: Integer): Widestring;
function EditorTokenFullString(Ed: TSyntaxMemo; TokenIndex: Integer; IsDotNeeded: boolean): Widestring;
procedure EditorFoldLevel(Ed: TSyntaxMemo; NLevel: Integer);
function EditorSelectToken(Ed: TSyntaxMemo; SkipQuotes: boolean = false): boolean;
procedure EditorMarkSelStart(Ed: TSyntaxMemo);
procedure EditorMarkSelEnd(Ed: TSyntaxMemo);

type
  TSynEditorInsertMode = (mTxt, mNum, mBul);
  TSynEditorInsertPos = (pCol, pAfterSp, pAfterStr);
  TSynEditorInsertData = record
    NStart, NDigits: integer;
    NBegin, NTail: Widestring;
    NCounter: integer;
    SText1, SText2: Widestring;
    InsMode: TSynEditorInsertMode;
    InsPos: TSynEditorInsertPos;
    InsCol: Integer;
    InsStrAfter: Widestring;
    SkipEmpty: boolean;
  end;
procedure EditorInsertTextData(Ed: TSyntaxMemo; const Data: TSynEditorInsertData);

type
  TSynScrollLineTo = (cScrollToTop, cScrollToBottom, cScrollToMiddle);
procedure EditorScrollCurrentLineTo(Ed: TSyntaxMemo; Mode: TSynScrollLineTo);

procedure EditorDuplicateLine(Ed: TSyntaxMemo);
procedure EditorDeleteLine(Ed: TSyntaxMemo; NLine: integer; AUndo: boolean);
procedure EditorReplaceLine(Ed: TSyntaxMemo; NLine: integer;
  const S: WideString; AUndo: boolean);
procedure EditorAddBookmarksToSortedList(Ed: TSyntaxMemo; L: TList);

function EditorCaretAfterUnclosedQuote(Ed: TSyntaxMemo; var QuoteChar: WideChar): boolean;
function EditorNeedsHtmlOpeningBracket(Ed: TSyntaxMemo): boolean;

function EditorHasNoCaret(Ed: TSyntaxMemo): boolean;
function EditorTabSize(Ed: TSyntaxMemo): Integer;
function EditorTabExpansion(Ed: TSyntaxMemo): Widestring;

type
  TSynSelSave = record
    FSelStream: boolean;
    FSelStart, FSelEnd: TPoint;
    FSelRect: TRect;
    FCaretPos: TPoint;
  end;

procedure EditorSaveSel(Ed: TSyntaxMemo; var Sel: TSynSelSave);
procedure EditorRestoreSel(Ed: TSyntaxMemo; const Sel: TSynSelSave);


procedure EditorGetSelLines(Ed: TSyntaxMemo; var Ln1, Ln2: Integer);
function EditorHasMultilineSelection(Ed: TSyntaxMemo): boolean;
procedure EditorAddLineToEnd(Ed: TSyntaxMemo);
function EditorSelectionForGotoCommand(Ed: TSyntaxMemo): Widestring;
function EditorSelectWord(Ed: TSyntaxMemo): boolean;
procedure EditorSearchMarksToList(Ed: TSyntaxmemo; List: TTntStrings);
function EditorSelectedTextForWeb(Ed: TSyntaxMemo): Widestring;

procedure EditorSelectToPosition(Ed: TSyntaxMemo; NTo: Integer);
procedure EditorCheckCaretOverlappedByForm(Ed: TCustomSyntaxMemo; Form: TForm);
function SyntaxManagerFilesFilter(M: TSyntaxManager; const SAllText: Widestring): Widestring;

function EditorWordLength(Ed: TSyntaxMemo): Integer;
procedure EditorSetModified(Ed: TSyntaxMemo);
function EditorShortSelText(Ed: TSyntaxMemo; MaxLen: Integer): Widestring;
function EditorGetCollapsedRanges(Ed: TSyntaxMemo): string;
procedure EditorSetCollapsedRanges(Ed: TSyntaxMemo; S: Widestring);
function EditorTokenName(Ed: TSyntaxMemo; StartPos, EndPos: integer): string;
procedure EditorCommentLinesAlt(Ed: TSyntaxMemo; const sComment: Widestring);

procedure EditorCollapseWithNested(Ed: TSyntaxMemo; Line: Integer);
procedure EditorCollapseParentRange(Ed: TSyntaxMemo; APos: Integer);
procedure EditorUncollapseLine(Ed: TCustomSyntaxMemo; Line: Integer);
function IsEditorLineCollapsed(Ed: TCustomSyntaxMemo; Line: Integer): boolean;

procedure EditorCountWords(L: TSyntMemoStrings; var NWords, NChars: Int64);
procedure EditorCenterPos(Ed: TCustomSyntaxMemo; AGotoMode: boolean; NOffsetY: Integer);

implementation

uses
  Windows,
  Math,
  Clipbrd,
  SysUtils,
  StrUtils,
  TntSysUtils,
  ecStrUtils,
  ecCmdConst,
  ATxSProc;

procedure EditorSearchMarksToList(Ed: TSyntaxmemo; List: TTntStrings);
var
  i: Integer;
begin
  List.Clear;
  with Ed.SearchMarks do
    for i:= 0 to Count-1 do
      List.Add(Copy(Ed.Text, Items[i].StartPos+1, Items[i].Size));
end;

function EditorSelectedTextForWeb(Ed: TSyntaxMemo): Widestring;
begin
  with Ed do
    if SelLength>0 then
      Result:= SelText
    else
      Result:= WordAtPos(CaretPos);

  SReplaceAllW(Result, #13, ' ');
  SReplaceAllW(Result, #10, ' ');
  SReplaceAllW(Result, '  ', ' ');
  SReplaceAllW(Result, ' ', '+');
end;

procedure EditorSelectToPosition(Ed: TSyntaxMemo; NTo: Integer);
var
  N1, N2, NFrom: Integer;
begin
  NFrom:= Ed.CaretStrPos;
  if NFrom<=NTo then
    begin N1:= NFrom; N2:= NTo end
  else
    begin N2:= NFrom; N1:= NTo end;
  Ed.SetSelection(N1, N2-N1);
end;

procedure EditorCheckCaretOverlappedByForm(Ed: TCustomSyntaxMemo; Form: TForm);
const
  cDY = 35; //minimal offset from form's border to caret position
var
  P, P2: TPoint;
  NStart, NLen: Integer;
begin
  if Form=nil then Exit;
  P:= Ed.CaretPos;

  //uncollapse found line
  if IsEditorLineCollapsed(Ed, P.Y) then
  begin
    EditorUncollapseLine(Ed, P.Y);
    NStart:= Ed.SelStart;
    NLen:= Ed.SelLength;
    Ed.SetSelection(NStart, NLen);
  end;

  P:= Ed.CaretToMouse(P.X, P.Y);
  P:= Ed.ClientToScreen(P);
  P2:= Point(P.X, P.Y + cDY);
  //P is coord of top caret point,
  //P2 is coord of bottom caret point
  if PtInRect(Form.BoundsRect, P) or
    PtInRect(Form.BoundsRect, P2) then
  begin
    if P.Y >= Form.Height + cDY then
      //move form up
      Form.Top:= P.Y - Form.Height - cDY
    else
      //move form down
      Form.Top:= P.Y + cDY * 2;
  end;
end;

function SyntaxManagerFilesFilter(M: TSyntaxManager; const SAllText: Widestring): Widestring;
  //
  function GetExtString(const Extentions: string): string;
  var
    SAll, SItem: Widestring;
  begin
    Result:= '';
    SAll:= Extentions;
    repeat
      SItem:= SGetItem(SAll, ' ');
      if SItem='' then Break;
      if Pos('/', SItem)=0 then //Makefiles lexer has "/mask"
        SItem:= '*.' + SItem
      else
        SReplaceAllW(SItem, '/', '');
      Result:= Result + IfThen(Result<>'', ';') + SItem;
    until false;
  end;
  //
var
  s: string;
  o: TStringList;
  i, j: integer;
begin
  Result := '';
  o:= TStringList.Create;
  try
    o.Duplicates:= dupIgnore;
    o.Sorted:= True;

    for i:= 0 to M.AnalyzerCount-1 do
      if not M.Analyzers[i].Internal then
        with M.Analyzers[i] do
          o.Add(LexerName);

    for j:= 0 to o.Count-1 do
      for i:= 0 to M.AnalyzerCount-1 do
        if not M.Analyzers[i].Internal then
          with M.Analyzers[i] do
           if LexerName=o[j] then
           begin
             s:= GetExtString(Extentions);
             if s<>'' then
               Result:= Result + Format('%s (%s)|%1:s|', [LexerName, s]);
           end;
  finally
    FreeAndNil(o);
  end;

  Result:= Result + SAllText + ' (*.*)|*.*';
end;

function EditorWordLength(Ed: TSyntaxMemo): Integer;
var
  S: Widestring;
  N: Integer;
begin
  Result:= 0;
  N:= Ed.CurrentLine;
  if (N>=0) and (N<Ed.Lines.Count) then
    S:= Ed.Lines[N]
  else
    Exit;

  N:= Ed.CaretPos.X+1;
  if N>Length(S) then
    N:= Length(S)+1;
  repeat
    Dec(N);
    if N=0 then Break;
    if not IsWordChar(S[N]) then Break;
    Inc(Result);
  until false;
end;

procedure EditorSetModified(Ed: TSyntaxMemo);
const
  S: Widestring = ' ';
var
  p: TPoint;
begin
  with Ed do
  begin
    BeginUpdate;
    try
      p:= CaretPos;
      if HaveSelection then
        ResetSelection;
      InsertText(S);
      CaretPos:= p;
      DeleteText(Length(S));
    finally
      EndUpdate;
    end;
  end;
end;

function EditorShortSelText(Ed: TSyntaxMemo; MaxLen: Integer): Widestring;
begin
  Result:= Ed.SelText;
  SDeleteFromW(Result, #13);
  SDeleteFromW(Result, #10);
  if Length(Result)>MaxLen then
    SetLength(Result, MaxLen);
end;

function EditorGetCollapsedRanges(Ed: TSyntaxMemo): string;
var
  i: Integer;
begin
  Result:= '';
  for i:= 0 to Ed.Lines.Count-1 do
    if Ed.IsLineCollapsed(i)=1 then
      Result:= Result+IntToStr(i)+',';
end;

procedure EditorSetCollapsedRanges(Ed: TSyntaxMemo; S: Widestring);
var
  S1: Widestring;
  N: Integer;
begin
  repeat
    S1:= SGetItem(S);
    if S1='' then Break;
    N:= StrToIntDef(S1, -1);
    if (N>=0) and (N<Ed.Lines.Count) then
      Ed.CollapseNearest(N);
  until false;
  Ed.Invalidate;
end;

function EditorTokenName(Ed: TSyntaxMemo; StartPos, EndPos: integer): string;
var
  n: integer;
  t: TSyntToken;
begin
  Result:= '';
  Dec(StartPos);
  Dec(EndPos);

  if Ed.SyntObj=nil then Exit;
  n:= Ed.SyntObj.TokenAtPos(StartPos);
  if n<0 then Exit;
  t:= Ed.SyntObj.Tags[n];
  if t=nil then Exit;
  if t.Style=nil then Exit;

  //t.StartPos, t.EndPos
  if (StartPos>=t.StartPos) and (EndPos<=t.EndPos) then
    Result:= t.Style.DisplayName;
end;

procedure EditorCommentLinesAlt(Ed: TSyntaxMemo; const sComment: Widestring);
var
  S: ecString;
  i, FirstLine, LastLine: integer;
  CaretOld: TPoint;
  NeedDown: boolean;
begin
  if sComment='' then Exit;

  Ed.GetSelectedLines(FirstLine, LastLine);
  CaretOld:= Ed.CaretPos;
  NeedDown:= not Ed.HaveSelection;
  if NeedDown then
    Inc(CaretOld.Y);

  Ed.BeginUpdate;
  Ed.ResetSelection;
  try
    for i:= LastLine downto FirstLine do
     begin
       if i<Ed.Lines.Count then
         S:= Ed.Lines[i]
       else
         S:= '';

       Ed.CaretPos := Point(SSpacesAtStart(S), i);
       Ed.InsertText(sComment);
     end;
    Ed.CaretPos := CaretOld;
  finally
    Ed.EndUpdate;
  end;
end;

procedure EditorCollapseWithNested(Ed: TSyntaxMemo; Line: Integer);
var
  i: Integer;
begin
  if not ((Line>=0) and (Line<Ed.Lines.Count)) then Exit;

  case Ed.IsLineCollapsed(Line) of
    1:
      Ed.ToggleCollapseChildren(Line);
    0:
      begin
      end;
    else
      begin
        for i:= Line-1 downto 0 do
          if Ed.IsLineCollapsed(i)>=0 then
          begin
            Ed.ToggleCollapseChildren(i);
            Exit
          end;
      end;
  end;
end;

procedure EditorCollapseParentRange(Ed: TSyntaxMemo; APos: Integer);
var
  r, r2: TTextRange;
begin
  with Ed do
    if Assigned(SyntObj) then
    begin
      r:= SyntObj.NearestRangeAtPos(APos);
      if r=nil then Exit;
      r2:= r.Parent;
      if r2<>nil then
        r:= r2;
      CollapseRange(r);
      Exit;
    end;
end;

procedure EditorUncollapseLine(Ed: TCustomSyntaxMemo; Line: Integer);
var
  i, AStartPos, AEndPos: Integer;
  Upd: boolean;
begin
  if (Line>=0) and (Line<Ed.Lines.Count) then
  begin
    AStartPos:= Ed.CaretPosToStrPos(Point(0, Line));
    AEndPos:= Ed.CaretPosToStrPos(Point(Ed.Lines.LineLength(Line), Line));
    Upd:= false;
    with Ed do
    begin
      for i:= Collapsed.Count - 1 downto 0 do
       with Collapsed[i] do
         if (StartPos <= AStartPos) and (EndPos >= AEndPos) then
         begin
           Collapsed.Delete(i);
           Upd:= true;
         end;
      if Upd then
        Invalidate;
    end;
  end;
end;

function IsEditorLineCollapsed(Ed: TCustomSyntaxMemo; Line: Integer): boolean;
var
  i, AStartPos, AEndPos: Integer;
begin
  Result:= false;
  if (Line>=0) and (Line<Ed.Lines.Count) then
  begin
    AStartPos:= Ed.CaretPosToStrPos(Point(0, Line));
    AEndPos:= Ed.CaretPosToStrPos(Point(Ed.Lines.LineLength(Line), Line));
    with Ed do
      for i:= Collapsed.Count - 1 downto 0 do
       with Collapsed[i] do
         if (StartPos <= AStartPos) and (EndPos >= AEndPos) then
         begin
           Result:= true;
           Exit
         end;
  end;
end;

procedure EditorCountWords(L: TSyntMemoStrings; var NWords, NChars: Int64);
var
  s: Widestring;
  i, j: integer;
  w: boolean;
begin
  NWords:= 0 ;
  NChars:= 0;
  for i:= 0 to L.Count-1 do
  begin
    S:= L[i];
    w:= false;
    for j:= 1 to Length(S) do
    begin
      if not IsSpaceChar(s[j]) then
        Inc(NChars);
      if IsWordChar(s[j]) then
        w:= true
      else
        begin if w then Inc(NWords); w:= false; end;
    end;
    if w then Inc(NWords);     
  end;
end;

procedure EditorCenterPos(Ed: TCustomSyntaxMemo; AGotoMode: boolean; NOffsetY: Integer);
var
  p: TPoint;
  ext: TSize;
  w, h: integer;
  dx, dy: integer; //indents from sr result to window edge
begin
  dy:= NOffsetY;
  dx:= dy;
  with Ed do
  begin
    p:= CaretPos;
    ext:= DefTextExt;
    w:= (ClientWidth - IfThen(Gutter.Visible, Gutter.Width)) div ext.cx;
    h:= (ClientHeight - IfThen(HorzRuler.Visible, HorzRuler.Height)) div ext.cy;

    {
    //uncollapse - buggy on big Python file folded line
    EditorUncollapseLine(Ed, p.Y);
    }

    //center Y
    if p.Y <= TopLine + 1 then
      TopLine:= TopLine - dy
    else
    if p.Y >= TopLine + h - dy then
      TopLine:= p.Y - dy;

    if WordWrap then
      ScrollCaret
    else
    //center X
    begin
      if AGotoMode or (SelLength=0) then
      begin
        //center caret
        if (p.X <= ScrollPosX + dx) or
          (p.X >= ScrollPosX + w - dx) then
        ScrollPosX:= p.X - w div 2;
      end
      else
      begin
        //center seltext
        if (StrPosToCaretPos(SelStart).X <= ScrollPosX + dx) or
          (StrPosToCaretPos(SelStart+SelLength).X >= ScrollPosX + w - dx) then
        ScrollPosX:= StrPosToCaretPos(SelStart + SelLength div 2).X - w div 2 + 1;
      end
    end;
  end;
end;


function EditorSelectWord(Ed: TSyntaxMemo): boolean;
var
  NPos: integer;
begin
  Result:= false;
  NPos:= Ed.CaretStrPos;
  if (NPos>=0) then
  begin
    if (NPos=Ed.TextLength) //caret at EOF
      or not IsWordChar(Ed.Text[NPos+1]) then //caret not under wordchar
    begin
      //previous char is wordchar?
      if (NPos>=1) and IsWordChar(Ed.Text[NPos]) then
        Ed.CaretStrPos:= NPos-1
      else
        Exit;
    end;
    Ed.SelectWord;
    Result:= true;
  end;
end;

function EditorSelectionForGotoCommand(Ed: TSyntaxMemo): Widestring;
const
  cMaxNameLen = 20; //max len of filename in popup menu
begin
  Result:= Ed.SelText;

  //don't show multi-line selection here
  if (Pos(#13, Result)>0) or
     (Pos(#10, Result)>0) or
     (Pos(#9, Result)>0) then
    Result:= '';

  if Length(Result)>cMaxNameLen then
    Result:= Copy(Result, 1, cMaxNameLen) + '...';
end;

procedure EditorAddLineToEnd(Ed: TSyntaxMemo);
var
  n: Integer;
begin
  //Fix: last line must be with EOL
  with Ed do
    if (CaretPos.Y = Lines.Count-1) and (Lines[Lines.Count-1]<>'') then
    begin
      n:= CaretStrPos;
      CaretStrPos:= TextLength;
      InsertNewLine(0, True, false);
      CaretStrPos:= n;
    end;
end;

//Get selected lines nums: from Ln1 to Ln2
procedure EditorGetSelLines(Ed: TSyntaxMemo; var Ln1, Ln2: Integer);
var
  p: TPoint;
begin
  with Ed do
    if HaveSelection then
    begin
      if SelLength>0 then
      begin
        Ln1:= StrPosToCaretPos(SelStart).Y;
        p:= StrPosToCaretPos(SelStart+SelLength);
        Ln2:= p.Y;
        if p.X = 0 then
          Dec(Ln2);
      end
      else
      begin
        Ln1:= SelRect.Top;
        Ln2:= SelRect.Bottom;
      end
    end
    else
    begin
      //no selection
      Ln1:= CaretPos.Y;
      Ln2:= Ln1;
    end;
end;


function EditorHasMultilineSelection(Ed: TSyntaxMemo): boolean;
var
  Ln1, Ln2: integer;
begin
  if not Ed.HaveSelection then
    Result:= false
  else
  begin
    EditorGetSelLines(Ed, Ln1, Ln2);
    Result:= Ln2 > Ln1;
  end;
end;


function EditorTabSize(Ed: TSyntaxMemo): Integer;
begin
  if Ed.TabList.Count>0 then
    Result:= Ed.TabList[0]
  else
    Result:= 8;
end;

function EditorTabExpansion(Ed: TSyntaxMemo): Widestring;
begin
  Result:= StringOfChar(' ', EditorTabSize(Ed));
end;

function EditorHasNoCaret(Ed: TSyntaxMemo): boolean;
begin
  with Ed do
    Result:= ReadOnly and not (soAlwaysShowCaret in Options);
end;


procedure EditorSaveSel(Ed: TSyntaxMemo; var Sel: TSynSelSave);
begin
  FillChar(Sel, SizeOf(Sel), 0);
  with Ed do
  begin
    Sel.FSelStream:= Ed.SelLength>0;
    if Sel.FSelStream then
    begin
      Sel.FSelStart:= Ed.StrPosToCaretPos(Ed.SelStart);
      Sel.FSelEnd:= Ed.StrPosToCaretPos(Ed.SelStart+Ed.SelLength);
    end
    else
      Sel.FSelRect:= SelRect;
    Sel.FCaretPos:= CaretPos;
  end;
end;

procedure EditorRestoreSel(Ed: TSyntaxMemo; const Sel: TSynSelSave);
begin
  with Ed do
  begin
    BeginUpdate;
    try
      CaretPos:= Sel.FCaretPos;
      if Sel.FSelStream then
      begin
        SelStart:= Ed.CaretPosToStrPos(Sel.FSelStart);
        SelLength:= Ed.CaretPosToStrPos(Sel.FSelEnd) - SelStart;
      end
      else
        SelRect:= Sel.FSelRect;
    finally
      EndUpdate;
    end;
  end;
end;


procedure EditorDuplicateLine(Ed: TSyntaxMemo);
var
  n, nn: Integer;
  s: ecString;
begin
  with Ed do
  if SelLength>0 then
  begin
    n:= SelStart;
    nn:= SelLength;
    s:= SelText;
    SetSelection(n, 0);
    InsertText(s);
    SetSelection(n, nn);
  end
  else
  try
    Ed.BeginUpdate;
    EditorAddLineToEnd(Ed);
    Ed.DuplicateLine(Ed.CaretPos.Y);
    Ed.ExecCommand(smDown);
    EditorSetModified(Ed);
  finally
    Ed.EndUpdate;
  end;
end;


procedure EditorDeleteLine(Ed: TSyntaxMemo; NLine: integer; AUndo: boolean);
var
  p: TPoint;
begin
  //save caret
  p:= Ed.CaretPos;
  if NLine <= p.Y then
    Dec(p.Y); //fix caret pos

  if AUndo then
    with Ed do
    begin
      CaretPos:= Point(0, NLine);
      DeleteText(Lines.LineSpace(NLine));
    end
  else
  begin
    Ed.ClearUndo;
    Ed.Lines.Delete(NLine);
    Ed.Modified:= true;
  end;

  //restore caret
  Ed.CaretPos:= p;
end;


procedure EditorReplaceLine(Ed: TSyntaxMemo; NLine: integer;
  const S: WideString; AUndo: boolean);
var
  p: TPoint;
begin
  if AUndo then
    with Ed do
    begin
      p:= CaretPos;
      CaretPos:= Point(0, NLine);
      DeleteText(Lines.LineLength(NLine));
      InsertText(S);
      CaretPos:= p;
    end
  else
  begin
    Ed.Lines[NLine]:= S;
    Ed.Modified:= true;
  end;
end;

var
  _CmpMemo: TCustomSyntaxMemo = nil;

function _BookmarkCompare(N1, N2: Pointer): Integer;
begin
  if not Assigned(_CmpMemo) then
    raise Exception.Create('CmpMemo nil');
  with _CmpMemo do
    Result:= Bookmarks[Integer(N1)] - Bookmarks[Integer(N2)];
end;

procedure EditorAddBookmarksToSortedList(Ed: TSyntaxMemo; L: TList);
var
  i: Integer;
begin
  with Ed.BookmarkObj do
    for i:= 0 to Count-1 do
      L.Add(Pointer(Items[i].BmIndex));

  _CmpMemo:= Ed;
  L.Sort(_BookmarkCompare);
end;

function EditorCaretAfterUnclosedQuote(Ed: TSyntaxMemo; var QuoteChar: WideChar): boolean;
var
  i: Integer;
  ch: WideChar;
begin
  Result:= false;
  QuoteChar:= #0;

  if Ed.TextLength=0 then Exit;
  i:= Ed.CaretStrPos;
  if not IsWordChar(Ed.Lines.Chars[i]) then Exit;
  while IsWordChar(Ed.Lines.Chars[i]) do Dec(i);
  ch:= Ed.Lines.Chars[i];
  Result:= IsQuoteChar(ch);
  if Result then
    QuoteChar:= ch;
end;

//Result must be true only when
//- TextLength=0
//- caret on space/tab/EOL
//- caret prev char is not wordchar, not '<', '/'
function EditorNeedsHtmlOpeningBracket(Ed: TSyntaxMemo): boolean;
var
  i: Integer;
  ch: Widechar;
begin
  Result:= true;
  with Ed do
    if (TextLength>0) then
    begin
      i:= CaretStrPos;
      //check for previous char
      if (i<=TextLength) then
      begin
        ch:= Lines.Chars[i];
        if IsWordChar(ch) or (ch='<') or (ch='/')
          //or (ch=' ') {fix for unneeded "<" at text end}
          then
            Result:= false;
      end;
      //check for current char
      if (i+1<=TextLength) then
      begin
        ch:= Lines.Chars[i+1];
        if not IsSpaceChar(ch) then
          Result:= false;
      end;
    end;
end;

procedure EditorMarkSelStart(Ed: TSyntaxMemo);
begin
  with Ed do
    SelStartMarked:= CaretStrPos;
end;

procedure EditorMarkSelEnd(Ed: TSyntaxMemo);
var
  nFrom, nTo: Integer;
  pFrom, pTo: TPoint;
begin
  with Ed do
    if SelStartMarked>=0 then
    begin
      nTo:= CaretStrPos;
      if SelStartMarked>nTo then
      begin
        nFrom:= nTo;
        nTo:= SelStartMarked;
      end
      else
        nFrom:= SelStartMarked;

      if SelectModeDefault in [msNone, msNormal] then
        //normal select mode
        SetSelection(nFrom, nTo-nFrom)
      else
      begin
        pFrom:= StrPosToCaretPos(nFrom);
        pTo:= StrPosToCaretPos(nTo);
        if SelectModeDefault = msColumn then
          //column select mode
          SelRect:= Rect(pFrom.X, pFrom.Y, pTo.X, pTo.Y)
        else
          //line select mode
          SelectLines(pFrom.Y, pTo.Y);
      end;
    end;
end;

procedure EditorScrollCurrentLineTo(Ed: TSyntaxMemo; Mode: TSynScrollLineTo);
var
  p: TPoint;
  dy, minY, newY, i: Integer;
begin
  if Ed.Lines.Count>1 then
  case Mode of
    cScrollToTop:
      Ed.TopLine:= Ed.CaretPos.Y;

    cScrollToBottom,
    cScrollToMiddle:
      begin
        dy:= Ed.ClientHeight;
        if Mode=cScrollToMiddle then
          dy:= dy div 2;

        p:= Ed.CaretPos;
        Ed.TopLine:= p.Y;
        minY:= Ed.ScrollPosY - dy;

        newY:= Ed.ScrollPosY;
        for i:= p.Y-1 downto 0 do
        begin
          Dec(newY, Ed.LineHeight(i));
          if newY<minY then
          begin
            Ed.TopLine:= i+1;
            Exit;
          end;  
        end;
        Ed.TopLine:= 0;
      end;
    else
      raise Exception.Create('Unknown scroll mode');
  end;
end;


function EditorSelectToken(Ed: TSyntaxMemo; SkipQuotes: boolean = false): boolean;
var
  n, nStart, nLen: integer;
  t: TSyntToken;
begin
  Result:= false;
  if Ed.SyntObj=nil then Exit;

  n:= Ed.SyntObj.TokenAtPos(Ed.CaretStrPos);
  if n<0 then Exit;

  t:= Ed.SyntObj.Tags[n];
  if t=nil then Exit;

  nStart:= t.StartPos;
  nLen:= t.EndPos - t.StartPos;
  if (nStart<0) or (nLen<=0) then Exit;

  if SkipQuotes then
  begin
    //skip ending quotes
    while (nLen>0) and IsQuoteChar(Ed.Lines.Chars[nStart+nLen]) do
      Dec(nLen);
    //skip starting quotes
    while (nLen>0) and IsQuoteChar(Ed.Lines.Chars[nStart+1]) do
    begin
      Inc(nStart);
      Dec(nLen);
    end;
  end;

  Ed.SetSelection(nStart, nLen);
  Result:= true;
end;


procedure EditorFoldLevel(Ed: TSyntaxMemo; NLevel: Integer);
var
  An: TClientSyntAnalyzer;
  i: Integer;
begin
  An:= Ed.SyntObj;
  if An=nil then Exit;

  Ed.BeginUpdate;
  try
    Ed.FullExpand;
    for i:= 0 to An.RangeCount-1 do
      if An.Ranges[i].Level > NLevel then
        Ed.CollapseRange(An.Ranges[i]);
  finally
    Ed.EndUpdate;
  end;
end;

function EditorCurrentLexerHasTemplates(Ed: TSyntaxMemo): boolean;
begin
  Result:= false;
  if Assigned(Ed) and
     Assigned(Ed.SyntObj) and
     Assigned(Ed.SyntObj.AnalyzerAtPos(Ed.CaretStrPos)) then
    Result:= Ed.SyntObj.AnalyzerAtPos(Ed.CaretStrPos).CodeTemplates.Count > 0;
end;

function EditorCurrentLexerForPos(Ed: TSyntaxMemo; NPos: integer): string;
var
  An: TSyntAnalyzer;
begin
  Result:= '';
  if Assigned(Ed) and Assigned(Ed.SyntObj) then
  begin
    An:= Ed.SyntObj.AnalyzerAtPos(NPos);
    if An<>nil then
      Result:= An.LexerName;
  end;
end;


function EditorTokenString(Ed: TSyntaxMemo; TokenIndex: Integer): Widestring;
begin
  Result:= '';
  if Ed.SyntObj<>nil then
    with Ed.SyntObj do
      Result:= TagStr[TokenIndex];
end;

function EditorTokenFullString(Ed: TSyntaxMemo; TokenIndex: Integer; IsDotNeeded: boolean): Widestring;
var
  i: Integer;
begin
  Result:= '';
  if Ed.SyntObj<>nil then
    with Ed.SyntObj do
    begin
      Result:= TagStr[TokenIndex];

      //add lefter tokens
      //(needed for complex id.id.id, e.g. for C#)
      i:= TokenIndex;
      while (i-2>=0) do
      begin
        if not ((TagStr[i-1]='.') and IsDotNeeded) then
          Break;
        Insert(TagStr[i-2]+TagStr[i-1], Result, 1);
        Dec(i, 2);
      end;

      //add righter tokens
      i:= TokenIndex;
      while (i+2<=TagCount-1) do
      begin
        if not ((TagStr[i+1]='.') and IsDotNeeded) then
          Break;
        Result:= Result+TagStr[i+1]+TagStr[i+2];
        Inc(i, 2);
      end;
    end;
end;

procedure EditorExtendSelectionByPosition(
  Ed: TSyntaxMemo;
  AOldStart, AOldLength,
  ANewStart, ANewLength: integer);
var
  AOldEnd, ANewEnd: integer;
begin
  AOldEnd:= AOldStart+AOldLength;
  ANewEnd:= ANewStart+ANewLength;
  ANewStart:= Min(AOldStart, ANewStart);
  ANewEnd:= Max(AOldEnd, ANewEnd);
  ANewLength:= ANewEnd-ANewStart;
  Ed.SetSelection(ANewStart, ANewLength, true);
end;


procedure EditorFillBlockRect(Ed: TSyntaxMemo; SData: Widestring; bKeep: boolean);
var
  R: TRect;
  s: Widestring;
  OldCaret: TPoint;
  nLen, i: Integer;
begin
  with Ed do
  begin
    if not HaveSelection then Exit;
    if SelectMode<>msColumn then Exit;
    
    R:= SelRect;
    OldCaret:= CaretPos;
    if bKeep then
    begin
      if Length(sData) > R.Right - R.Left then
        SetLength(sData, R.Right - R.Left);
      nLen:= Length(sData);
    end
    else
      nLen:= R.Right - R.Left;

    BeginUpdate;
    try
      for i:= R.Top to R.Bottom do
      begin
        s:= Lines[i];

        //expand tabs to spaces
        if Pos(#9, s)>0 then
        begin
          s:= SUntab(s, EditorTabSize(Ed));
          EditorReplaceLine(Ed, i, s, true{ForceUndo});
        end;

        //fill line tail with spaces
        if Length(s)<R.Right then
        begin
          CaretPos:= Point(Length(s), i);
          InsertText(StringOfChar(' ', R.Right-Length(s)));
        end;

        //replace block line
        ReplaceText(
          CaretPosToStrPos(Point(R.Left, i)),
          nLen, sData);
      end;

      if bKeep then
        nLen:= R.Right - R.Left
      else
        nLen:= Length(sData);

      CaretPos:= Point(R.Left + nLen, OldCaret.Y);
      SelRect:= Rect(R.Left, R.Top, R.Left + nLen, R.Bottom);
    finally
      EndUpdate;
    end;
  end;
end;

function EditorEOL(Ed: TSyntaxMemo): Widestring;
begin
  case Ed.Lines.TextFormat of
    tfCR: Result:= #13;
    tfNL: Result:= #10;
    else Result:= #13#10;
  end;
end;

//s1 - comment start mark
//s2 - comment end mark
//CmtMLine - need to place comment marks on separate lines
procedure EditorToggleStreamComment(Ed: TSyntaxMemo; s1, s2: string; CmtMLine: boolean);
var
  n, nLen: Integer;
  Uncomm: boolean;
  sCR: string;
begin
  with Ed do
    begin
      //msginfo(s1+#13+s2);
      n:= SelStart;
      nLen:= SelLength;
      SetSelection(n, 0);

      if CmtMLine then
        Uncomm:= false
      else
        Uncomm:= (Copy(Lines.FText, n+1, Length(s1)) = s1) and
               (Copy(Lines.FText, n+nLen-Length(s2)+1, Length(s2)) = s2);
      if not Uncomm then
      begin
        //do comment
        if CmtMLine then
        begin
          sCR:= EditorEOL(Ed);
          if (n-Length(sCR)>=0) and
            (Copy(Lines.FText, n-Length(sCR)+1, Length(sCR)) = sCR) then
            s1:= s1+sCR
          else
            s1:= sCR+s1+sCR;
          if Copy(Lines.FText, n+nLen-Length(sCR)+1, Length(sCR)) = sCR then
            s2:= s2+sCR
          else
            s2:= sCR+s2+sCR;
        end;
        BeginUpdate;
        try
          CaretStrPos:= n;
          InsertText(s1);
          CaretStrPos:= n+nLen+Length(s1);
          InsertText(s2);
        finally
          EndUpdate;
        end;
      end
      else
      begin
        //do uncomment
        BeginUpdate;
        try
          CaretStrPos:= n+nLen-Length(s2);
          DeleteText(Length(s2));
          CaretStrPos:= n;
          DeleteText(Length(s1));
        finally
          EndUpdate;
        end;
      end;
    end;
end;


function EditorDeleteSelectedLines(Ed: TSyntaxMemo): Integer;
var
  i, Ln1, Ln2, NCol: Integer;
begin
  Result:= 0;
  if Ed.ReadOnly then Exit;

  EditorGetSelLines(Ed, Ln1, Ln2);
  if Ln1=Ln2 then
    NCol:= Ed.CaretPos.X
  else
    NCol:= 0;

  Ed.BeginUpdate;
  try
    for i:= Ln2 downto Ln1 do
    begin
      EditorDeleteLine(ed, i, true{ForceUndo});
      Inc(Result);
    end;
    Ed.CaretPos:= Point(NCol, Ln1);
  finally
    Ed.EndUpdate;
  end;
end;


procedure EditorCenterSelectedLines(Ed: TSyntaxMemo);
var
  Ln1, Ln2, i: Integer;
  s: Widestring;
begin
  with Ed do
    if (not ReadOnly) and (Lines.Count>0) then
    begin
      EditorGetSelLines(Ed, Ln1, Ln2);
      Ed.BeginUpdate;
      try
        for i:= Ln1 to Ln2 do
        begin
          s:= Trim(Lines[i]);
          if Length(s)<RightMargin then
          begin
            s:= StringOfChar(' ', (RightMargin-Length(s)) div 2) + s;
            EditorReplaceLine(Ed, i, s, true{ForceUndo});
          end;
        end;
      finally
        Ed.EndUpdate;
      end;
    end;
end;


procedure EditorExtendSelectionByOneLine(Ed: TSyntaxMemo);
var
  DoNext: boolean;
  NStart, NEnd: Integer;
begin
  NStart:= Ed.SelStart;
  NEnd:= Ed.SelStart+Ed.SelLength;

  DoNext:=
    (Ed.SelLength>0) and
    (Ed.CaretStrPos = NEnd) and
    (Ed.StrPosToCaretPos(NStart).X = 0) and
    ((Ed.StrPosToCaretPos(NEnd).X = 0) or (NEnd = Ed.TextLength));

  if not DoNext then
  begin
    Ed.ResetSelection;
    Ed.ExecCommand(smLineStart);
  end;
  Ed.ExecCommand(smSelDown);
end;


procedure EditorScrollToSelection(Ed: TSyntaxMemo; NSearchOffsetY: Integer);
var
  Save: TSynSelSave;
begin
  with Ed do
    if HaveSelection then
    begin
      EditorSaveSel(Ed, Save);
      if SelLength>0 then
        CaretStrPos:= SelStart
      else
        CaretPos:= Point(SelRect.Left, SelRect.Top);
      EditorCenterPos(Ed, true{GotoMode}, NSearchOffsetY);
      EditorRestoreSel(Ed, Save);
    end;
end;


procedure EditorExtendSelectionByLexer_All(Ed: TSyntaxMemo; var Err: string);
var
  An: TClientSyntAnalyzer;
  R: TTextRange;
  SelSave: TSynSelSave;
  EndPos: Integer;
begin
  Err:= '';
  An:= Ed.SyntObj;
  if An=nil then
    begin Err:= 'No lexer active'; Exit end;

  EditorSaveSel(Ed, SelSave);

  //if selection is made, it may be selection from prev ExtendSel call,
  //so need to increment caret pos, to extend selection further
  if Ed.HaveSelection then
  begin
    Ed.ResetSelection;
    Ed.CaretStrPos:= Ed.CaretStrPos+2;
  end;

  R:= An.NearestRangeAtPos(Ed.CaretStrPos);
  if (R=nil) or not R.IsClosed then
  begin
    Err:= 'Extend selection: no range at caret';
    EditorRestoreSel(Ed, SelSave);
    Exit
  end;

  EndPos:= R.EndIdx;
  if not ((EndPos>=0) and (EndPos<An.TagCount)) then
  begin
    Err:= 'Extend selection: no closed range';
    Exit
  end;

  EndPos:= An.Tags[EndPos].EndPos;
  Ed.SetSelection(R.StartPos, EndPos-R.StartPos);
end;


procedure EditorExtendSelectionByLexer_HTML(Ed: TSyntaxMemo);
var
  An: TClientSyntAnalyzer;
  i, StPos, EndPos, NCaret: Integer;
begin
  An:= Ed.SyntObj;
  if An=nil then Exit;

  NCaret:= Ed.CaretStrPos;
  for i:= An.RangeCount-1 downto 0 do
  begin
    //get StPos start of range, EndPos end of range
    StPos:= An.Ranges[i].StartPos;
    EndPos:= An.Ranges[i].EndIdx;
    if EndPos<0 then Continue;
    EndPos:= An.Tags[EndPos].EndPos;

    //take only range, which starts before NCaret, and ends after NCaret
    if (StPos<NCaret) and (EndPos>=NCaret) then
      //and not range which is from "<" to ">" - this is just tag
      if not (Ed.Lines.Chars[StPos+1]='<') then
      begin
        //correct StPos, EndPos coz they don't include "<" and ">" in HTML
        Dec(StPos);
        Inc(EndPos);
        Ed.SetSelection(StPos, EndPos-StPos);
        Break
      end;
  end;
end;

procedure EditorSplitLinesByPosition(Ed: TSyntaxMemo; nCol: Integer);
var
  Ln1, Ln2, i: Integer;
  s, sCR: Widestring;
begin
  EditorGetSelLines(Ed, Ln1, Ln2);
  sCR:= EditorEOL(Ed);

  Ed.BeginUpdate;
  try
    for i:= Ln2 downto Ln1 do
    begin
      s:= Ed.Lines[i];
      s:= WideWrapText(s, sCR, [' ', '-', '+', #9], nCol);
      EditorReplaceLine(Ed, i, s, true{Undo});
    end;
  finally
    Ed.EndUpdate;
  end;
end;

procedure EditorInsertTextData(Ed: TSyntaxMemo; const Data: TSynEditorInsertData);
var
  iFrom, iTo, iCnt, i, n: Integer;
  IsSel: boolean;
  S: Widestring;
begin
  if Ed.ReadOnly then Exit;
  EditorGetSelLines(Ed, iFrom, iTo);
  IsSel:= iTo > iFrom;

  with Ed do
  with Data do
  begin
    BeginUpdate;
    ResetSelection;
    try
      iCnt:= 0;
      if not IsSel then
      begin
        //----counter times inserting
        for i:= 1 to NCounter do
        begin
          case InsMode of
            mTxt: S:= SText1 + SText2;
            mBul: S:= WideString(#$2022) + ' ';
            mNum: S:= NBegin + SFormatNum(NStart+i-1, NDigits) + NTail;
            else S:= '';
          end;//case
          InsertText(
            StringOfChar(' ', InsCol-1)
            + S + EditorEOL(Ed));
        end;
      end
      else
      //----insert into selection
      for i:= iFrom to iTo do
      begin
        if (Lines[i]='') and SkipEmpty then
          Continue;
        Inc(iCnt);

        //Put caret
        case InsPos of
          pCol:
            begin
              CaretPos:= Point(InsCol-1, i);
              //handle "Keep caret in text"
              if soKeepCaretInText in Ed.Options then
                if CaretPos.X<InsCol-1 then
                  InsertText(StringOfChar(' ', (InsCol-1)-CaretPos.X));
            end;
          pAfterSp:
            begin
              CaretPos:= Point(SNumLeadSpaces(Lines[i]), i);
            end;
          else
            begin
              n:= Pos(InsStrAfter, Lines[i]);
              if n=0 then Continue;
              CaretPos:= Point(n-1+Length(InsStrAfter), i);
            end;
        end;

        case InsMode of
        //Text
        mTxt:
          begin
            if SText1<>'' then
            begin
              InsertText(SText1);
            end;
            if SText2<>'' then
            begin
              CaretPos:= Point(Length(Lines[i]), i);
              InsertText(SText2);
            end;
          end;
        //Bullets
        mBul:
          begin
            InsertText(WideString(#$2022) + ' ');
          end;
        //Nums
        mNum:
          begin
            s:= NBegin + SFormatNum(NStart+iCnt-1, NDigits) + NTail;
            InsertText(s);
          end;
        end;//case
      end;
    finally
      EndUpdate;
    end;
  end;
end;


procedure EditorPasteAndSelect(Ed: TSyntaxMemo);
var
  ins_text: Widestring;
  NStart, NLen: Integer;
begin
  if Ed.ReadOnly then Exit;
  if not Clipboard.HasFormat(CF_TEXT) then Exit;

  //column block?
  if (GetClipboardBlockType <> 2) then
  begin
    //part copied from ecSyntMemo.PasteFromClipboard
    //yes, not DRY
    if soSmartPaste in Ed.OptionsEx then
      ins_text:= GetClipboardTextEx(Ed.Charset)
    else
      ins_text:= GetClipboardText(Ed.Charset);

    case Ed.Lines.TextFormat of
      tfCR: ReplaceStr(ins_text, #13#10, #13);
      tfNL: ReplaceStr(ins_text, #13#10, #10);
    end;

    Ed.InsertText(''); //fix CaretStrPos when caret is after EOL
    NStart:= Ed.CaretStrPos;
    NLen:= Length(ins_text);

    Ed.InsertText(ins_text);
    Ed.SetSelection(NStart, NLen);
  end
  else
    Ed.PasteFromClipboard();
end;


procedure EditorInsertBlankLineAboveOrBelow(Ed: TSyntaxMemo; ABelow: boolean);
begin
  if Ed.ReadOnly then Exit;
  if ABelow then
  begin
    if Ed.CaretPos.Y < Ed.Lines.Count-1 then
    begin
      Ed.CaretPos:= Point(0, Ed.CaretPos.Y+1);
      Ed.InsertNewLine(0, true{DoNotMoveCaret}, false);
    end
    else
    begin
      Ed.ExecCommand(smEditorBottom);
      Ed.InsertNewLine(0, false{DoNotMoveCaret}, false);
    end;
  end
  else
  begin
    Ed.CaretPos:= Point(0, Ed.CaretPos.Y);
    Ed.InsertNewLine(0, true{DoNotMoveCaret}, false);
  end;
end;


procedure EditorDoHomeKey(Ed: TSyntaxMemo);
//do Eclipse/Sublime-like jump by Home key
var
  p: TPoint;
  s: Widestring;
  NIndent: Integer;
begin
  p:= Ed.CaretPos;
  if (p.Y>=0) and (p.Y<Ed.Lines.Count) then
  begin
    s:= Ed.Lines[p.Y];
    NIndent:= Length(SIndentOf(s));
    if p.X = NIndent then
      p.X:= 0
    else
      p.X:= NIndent;
    Ed.CaretPos:= p;
  end;
end;

end.
