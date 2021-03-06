{
SynWrite main Options dialog.
}
//{$define NOSEQ}

unit unSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Grids, Spin,

  ecSyntMemo, ecKeyMap, ecHotKeyEdit, ecPopupCtrl,
  TntStdCtrls, TntComCtrls, TntForms, TntGrids,
  DKLang,

  unMain,
  unSetupOvr;

type
  TfmSetup = class(TTntForm)
    Tabs: TTntPageControl;
    bApply: TTntButton;
    bCan: TTntButton;
    tabColors: TTntTabSheet;
    tabKey: TTntTabSheet;
    bOk: TTntButton;
    FontDialog: TFontDialog;
    KeyList: TTntStringGrid;
    KeyMapping: TSyntKeyMapping;
    ecHotKey: TecHotKey;
    bKeySet: TTntButton;
    bKeyClear: TTntButton;
    tabFiles: TTntTabSheet;
    gColors: TTntGroupBox;
    Label4: TTntLabel;
    ListColors: TTntListBox;
    Label5: TTntLabel;
    StaticText1: TTntStaticText;
    tabProgSett: TTntTabSheet;
    boxProgSett: TTntGroupBox;
    cbChar: TTntCheckBox;
    Label11: TTntLabel;
    cbStat: TTntCheckBox;
    tabACP: TTntTabSheet;
    bKeyFind: TTntButton;
    cbMenu: TTntCheckBox;
    DKLanguageController1: TDKLanguageController;
    ColorBox1: TColorBox;
    cbInst: TTntCheckBox;
    gAcpAll: TTntGroupBox;
    Label42: TTntLabel;
    cbAcpFilter: TTntComboBox;
    cbAcpNone: TTntCheckBox;
    edAcpDrop: TSpinEdit;
    bColorLoad: TTntButton;
    bColorSave: TTntButton;
    OpenDialogPre: TOpenDialog;
    SaveDialogPre: TSaveDialog;
    tabHist: TTntTabSheet;
    boxHist: TTntGroupBox;
    Label8: TTntLabel;
    Label7: TTntLabel;
    TntLabel11: TTntLabel;
    edFS: TSpinEdit;
    edSR: TSpinEdit;
    cbHCaret: TTntCheckBox;
    cbHEnc: TTntCheckBox;
    bClrSR: TTntButton;
    bClrFS: TTntButton;
    cbMru: TTntCheckBox;
    cbDirLast: TTntComboBox;
    edDirLast: TTntEdit;
    bDirLast: TTntButton;
    TntLabel10: TTntLabel;
    cbBak: TTntComboBox;
    edAcpNum: TSpinEdit;
    gAcp2: TTntGroupBox;
    cbAcpFile: TTntCheckBox;
    edAcpFileChars: TSpinEdit;
    edAcpFileSize: TSpinEdit;
    LabelAcpFileChars: TTntLabel;
    LabelAcpFileSize: TTntLabel;
    cbKeyCat: TTntComboBox;
    TntLabel19: TTntLabel;
    cbEsc: TTntComboBox;
    TntLabel21: TTntLabel;
    tabSearch: TTntTabSheet;
    boxFind: TTntGroupBox;
    cbSrWord: TTntCheckBox;
    cbSrOnTop: TTntCheckBox;
    TntLabel22: TTntLabel;
    edFilter: TTntEdit;
    TntLabel25: TTntLabel;
    TimerFilt: TTimer;
    bFiltClear: TTntButton;
    cbSrSel: TTntCheckBox;
    tabASave: TTntTabSheet;
    gASave: TTntGroupBox;
    cbASaveTimer: TTntCheckBox;
    edASaveTime: TSpinEdit;
    cbASaveFocus: TTntCheckBox;
    gASaveWhat: TTntGroupBox;
    cbASaveCurrFile: TTntRadioButton;
    cbASaveAllFiles: TTntRadioButton;
    labASavIgnore: TTntLabel;
    edASaveMaxSize: TSpinEdit;
    labASaveTime: TTntLabel;
    labKByte: TTntLabel;
    gUnnamed: TTntGroupBox;
    edASaveUnnamedDir: TEdit;
    cbASaveUnIgnore: TTntRadioButton;
    cbASaveUnShowSave: TTntRadioButton;
    cbASaveUnSaveToDir: TTntRadioButton;
    bUnnamedBrowse: TTntButton;
    gAcpSp: TTntGroupBox;
    cbAcpHtm: TTntCheckBox;
    cbAcpTabbing: TTntCheckBox;
    cbAcpCss: TTntCheckBox;
    labSmTabHelp: TTntLabel;
    cbHTemp: TTntCheckBox;
    cbAcpUseSingle: TTntCheckBox;
    cbTplTabbing: TTntCheckBox;
    labTplHelp: TTntLabel;
    cbACloseTags: TTntCheckBox;
    TntLabel7: TTntLabel;
    TntLabel12: TTntLabel;
    labAutoCloseHelp: TTntLabel;
    cbACloseBr: TTntCheckBox;
    cbACloseBrEsc: TTntCheckBox;
    cbACloseQ: TTntCheckBox;
    ListCat: TTntListBox;
    tabTabs: TTntTabSheet;
    boxTabs: TTntGroupBox;
    TntLabel3: TTntLabel;
    cbTabBtn: TTntCheckBox;
    cbTabMul: TTntCheckBox;
    cbTabDown: TTntCheckBox;
    cbTabNums: TTntCheckBox;
    cbTabSw: TTntCheckBox;
    cbTabDnD: TTntCheckBox;
    edTabMaxLen: TSpinEdit;
    cbTabDbl: TTntCheckBox;
    boxToolbar: TTntGroupBox;
    Label2: TTntLabel;
    cbTheme: TTntComboBox;
    Label12: TTntLabel;
    cbIcons: TTntComboBox;
    tabFonts: TTntTabSheet;
    gFont: TTntGroupBox;
    b1: TTntButton;
    b2: TTntButton;
    b4: TTntButton;
    b3: TTntButton;
    b5: TTntButton;
    b6: TTntButton;
    tabTree: TTntTabSheet;
    boxTree: TTntGroupBox;
    cbTreeSync: TTntCheckBox;
    tabSess: TTntTabSheet;
    boxSess: TTntGroupBox;
    cbSessDef: TTntCheckBox;
    cbSessLoad: TTntCheckBox;
    cbSessSave: TTntCheckBox;
    boxProj: TTntGroupBox;
    cbProjLoad: TTntCheckBox;
    cbProjSave: TTntCheckBox;
    boxMinimap: TTntGroupBox;
    TntLabel26: TTntLabel;
    edMapZoom: TSpinEdit;
    boxFGroup: TTntGroupBox;
    TntLabel1: TTntLabel;
    cbText_: TTntComboBox;
    Label17: TTntLabel;
    TntLabel8: TTntLabel;
    edOem: TTntEdit;
    edUTF8: TTntEdit;
    TntLabel9: TTntLabel;
    boxReload: TTntGroupBox;
    Label9: TTntLabel;
    cbNotif: TTntComboBox;
    cbTail: TTntCheckBox;
    cbOverRO: TTntCheckBox;
    edBigSize: TSpinEdit;
    TntLabel23: TTntLabel;
    ListTabColors: TTntListBox;
    TntLabel13: TTntLabel;
    tabFolders: TTntTabSheet;
    boxFolders: TTntGroupBox;
    TntLabel14: TTntLabel;
    TntLabel15: TTntLabel;
    edFolders: TTntMemo;
    bAddFolder: TTntButton;
    tabSpell: TTntTabSheet;
    boxSpellOpt: TTntGroupBox;
    TntLabel16: TTntLabel;
    TntLabel24: TTntLabel;
    edSpellExt: TTntEdit;
    cbSpellEn: TTntCheckBox;
    bSpellOpt: TTntButton;
    boxSpellLnk: TTntGroupBox;
    TntLabel27: TTntLabel;
    labDictWww: TTntLabel;
    labDictDir: TTntLabel;
    tabOvr: TTntTabSheet;
    edSrOffsetY: TSpinEdit;
    TntLabel32: TTntLabel;
    cbTabVis: TTntComboBox;
    edTplTabEx: TEdit;
    TntLabel34: TTntLabel;
    TntLabel36: TTntLabel;
    cbUniNeed: TTntComboBox;
    cbTreeDelay: TSpinEdit;
    TntLabel39: TTntLabel;
    tabCarets: TTntTabSheet;
    boxCarets: TTntGroupBox;
    cbCaretMulti: TTntCheckBox;
    TntLabel30: TTntLabel;
    cbCaretIndNone: TTntRadioButton;
    cbCaretIndLine: TTntRadioButton;
    cbCaretIndGutter: TTntRadioButton;
    TntLabel31: TTntLabel;
    edCaretGutterCol: TSpinEdit;
    labCaretHelp: TTntLabel;
    labAcpHelp: TTntLabel;
    boxFindTree: TTntGroupBox;
    cbSrExpand: TTntCheckBox;
    edSrMaxTreeMatches: TSpinEdit;
    TntLabel17: TTntLabel;
    cbSrQsCap: TTntCheckBox;
    boxCarets2: TTntGroupBox;
    edCaretType: TTntComboBox;
    TntLabel40: TTntLabel;
    cbCaretSmart: TTntCheckBox;
    cbCaretInText: TTntCheckBox;
    cbCaretKeepOnPaste: TTntCheckBox;
    cbCaretInRO: TTntCheckBox;
    tabNewOpen: TTntTabSheet;
    boxNew: TTntGroupBox;
    TntLabel4: TTntLabel;
    TntLabel5: TTntLabel;
    TntLabel6: TTntLabel;
    edEnc: TTntComboBox;
    edLE: TTntComboBox;
    edLex: TTntComboBox;
    tabView: TTntTabSheet;
    tabSelHL: TTntTabSheet;
    tabInsertFormat: TTntTabSheet;
    cbSavePos: TTntCheckBox;
    boxMicromap: TTntGroupBox;
    cbMicroMap: TTntCheckBox;
    cbBeep: TTntCheckBox;
    cbMenuIcon: TTntCheckBox;
    cbFullTitle: TTntCheckBox;
    cbGroupLexers: TTntCheckBox;
    cbSortMode: TTntComboBox;
    TntLabel38: TTntLabel;
    TntLabel37: TTntLabel;
    cbRecColors: TTntComboBox;
    boxDateFormat: TTntGroupBox;
    cbZenProfile: TTntComboBox;
    labEmmet: TTntLabel;
    TntLabel18: TTntLabel;
    edDateFmt: TTntEdit;
    labDate: TTntLabel;
    TntLabel20: TTntLabel;
    edDateFmtP: TTntEdit;
    TntLabel33: TTntLabel;
    boxIndent: TTntGroupBox;
    Label1: TTntLabel;
    edIndent: TSpinEdit;
    boxSelFmt: TTntGroupBox;
    cbUrlHilite: TTntCheckBox;
    cbUrlClick: TTntCheckBox;
    cbHiliteSmart: TTntCheckBox;
    cbHiliteSmartCase: TTntCheckBox;
    cbHiliteBrackets: TTntCheckBox;
    cbCopyLineNSel: TTntCheckBox;
    cbColorOnEmpty: TTntCheckBox;
    boxView: TTntGroupBox;
    Label15: TTntLabel;
    Label3: TTntLabel;
    Label14: TTntLabel;
    TntLabel28: TTntLabel;
    cbDrawLineBG: TTntCheckBox;
    cbHideCursor: TTntCheckBox;
    edLSpace: TSpinEdit;
    edMargin: TSpinEdit;
    cbMargin: TTntCheckBox;
    edLineNums: TTntComboBox;
    cbDrawFocus: TTntCheckBox;
    cbRuler: TTntCheckBox;
    cbStaples: TComboBox;
    edStapleOffset: TSpinEdit;
    cbDrawWrapMark: TTntCheckBox;
    cbDrawCol: TTntCheckBox;
    boxNonPrint: TTntGroupBox;
    cbNPrintShow: TTntCheckBox;
    cbNPrintSp: TTntCheckBox;
    cbNPrintEol: TTntCheckBox;
    cbNPrintEolEx: TTntCheckBox;
    tabUndo: TTntTabSheet;
    boxUndo: TTntGroupBox;
    TntLabel2: TTntLabel;
    edUndoLimit: TSpinEdit;
    cbUndoMass: TTntCheckBox;
    cbGroupRedo: TTntCheckBox;
    cbGroupUndo: TTntCheckBox;
    cbUndoAfterSave: TTntCheckBox;
    cbAutoIndent: TTntCheckBox;
    cbBackspUnindent: TTntCheckBox;
    cbUnindentAlign: TTntCheckBox;
    cbOptFill: TTntCheckBox;
    cbKeepBlank: TTntCheckBox;
    cbWrap: TTntCheckBox;
    cbFold: TTntCheckBox;
    cbFixLineSize: TTntCheckBox;
    cbScrollLast: TTntCheckBox;
    cbWrapMargin: TTntCheckBox;
    cbFixColMove: TTntCheckBox;
    cbVarHorzBar: TTntCheckBox;
    cbSelMode: TTntComboBox;
    TntLabel35: TTntLabel;
    cbFloatM: TTntCheckBox;
    cbCollap: TTntCheckBox;
    cbDrag: TTntCheckBox;
    cbCopyRtf: TTntCheckBox;
    cbGrSel: TTntCheckBox;
    cbDClick: TTntCheckBox;
    cbBPers: TTntCheckBox;
    cbBOver: TTntCheckBox;
    boxTabs2: TTntGroupBox;
    edTabStops: TTntEdit;
    Label16: TTntLabel;
    edTabMode: TTntComboBox;
    Label6: TTntLabel;
    cbReplaceTabs: TTntCheckBox;
    boxLang: TTntGroupBox;
    labLangInfo: TTntLabel;
    cbLang: TTntComboBox;
    edWordChars: TTntEdit;
    labWordChars: TTntLabel;
    cbTabStyle: TTntComboBox;
    cbAcpParamHints: TTntCheckBox;
    cbHiliteSmartClick: TTntCheckBox;
    cbHiliteSmartWords: TTntCheckBox;
    cbProjSessSave: TTntCheckBox;
    cbProjSessOpen: TTntCheckBox;
    cbProjCloseTabs: TTntCheckBox;
    bKeyExtend: TTntButton;
    procedure bApplyClick(Sender: TObject);
    procedure bCanClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Apply;
    procedure bOkClick(Sender: TObject);
    procedure tabColorsShow(Sender: TObject);
    procedure ListColorsClick(Sender: TObject);
    procedure ColorBox1Select(Sender: TObject);
    procedure bKeySetClick(Sender: TObject);
    procedure tabKeyShow(Sender: TObject);
    procedure KeyListMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure KeyListSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure KeyListDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure KeyListClick(Sender: TObject);
    procedure KeyListMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure KeyListMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure bKeyClearClick(Sender: TObject);
    procedure ecHotKeyChange(Sender: TObject);
    procedure tabFilesShow(Sender: TObject);
    procedure b1Click(Sender: TObject);
    procedure b2Click(Sender: TObject);
    procedure b3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FontDialogShow(Sender: TObject);
    procedure tabProgSettShow(Sender: TObject);
    procedure tabACPShow(Sender: TObject);
    procedure bClrFSClick(Sender: TObject);
    procedure bClrSRClick(Sender: TObject);
    procedure bKeyFindClick(Sender: TObject);
    procedure b4Click(Sender: TObject);
    procedure b5Click(Sender: TObject);
    procedure edTabModeChange(Sender: TObject);
    procedure b6Click(Sender: TObject);
    procedure bColorSaveClick(Sender: TObject);
    procedure bColorLoadClick(Sender: TObject);
    procedure bDirLastClick(Sender: TObject);
    procedure tabHistShow(Sender: TObject);
    procedure cbKeyCatChange(Sender: TObject);
    procedure labDateClick(Sender: TObject);
    procedure tabSearchShow(Sender: TObject);
    procedure cbSessSaveClick(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure TimerFiltTimer(Sender: TObject);
    procedure cbStaplesDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure edIndentKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bFiltClearClick(Sender: TObject);
    procedure tabASaveShow(Sender: TObject);
    procedure bUnnamedBrowseClick(Sender: TObject);
    procedure cbASaveUnnamedClick(Sender: TObject);
    procedure cbASaveTimerClick(Sender: TObject);
    procedure labSmTabHelpClick(Sender: TObject);
    procedure labTplHelpClick(Sender: TObject);
    procedure labAutoCloseHelpClick(Sender: TObject);
    procedure cbACloseBrClick(Sender: TObject);
    procedure cbAcpFileClick(Sender: TObject);
    procedure ListColorsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListCatClick(Sender: TObject);
    procedure tabTabsShow(Sender: TObject);
    procedure tabFontsShow(Sender: TObject);
    procedure tabTreeShow(Sender: TObject);
    procedure tabSessShow(Sender: TObject);
    procedure cbLangChange(Sender: TObject);
    procedure ListTabColorsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListTabColorsDblClick(Sender: TObject);
    procedure ListTabColorsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bAddFolderClick(Sender: TObject);
    procedure edFoldersKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tabFoldersShow(Sender: TObject);
    procedure tabSpellShow(Sender: TObject);
    procedure labDictWwwClick(Sender: TObject);
    procedure labDictDirClick(Sender: TObject);
    procedure bSpellOptClick(Sender: TObject);
    procedure tabOvrShow(Sender: TObject);
    procedure TntFormCreate(Sender: TObject);
    procedure labEmmetClick(Sender: TObject);
    procedure tabCaretsShow(Sender: TObject);
    procedure labCaretHelpClick(Sender: TObject);
    procedure labAcpHelpClick(Sender: TObject);
    procedure tabNewOpenShow(Sender: TObject);
    procedure tabViewShow(Sender: TObject);
    procedure tabSelHLShow(Sender: TObject);
    procedure tabInsertFormatShow(Sender: TObject);
    procedure tabUndoShow(Sender: TObject);
    procedure bKeyExtendClick(Sender: TObject);
  private
    { Private declarations }
    fmOvr: TfmSetupOvr;
    Colors: TSynColors;
    ColorsOfTabs: array[0..Pred(cTabColors)] of TColor;
    FLangChanged: boolean;
    
    procedure UpdateKeyButtons;
    procedure ListKeys;
    procedure FixWnd;
    function ColorPreFN(const Name: string): string;
    function KeymappingIndex(Row: integer): integer;

    procedure ApplyView;
    procedure ApplySelHL;
    procedure ApplyInsertFormat;
    procedure ApplyLang;
    procedure ApplyProgSett;
    procedure ApplyColors;
    procedure ApplyFonts;
    procedure ApplyTabs;
    procedure ApplyEditorCarets;
    procedure ApplyEditorOverrides;
    procedure ApplyKeys;
    procedure ApplyFiles;
    procedure ApplySearch;
    procedure ApplyTree;
    procedure ApplyHistory;
    procedure ApplyUndo;
    procedure ApplySessionsProjects;
    procedure ApplyAutoComplete;
    procedure ApplyAutoSave;
    procedure ApplySpell;
    procedure ApplySearchFolders;
    procedure ApplyNewOpen;

    procedure InitView;
    procedure InitSelHL;
    procedure InitInsertFormat;
    procedure InitNewOpen;
    procedure InitSidebar;
    procedure InitLang;
    procedure InitProgSett;
    procedure InitColors;
    procedure InitFonts;
    procedure InitTabs;
    procedure InitEditorCarets;
    procedure InitEditorOverrides;
    procedure InitKeys;
    procedure InitFiles;
    procedure InitSearch;
    procedure InitTree;
    procedure InitHistory;
    procedure InitUndo;
    procedure InitSessionsProjects;
    procedure InitAutoComplete;
    procedure InitAutoSave;
    procedure InitSpell;
    procedure InitSearchFolders;
  public
    { Public declarations }
    fmMain: TfmMain;
  end;

const
  cColors: array[0..cColorsNum-1] of string = (
    'Text', //0
    'Text-BG', //1
    'Current-line-BG', //2
    'Line-numbers-text', //3
    'Line-numbers-BG', //4
    'Collapse-line', //5
    'Folding-lines', //6
    'Folding-bar-BG', //7
    'Gutter-separator', //8
    'Selection-text', //9
    'Selection-BG', //10
    'Right-margin', //11
    'Hints-text', //12
    'Hints-BG', //13
    'Non-printable-chars', //14
    'Indentation-staples', //15
    'Gutter-gradient-right', //16
    'Tree-text', //17
    'Tree-BG', //18
    'Ruler-text', //19
    'Ruler-BG', //20
    'Passive-tabs', //21
    'Active-tab', //22
    'Active-tab-line', //23
    'Search-marks-text', //24
    'Search-marks-BG', //25
    'Output-panel-text', //26
    'Output-panel-BG', //27
    'Output-panel-selection-text', //28
    'Output-panel-selection-BG', //29
    'Output-panel-active-text', //30
    'Output-panel-active-selected-text', //31
    'Output-panel-highlight-mask', //32
    'Pair-brackets', //33
    'Pair-brackets-BG', //34
    'Links-highlighting', //35
    'Views-splitter', //36
    'Current-line-text', //37
    'Line-state-modified', //38
    'Line-state-new', //39
    'Line-state-saved', //40
    'Line-state-unchanged', //41
    'Tab-caption', //42
    'Tab-caption-unsaved', //43
    'Bookmark-BG', //44
    'Map-BG', //45
    'Collapse-mark', //46
    'Slave-splitter', //47
    'Line-state-def', //48
    'Non-printable-BG', //49
    'Collapse-mark-BG', //50
    'SyncEdit-BG', //51
    'Map-marks-BG', //52
    'Carets-gutter-BG', //53
    'Auto-complete-text', //54
    'Auto-complete-BG' //55
    );

const
  cColorsOrder: array[0..cColorsNum-7] of integer = (
    0,
    1,
    9,
    10,
    37,
    2,
    3,
    4,
    6,
    7,
    5,
    46,
    50,
    14,
    49,
    15,
    11,
    24,
    25,
    44,
    42,
    43,
    21,
    22,
    23,
    17,
    18,
    19,
    20,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    //33,
    //34,
    35,
    //36,
    //47,
    38,
    39,
    40,
    41,
    48,
    45,
    52,
    51,
    53,
    54,
    55,
    12,
    13
    );

implementation

uses
  IniFiles, Types,
  ecSyntTree, ecSyntAnal, ecStrUtils,
  ATSyntMemo,
  ATxShell, ATxFProc, ATxSProc,

  //unHints, //seems no effect for SpTbx hints, for editor hints. 
             //only effect for project tree (hints loose shadow). poor.
  
  unProc,
  unProcHelp,
  unProj,
  unProcSort,

  TntClasses,
  TntFileCtrl;

{$R *.dfm}

const
  cColorExt = 'synw-colors';
  cColorFilter = '*.'+cColorExt+'|*.'+cColorExt;

procedure TfmSetup.bOkClick(Sender: TObject);
begin
  Apply;
  ModalResult:= mrOk;
end;

procedure TfmSetup.bCanClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfmSetup.bApplyClick(Sender: TObject);
begin
  Apply;
end;

procedure TfmSetup.Apply;
var
  i: integer;
begin
  if tabCarets.Tag  <>0 then ApplyEditorCarets;
  if tabOvr.Tag     <>0 then ApplyEditorOverrides;
  if tabSearch.Tag  <>0 then ApplySearch;
  if tabTree.Tag    <>0 then ApplyTree;
  if tabFonts.Tag   <>0 then ApplyFonts;
  if tabColors.Tag  <>0 then ApplyColors;
  if tabKey.Tag     <>0 then ApplyKeys;
  if tabFolders.Tag <>0 then ApplySearchFolders;
  if tabSpell.Tag   <>0 then ApplySpell;
  if tabFiles.Tag   <>0 then ApplyFiles;
  if tabProgSett.Tag<>0 then ApplyProgSett;
  if tabTabs.Tag    <>0 then ApplyTabs;
  if tabACP.Tag     <>0 then ApplyAutoComplete;
  if tabASave.Tag   <>0 then ApplyAutoSave;
  if tabSess.Tag    <>0 then ApplySessionsProjects;
  if tabHist.Tag    <>0 then ApplyHistory;
  if tabUndo.Tag    <>0 then ApplyUndo;
  if tabNewOpen.Tag <>0 then ApplyNewOpen;
  if tabView.Tag    <>0 then ApplyView;
  if tabSelHL.Tag   <>0 then ApplySelHL;
  if tabInsertFormat.Tag<>0 then ApplyInsertFormat;

  with fmMain do
  begin
    //update from template
    PropsManager.UpdateAll;
    for i:= 0 to FrameAllCount-1 do
      UpdateGutter(FramesAll[i]);

    //save
    opTabOptionsLast:= ListCat.ItemIndex;
    SaveIni;
  end;
end;

procedure TfmSetup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

function ColorNumToLngID(n: integer): string;
begin
  Result:= 'zzc_' + cColors[n];
  SReplaceAll(Result, '-', '_');
end;

//view
procedure TfmSetup.tabColorsShow(Sender: TObject);
begin
  if tabColors.Tag<>0 then Exit;
  tabColors.Tag:= 1;
  InitColors;
end;

procedure TfmSetup.ListColorsClick(Sender: TObject);
begin
  ColorBox1.Selected:= Colors[cColorsOrder[ListColors.ItemIndex]];
  ColorBox1.Items.Objects[0]:= TObject(ColorBox1.Selected); //set Custom color
  ColorBox1.Invalidate;
end;

procedure TfmSetup.ColorBox1Select(Sender: TObject);
begin
  Colors[cColorsOrder[ListColors.ItemIndex]]:= ColorBox1.Selected;
  ListColors.Invalidate;
end;

procedure TfmSetup.b1Click(Sender: TObject);
begin
  FontDialog.Font:= b1.Font;
  if FontDialog.Execute then
    b1.Font:= FontDialog.Font;
end;

procedure TfmSetup.tabKeyShow(Sender: TObject);
begin
  if tabKey.Tag<>0 then Exit;
  tabKey.Tag:= 1;

  InitKeys;
  UpdateKeyButtons;
end;

function SKeysOf(c: TecCommandItem): string;
begin
  Result:= '';
  if c.KeyStrokes.Count>0 then
    Result:= Result + c.KeyStrokes.Items[0].AsString+' ';
  if c.KeyStrokes.Count>1 then
    Result:= Result + c.KeyStrokes.Items[1].AsString+' ';
end;

procedure TfmSetup.ListKeys;
var
  i, j, k: integer;
  //info: TScrollInfo;
  old: string;
  g: TGridRect;
begin
  with KeyList do
  begin
    ColWidths[0]:= 0;
    ColWidths[1]:= Width - 2*DefaultColWidth - 32;
    Cells[1,0]:= DKLangConstW('zKeyCmd');
    Cells[2,0]:= DKLangConstW('zKey1');
    Cells[3,0]:= DKLangConstW('zKey2');
    RowCount:= 2;
    j:= 1;
    old:= '';

    for k:= 0 to cbKeyCat.Items.Count-1 do //categories
    for i:= 0 to KeyMapping.Items.Count-1 do //items
    //item filtered?
    if SSubstringMatch(KeyMapping.Items[i].DisplayName, edFilter.Text) or
      SSubstringMatch(SKeysOf(KeyMapping.Items[i]), edFilter.Text) then
    if KeyMapping.Items[i].Category = cbKeyCat.Items[k] then
    begin
      if not KeyMapping.Items[i].Customizable then Continue;
      if KeyMapping.Items[i].Command = -1 then //unused items
        begin KeyMapping.Items[i].KeyStrokes.Clear; Continue; end;

      RowCount:= j+1;
      KeyList.RowHeights[KeyList.RowCount-1]:= KeyList.RowHeights[0];

      //add category
      if old<>KeyMapping.Items[i].Category then
      begin
        Cells[0,j]:= '-';
        Cells[1,j]:= KeyMapping.Items[i].Category;
        Cells[2,j]:= '';
        Cells[3,j]:= '';
        old:= Cells[1,j];
        inc(j);
        RowCount:= j+1;
      end;
      //add item
      Cells[0,j]:= IntToStr(i);
      Cells[1,j]:= KeyMapping.Items[i].DisplayName;
      Cells[2,j]:= '';
      Cells[3,j]:= '';
      if KeyMapping.Items[i].KeyStrokes.Count>0 then Cells[2,j]:= KeyMapping.Items[i].KeyStrokes.Items[0].AsString;
      if KeyMapping.Items[i].KeyStrokes.Count>1 then Cells[3,j]:= KeyMapping.Items[i].KeyStrokes.Items[1].AsString;
      inc(j);
    end;
  end;

  if edFilter.Text='' then
    cbKeyCatChange(Self);

  //scrollbar
  {FillChar(info, SizeOf(info), 0);
  with info do begin
   cbsize := SizeOf(info);
   fmask  := SIF_ALL;
   GetScrollInfo(KeyList.Handle, SB_VERT, info);
   fmask := fmask or SIF_PAGE;
   nPage := 22 * (nmax - nmin) div j;
  end;
  SetScrollInfo(KeyList.Handle, SB_VERT, info, True);}

  g.Left:= 2; g.Top:= 2; g.Right:= 2; g.Bottom:= 2;
  KeyList.Selection:= g;
end;

procedure TfmSetup.KeyListMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  c, r: integer;
begin
  KeyList.MouseToCell(x, y, c, r);
  if (c<0) or (r<0) then Exit;
  if (r=0) or (c=0) then
    KeyList.Hint:= ''
  else
    KeyList.Hint:= KeyList.Cells[c, r];

  Application.ActivateHint(KeyList.ClientToScreen(Point(x, y)));
end;

procedure TfmSetup.KeyListSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  r: TGridRect;
begin
  KeyList.Repaint;
  if ARow=0 then Exit;

  if KeymappingIndex(ARow)<0 then
  begin
    Inc(ARow);
    ACol:= 0;
  end;
  if (ACol<2) then
  begin
    r.Left:= 2;
    r.Top:= ARow;
    r.Right:= r.Left;
    r.Bottom:= r.Top;
    KeyList.Selection:= r;
    CanSelect:= false;
  end;
end;

procedure TfmSetup.KeyListDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  r: TRect;
  s: WideString;
begin
  if (ARow=0) or (ACol=0) then Exit;
  //category
  if KeymappingIndex(ARow)<0 then
  begin
    r:= Rect;
    Inc(r.Right);
    KeyList.Canvas.FillRect(r);
    KeyList.Canvas.Font.Color:= clNavy;
    KeyList.Canvas.Font.Style:= KeyList.Canvas.Font.Style+[fsBold];
    s:= KeyList.Cells[ACol, ARow];
    TextOutW(KeyList.Canvas.Handle, Rect.Left+2, Rect.Top+2, PWChar(s), Length(s));
  end;
  //selection line
  if ARow=KeyList.Selection.Top then begin
    if ACol=KeyList.Selection.Left then
      KeyList.Canvas.Brush.Color:= clHighlight
    else
      KeyList.Canvas.Brush.Color:= clMedGray;
    KeyList.Canvas.FillRect(Rect);
    s:= KeyList.Cells[ACol, ARow];
    TextOutW(KeyList.Canvas.Handle, Rect.Left+2, Rect.Top+2, PWChar(s), Length(s));
  end;
end;

procedure TfmSetup.KeyListClick(Sender: TObject);
begin
  KeyList.Repaint;
  UpdateKeyButtons;
end;

procedure TfmSetup.KeyListMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled:= true;
  with KeyList do
  if TopRow>Mouse.WheelScrollLines then
    TopRow:= TopRow-Mouse.WheelScrollLines
  else
    TopRow:= 1;
end;

procedure TfmSetup.KeyListMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled:= true;
  with KeyList do
  if TopRow<RowCount-VisibleRowCount then
    TopRow:= TopRow+Mouse.WheelScrollLines;
end;

procedure TfmSetup.bKeySetClick(Sender: TObject);
const
  cCheckDupKeys = true;
var
  i, j, c, r,
  mapindex, keyindex: integer;
  s: string;
  ovr_i, ovr_j: integer;
  cfm: boolean;
begin
  if ecHotKey.Text='' then Exit;
  c:= KeyList.Selection.Left;
  r:= KeyList.Selection.Top;
  ovr_i:= -1;
  ovr_j:= -1;

  if cCheckDupKeys then
  begin
    //find dup keys
    with KeyMapping do
     for i:= 0 to Items.Count-1 do
      for j:= 0 to Items[i].KeyStrokes.Count-1 do
        if Items[i].KeyStrokes[j].AsString=ecHotKey.Text then
        begin
          s:= DKLangConstW('zKeyUsed')+#13 + Items[i].Category + ' / ' + Items[i].DisplayName;
          cfm:= MsgConfirm(s + #13#13 + DKLangConstW('zKeyOvr'), Handle);
          if cfm then
            begin ovr_i:= i; ovr_j:= j; Break; end
          else
            Exit;
        end;

    //delete duplicate key
    if (ovr_i>=0) and (ovr_j>=0) then
    begin
      KeyMapping.Items[ovr_i].KeyStrokes.Delete(ovr_j);
      for i:= 0 to KeyList.RowCount-1 do
        if KeymappingIndex(i)=ovr_i then
        begin
          KeyList.Cells[ovr_j+2, i]:= '';
          if ovr_j=0 then
          begin
            KeyList.Cells[2, i]:= KeyList.Cells[3, i];
            KeyList.Cells[3, i]:= '';
          end;
        end;
    end;
  end;

  //assign new hotkey
  mapindex:= KeymappingIndex(r);
  keyindex:= c-2;
  if mapindex<0 then Exit;

  with KeyMapping.Items[mapindex] do
  begin
    case KeyStrokes.Count of
      0: begin KeyStrokes.Add; keyindex:= 0; end;
      1: begin if keyindex>0 then begin KeyStrokes.Add; keyindex:= 1; end; end;
      else
        raise Exception.Create(Format('Unexpected number of keystrokes, %d', [KeyStrokes.Count]));
    end;

    KeyStrokes[keyindex].KeyDefs.Clear;
    KeyStrokes[keyindex].KeyDefs.Add.ShortCut:= ecHotKey.HotKey;
    KeyList.Cells[keyindex+2, r]:= KeyStrokes[keyindex].AsString;
  end;

  UpdateKeyButtons;
end;

procedure TfmSetup.bKeyClearClick(Sender: TObject);
var
  c, r, mapindex, keyindex: integer;
begin
  c:= KeyList.Selection.Left;
  r:= KeyList.Selection.Top;
  mapindex:= KeymappingIndex(r);
  keyindex:= c-2;

  if mapindex<0 then Exit;
  if keyindex=0 then
    KeyList.Cells[2, r]:= KeyList.Cells[3, r];
  KeyList.Cells[3, r]:= '';
  
  KeyMapping.Items[mapindex].KeyStrokes.Delete(keyindex);

  ecHotKey.Text:= '';
  ecHotKeyChange(Self);
end;

procedure TfmSetup.ecHotKeyChange(Sender: TObject);
begin
  UpdateKeyButtons;
end;

//misc
procedure TfmSetup.tabFilesShow(Sender: TObject);
begin
  if tabFiles.Tag<>0 then Exit;
  tabFiles.Tag:= 1;
  InitFiles;
end;

procedure TfmSetup.b2Click(Sender: TObject);
begin
  FontDialog.Font:= b2.Font;
  if FontDialog.Execute then
    b2.Font:= FontDialog.Font;
end;

procedure TfmSetup.b3Click(Sender: TObject);
begin
  FontDialog.Font:= b3.Font;
  if FontDialog.Execute then
    b3.Font:= FontDialog.Font;
end;

procedure TfmSetup.InitSidebar;
  //----
  procedure AddTab(tab: TTntTabSheet);
  const
    SPad = '    ';
  begin
    ListCat.Items.AddObject(SPad+tab.Caption, tab);
  end;
var
  i: Integer;
begin
  for i:= 0 to Tabs.PageCount-1 do
    Tabs.Pages[i].TabVisible:= false;

  ListCat.Items.Clear;
  ListCat.Items.Add(DKLangConstW('zMOp_Intf'));
  AddTab(tabProgSett);
  AddTab(tabKey);
  AddTab(tabColors);
  AddTab(tabFonts);
  AddTab(tabTabs);
  AddTab(tabSearch);
  AddTab(tabTree);

  ListCat.Items.Add(DKLangConstW('zMOp_Editor'));
  AddTab(tabView);
  AddTab(tabSelHL);
  AddTab(tabCarets);
  AddTab(tabUndo);
  AddTab(tabInsertFormat);
  AddTab(tabOvr);
  AddTab(tabACP);
  AddTab(tabSpell);

  ListCat.Items.Add(DKLangConstW('zMOp_Files'));
  AddTab(tabNewOpen);
  AddTab(tabASave);
  AddTab(tabHist);
  AddTab(tabFiles);
  AddTab(tabSess);
  AddTab(tabFolders);

  //activate last used category
  if fmMain.opTabOptionsIndex<0 then
    ListCat.ItemIndex:= fmMain.opTabOptionsLast
  else
    ListCat.ItemIndex:= fmMain.opTabOptionsIndex;
  ListCatClick(Self);
end;

procedure TfmSetup.FormShow(Sender: TObject);
var
  i, n: Integer;
begin
  FLangChanged:= false;
  InitSidebar;

  n:= KeyList.RowHeights[0];
  n:= ScaleFontSize(n, Self);
  for i:= 0 to KeyList.RowCount-1 do
    KeyList.RowHeights[i]:= n;
end;

procedure TfmSetup.FontDialogShow(Sender: TObject);
begin
  WndCenter(FontDialog.Handle, Self);
end;

procedure TfmSetup.tabProgSettShow(Sender: TObject);
begin
  if tabProgSett.Tag<>0 then Exit;
  tabProgSett.Tag:= 1;
  InitProgSett;
end;

procedure TfmSetup.tabACPShow(Sender: TObject);
begin
  if tabACP.Tag<>0 then Exit;
  tabACP.Tag:= 1;
  InitAutoComplete;
end;

procedure TfmSetup.bClrFSClick(Sender: TObject);
begin
  fmMain.TBXItemClrClick(Self);
  bClrFS.Enabled:= false;
end;

procedure TfmSetup.bClrSRClick(Sender: TObject);
begin
  fmMain.DoClearHistory;
  bClrSR.Enabled:= false;
end;

procedure TfmSetup.bKeyFindClick(Sender: TObject);
var
  i, j, k: Integer;
  g: TGridRect;
begin
  if ecHotKey.Text='' then Exit;
  for i:= 1 to KeyList.RowCount-1 do
    for j:= 2 to 3 do
      if (KeyList.Cells[j, i]=ecHotKey.Text) then
      begin
        g.Left:= j;
        g.Top:= i;
        g.Right:= g.Left;
        g.Bottom:= g.Top;
        k:= i-2;
        if k<1 then k:= 1;
        if k>KeyList.RowCount-KeyList.VisibleRowCount then
          k:= KeyList.RowCount-KeyList.VisibleRowCount;
        KeyList.TopRow:= k;
        KeyList.Selection:= g;
        KeyList.Repaint;
        Exit;
      end;

  MsgInfo(DKLangConstW('zKeyNotUsed'), Handle);
end;

procedure TfmSetup.b4Click(Sender: TObject);
begin
  FontDialog.Font:= b4.Font;
  if FontDialog.Execute then
    b4.Font:= FontDialog.Font;
end;

procedure TfmSetup.b5Click(Sender: TObject);
begin
  FontDialog.Font:= b5.Font;
  if FontDialog.Execute then
    b5.Font:= FontDialog.Font;
end;

procedure TfmSetup.edTabModeChange(Sender: TObject);
begin
  cbReplaceTabs.Enabled:= edTabMode.ItemIndex=0;
end;

procedure TfmSetup.b6Click(Sender: TObject);
begin
  FontDialog.Font:= b6.Font;
  if FontDialog.Execute then
    b6.Font:= FontDialog.Font;
end;

procedure TfmSetup.bColorSaveClick(Sender: TObject);
var
  i:Integer;
  ok:Boolean;
begin
  with SaveDialogPre do
  begin
    InitialDir:= ExtractFileDir(ColorPreFN('-'));
    FileName:= '';
    ok:= Execute;
    FixWnd;
    if not ok then Exit;
    if ExtractFileExt(FileName) <> '.'+cColorExt then
      FileName:= FileName+'.'+cColorExt;
    with TIniFile.Create(FileName) do
    try
      EraseSection('Colors');
      for i:= 0 to cColorsNum-1 do
        WriteString('Colors_', cColors[i], ColorToString(Colors[i]));
    finally
      Free
    end;
  end;
end;

function TfmSetup.ColorPreFN(const Name: string): string;
begin
  Result:= ExtractFilePath(GetModuleName(HInstance)) + 'Template\colors\' + Name + '.'+cColorExt;
end;

procedure TfmSetup.FixWnd;
begin
  if not fmMain.SynExe then
  begin
    SetForegroundWindow(fmMain.hLister);
    SetForegroundWindow(Handle);
  end;
end;

procedure TfmSetup.bColorLoadClick(Sender: TObject);
var
  i:Integer;
  ok:Boolean;
  s:string;
begin
  with OpenDialogPre do
  begin
    InitialDir:= ExtractFileDir(ColorPreFN('-'));
    FileName:= '';
    ok:= Execute;
    FixWnd;
    if not ok then Exit;

    with TIniFile.Create(FileName) do
    try
      for i:= 0 to cColorsNum-1 do
      begin
        s:= ReadString('Colors_', cColors[i], '');
        if s<>'' then
          Colors[i]:= StringToColor(s);
      end;
    finally
      Free
    end;
  end;

  ListColorsClick(Self);
  ListColors.Invalidate;
end;

procedure TfmSetup.bDirLastClick(Sender: TObject);
var S: Widestring;
begin
  S:= edDirLast.Text;
  if WideSelectDirectory('', '', S) then
    edDirLast.Text:= S;
end;

procedure TfmSetup.tabHistShow(Sender: TObject);
begin
  if tabHist.Tag<>0 then Exit;
  tabHist.Tag:= 1;
  InitHistory;
end;

procedure TfmSetup.cbKeyCatChange(Sender: TObject);
var
  s: Widestring;
  i: Integer;
  r: TGridRect;
begin
  with cbKeyCat do
    s:= Items[ItemIndex];
  with KeyList do
    for i:= 0 to RowCount-1 do
      if (Cells[0,i] = '-') and
         (Cells[1,i] = s) then
      begin
        TopRow:= i;
        r.Top:= TopRow+1;
        r.Bottom:= r.Top;
        r.Left:= 2;
        r.Right:= 2;
        Selection:= r;
        Repaint;
        Break
      end;
end;

procedure TfmSetup.labDateClick(Sender: TObject);
begin
  FHelpShow(fmMain.SynDir, helpDateFmt, Handle);
end;

procedure TfmSetup.tabSearchShow(Sender: TObject);
begin
  if tabSearch.Tag<>0 then Exit;
  tabSearch.Tag:= 1;
  InitSearch;
end;

procedure TfmSetup.cbSessSaveClick(Sender: TObject);
begin
  cbSessDef.Enabled:= cbSessSave.Checked;
end;

procedure TfmSetup.edFilterChange(Sender: TObject);
begin
  TimerFilt.Enabled:= false;
  TimerFilt.Enabled:= true;
end;

procedure TfmSetup.TimerFiltTimer(Sender: TObject);
begin
  TimerFilt.Enabled:= false;
  ListKeys;
end;

procedure TfmSetup.cbStaplesDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  with cbStaples.Canvas do
  begin
    Brush.Color:= clWindow;
    FillRect(Rect);
    Pen.Color:= clBlack;
    Pen.Style:= TPenStyle(Index);
    Pen.Width:= 1;
    MoveTo(Rect.Left+4, (Rect.Top+Rect.Bottom)div 2);
    LineTo(Rect.Right-4, (Rect.Top+Rect.Bottom)div 2);
    MoveTo(Rect.Left+4, (Rect.Top+Rect.Bottom)div 2+1);
    LineTo(Rect.Right-4, (Rect.Top+Rect.Bottom)div 2+1);
    if odSelected in State then
    begin
      Brush.Style:= bsClear;
      Pen.Color:= clNavy;
      Pen.Style:= psSolid;
      InflateRect(Rect, -1, -1);
      Rectangle(Rect);
    end;
  end;
end;

procedure TfmSetup.edIndentKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_ESCAPE then
  begin
    bCan.Click;
    Key:= 0;
    Exit
  end;
  if key=VK_RETURN then
  begin
    bOk.Click;
    Key:= 0;
    Exit
  end;
end;

procedure TfmSetup.bFiltClearClick(Sender: TObject);
begin
  edFilter.Text:= '';
  TimerFilt.Enabled:= false;
  ListKeys;
end;

procedure TfmSetup.tabASaveShow(Sender: TObject);
begin
  if tabASave.Tag<>0 then Exit;
  tabASave.Tag:= 1;
  InitAutoSave;
end;

procedure TfmSetup.bUnnamedBrowseClick(Sender: TObject);
var S: Widestring;
begin
  S:= SExpandVars(edASaveUnnamedDir.Text);
  if WideSelectDirectory('', '', S) then
    edASaveUnnamedDir.Text:= S;
end;

procedure TfmSetup.cbASaveUnnamedClick(Sender: TObject);
var en: boolean;
begin
  en:= cbASaveUnSaveToDir.Checked;
  edASaveUnnamedDir.Enabled:= en;
  bUnnamedBrowse.Enabled:= en;
end;

procedure TfmSetup.cbASaveTimerClick(Sender: TObject);
var
  en: boolean;
begin
  en:= cbASaveTimer.Checked;
  edASaveTime.Enabled:= en;
  labASaveTime.Enabled:= en;
end;

procedure TfmSetup.labSmTabHelpClick(Sender: TObject);
begin
  FHelpShow(fmMain.SynDir, helpSmartTabbing, Handle);
end;

procedure TfmSetup.labTplHelpClick(Sender: TObject);
begin
  FHelpShow(fmMain.SynDir, helpCodeTpl, Handle);
end;

procedure TfmSetup.labAutoCloseHelpClick(Sender: TObject);
begin
  FHelpShow(fmMain.SynDir, helpAutoClose, Handle);
end;

procedure TfmSetup.cbACloseBrClick(Sender: TObject);
begin
  cbACloseBrEsc.Enabled:= cbACloseBr.Checked or cbACloseQ.Checked;
end;

procedure TfmSetup.cbAcpFileClick(Sender: TObject);
var en: boolean;
begin
  en:= cbAcpFile.Checked;
  edAcpFileChars.Enabled:= en;
  edAcpFileSize.Enabled:= en;
  LabelAcpFileChars.Enabled:= en;
  LabelAcpFileSize.Enabled:= en;
end;

procedure TfmSetup.ListColorsDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
const
  cw = 16; //color rect width
  cNone = '?';
var
  NFont: TColor;
  R1, R2: TRect;
begin
  R1:= Types.Rect(Rect.Left+1, Rect.Top, Rect.Left+cw, Rect.Bottom);
  R2:= Types.Rect(Rect.Left+cw+3, Rect.Top, Rect.Right, Rect.Bottom);
  with ListColors.Canvas do
  begin
    Brush.Color:= clWindow;
    FillRect(Rect);
    Brush.Color:= Colors[cColorsOrder[Index]];
    if Brush.Color<>clNone then
      FillRect(R1)
    else
    begin
      {
      //fill using diagonal lines
      Brush.Style:= bsBDiagonal;
      Brush.Color:= clWhite;
      FillRect(R1);
      Brush.Style:= bsSolid;
      }
      //draw "?" char
      NFont:= Font.Color;
      Font.Color:= clWindowText;
      Brush.Color:= clWindow;
      TextOut((R1.Left + R1.Right) div 2 - TextWidth(cNone) div 2, R1.Top, cNone);
      Font.Color:= NFont;
    end;

    if odSelected in State then
    begin
      Brush.Color:= clHighlight;
      Pen.Color:= clHighlightText;
    end
    else
    begin
      Brush.Color:= clWindow;
      Pen.Color:= clWindowText;
    end;
    FillRect(R2);
    ecTextOut(ListColors.Canvas, R2.Left, R2.Top, ListColors.Items[Index]);
  end;
end;

procedure TfmSetup.ListCatClick(Sender: TObject);
var
  TabObj: TTntTabSheet;
begin
  if ListCat.ItemIndex>=0 then
  begin
    TabObj:= ListCat.Items.Objects[ListCat.ItemIndex] as TTntTabSheet;
    if Assigned(TabObj) then
      Tabs.ActivePage:= TabObj
    else
    begin
      ListCat.ItemIndex:= ListCat.ItemIndex+1;
      ListCatClick(Self);
    end;
  end;
end;

procedure TfmSetup.tabTabsShow(Sender: TObject);
begin
  if tabTabs.Tag<>0 then Exit;
  tabTabs.Tag:= 1;
  InitTabs;
end;

procedure TfmSetup.tabFontsShow(Sender: TObject);
begin
  if tabFonts.Tag<>0 then Exit;
  tabFonts.Tag:= 1;
  InitFonts;
end;

procedure TfmSetup.tabTreeShow(Sender: TObject);
begin
  if tabTree.Tag<>0 then Exit;
  tabTree.Tag:= 1;
  InitTree;
end;

procedure TfmSetup.tabSessShow(Sender: TObject);
begin
  if tabSess.Tag<>0 then Exit;
  tabSess.Tag:= 1;
  InitSessionsProjects;
end;

procedure TfmSetup.cbLangChange(Sender: TObject);
begin
  FLangChanged:= true;
  labLangInfo.Caption:= DKLangConstW('MLnApply');
  labLangInfo.Font.Color:= clBlue;
  labLangInfo.Show;
end;

procedure TfmSetup.ListTabColorsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  c: TColor;
begin
  C:= ColorsOfTabs[Index];
  ListTabColors.Canvas.Brush.Color:= c;
  ListTabColors.Canvas.FillRect(Rect);
  if odSelected in State then
  begin
    ListTabColors.Canvas.Brush.Color:= clBlack;
    ListTabColors.Canvas.FrameRect(Rect);
  end;
end;

procedure TfmSetup.ListTabColorsDblClick(Sender: TObject);
var
  N: Integer;
begin
  N:= ListTabColors.ItemIndex;
  if N<0 then Exit;
  with TColorDialog.Create(nil) do
  try
    Options:= Options+[cdFullOpen];
    Color:= ColorsOfTabs[N];
    if Execute then
    begin
      ColorsOfTabs[N]:= Color;
      ListTabColors.Invalidate;
    end;
  finally
    Free
  end;
end;

procedure TfmSetup.ListTabColorsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=vk_space) then
  begin
    ListTabColorsDblClick(Self);
    Key:= 0;
    Exit
  end;
end;

procedure TfmSetup.bAddFolderClick(Sender: TObject);
var s: Widestring;
begin
  s:= '';
  if WideSelectDirectory('', '', s) then
    edFolders.Lines.Add(s);
  SetFocus;//TC
end;

procedure TfmSetup.edFoldersKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=vk_escape) then
  begin
    bCan.Click;
    Key:= 0;
    Exit
  end;
end;

procedure TfmSetup.tabFoldersShow(Sender: TObject);
begin
  if tabFolders.Tag<>0 then Exit;
  tabFolders.Tag:= 1;
  InitSearchFolders;
end;

procedure TfmSetup.tabSpellShow(Sender: TObject);
begin
  if tabSpell.Tag<>0 then Exit;
  tabSpell.Tag:= 1;
  InitSpell;
end;

procedure TfmSetup.labDictWwwClick(Sender: TObject);
begin
  FOpenUrl('http://www.addictivesoftware.com/dl-dictionaries.htm', Handle);
end;

procedure TfmSetup.labDictDirClick(Sender: TObject);
begin
  FExecute(fmMain.SynDictDir, '', '', Handle);
end;

procedure TfmSetup.bSpellOptClick(Sender: TObject);
begin
  fmMain.DoSpellCfg(nil);
end;

procedure TfmSetup.tabOvrShow(Sender: TObject);
begin
  if tabOvr.Tag<>0 then Exit;
  tabOvr.Tag:= 1;
  InitEditorOverrides;
end;

procedure TfmSetup.TntFormCreate(Sender: TObject);
begin
  fmOvr:= nil;
  with ListTabColors do
    ItemHeight:= ScaleFontSize(ItemHeight, Self);
  with ListColors do
    ItemHeight:= ScaleFontSize(ItemHeight, Self);

  OpenDialogPre.Filter:= cColorFilter;
  SaveDialogPre.Filter:= cColorFilter;
end;

procedure TfmSetup.labEmmetClick(Sender: TObject);
begin
  FHelpShow(fmMain.SynDir, helpEmmet, Handle);
end;

procedure TfmSetup.tabCaretsShow(Sender: TObject);
begin
  if tabCarets.Tag<>0 then Exit;
  tabCarets.Tag:= 1;
  InitEditorCarets;
end;

procedure TfmSetup.labCaretHelpClick(Sender: TObject);
begin
  FHelpShow(fmMain.SynDir, helpCarets, Handle);
end;

procedure TfmSetup.labAcpHelpClick(Sender: TObject);
begin
  FHelpShow(fmMain.SynDir, helpAcp, Handle);
end;

procedure TfmSetup.ApplyFiles;
begin
  with fmMain do
  begin
    opNotif:= TSynReloadMode(cbNotif.ItemIndex);
    opAskOverwrite:= cbOverRO.Checked;
    opTextOnly:= cbText_.ItemIndex;
    opOem:= edOem.Text;
    opUTF8:= edUTF8.Text;
    opBigSize:= edBigSize.Value;
    opFollowTail:= cbTail.Checked;
    opUnicodeNeeded:= cbUniNeed.ItemIndex;
  end;
end;

procedure TfmSetup.ApplyAutoComplete;
begin
  with fmMain do
  begin
    opAcpHtm:= cbAcpHtm.Checked;
    opAcpCss:= cbAcpCss.Checked;
    opAcpTabbing:= cbAcpTabbing.Checked;
    opTemplateTabbing:= cbTplTabbing.Checked;
    opTemplateTabbingExcept:= edTplTabEx.Text;
    opAutoCloseTags:= cbACloseTags.Checked;
    opAutoCloseBrackets:= cbACloseBr.Checked;
    opAutoCloseBracketsNoEsc:= cbACloseBrEsc.Checked;
    opAutoCloseQuotes:= cbACloseQ.Checked;
    opAcpNum:= edAcpNum.Value;
    opAcpUseSingle:= cbAcpUseSingle.Checked;
    ParamCompletion.Enabled:= cbAcpParamHints.Checked;
    SyntaxManagerChange(nil);
    ecACP.DropDownCount:= edAcpDrop.Value;
    ecACP.ShowWhenNone:= cbAcpNone.Checked;
    ecACP.FilterType:= TAutoCompleteFilter(cbAcpFilter.ItemIndex);
    ApplyACP;
    opAcpFile:= cbAcpFile.Checked;
    opAcpFileChars:= edAcpFileChars.Value;
    opAcpFileSize:= edAcpFileSize.Value;
  end;
end;

procedure TfmSetup.ApplyAutoSave;
begin
  with fmMain do
  begin
    opASaveOnTimer:= cbASaveTimer.Checked;
    opASaveOnFocus:= cbASaveFocus.Checked;
    opASaveTimeMin:= edASaveTime.Value;
    opASaveAllFiles:= cbASaveAllFiles.Checked;
    opASaveMaxSizeKb:= edASaveMaxSize.Value;
    if cbASaveUnIgnore.Checked then opASaveUnnamed:= cAutoSaveIgnore else
     if cbASaveUnShowSave.Checked then opASaveUnnamed:= cAutoSavePromptFN else
      if cbASaveUnSaveToDir.Checked then opASaveUnnamed:= cAutoSaveSaveToDir;
    opASaveUnnamedDir:= edASaveUnnamedDir.Text;
    ApplyAutoSave;
  end;  
end;

procedure TfmSetup.ApplyColors;
begin
  with fmMain do
  begin
    Theme:= cbTheme.Text;
    Icons:= cbIcons.ItemIndex;
    ApplyIntf;
    ApplyColorsArrayToEditor(Colors, TemplateEditor);
    ApplyColors;
    ApplyOut;
    ApplyMap;
    ApplyCarets;
  end;
end;

procedure TfmSetup.ApplyEditorCarets;
begin
  with fmMain do
  begin
    opCaretsEnabled:= cbCaretMulti.Checked;
    if cbCaretIndNone.Checked then opCaretsIndicator:= 0 else
     if cbCaretIndLine.Checked then opCaretsIndicator:= 1 else
      if cbCaretIndGutter.Checked then opCaretsIndicator:= 2;
    opCaretsGutterBand:= edCaretGutterCol.Value;
    opCaretType:= edCaretType.ItemIndex; //cbCaretWidth.Position;

    if cbCaretSmart.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soSmartCaret]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soSmartCaret];

    if cbCaretInText.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soKeepCaretInText]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soKeepCaretInText];

    if cbCaretKeepOnPaste.Checked then
      TemplateEditor.OptionsEx:= TemplateEditor.OptionsEx + [soKeepCaretPaste]
    else
      TemplateEditor.OptionsEx:= TemplateEditor.OptionsEx - [soKeepCaretPaste];

    if cbCaretInRO.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soAlwaysShowCaret]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soAlwaysShowCaret];

    ApplyCarets;
  end;
end;

procedure TfmSetup.ApplyEditorOverrides;
begin
  fmMain.opLexersOverride:= fmOvr.FString;
end;

procedure TfmSetup.ApplyFonts;
begin
  with fmMain do
  begin
    //editor
    TemplateEditor.Font:= b1.Font;
    //line nums
    TemplateEditor.LineNumbers.Font:= b2.Font;
    //tree
    Tree.Font:= b3.Font;
    //ruler
    TemplateEditor.HorzRuler.Font:= b4.Font;
    //auto-complete
    ecACP.Font:= b5.Font;
    ApplyACP;
    //output panel
    ListOut.Font:= b6.Font;
    ApplyOut;
    
    ApplyFonts;
  end;
end;

procedure TfmSetup.ApplyHistory;
begin
  with fmMain do
  begin
    opMruCheck:= cbMru.Checked;
    opSaveState:= edFS.Value;
    opSaveSRHist:= edSR.Value;
    opSaveCaret:= cbHCaret.Checked;
    opSaveEnc:= cbHEnc.Checked;
    opStateForTemp:= cbHTemp.Checked;
    opLastDir:= TSynLastDirMode(cbDirLast.ItemIndex);
    opLastDirPath:= edDirLast.Text;
    opFileBackup:= TSynBackup(cbBak.ItemIndex);
  end;
end;

procedure TfmSetup.ApplyUndo;
begin
  with fmMain do
  begin
    TemplateEditor.UndoLimit:= edUndoLimit.Value;
    opBkUndo:= cbUndoMass.Checked;

    if cbGroupUndo.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soGroupUndo]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soGroupUndo];

    if cbGroupRedo.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soGroupRedo]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soGroupRedo];

    if cbUndoAfterSave.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soUndoAfterSave]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soUndoAfterSave];
  end;
end;


procedure TfmSetup.ApplyProgSett;
begin
  ApplyLang;
  
  with fmMain do
  begin
    opChInf:= cbChar.Checked;
    UpdateStatusbar;

    Menu.Visible:= cbMenu.Checked;
    Status.Visible:= cbStat.Checked;
    opEsc:= TSynEscMode(cbEsc.ItemIndex);
    opSingleInstance:= cbInst.Checked;
    ApplyInst;

    opSavePos:= cbSavePos.Checked;
    opShowRecentColors:= TSynRecentColors(cbRecColors.ItemIndex);
    opSortMode:= TSynSortMode(cbSortMode.ItemIndex);
    ApplyShowRecentColors;
    opLexerCat:= cbGroupLexers.Checked;
    opMenuIcon:= cbMenuIcon.Checked;
    Icons:= Icons; //update menu
    opTitleFull:= cbFullTitle.Checked;
    opBeep:= cbBeep.Checked;

    //redraw
    tbFile.Invalidate;
    tbEdit.Invalidate;
    tbView.Invalidate;
    plTree.Invalidate;
    //
  end;
end;

procedure TfmSetup.ApplyKeys;
begin
  fmMain.SyntKeyMapping.Assign(Self.KeyMapping);
end;

procedure TfmSetup.ApplySearch;
begin
  with fmMain do
  begin
    opMaxTreeMatches:= edSrMaxTreeMatches.Value;
    opSrOffsetY:= edSrOffsetY.Value;
    opSrExpand:= cbSrExpand.Checked;
    opSrOnTop:= cbSrOnTop.Checked;
    opSrSuggestWord:= cbSrWord.Checked;
    opSrSuggestSel:= cbSrSel.Checked;
    opQsCap:= cbSrQsCap.Checked;
    ApplyQs;
  end;
end;

procedure TfmSetup.ApplySearchFolders;
begin
  with fmMain do
  begin
    SListToString(edFolders.Lines, opProjPaths);
  end;
end;

procedure TfmSetup.ApplySessionsProjects;
begin
  with fmMain do
  begin
    opHistSessionSave:= cbSessSave.Checked;
    opHistSessionLoad:= cbSessLoad.Checked;
    opHistSessionProjSave:= cbProjSessSave.Checked;
    opHistSessionProjLoad:= cbProjSessOpen.Checked;
    opHistSessionDef:= cbSessDef.Checked;
    opHistProjectSave:= cbProjSave.Checked;
    opHistProjectLoad:= cbProjLoad.Checked;
    opHistProjectCloseTabs:= cbProjCloseTabs.Checked;
  end;
end;

procedure TfmSetup.ApplySpell;
begin
  with fmMain do
  begin
    opSpellEn:= cbSpellEn.Checked;
    opSpellExt:= edSpellExt.Text;
    ApplySpell;
  end;
end;

procedure TfmSetup.ApplyTabs;
var
  i: Integer;
begin
  with fmMain do
  begin
    opTabVisible:= cbTabVis.ItemIndex;
    opTabStyle:= cbTabStyle.ItemIndex;
    opTabBtn:= cbTabBtn.Checked;
    opTabNums:= cbTabNums.Checked;
    opTabSwitcher:= cbTabSw.Checked;
    opTabDragDrop:= cbTabDnD.Checked;
    opTabDblClick:= cbTabDbl.Checked;
    opTabMaxLen:= edTabMaxLen.Value;
    opTabMultiLine:= cbTabMul.Checked;
    opTabAtBottom:= cbTabDown.Checked;

    for i:= 0 to High(ColorsOfTabs) do
      opTabColors[i]:= ColorsOfTabs[i];

    ApplyTabOptions;
    ApplyFrames;
  end;
end;

procedure TfmSetup.ApplyTree;
begin
  with fmMain do
  begin
    Tree.AutoSynchronize:= cbTreeSync.Checked;
    Tree.UpdateDelay:= cbTreeDelay.Value;

    opMapZoom:= edMapZoom.Value;
    ApplyMap;

    opMicroMap:= cbMicroMap.Checked;
    ApplyFrames;
  end;
end;

procedure TfmSetup.InitAutoComplete;
begin
  with fmMain do
  begin
    cbAcpHtm.Checked:= opAcpHtm;
    cbAcpCss.Checked:= opAcpCss;
    cbAcpTabbing.Checked:= opAcpTabbing;
    cbTplTabbing.Checked:= opTemplateTabbing;
    edTplTabEx.Text:= opTemplateTabbingExcept;
    cbACloseTags.Checked:= opAutoCloseTags;

    cbACloseBr.Checked:= opAutoCloseBrackets;
    cbACloseBrEsc.Checked:= opAutoCloseBracketsNoEsc;
    cbACloseQ.Checked:= opAutoCloseQuotes;
    cbACloseBrClick(Self);

    cbAcpParamHints.Checked:= ParamCompletion.Enabled;
    cbAcpUseSingle.Checked:= opAcpUseSingle;
    edAcpNum.Value:= opAcpNum;
    cbAcpNone.Checked:= ecACP.ShowWhenNone;
    cbAcpFilter.ItemIndex:= integer(ecACP.FilterType);
    cbAcpFile.Checked:= opAcpFile;
    cbAcpFileClick(Self);
    edAcpFileChars.Value:= opAcpFileChars;
    edAcpFileSize.Value:= opAcpFileSize;
    edAcpDrop.Value:= ecACP.DropDownCount;
  end;
end;

procedure TfmSetup.InitAutoSave;
begin
  with fmMain do
  begin
    cbASaveTimer.Checked:= opASaveOnTimer;
    cbASaveFocus.Checked:= opASaveOnFocus;
    edASaveTime.Value:= opASaveTimeMin;
    cbASaveAllFiles.Checked:= opASaveAllFiles;
    cbASaveCurrFile.Checked:= not opASaveAllFiles;
    edASaveMaxSize.Value:= opASaveMaxSizeKb;
    cbASaveUnIgnore.Checked:= opASaveUnnamed=cAutoSaveIgnore;
    cbASaveUnShowSave.Checked:= opASaveUnnamed=cAutoSavePromptFN;
    cbASaveUnSaveToDir.Checked:= opASaveUnnamed=cAutoSaveSaveToDir;
    edASaveUnnamedDir.Text:= opASaveUnnamedDir;
    cbASaveTimerClick(Self);
    cbASaveUnnamedClick(Self);
  end;
end;

procedure TfmSetup.InitColors;
var
  i: Integer;
begin
  for i:= Low(cColorsOrder) to High(cColorsOrder) do
    ListColors.Items.Add(DKLangConstW(ColorNumToLngId(cColorsOrder[i])));
  ListColors.Selected[0]:= true;

  with fmMain do
  begin
    cbTheme.ItemIndex:= cbTheme.Items.IndexOf(Theme);
    cbIcons.ItemIndex:= Icons;
    InitColorsArray(Colors);
  end;

  ListColorsClick(Self);
end;

procedure TfmSetup.InitEditorCarets;
begin
  with fmMain do
  begin
    cbCaretMulti.Checked:= opCaretsEnabled;
    cbCaretIndNone.Checked:= opCaretsIndicator=0;
    cbCaretIndLine.Checked:= opCaretsIndicator=1;
    cbCaretIndGutter.Checked:= opCaretsIndicator=2;
    edCaretGutterCol.Value:= opCaretsGutterBand;
    edCaretType.ItemIndex:= opCaretType;

    cbCaretSmart.Checked:= soSmartCaret in TemplateEditor.Options;
    cbCaretInText.Checked:= soKeepCaretInText in TemplateEditor.Options;
    cbCaretKeepOnPaste.Checked:= soKeepCaretPaste in TemplateEditor.OptionsEx;
    cbCaretInRO.Checked:= soAlwaysShowCaret in TemplateEditor.Options;
  end;
end;

procedure TfmSetup.InitEditorOverrides;
var
  i: Integer;
begin
  fmOvr:= TfmSetupOvr.Create(Self);
  fmOvr.Parent:= tabOvr;
  fmOvr.Align:= alClient;
  fmOvr.BorderStyle:= bsNone;

  with fmOvr do
  begin
    FString:= fmMain.opLexersOverride;
    FDefTabStop:= fmMain.TemplateEditor.TabList.AsString;
    case fmMain.TemplateEditor.TabMode of
      tmSpaces: FDefTabMode:= 0;
      tmTabChar: FDefTabMode:= 1;
      tmSmartTab: FDefTabMode:= 2;
    end;
    FDefMargin:= fmMain.TemplateEditor.RightMargin;
    FDefSpacing:= fmMain.TemplateEditor.LineSpacing;

    with fmMain.SyntaxManager do
      for i:= 0 to AnalyzerCount-1 do
        if not Analyzers[i].Internal then
          ListLex.Items.Add(Analyzers[i].LexerName);
  end;
  fmOvr.Show;
end;

procedure TfmSetup.InitFiles;
begin
  with fmMain do
  begin
    cbNotif.ItemIndex:= Ord(opNotif);
    cbOverRO.Checked:= opAskOverwrite;
    cbText_.ItemIndex:= opTextOnly;
    edOem.Text:= opOem;
    edUTF8.Text:= opUTF8;
    edBigSize.Value:= opBigSize;
    cbTail.Checked:= opFollowTail;
    cbUniNeed.ItemIndex:= opUnicodeNeeded;
  end;
end;

procedure TfmSetup.InitFonts;
begin
  with fmMain do
  begin
    b1.Font:= TemplateEditor.Font;
    b2.Font:= TemplateEditor.LineNumbers.Font;
    b3.Font:= Tree.Font;
    b4.Font:= TemplateEditor.HorzRuler.Font;
    b5.Font:= ecACP.Font;
    b6.Font:= ListOut.Font;
  end;
end;

procedure TfmSetup.InitHistory;
begin
  with fmMain do
  begin
    edFS.Value:= opSaveState;
    edSR.Value:= opSaveSRHist;
    cbHCaret.Checked:= opSaveCaret;
    cbHEnc.Checked:= opSaveEnc;
    cbHTemp.Checked:= opStateForTemp;
    cbMru.Checked:= opMruCheck;
    cbDirLast.ItemIndex:= Ord(opLastDir);
    edDirLast.Text:= opLastDirPath;
    cbBak.ItemIndex:= Ord(opFileBackup);
  end;
end;


procedure TfmSetup.InitUndo;
begin
  with fmMain do
  begin
    edUndoLimit.Value:= TemplateEditor.UndoLimit;
    cbGroupUndo.Checked:= soGroupUndo in TemplateEditor.Options;
    cbGroupRedo.Checked:= soGroupRedo in TemplateEditor.Options;
    cbUndoAfterSave.Checked:= soUndoAfterSave in TemplateEditor.Options;
    cbUndoMass.Checked:= opBkUndo;
  end;
end;


procedure TfmSetup.InitProgSett;
begin
  InitLang;

  with fmMain do
  begin
    cbMenu.Checked:= Menu.Visible;
    cbStat.Checked:= Status.Visible;
    cbChar.Checked:= opChInf;

    cbEsc.ItemIndex:= Ord(opEsc);
    cbInst.Checked:= opSingleInstance;

    cbSavePos.Checked:= opSavePos;
    cbRecColors.ItemIndex:= Ord(opShowRecentColors);
    cbSortMode.ItemIndex:= Ord(opSortMode);
    cbGroupLexers.Checked:= opLexerCat;
    cbFullTitle.Checked:= opTitleFull;
    cbMenuIcon.Checked:= opMenuIcon;
    cbBeep.Checked:= opBeep;
  end;
end;

procedure TfmSetup.InitKeys;
var
  L: TStringList;
  i: Integer;
begin
  KeyMapping.Assign(fmMain.SyntKeyMapping);

  //list categories
  L:= TStringList.Create;
  try
    for i:= 0 to KeyMapping.Items.Count-1 do
      if KeyMapping.Items[i].Customizable then
        if L.IndexOf(KeyMapping.Items[i].Category)<0 then
          L.Add(KeyMapping.Items[i].Category);

    cbKeyCat.Items.AddStrings(L);
    cbKeyCat.ItemIndex:= 0;
  finally
    FreeandNil(L);
  end;  

  //list keys
  ListKeys;
  KeyList.SetFocus;
end;

procedure TfmSetup.InitSearch;
begin
  with fmMain do
  begin
    edSrMaxTreeMatches.Value:= opMaxTreeMatches;
    edSrOffsetY.Value:= opSrOffsetY;
    cbSrExpand.Checked:= opSrExpand;
    cbSrOnTop.Checked:= opSrOnTop;
    cbSrWord.Checked:= opSrSuggestWord;
    cbSrSel.Checked:= opSrSuggestSel;
    cbSrQsCap.Checked:= opQsCap;
  end;
end;

procedure TfmSetup.InitSearchFolders;
begin
  SStringToList(fmMain.opProjPaths, edFolders.Lines);
end;

procedure TfmSetup.InitSessionsProjects;
begin
  with fmMain do
  begin
    cbSessSave.Checked:= opHistSessionSave;
    cbSessLoad.Checked:= opHistSessionLoad;
    cbProjSessSave.Checked:= opHistSessionProjSave;
    cbProjSessOpen.Checked:= opHistSessionProjLoad;
    cbSessDef.Checked:= opHistSessionDef;
    cbSessSaveClick(Self);
    cbProjSave.Checked:= opHistProjectSave;
    cbProjLoad.Checked:= opHistProjectLoad;
    cbProjCloseTabs.Checked:= opHistProjectCloseTabs;
  end;
end;

procedure TfmSetup.InitSpell;
begin
  with fmMain do
  begin
    cbSpellEn.Checked:= opSpellEn;
    edSpellExt.Text:= opSpellExt;
  end;
end;

procedure TfmSetup.InitTabs;
var
  i: Integer;
begin
  with fmMain do
  begin
    cbTabBtn.Checked:= opTabBtn;
    cbTabVis.ItemIndex:= opTabVisible;
    cbTabStyle.ItemIndex:= opTabStyle;
    cbTabNums.Checked:= opTabNums;
    cbTabMul.Checked:= opTabMultiLine;
    cbTabDown.Checked:= opTabAtBottom;
    cbTabSw.Checked:= opTabSwitcher;
    cbTabDnD.Checked:= opTabDragDrop;
    cbTabDbl.Checked:= opTabDblClick;
    edTabMaxLen.Value:= opTabMaxLen;

    ListTabColors.Items.Clear;
    for i:= 0 to High(ColorsOfTabs) do
    begin
      ColorsOfTabs[i]:= opTabColors[i];
      ListTabColors.Items.Add(IntToStr(i));
    end;
  end;
end;

procedure TfmSetup.InitTree;
begin
  with fmMain do
  begin
    cbTreeSync.Checked:= Tree.AutoSynchronize;
    cbTreeDelay.Value:= Tree.UpdateDelay;
    edMapZoom.Value:= opMapZoom;
    cbMicroMap.Checked:= opMicroMap;
  end;
end;

procedure TfmSetup.ApplyLang;
begin
  with fmMain do
    opLang:= LangManager.LanguageIDs[cbLang.ItemIndex];
end;

procedure TfmSetup.InitLang;
var
  i: Integer;
begin
  with cbLang do begin
    Items.Clear;
    for i:= 0 to LangManager.LanguageCount-1 do
      Items.Add(LangManager.LanguageNames[i]);
    ItemIndex:= LangManager.LanguageIndex;
  end;
end;

procedure TfmSetup.tabNewOpenShow(Sender: TObject);
begin
  if tabNewOpen.Tag<>0 then Exit;
  tabNewOpen.Tag:= 1;
  InitNewOpen;
end;

procedure TfmSetup.ApplyNewOpen;
begin
  with fmMain do
  begin
    opNewEnc:= edEnc.ItemIndex;
    opNewLineEnds:= edLE.ItemIndex;
    if edLex.ItemIndex=0 then
      opNewLex:= ''
    else
      opNewLex:= edLex.Text;
  end;
end;

procedure TfmSetup.InitNewOpen;
var
  i: Integer;
begin
  with fmMain do
  begin
    edLex.Items.Add(' '+DKLangConstW('None'));
    with SyntaxManager do
      for i:= 0 to AnalyzerCount-1 do
        if not Analyzers[i].Internal then
          edLex.Items.Add(Analyzers[i].LexerName);
    with edLex do
      if opNewLex='' then
        ItemIndex:= 0
      else
        ItemIndex:= Items.IndexOf(opNewLex);
    edEnc.ItemIndex:= opNewEnc;
    edLE.ItemIndex:= opNewLineEnds;
  end;
end;

procedure TfmSetup.tabViewShow(Sender: TObject);
begin
  if tabView.Tag<>0 then Exit;
  tabView.Tag:= 1;
  InitView;
end;

procedure TfmSetup.tabSelHLShow(Sender: TObject);
begin
  if tabSelHL.Tag<>0 then Exit;
  tabSelHL.Tag:= 1;
  InitSelHL;
end;

procedure TfmSetup.tabInsertFormatShow(Sender: TObject);
begin
  if tabInsertFormat.Tag<>0 then Exit;
  tabInsertFormat.Tag:= 1;
  InitInsertFormat;
end;

procedure TfmSetup.ApplyInsertFormat;
begin
  with fmMain do
  begin
    TemplateEditor.BlockIndent:= edIndent.Value;
    TemplateEditor.TabList.AsString:= edTabStops.Text;
    case edTabMode.ItemIndex of
      0: TemplateEditor.TabMode:= tmSpaces;
      1: TemplateEditor.TabMode:= tmTabChar;
      2: TemplateEditor.TabMode:= tmSmartTab;
    end;
    opTabsReplace:= cbReplaceTabs.Checked;

    if cbAutoIndent.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soAutoIndentMode]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soAutoIndentMode];

    if cbBackspUnindent.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soBackUnindent]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soBackUnindent];

    if cbUnindentAlign.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soUnindentKeepAlign]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soUnindentKeepAlign];

    if cbOptFill.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soOptimalFill]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soOptimalFill];

    if cbKeepBlank.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soKeepTrailingBlanks]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soKeepTrailingBlanks];

    ApplyFrames;

    opDateFmt:= edDateFmt.Text;
    opDateFmtPLog:= edDateFmtP.Text;
    opZenProfile:= cbZenProfile.Text;
  end;
end;

procedure TfmSetup.ApplySelHL;
begin
  with fmMain do
  begin
    opHiliteUrls:= cbUrlHilite.Checked;
    opSingleClickURL:= cbUrlClick.Checked;
    ApplyUrlClick;

    opHiliteSmart:= cbHiliteSmart.Checked;
    opHiliteSmartOnClick:= cbHiliteSmartClick.Checked;
    opHiliteSmartCase:= cbHiliteSmartCase.Checked;
    opHiliteSmartWords:= cbHiliteSmartWords.Checked;
    opHiliteBrackets:= cbHiliteBrackets.Checked;
    opCopyLineIfNoSel:= cbCopyLineNSel.Checked;

    if cbColorOnEmpty.Checked then
      TemplateEditor.OptionsEx:= TemplateEditor.OptionsEx - [soNormalSelToLineEnd]
    else
      TemplateEditor.OptionsEx:= TemplateEditor.OptionsEx + [soNormalSelToLineEnd];

    if cbBOver.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soOverwriteBlocks]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soOverwriteBlocks];

    if cbBPers.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soPersistentBlocks]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soPersistentBlocks];

    if cbDClick.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soDoubleClickLine]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soDoubleClickLine];

    if cbCopyRtf.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soCopyAsRTF]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soCopyAsRTF];

    if cbDrag.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soDragText]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soDragText];

    if cbCollap.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soCallapseEmptyLines]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soCallapseEmptyLines];

    if cbFloatM.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soFloatMarkers]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soFloatMarkers];

    if cbGrSel.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soGreedySelect]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soGreedySelect];

    case cbSelMode.ItemIndex of
      0: TemplateEditor.SelectModeDefault:= msNormal;
      1: TemplateEditor.SelectModeDefault:= msColumn;
      2: TemplateEditor.SelectModeDefault:= msLine;
    end;
    opWordChars:= edWordChars.Text;

    ApplyEdOptions;
    ApplyFrames;
  end;
end;

procedure TfmSetup.ApplyView;
begin
  with fmMain do
  begin
    TemplateEditor.WordWrap:= cbWrap.Checked;
    TemplateEditor.DisableFolding:= not cbFold.Checked;
    TemplateEditor.HorzRuler.Visible:= cbRuler.Checked;
    TemplateEditor.DefaultStyles.CurrentLine.Enabled:= cbDrawLineBG.Checked;
    TemplateEditor.LineSpacing:= edLSpace.Value;
    TemplateEditor.ShowRightMargin:= cbMargin.Checked;
    TemplateEditor.RightMargin:= edMargin.Value;
    TemplateEditor.LineNumbers.NumberingStyle:= TLineNumberingStyle(edLineNums.ItemIndex);
    TemplateEditor.StapleOffset:= edStapleOffset.Value;
    TemplateEditor.StaplePen.Style:= TPenStyle(cbStaples.ItemIndex);

    if cbDrawFocus.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soDrawCurLineFocus]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soDrawCurLineFocus];

    if cbHideCursor.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soHideCursorOnType]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soHideCursorOnType];

    if cbFixLineSize.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soFixedLineHeight]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soFixedLineHeight];

    if cbScrollLast.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soScrollLastLine]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soScrollLastLine];

    if cbWrapMargin.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soBreakOnRightMargin]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soBreakOnRightMargin];

    if cbFixColMove.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soFixedColumnMove]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soFixedColumnMove];

    if cbVarHorzBar.Checked then
      TemplateEditor.Options:= TemplateEditor.Options + [soVariableHorzScrollBar]
    else
      TemplateEditor.Options:= TemplateEditor.Options - [soVariableHorzScrollBar];

    opNonPrint:= cbNPrintShow.Checked;
    opNonPrintSpaces:= cbNPrintSp.Checked;
    opNonPrintEol:= cbNPrintEol.Checked;
    opNonPrintEolDetail:= cbNPrintEolEx.Checked;

    opShowWrapMark:= cbDrawWrapMark.Checked;
    opShowCurrentColumn:= cbDrawCol.Checked;
    ApplyEdOptions;
    ApplyFrames;
  end;
end;

procedure TfmSetup.InitInsertFormat;
begin
  with fmMain do
  begin
    edIndent.Value:= TemplateEditor.BlockIndent;
    edTabStops.Text:= TemplateEditor.TabList.AsString;
    case TemplateEditor.TabMode of
      tmSpaces:   edTabMode.ItemIndex:= 0;
      tmTabChar:  edTabMode.ItemIndex:= 1;
      tmSmartTab: edTabMode.ItemIndex:= 2;
    end;
    cbReplaceTabs.Checked:= opTabsReplace;
    edTabModeChange(Self);

    cbAutoIndent.Checked:= soAutoIndentMode in TemplateEditor.Options;
    cbBackspUnindent.Checked:= soBackUnindent in TemplateEditor.Options;
    cbUnindentAlign.Checked:= soUnindentKeepAlign in TemplateEditor.Options;
    cbOptFill.Checked:= soOptimalFill in TemplateEditor.Options;
    cbKeepBlank.Checked:= soKeepTrailingBlanks in TemplateEditor.Options;

    edDateFmt.Text:= opDateFmt;
    edDateFmtP.Text:= opDateFmtPLog;

    with cbZenProfile do
    begin
      Items.LoadFromFile(SynDir + 'Tools\emmet.txt');
      ItemIndex:= Items.IndexOf(opZenProfile);
    end;
  end;
end;

procedure TfmSetup.InitSelHL;
begin
  with fmMain do
  begin
    cbUrlHilite.Checked:= opHiliteUrls;
    cbUrlClick.Checked:= opSingleClickURL;

    cbHiliteSmart.Checked:= opHiliteSmart;
    cbHiliteSmartClick.Checked:= opHiliteSmartOnClick;
    cbHiliteSmartCase.Checked:= opHiliteSmartCase;
    cbHiliteSmartWords.Checked:= opHiliteSmartWords;
    cbHiliteBrackets.Checked:= opHiliteBrackets;

    cbCopyLineNSel.Checked:= opCopyLineIfNoSel;
    cbColorOnEmpty.Checked:= not (soNormalSelToLineEnd in TemplateEditor.OptionsEx);

    cbBOver.Checked:= sooverwriteBlocks in TemplateEditor.Options;
    cbBPers.Checked:= soPersistentBlocks in TemplateEditor.Options;
    cbDClick.Checked:= soDoubleClickLine in TemplateEditor.Options;
    cbCopyRtf.Checked:= soCopyAsRTF in TemplateEditor.Options;
    cbDrag.Checked:= soDragText in TemplateEditor.Options;
    cbCollap.Checked:= soCallapseEmptyLines in TemplateEditor.Options;
    cbFloatM.Checked:= soFloatMarkers in TemplateEditor.Options;
    cbGrSel.Checked:= soGreedySelect in TemplateEditor.Options;

    case TemplateEditor.SelectModeDefault of
      msNone,
      msNormal: cbSelMode.ItemIndex:= 0;
      msColumn: cbSelMode.ItemIndex:= 1;
      msLine: cbSelMode.ItemIndex:= 2;
    end;
    edWordChars.Text:= opWordChars;
  end;
end;

procedure TfmSetup.InitView;
var
  i: Integer;
begin
  cbStaples.Items.Clear;
  for i:= 0 to Ord(psClear) do
    cbStaples.Items.Add('-'); //empty items for line styles

  with fmMain do
  begin
    cbRuler.Checked:= TemplateEditor.HorzRuler.Visible;
    cbHideCursor.Checked:= soHideCursorOnType in TemplateEditor.Options;
    cbDrawFocus.Checked:= soDrawCurLineFocus in TemplateEditor.Options;
    cbDrawLineBG.Checked:= TemplateEditor.DefaultStyles.CurrentLine.Enabled;
    cbMargin.Checked:= TemplateEditor.ShowRightMargin;
    edMargin.Value:= TemplateEditor.RightMargin;
    edLSpace.Value:= TemplateEditor.LineSpacing;
    edLineNums.ItemIndex:= Ord(TemplateEditor.LineNumbers.NumberingStyle);
    edStapleOffset.Value:= TemplateEditor.StapleOffset;
    cbStaples.ItemIndex:= Ord(TemplateEditor.StaplePen.Style);
    cbDrawWrapMark.Checked:= opShowWrapMark;
    cbDrawCol.Checked:= opShowCurrentColumn;

    cbWrap.Checked:= TemplateEditor.WordWrap;
    cbWrapMargin.Checked:= soBreakOnRightMargin in TemplateEditor.Options;
    cbFold.Checked:= not TemplateEditor.DisableFolding;
    cbFixLineSize.Checked:= soFixedLineHeight in TemplateEditor.Options;
    cbFixColMove.Checked:= soFixedColumnMove in TemplateEditor.Options;
    cbScrollLast.Checked:= soScrollLastLine in TemplateEditor.Options;
    cbVarHorzBar.Checked:= soVariableHorzScrollBar in TemplateEditor.Options;

    cbNPrintShow.Checked:= opNonPrint;
    cbNPrintSp.Checked:= opNonPrintSpaces;
    cbNPrintEol.Checked:= opNonPrintEol;
    cbNPrintEolEx.Checked:= opNonPrintEolDetail;
  end;
end;

procedure TfmSetup.tabUndoShow(Sender: TObject);
begin
  if tabUndo.Tag<>0 then Exit;
  tabUndo.Tag:= 1;
  InitUndo;
end;

function TfmSetup.KeymappingIndex(Row: integer): integer;
begin
  Result:= StrToIntDef(KeyList.Cells[0, Row], -1);
end;

procedure TfmSetup.bKeyExtendClick(Sender: TObject);
var
  c, r, mapindex, keyindex: integer;
  stroke: TKeyStroke;
begin
  if ecHotKey.Text='' then Exit;
  if ecHotKey.Hotkey=0 then
    begin MessageBeep(mb_iconwarning); Exit end;

  c:= KeyList.Selection.Left;
  r:= KeyList.Selection.Top;
  mapindex:= KeymappingIndex(r);
  keyindex:= c-2;
  if mapindex<0 then Exit;

  stroke:= nil;
  if (keyindex>=0) and (keyindex<KeyMapping.Items[mapindex].KeyStrokes.Count) then
    stroke:= KeyMapping.Items[mapindex].KeyStrokes[keyindex];
  if stroke=nil then
    begin MessageBeep(mb_iconwarning); Exit end;
    
  stroke.KeyDefs.Add.ShortCut:= ecHotKey.HotKey;
  KeyList.Cells[c, r]:= stroke.AsString;
end;

procedure TfmSetup.UpdateKeyButtons;
var
  IsCellSet, IsKeySet: boolean;
begin
  IsCellSet:= KeyList.Cells[KeyList.Selection.Left, KeyList.Selection.Top] <> '';
  IsKeySet:= ecHotkey.Text <> '';

  bKeySet.Enabled:= IsKeySet;
  bKeyExtend.Enabled:= IsKeySet and IsCellSet;
  bKeyClear.Enabled:= IsCellSet;
  bKeyFind.Enabled:= IsKeySet;
end;

end.

