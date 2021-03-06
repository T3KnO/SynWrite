unit unProjProps;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  TntForms, TntStdCtrls, ComCtrls, TntComCtrls, DKLang;

type
  TfmProjProps = class(TTntForm)
    btnOk: TTntButton;
    btnCan: TTntButton;
    Pages: TTntPageControl;
    TntTabSheet1: TTntTabSheet;
    TntTabSheet2: TTntTabSheet;
    edDirs: TTntMemo;
    Label4: TTntLabel;
    edWorkDir: TTntEdit;
    TntLabel1: TTntLabel;
    edMainFN: TTntEdit;
    btnWorkDir: TTntButton;
    TntLabel3: TTntLabel;
    Label1: TTntLabel;
    cbEnc: TTntComboBox;
    Label2: TTntLabel;
    cbEnds: TTntComboBox;
    Label3: TTntLabel;
    cbLexer: TTntComboBox;
    btnDirAdd: TTntButton;
    TntLabel2: TTntLabel;
    DKLanguageController1: TDKLanguageController;
    TntLabel4: TTntLabel;
    cbSort: TTntComboBox;
    TntTabSheet3: TTntTabSheet;
    edVars: TTntMemo;
    TntLabel5: TTntLabel;
    btnHelp: TTntButton;
    procedure btnWorkDirClick(Sender: TObject);
    procedure btnDirAddClick(Sender: TObject);
    procedure TntFormShow(Sender: TObject);
    procedure edDirsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FSynDir: string;
  end;

implementation

uses
  unProc,
  unProcHelp,
  TntFileCtrl;

{$R *.dfm}

procedure TfmProjProps.btnWorkDirClick(Sender: TObject);
var
  SDir: Widestring;
begin
  SDir:= edWorkDir.Text;
  if WideSelectDirectory('', '', SDir) then
    edWorkDir.Text:= SDir;
end;

procedure TfmProjProps.btnDirAddClick(Sender: TObject);
var
  SDir: Widestring;
begin
  SDir:= edWorkDir.Text;
  if WideSelectDirectory('', '', SDir) then
    edDirs.Lines.Add(SDir);
end;

procedure TfmProjProps.TntFormShow(Sender: TObject);
begin
  Pages.ActivePageIndex:= 0;
end;

procedure TfmProjProps.edDirsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=vk_escape) then
  begin
    btnCan.Click;
    Key:= 0;
    Exit
  end;  
end;

procedure TfmProjProps.btnHelpClick(Sender: TObject);
begin
  FHelpShow(FSynDir, helpProjOpts, Handle);
end;

end.
