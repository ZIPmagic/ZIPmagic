unit uLocalize;

interface

uses
  Windows, Registry, SysUtils, ActiveX;

  { Localization }

const
  CLSID_TaskbarList: TGUID = '{56FDF344-FD6D-11d0-958A-006097C9A090}';
  TBPF_NOPROGRESS    = 0;
  TBPF_INDETERMINATE = $1;
  TBPF_NORMAL        = $2;
  TBPF_ERROR         = $4;
  TBPF_PAUSED        = $8;

type
  ITaskbarList = interface(IUnknown)
    ['{56FDF342-FD6D-11D0-958A-006097C9A090}']
    function HrInit: HRESULT; stdcall;
    function AddTab(hwnd: HWND): HRESULT; stdcall;
    function DeleteTab(hwnd: HWND): HRESULT; stdcall;
    function ActivateTab(hwnd: HWND): HRESULT; stdcall;
    function SetActiveAlt(hwnd: HWND): HRESULT; stdcall;
  end;

  ITaskbarList2 = interface(ITaskbarList)
    ['{602D4995-B13A-429B-A66E-1935E44F4317}']
    function MarkFullscreenWindow(hwnd: HWND;
      fFullscreen: BOOL): HRESULT; stdcall;
  end;

  THUMBBUTTON = record
    dwMask: DWORD;
    iId: UINT;
    iBitmap: UINT;
    hIcon: HICON;
    szTip: packed array[0..259] of WCHAR;
    dwFlags: DWORD;
  end;
  TThumbButton = THUMBBUTTON;
  PThumbButton = ^TThumbButton;

  ITaskbarList3 = interface(ITaskbarList2)
    ['{EA1AFB91-9E28-4B86-90E9-9E9F8A5EEFAF}']
    function SetProgressValue(hwnd: HWND; ullCompleted: Int64;
      ullTotal: Int64): HRESULT; stdcall;
    function SetProgressState(hwnd: HWND;
      tbpFlags: Integer): HRESULT; stdcall;
    function RegisterTab(hwndTab: HWND; hwndMDI: HWND): HRESULT; stdcall;
    function UnregisterTab(hwndTab: HWND): HRESULT; stdcall;
    function SetTabOrder(hwndTab: HWND;
      hwndInsertBefore: HWND): HRESULT; stdcall;
    function SetTabActive(hwndTab: HWND; hwndMDI: HWND;
      tbatFlags: Integer): HRESULT; stdcall;
    function ThumbBarAddButtons(hwnd: HWND; cButtons: UINT;
      pButton: PThumbButton): HRESULT; stdcall;
    function ThumbBarUpdateButtons(hwnd: HWND; cButtons: UINT;
      pButton: PThumbButton): HRESULT; stdcall;
    function ThumbBarSetImageList(hwnd: HWND;
      himl: THandle): HRESULT; stdcall;
    function SetOverlayIcon(hwnd: HWND; hIcon: HICON;
      pszDescription: LPCWSTR): HRESULT; stdcall;
    function SetThumbnailTooltip(hwnd: HWND;
      pszTip: LPCWSTR): HRESULT; stdcall;
    function SetThumbnailClip(hwnd: HWND;
      var prcClip: TRect): HRESULT; stdcall;
  end;

  LongRec = packed record
    case Integer of
      0: (Lo, Hi: Word);
      1: (Words: array [0..1] of Word);
      2: (Bytes: array [0..3] of Byte);
  end;

function TechName: String;
function BrandName: String;
function CompanyName: String;
function HomePage: String;
function SalesPage: String;
function Gratis: Boolean;
function AllowXPMenu: Boolean;

procedure Win7TaskBar;
procedure Win7TaskBarSet(Handle: THandle; Position: Int64); overload;
procedure Win7TaskBarSet(Handle: THandle; Position, Maximum: Int64); overload;

var
  // Common
  cCancel, cPause, cResume, cWait, cError, cRetry, cFatalError,
  cOverwrite, cTest, cTestComplete, cGeneral, cCompress, cSwitches,
  cMultiPart, cOK, cApply, clPriority, clUserMode, cTimeCritical,
  cHighest, cHigher, cNormal, cLower, cLowest, cIdle, cNew, cInteractive,
  cLogged, cAlgorithm, cTradeOff, cFolder, cFolderRelative, cxOverwrite,
  cAutoFolder, cPreservePath, clOverwrite, cOverwriteAlways, cOverwriteAsk,
  cOverwriteNever, cEXEMaker, cEXEMakerExplanation, cEXEMakerKind, cSEAAs,
  cSaveAs, cClickToConvert, cConverting, cAllFiles, cEXEFiles, cSEADialogSaveAs,
  cTextFiles, cLogDialogSaveAs, cInvalidSaveName, cSkipFile, cYes, cYesToAll,
  cNo, cNoToAll, cOverwriteQuery, cOverwriteQueryCaption, cClose, cBack, cNext, cHelp,
  cDesignedAt, cResearchLabs, cFeaturing, cVersion, cClickNext, cBasedOn,
  cPlugRegFailure, cPlugIn, cNoWriteReg, cPlugRegSuccess, cPlugUnRegFailure,
  cPlugUnRegSuccess, cBrowse, cAddFiles, cRemove, cClear, cTryAgain,
  cAllCompressedFiles, cCodexNoPlug, cCodexPlugUpdate, cCodexGetNewPlug,
  cArcsSupported, cPlugsSupported, cAllArchives, cArchiveQuote, cQuoteExtracted,
  cPlugInLibBad, cPlugInLibNoEnc, cPlugInLibNoDec, cNewProfile, cEditProfile,
  cDeleteProfile, cMB, cNoArchiveSelected, cNoPlugExtConv1, cNoPlugExtConv2,
  cNoPlugCompConv1, cNoPlugCompConv2, cConvertingTitle, cExtractPhase, cCompressPhase,
  cStep, cOf, cBadCompEngine, cBadExtEngine, cPlugReInstall, cArchive,
  cUsingArchiveType, cConvertDone, cBadToolEngine, cForPlugIn, cPlugReInstallAlt,
  cTool, cArchiveDone, cBadMenu, cNoPlugTools, cNoPlugToolsHint, cViewEXE0, cViewEXE1, cViewEXE2,
  cNoPlugView1, cNoPlugView2, cPrepView, cInArchive, cViewUpdating, cBadIconSubsystem,
  cViewUpdateDone, cNoCheckOutRights1, cNoCheckOutRights2, cNoPlugExt, cPlugExtReq, cNoPlugCheckOut,
  cPlugCheckOutReq, cCheckingOut, cCreatingIcons, cBadUpdateSubsystem, cCheckOutDone,
  cInstalling, cRunning, cIn, cNoPlugOp, cPlugOpReq, cNoAutoSetup1, cNoAutoSetup2,
  cPreparing, cForOp, cFailedRun, cFailedRun_, cArchiveOp, cStartOrFinish, cBadAV1, cBadAV2,
  cNoPlugAV, cPlugReqAV, cQuarantine, cVirusScan, cAV0, cAV1, cAV2, cAV3, cExtracting,
  cExtracted, cBadExtract, cCompressing, cCompressed, cFailConfComp, cFailConfExt,
  cActionError, cDecryptPassword, cExtractNewFolder, cBadMulti, cBadDelete, cCompressionCancelled,
  cHasOccured, cCompressionKind, cCompMax, cCompNorm, cCompFast, cCompSuper, cDelAfterComp,
  cDelete, cSpan, cAction, cDefault, cMinMax, cFasterTighter, cEncrypt, cMist, cKB,
  cComments, cCommentsHint, cRepair, cRepairHint, cRepairProgress, cFile, cRepaired, cExtract,
  cStop, cInternal, cBadDir, cLock, cProtect, cProfile, cPortionsBy, cCodexUnableToOpen,
  cIllustration, cNoArchivable, cTipCaption, cTipTitle, cTipShow, cTipNext,
  cVAS, cWinCox, cQComp, cQDec, cUltra, cEdit, cCopy, cPaste, cCopyHint, cPasteHint, cSplit, cInvalidSplitSize,
  cOnlineUpdate, cD1, cD2, cD3, cD4, cD5, cD6, cD7, cD8, cD9, cD10, cD11, cD12, cD13, cD14, cD15, cD16, cD17, cD18,
  cD19, cD20, cD21, cD22, cD23, cD24, cD25, cD26, cD27, cD28, cD29, cD30, cD31, cD32, cD33, cD34, cD35, cD36, cD37,
  cD38, cD39, cD40, cD41, cD42, cD43, cD44, cD45, cD46, cD47, cD48, cMaxLic, cBadLic, cUpdate1, cUpdate2, cUpdate3,
  cSlowDown, cSpeedUp, cCompressedX: String;
  // CAB Extensions
  cabCabinetExists, cabDiskette, cabNewDisk, cabDiskSpace,
  cabInsertDisk, cabBadHeader, cabMSZIP, cabLZX, cabStrength, cabHistory,
  cabNote, cab512, cab1, cabReserve, cabBytes, cabMultiple, cabBytesEach,
  cabMultiNote, cabAutoFolder, cabEXEWin, cabEXEDOS, cabPlatformID, cabSeaText,
  cabNextPartMissing, cabInsertContainingDisk, cabFileAbsent, cabvEXE, cabvTest,
  cabvEXEHint, cabvTestHint: String;
  // Codex Commander
  comTitle, comSmart, comUsage, comCommands, comA, comAR, comL, comE, comV, comC,
  comT, comPI, comPA, comPE, comPT, comW, comLoadPlugs, comFileSupport, comParsing,
  comFailed, comComplete, comOpening, comFILES, comBYTES, comFindingTool, comForArchive,
  comFindingFilesForTool, comStartingTool, comErrNoPlug, comStartWeb,
  comArcSpecTools, comNoTools, comConvertEffect, comStartConvert, comViewUpdate,
  comInArchive, comFindExtract, comStartExtract, comExtracting, comDirList,
  comFILES_, comBYTES_, comNoCompPlug, comStartComp, comCompressing, comPIExec: String;
  // Q Wizards
  qWelcomeTo, qCompIntro, qSaveAsTitle, qAddFilesTitle, qCompArc, qCompSelFolder,
  qCompCheckNorm, qCompCheckRec, qCompSelFiles, qCompArcKind, qAdvanced, qAdvancedNote1,
  qAdvancedNote2, qCompReady, qCompUnderWay, qCompWait, qComplete, qCompFinish, qThanks,
  qCompWelcome, qCompSelectFile, qCompAddFolders, qCompAddFiles, qCompNoSel, qCompCompressType,
  qCompReadyToCompress, qCompWorking, qCompFinished, qCompNoPlugs, qCompClearList,
  qDecArcDlg, qDecTargDlg, qDecIntro, qDecSelArc, qDecPurpose, qDecInstall, qDecCheckOut,
  qDecAntiVirus, qDecDecode, qDecLook, qDecReady, qDecUnderWay, qDecWait, qDecStartOver,
  qDecSelFolder, qDecSelInstall, qDecSelAppFolder, qDecSelIcons, qDecIconAll, qDecIconSome,
  qDecIconEXE, qDecIconHLP, qDecIconTXT, qDecNavigate, qDecNavigate_, qDecType,
  qDecInstallType, qDecInto, qDecInside, qDecFolderAccess, qDecReadyToGo, qDecAtWork,
  qDecAntiVirusBad, qDecBye, qDecNoPlugs, qDecDNDSingle: String;
  // Visual Archive Studio
  vasAllFolders, vasSelectionDetails, vasListCol0, vasListCol1, vasListCol2, vasListCol3,
  vasListCol4, vasListCol5, vasToolBar0, vasToolBar1, vasToolBar2, vasToolBar3, vasToolBar4,
  vasToolBar5, vasToolBar6, vasToolBar7, vasToolBar8, vasToolBar9, vasMenuBar0, vasMenuBar1,
  vasMenuBar2, vasMenuBar3, vasMenuBar4, vasMenuBar5, vasMenuBar6, vasFileMenu0, vasFileMenu1,
  vasFileMenu2, vasFileMenu3, vasFileMenu4, vasFileMenu5, vasFileMenu6, vasFileMenu7, vasFileMenu8,
  vasFileMenu9, vasFileMenu10, vasViewMenu0, vasViewMenu1, vasViewMenu2, vasViewMenu3, vasViewMenu4,
  vasViewMenu5, vasViewMenu6, vasViewMenu7, vasViewMenu8, vasViewMenu9, vasViewMenu10, vasViewMenu11,
  vasViewMenu12, vasViewMenu13, vasArcMenu0, vasArcMenu1, vasArcMenu2, vasArcMenu3, vasArcMenu4,
  vasAccMenu0, vasAccMenu1, vasAccMenu2, vasOptMenu0, vasOptMenu1, vasOptMenu2, vasOptMenu3, vasOptMenu4,
  vasOptMenu5, vasToolMenu0, vasToolMenu1, vasToolMenu2, vasToolMenu3, vasHelpMenu0, vasHelpMenu1, vasHelpMenu2,
  vasHelpMenu3, vasHelpMenu4, vasHelpMenu5, vasTreePop0, vasTreePop1, vasTreePop2, vasTreePop3, vasTreePop4,
  vasTreePop5, vasTreePop6, vasToolPop0, vasToolPop1, vasToolPop2, vasListPop0, vasListPop1, vasListPop2,
  vasListPop3, vasListPop4, vasListPop5, vasListPop6, vasListPop7, vasListPop8, vasListPop9, vasActCodec0,
  vasActCodec1, vasActCodec2, vasActCodec3, vasActCodec4, vasActCodec5, vasActCodec6, vasActCodec7, vasActFiles0,
  vasActFiles1, vasActFiles2, vasActFiles3, vasActFiles4, vasActFiles5, vasActFiles6, vasActFiles7, vasActFiles8,
  vasActFiles9, vasActFiles10, vasActFiles11, vasActFiles12, vasActFiles13, vasActList0, vasActList1, vasActList2,
  vasActList3, vasActList4, vasActList5, vasActList6, vasActList7, vasActList8, vasActNeig0, vasActNeig1, vasActNeig2,
  vasActNeig3, vasActNeig4, vasActPlug0, vasActBar0, vasActBar1, vasActBar2, vasActTree0, vasActTree1, vasActTree2,
  vasActTree3, vasHintQuit, vasHintNone, vasHintThread, vasHintMsgs, vasArcHint0, vasArcHint1, vasArcHint2, vasArcHint3,
  vasAccHint0, vasAccHint1, vasAccHint2, vasOptHint0, vasOptHint1, vasOptHint2, vasOptHint3, vasOptHint4, vasOptHint5,
  vasHelpHint0, vasHelpHint1, vasHelpHint2, vasHelpHint3, vasHelpHint4, vasHelpHint5, vasGuiDlg0, vasGuiDlg1, vasGuiDlg2,
  vasGuiDlg3, vasGuiDlg4, vasNoPlugs, vasPlugAbout, vasModified, vasSize, vasCompressedSize, vasCompressionRatio,
  vasTask0, vasTask1, vasTask2, vasTask3, vasTask4, vasTask5, vasTask6, vasTask7, vasTask8, vasTask9, vasTask10,
  vasTask11, vasTask12, vasTask13, vasTask14, vasTask15, vasTask16, vasTask17, vasTask18, vasTask19, vasTask20, vasTask21,
  vasTask22, vasTask23, vasTask24, vasTask25, vasTask26, vasObjectState, vasOpeningFaves, vasBadMAPI, vasWaitMAPI,
  vasDropDirect, vasDropNoPlug, vasPlugCaption, vasPlugFeatures, vasPlugPlugins, vasPlugSupport, vasPlugExpand,
  vasPlugNone, vasSetSet, vasSetDesktop, vasSetViewStyle, vasSetPlaces, vasSetFolders, vasSetAntiVirus, vasSetTechnical,
  vasSetDlgFave, vasSetDlgView, vasSetDlgComp, vasSetDlgExt, vasSetLabel1, vasSetSingleDesk, vasSetMultiDesk, vasSetNeighbor,
  vasSetLabel2, vasSetView0, vasSetView1, vasSetView2, vasSetView3, vasSetView4, vasSetView5, vasSetView6, vasSetView7, vasSetView8,
  vasSetView9, vasSetView10, vasSetFave0, vasSetFave1, vasSetFave2, vasSetFave3, vasSetFave4, vasSetFave5, vasSetAnti0, vasSetAnti1,
  vasSetAnti2, vasSetAnti3, vasSetAnti4, vasSetAnti5, vasSetAnti6, vasSetTech0, vasSetTech1, vasSetTech2, vasSetTech3, vasSetTech4,
  vasSetTech5, vasSetTech6, vasSetTech7, vasSetTech8, vasSetTech9, vasSetFldr0, vasSetFldr1, vasSetFldr2, vasSetFldr3, vasSetFldr4,
  vasSetRefresh, vasSetScan0, vasSetScan1, vasSetConfirmNuke, vasSetAntiHint0, vasSetAntiHint1, vasSetAntiHint2, vasSetAntiHint3,
  vasSetAntiBad, vasSetAntiConfirm, vasSetBad0, vasSetBad1, vasSetBad2, vasExpMy, vasExpVisual, vasExpDesktop, vasExpPlaces,
  vasExpFiles, vasTreeExp0, vasTreeExp1, vasTreeExp2, vasTreeExp3, vasTreeExp4, vasTreeExp5, vasTreeExp6, vasTreeExp7, vasTreeExp8,
  vasTreeExp9, vasTreeExp10, vasTreeExp11, vasEnc0, vasEnc1, vasEnc2, vasEnc3, vasEnc4, vasEnc5, vasEnc6, vasEnc7, vasEnc8, vasEnc9,
  vasEnc10, vasEnc11, vasEnc12, vasEnc13, vasEnc14, vasEnc15, vasEnc16, vasEnc17, vasEnc18, vasEnc19, vasEnc20, vasEnc21, vasEnc22, vasEnc23, vasEnc24,
  vasEnc25, vasEnc26, vasEnc27, vasEnc28, vasEnc29, vasEnc30, vasEnc31, vasEnc32, vasEnc33, vasEnc34, vasEnc35, vasEnc36, vasEnc37, vasEnc38, vasEnc39,
  vasEnc40, vasEncNoCodecs, vasEnc41, vasEnc42, vasEnc43, vasEnc44, vasEncTitle, vasEnc45, vasEnc46, vasEnc47, vasEnc48, vasEnc49, vasEnc50, vasEnc51,
  vasNA, vasEnc52, vasEnc53, vasEnc54, vasDec0, vasDec1, vasDec2, vasDec3, vasDec4, vasDec5, vasDec6, vasDec7, vasDec8, vasDec9, vasDec10, vasDec11,
  vasDecNoCodecs, vasDec12, vasDec13, vasDec14, vasDec15, vasDec16, vasDec17, vasDec18, vasDec19, vasDecProf0, vasDecProf1, vasDecProf2, vasDecProf3,
  vasNewProfile, vasProfileExists, vasThread0, vasThread1, vasThread2, vasThread3, vasThread4, vasThread5, vasEncProf0, vasSearching,
  vasAVM0, vasAVM1, vasAVM2, vasAVM3, vasAVM4, vasAVM5, vasAVM6, vasAVM7, vasAVM8, vasAVM9, vasInst0, vasInst1, vasInst2, vasInst3, vasInst4, vasInst5,
  vasAntiVirus0, vasAntiVirus1, vasAntiVirus2, vasAntiVirus3, vasAntiVirus4, vasAntiVirus5, vasAntiVirus6, vasCheck0, vasCheck1, vasCheck2, vasCheck3,
  vasCheck4, vasCheck5, vasCheck6, vasCheck7, vasCheck8, vasCheck9, vasCheck10, vasCheck11, vasCheck12, vasCheck13, vasCheck14, vasCheck15,
  vasCheck16, vasCheck17, vasCheck18, vasFind0, vasFind1, vasFind2, vasFind3, vasFind4, vasFind5, vasConv0, vasConv1, vasConv2, vasConv3, vasConv4,
  vasConv5, vasConv6, vasConv7, vasConv8, vasConv9, vasConv10, vasConv11, vasConv12, vasConv13, vasConv14, vasConv15, vasConv16, vasConv17, vasMsgs0,
  vasMsgs1, vasMsgs2, vasMail0, vasMail1, vasMail2, vasEncList0, vasEncList1, vasMiss0, vasCntxMenu, vasCntxMenuHint: String;
  // Core Archives
  mtvInsertVolume, mtvCorruptHeader, mtvGetFirstDisk, mtvGetLastDisk, mtvGetDiskVolume, mtvGetDiskNumber, mtvTestTitle, mtvTestDone, mtvPassword,
  mtvInsertVolumeCont, mtvCurrentArchive, mtvCurrentFile, mtvError, mtvMessage, mtvBadFile, mtvContinueTest, mtvArcHeaderBad, mtvExtract, mtvSetup,
  mtvEXEError, mtvGZipMulti, mtvGZipExists, mtvDiskError, mtvFormattedDisk, mtvClickOK, mtvWriteProtect, mtvRemoveWriteProtect, mtvGetDisk,
  mtvlPassword, mtvAlg, mtvRarAct0, mtvRarAct1, mtvRarAct2, mtvRarAct3, mtvCompLevel, mtvDictSize, mtvSolid, mtvSolidHint, mtvRecoveryInfo, mtvMediaPrepare,
  mtvLeaveAsIs, mtvEraseAll, mtvEnableSpan, mtvSpanSetup, mtvSpanAuto, mtvSpanSize, mtvIndepSolid, mtvRarGraphWin, mtvRarWin, mtvRarDos, mtvRarOS2,
  mtvFileAbsent, mtvEXEMakerHint, mtvTest, mtvTestHint, mtvDelete, mtvDeleteHint, mtvLock, mtvLockHint, mtvProtect,
  mtvProtectHint, mtvTestAdv, mtvTestAdvHint, mtvEXEAdv, mtvEXEAdvHint, mtvComm, mtvCommHint, mtvRepair, mtvRepairHint,
  mtvPass, mtvPassHint, mtvRarRepair0, mtvRarRepair1, mtvRarRepair2, mtvRarRepair3, mtvRepairHigh, mtvRepairLow, mtvAce0, mtvAce1, mtvAce2, mtvAce3, mtvAce4,
  mtvAce5, mtvAceRepair0, mtvAceRepair1, mtvAceRepair2, mtvAceRepair3, mtvAceRepair4, mtvAceRepair5, mtvAceEx0, mtvAceEx1, mtvAceEx2, mtvAceEx3, mtvAceEx4, mtvAceEx5,
  mtvAceEx6, mtvAceEx7, mtvAceEx8, mtvAceEx9, mtvAceEx10, mtvAceEx11, mtvAceEx12, mtvAceEx13, mtvAceEx14, mtvAceEx15, mtvAceEx16, mtvAceEx17, mtvAceEx18, mtvAceEx19, mtvAceEx20,
  mtvAceEx21, mtvAceEx22, mtvAceEx23, mtvAceEx24, mtvAceEx25, mtvAceEx26, mtvAceEx27, mtvAceEx28, mtvAceEx29, mtvAceEx30, mtvAceEx31, mtvAceEx32, mtvAceEx33, mtvAceEx34, mtvAceEx35,
  mtvAceEx36, mtvAceEx37, mtvZipFix0, mtvZipFix1, mtvZipFix2, mtvZipFix3, mtvZipFix4, mtvZipFix5, mtvZipFix6, mtvZipFix7, mtvZipFix8, mtvZipFix9, mtvZipFix10, mtvZipFix11,
  mtvZipFix12, mtvZipFix13, mtvZipPass0, mtvZipPass1, mtvZipPass2, mtvZipPass3, mtvZipPass4, mtvZipPass5, mtvZipPass6, mtvZipPass7, mtvZipPass8, mtvZipPass9, mtvZipPass10, mtvZipPass11, mtvZipPass12,
  mtvZipPass13, mtvZipPass14, mtvZipPass15, mtvZipPass16, mtvZipPass17, mtvZipPass18, mtvZipPass19, mtvZipPass20, mtvContOp, mtvGenFail, mtvDecode0, mtvDecode1, mtvDecode2,
  mtvSplitZip, mtvSplitZipHint, mtvSplitZip0, mtvSplitZip1, mtvSplitZip2, mtvSplitZip3, mtvSplitZip4, mtvSplitZip5, mtvSplitZip6, mtvSplitZip7, mtvSplitZip8, mtvSplitZip9, mtvSplitZip10, mtvSplitZip11,
  mtvSplitZip12, mtvSplitZip13, mtvSplitZip14, mtvSplitZip15, mtvRarLic0, mtvRarLic1, mtvRarLic2, mtvRarLic3, mtvRarLic4, mtvRarLic5: String;
  // WinCox
  coxMenu0, coxMenu1, coxMenu2, coxMenu3, coxMenu4, coxMenu5, coxMenu6, coxMenu7, coxMenu8, coxMenu9, coxMenu10, coxMenu11, coxMenu12, coxMenu13, coxMenu14, coxMenu15, coxMenu16,
  coxMenu17, coxMenu18, coxMenu19, coxMenu20, coxMenu21, coxMenu22, coxMenu23, coxMenu24, coxMenu25, coxMenu26, coxMenu27, coxMenu28, coxMenu29, coxMenu30, coxMenu31, coxMenu32, coxMenu33,
  coxMenu34, coxPlugBeg, coxMenu35, coxMenu36, coxMenu37, coxTool0, coxTool1, coxTool2, coxTool3, coxTool4, coxTool5, coxTool6, coxTool7, coxList0, coxList1, coxList2, coxList3, coxList4,
  coxList5, coxList6, coxDlg0, coxDlg1, coxDlg2, coxAlt0, coxTool8, coxAlt1, coxAlt2, coxAlt3, coxAlt4, coxAlt5, coxAlt6, coxAlt7, coxAlt8, coxAlt9, coxAlt10, coxAlt11, coxAlt12, coxMap0, coxMap1,
  coxAdd0, coxAdd1, coxAdd2, coxAdd3, coxAdd4, coxAdd5, coxAdd6, coxAdd7, coxAdd8, coxEx0, coxEx1, coxEx2, coxEx3, coxEx4, coxEx5, coxEx6, coxEx7, coxEx8, coxEx9, coxEx10, coxEx11,
  coxOut0, coxOut1, coxOut2, coxOut3, coxOut4, coxOut5, coxOut6, coxOut7, coxChk0, coxChk1, coxChk2, coxChk3, coxChk4, coxChk5, coxChk6, coxChk7, coxChk8, coxChk9, coxMail0, coxMail1, coxMail2,
  coxConf0, coxConf1, coxConf2, coxConf3, coxConf4, coxConf5, coxConf6, coxConf7, coxConf8, coxConf9, coxConf10, coxConf11, coxConf12, coxConf13, coxConf14, coxConf15, coxConf16, coxConf17, coxConf18, coxConf19,
  coxConf20, coxConf21, coxConf22, coxConf23, coxConf24, coxConf25, coxConf26, coxConf27, coxConf28, coxConf29, coxConf30, coxConf31, coxConf32, coxConf33, coxConf34, coxConf35, coxConf36, coxConf37, coxConf38, coxConf39,
  coxConf40, coxConf41, coxConf42, coxConf43, coxConf44, coxConf45, coxConf46, coxConf47, coxConf48, coxConf49: String;
  // ShellExtensions
  shExt0, shExt1, shExt2, shExt3, shExt4, shExt5, shExt6, shComp0, shComp1, shComp2, shComp3, shComp4, shComp5, shComp6, shComp7, shComp8, shComp9, shComp10, shComp11, shProf0, shProf1, shProf2, shProf3, shProf4, shProf5,
  shProf6, shProf7, shProf8, shProf9, shProf10, shProf11, shProf12, shProf13, shProf14, shProf15, shProf16, shProf17, shProf18, shProf19, shProf20, shProf21, shProf22, shProf23, shProf24, shProf25, shProf26, shProf27, shProf28,
  shProf29, shProf30, shProf31, shEnc0, shEnc1, shEnc2, shEnc3, shEnc4, shEnc5, shEnc6, shEnc7, shEnc8, shEnc9, shEnc10, shEnc11, shEnc12, shEnc13, shEnc14, shEnc15, shEnc16, shEnc17, shCut0, shCut1, shCut2, shCut3, shCut4, shCut5,
  shCut6, shCut7, shCut8, shIcons, shView0, shView1, shView2, shView3, shSamp0, shSamp1, shSamp2, shSamp3, shSamp4, shSamp5, shSamp6, shSamp7, shSamp8, shSamp9, shSamp10, shSamp11, shSamp12, shSamp13, shSamp14, shSamp15, shSamp16,
  shSamp17, shSamp18, shSamp19, shSamp20, shSamp21, shSamp22, shSamp23, shSamp24, shSamp25, shCont0, shCont1, shCont2, shCont3, shCont4, shCont5, shCont6, shCont7, shCont8, shCont9, shCont10,
  shCutTip: String;
  // Control Panel
  cpl0, cpl1, cpl2, cpl3, cpl4, cpl5, cpl6, cpl7, cplCaption, cplHelpText, cplContext, cplCodex: String;
  // Codex DLL Stub
  stub0, stub1, stub2, stub3, stub4, stub5, stub6, stub7, stub8, stub9, stub10, stub11, stub12: String;
  // SZDD
  szdd0, szdd1, szdd2, szdd3, szdd4, szdd5, szdd6, szdd7, szdd8, szdd9, szdd10: String;
  // BZIP2 and ZLib Libraries
  lib0, lib1, lib2, lib3, lib4, lib5, lib6, lib7, lib8, lib9, lib10, lib11, lib12, lib13, lib14, lib15, lib16, lib17: String;
  // Codex API
  api0, api1, api2, api3, api4, api5, api6, api7, apiExtract, apiExtractHere, apiExtractFolder, apiNoOpen, apiReInstall,
  apiExtractHint, apiExtractHereHint, apiExtractFolderHint, apiCompress, apiCompressNow, apiCompressEmail, apiCompressHint,
  apiCompressNowHint, apiCompressEmailHint, apiCompressShellHint, api8, api9, api10, api11, api12, api13, api14, api15, api16,
  api17, api18, api19, api20, api21, api22, api23, api24, api25, api26, api27, api28, api29, api30, api31, api32, api33, api34,
  api35, api36, api37, api38, api39, api40, api41, api42, api43, apiSheet0, apiSheet1, apiSheet2, apiSheet3, apiSheet4,
  apiSheet5, apiSheet6, apiSheet7, apiSheet8, apiSheet9, apiAbout0, apiAbout1, apiAbout2, apiAbout3, apiTip0, apiTip1, apiTip2,
  apiTip3, apiTip4, apiTip5, apiTip6, apiTip7, apiTip8, apiTip9, apiTip10, apiTip11, apiTip12, apiTip13, apiTip14,
  apiLic0, apiLic1, apiLic2, apiLic3, apiLic4, apiLic5, apiLic6, apiLic7, apiLic8, apiLic9, apiLic10, apiLic11, apiLic12, apiLic13,
  apiLic14, apiLic15, apiLic16, apiLic17, apiLic18, api44, api45, api46, api47, api48, apiLic19, apiLic20, apiLic21, apiLic22, apiLic23, apiLic24,
  apiLic25, apiGenFail: String;
  // 7-Zip Archives
  sz0, sz1, sz2, sz3, sz4, sz5, sz6, sz7, sz8, sz9, sz10, sz11, sz12, sz13, sz14, sz15, sz16, sz17, sz18, sz19, sz20, sz21, sz22,
  sz23, szTimeCritical, szHigh, szNormal, szIdle, szInteract, szYesToAll, szYes, szNo, szStore, szMaximum, szCustom, szOff,
  szOn, szNone, SzBinary2, szBinary23, szBinary234, szBinary234Big, szPat2Remove, szPat2, szPat23, szPat3, szPat4,
  szHash23, szHash234, szBCJ, szBCJ2, szPriority, szUserMode, szMist, szStrength, szDeflateFastBytes, szDeflatePasses,
  szSolid, szHeader, szAlg, szLZMADict, szLZMAMatch, szLZMAFastBytes, szPPMdMemory, szPPMdModel, szConverter,
  szBCJ21, szBCJ22, sz24, sz25, sz26, sz27, sz28, sz29, sz30, sz31, sz32, sz33, sz34, szPassword, szMultiThreaded,
  szn0, szn1, szn2, szn3, szn4, szn5, szn6, szn7, szn8, szn9, szn10, szn11, szn12, szn13, sznPathMode, sznPathFull, sznPathRelative,
  sznPathNone, szn14, szn15, szn16, szn17, szn18, szn19, szn20, szn21, szn22, szn23, szn24, szn25, szn26, sznTryAgain, sznContinue,
  sznMultiWarn, sznTestSuccess: String;
  // Quick Start
  qs0, qs1, qsNew, qsAdd, qsExtract, qsView1, qsView2, qsInfo, qsView, qs2: String;
  // Ultra
  ult0, ult1, ult2, ult3, ult4, ult5, ult6, ult7, ult8, ult9, ult10, ult11, ult12, ult13, ult14, ult15, ult16, ult17, ult18, ult19, ult20,
  ult21, ult22, ult23, ult24, ult25, ult26, ult27, ult28, ult29, ult30, ult31, ult32, ult33, ult34, ult35, ult36, ult37, ult38, ult39, ult40,
  ult41, ult42, ult43, ult44, ult45, ult46, ult47, ult48, ult49, ult50, ult51, ult52, ult53, ult54, ult55, ultFolder, ult56, ult57, ult58, ult59, ult60,
  ult61, ult62, ult63, ult64, ult65, ult66, ult67, ult68, ult69, ult70, ult71, ult72, ult73, ult74, ult75, ult76, ult77, ult78, ult79,
  ultM0, ultM1, ultM2, ultM3: String;
  // Console Wrapper
  cw0, cw1, cw2, cw3: String;
  // WinImage Archives
  wa0, wa1, wa2, wa3, wa4, wa5, wa6, wa7, wa8, wa9, wa10, wa11, wa12, wa13, wa14, wa15, wa16, wa17, wa18,
  wa19, wa20, wa21, wa22, wa23, wa24, wa25, wa26, wa27, wa28, wa29, wa30, wa31, wa32, wa33, wa34, wa35,
  wa36, wa37, wa38, wa39, wa40, wa41, wa42, wa43, wa44, wa45, wa46, wa47, wa48, wa49, wa50, wa51, wa52,
  wa53, wa54, wa55: String;
  // Outlook Add-In
  oa0, oa1, oa2, oa3, oa4, oa5, oa6, oa7, oa8, oa9, oa10, oa11, oa12, oa13, oa14, oa15, oa16, oa17, oa18,
  oa19, oa20, oa21, oa22, oa23, oa24, oa25, oa26, oa27, oa28, oa29, oa30, oa31, oa32, oa33, oa34, oa35,
  oa36, oaAutoOn, oaAutoOff: String;
  // Recursive Extract Tool
  re0, re1, re2, re3, re4, re5, re6, re7, re8: String;
  // Office - REALLY part of COMMON
  oOpenArchive, oNewArchive, oRecommend, oOther, oDescription, oArchiveType, oByPlugIn, oNewDefaultName, oNewReadmeText, oNewReadmeFile: String;
  // Squeeze
  sqPass0, sqPass1, sqPass2, sqPass3, sqPass4, sqErr0, sqErr1, sqErr2, sqErr3, sqErr4, sqErr5, sqErr6, sqErr7, sqErr8, sqErr9, sqErr10,
  sqErr11, sqErr12, sqErr13, sqErr14, sqErr15, sqErr16, sqErr17, sqErr18, sqErr19, sqErr20,
  sqErr21, sqErr22, sqErr23, sqErr24, sqErr25, sqErr26, sqErr27, sqErr28, sqErr29, sqErr30,
  sqErr31, sqErr32, sqErr33, sqErr34, sqErr35, sqErr36, sqErr37, sqErr38, sqErr39, sqErr40,
  sqErr41, sqErr42, sqErr43, sqErr44, sqErr45, sqErr46, sqErr47, sqErr48, sqErr49, sqErr50, sqErr51, sqErr52,
  sqExt0, sqExt1, sqExt2, sqExt3, sqExt4, sqExt5, sqExt6, sqExt7, sqDisk0, sqDisk1, sqDisk2, sqDisk3, sqDisk4, sqDisk5,
  sqDisk6, sqDisk7, sqDisk8, sqDisk9, sqComp0, sqComp1, sqComp2, sqComp3, sqComp4, sqComp5, sqComp6, sqComp7, sqComp8,
  sqComp9, sqComp10, sqComp11, sqComp12, sqVol0, sqVol1, sqVol2, sqVol3, sqVol4, sqVol5, sqVol6, sqVol7, sqVol8, sqVol9,
  sqVol10, sqVol11, sqVol12, sqVol13, sqDic0, sqDic1, sqDic2, sqDic3, sqDic4, sqDic5, sqDic6, sqDic7,
  sqRate0, sqRate1, sqRate2, sqRate3, sqRec0, sqRec1, sqRec2, sqRec3, sqRec4, sqRec5, sqRec6, sqRec7, sqRec8, sqRec9,
  sqRec10, sqTool0, sqTool1, sqTool2, sqTool3, sqTool4, sqTool5, sqTool6, sqTool7, sqErr53, sqTool8, sqTool9,
  sqRep0, sqRep1, sqRep2, sqRep3, sqRep4, sqRep5, sqRep6, sqRep7, sqRep8, sqEXE0, sqEXE1: String;

implementation

var
  TBL: ITaskbarList3;

procedure Win7TaskBar;
begin
  if not CheckWin32Version(6, 1) then Exit;
  try
    CoCreateInstance(CLSID_TaskbarList, nil, CLSCTX_INPROC, ITaskbarList3, TBL);
  except
    //messagebox(0, 'except', nil, 0);
  end;
end;

procedure Win7TaskBarSet(Handle: THandle; Position: Int64); overload;
begin
  if not CheckWin32Version(6, 1) then Exit;
  if (TBL <> nil) then
  begin
    TBL.SetProgressValue(Handle, Position, 100);
    //messagebox(0, 'not nil', 'set', 0);
  end
  else
  begin
    Win7TaskBar;
    if (TBL <> nil) then
    begin
      TBL.SetProgressValue(Handle, Position, 100);
      //messagebox(0, 'not nil on second shot', 'set', 0);
    end
    else
    begin
      //messagebox(0, 'still nil', 'set', 0);
    end;
  end;
end;

procedure Win7TaskBarSet(Handle: THandle; Position, Maximum: Int64); overload;
begin
  if (TBL <> nil) then
    TBL.SetProgressValue(Handle, Position, Maximum)
  else
  begin
    Win7TaskBar;
    if (TBL <> nil) then
      TBL.SetProgressValue(Handle, Position, Maximum);
  end;
end;

function TechName: String;
begin
  Result := 'ZIPmagic';
end;

function BrandName: String;
begin
  Result := 'Simon King`s';
end;

function CompanyName: String;
begin
  Result := 'Simon King';
end;

function HomePage: String;
begin
  Result := 'http://www.zipmagic.com/';
end;

function SalesPage: String;
begin
  Result := 'http://www.zipmagic.co/purchase.asp';
end;

function Gratis: Boolean;
begin
  Result := FALSE;
end;

function AllowXPMenu: Boolean;
begin
  Result := TRUE;
end;

function GetUACDir: String;
var
  r: TRegistry;
begin
  Result := '';
  r := TRegistry.Create;
  r.RootKey := HKEY_LOCAL_MACHINE;
  r.Access := KEY_READ;
  if r.OpenKeyReadOnly('SOFTWARE\MimarSinan\Codex\2.0') then
  begin
    if r.ValueExists('Shared') then
      Result := IncludeTrailingPathDelimiter(r.ReadString('Shared'));
    r.CloseKey;
  end;
  r.Free;
end;

function InitializeLocalization: Boolean;
var
  p: PChar;
  s: String;
  t: TextFile;
begin
  FileMode := 0;
  GetMem(p, MAX_PATH);
  GetSystemDirectory(p, MAX_PATH);
  s := p;
  if s[Length(s)] <> '\' then s := s + '\';
  FreeMem(p);
  AssignFile(t, {s}GetUACDir + 'codex.Translations.active');
  Reset(t);
  ReadLn(t, cCancel);
  ReadLn(t, cPause);
  ReadLn(t, cResume);
  ReadLn(t, cWait);
  ReadLn(t, cError);
  ReadLn(t, cRetry);
  ReadLn(t, cFatalError);
  ReadLn(t, cabCabinetExists);
  ReadLn(t, cOverwrite);
  ReadLn(t, cabDiskette);
  ReadLn(t, cabNewDisk);
  ReadLn(t, cabDiskSpace);
  ReadLn(t, cabInsertDisk);
  ReadLn(t, cTest);
  ReadLn(t, cTestComplete);
  ReadLn(t, cabBadHeader);
  ReadLn(t, cGeneral);
  ReadLn(t, cCompress);
  ReadLn(t, cSwitches);
  ReadLn(t, cMultiPart);
  ReadLn(t, cOK);
  ReadLn(t, cApply);
  ReadLn(t, clPriority);
  ReadLn(t, clUserMode);
  ReadLn(t, cTimeCritical);
  ReadLn(t, cHighest);
  ReadLn(t, cHigher);
  ReadLn(t, cNormal);
  ReadLn(t, cLower);
  ReadLn(t, cLowest);
  ReadLn(t, cIdle);
  ReadLn(t, cNew);
  ReadLn(t, cInteractive);
  ReadLn(t, cLogged);
  ReadLn(t, cAlgorithm);
  ReadLn(t, cabMSZIP);
  ReadLn(t, cabLZX);
  ReadLn(t, cabStrength);
  ReadLn(t, cabHistory);
  ReadLn(t, cabNote);
  ReadLn(t, cab512);
  ReadLn(t, cab1);
  ReadLn(t, cTradeOff);
  ReadLn(t, cFolder);
  ReadLn(t, cFolderRelative);
  ReadLn(t, cabReserve);
  ReadLn(t, cabBytes);
  ReadLn(t, cabMultiple);
  ReadLn(t, cabBytesEach);
  ReadLn(t, cabMultiNote);
  ReadLn(t, cxOverwrite);
  ReadLn(t, cabAutoFolder);
  ReadLn(t, cAutoFolder);
  ReadLn(t, cPreservePath);
  ReadLn(t, clOverwrite);
  ReadLn(t, cOverwriteAlways);
  ReadLn(t, cOverwriteAsk);
  ReadLn(t, cOverwriteNever);
  ReadLn(t, cEXEMaker);
  ReadLn(t, cEXEMakerExplanation);
  ReadLn(t, cEXEMakerKind);
  ReadLn(t, cabEXEWin);
  ReadLn(t, cabEXEDOS);
  ReadLn(t, cSEAAs);
  ReadLn(t, cSaveAs);
  ReadLn(t, cClickToConvert);
  ReadLn(t, cConverting);
  ReadLn(t, cSEADialogSaveAs);
  ReadLn(t, cEXEFiles);
  ReadLn(t, cAllFiles);
  ReadLn(t, cTextFiles);
  ReadLn(t, cLogDialogSaveAs);
  ReadLn(t, cInvalidSaveName);
  ReadLn(t, cabPlatformID);
  ReadLn(t, cabSeaText);
  ReadLn(t, cSkipFile);
  ReadLn(t, cabNextPartMissing);
  ReadLn(t, cabInsertContainingDisk);
  ReadLn(t, cYes);
  ReadLn(t, cYesToAll);
  ReadLn(t, cNo);
  ReadLn(t, cNoToAll);
  ReadLn(t, cOverwriteQuery);
  ReadLn(t, cOverwriteQueryCaption);
  ReadLn(t, comTitle);
  ReadLn(t, comSmart);
  ReadLn(t, comUsage);
  ReadLn(t, comCommands);
  ReadLn(t, comA);
  ReadLn(t, comAR);
  ReadLn(t, comL);
  ReadLn(t, comE);
  ReadLn(t, comV);
  ReadLn(t, comC);
  ReadLn(t, comT);
  ReadLn(t, comPI);
  ReadLn(t, comPA);
  ReadLn(t, comPE);
  ReadLn(t, comPT);
  ReadLn(t, comW);
  ReadLn(t, comLoadPlugs);
  ReadLn(t, comFileSupport);
  ReadLn(t, comParsing);
  ReadLn(t, comFailed);
  ReadLn(t, comComplete);
  ReadLn(t, comOpening);
  ReadLn(t, comFILES);
  ReadLn(t, comBYTES);
  ReadLn(t, comFindingTool);
  ReadLn(t, comForArchive);
  ReadLn(t, comFindingFilesForTool);
  ReadLn(t, comStartingTool);
  ReadLn(t, comErrNoPlug);
  ReadLn(t, comStartWeb);
  ReadLn(t, comArcSpecTools);
  ReadLn(t, comNoTools);
  ReadLn(t, comConvertEffect);
  ReadLn(t, comStartConvert);
  ReadLn(t, comViewUpdate);
  ReadLn(t, comInArchive);
  ReadLn(t, comFindExtract);
  ReadLn(t, comStartExtract);
  ReadLn(t, comExtracting);
  ReadLn(t, comDirList);
  ReadLn(t, comFILES_);
  ReadLn(t, comBYTES_);
  ReadLn(t, comNoCompPlug);
  ReadLn(t, comStartComp);
  ReadLn(t, comCompressing);
  ReadLn(t, comPIExec);
  ReadLn(t, cClose);
  ReadLn(t, cBack);
  ReadLn(t, cNext);
  ReadLn(t, cHelp);
  ReadLn(t, qWelcomeTo);
  Readln(t, qCompIntro);
  ReadLn(t, cDesignedAt);
  ReadLn(t, cResearchLabs);
  ReadLn(t, cFeaturing);
  ReadLn(t, cVersion);
  ReadLn(t, cClickNext);
  ReadLn(t, qSaveAsTitle);
  ReadLn(t, qAddFilesTitle);
  ReadLn(t, cBasedOn);
  ReadLn(t, cabFileAbsent);
  ReadLn(t, cPlugRegFailure);
  ReadLn(t, cPlugIn);
  ReadLn(t, cNoWriteReg);
  ReadLn(t, cabvEXE);
  ReadLn(t, cabvEXEHint);
  ReadLn(t, cabvTest);
  ReadLn(t, cabvTestHint);
  ReadLn(t, cPlugRegSuccess);
  ReadLn(t, cPlugUnRegFailure);
  ReadLn(t, cPlugUnRegSuccess);
  ReadLn(t, cBrowse);
  ReadLn(t, qCompArc);
  ReadLn(t, qCompSelFolder);
  ReadLn(t, qCompCheckNorm);
  ReadLn(t, qCompCheckRec);
  ReadLn(t, qCompSelFiles);
  ReadLn(t, cAddFiles);
  ReadLn(t, cRemove);
  ReadLn(t, cClear);
  ReadLn(t, qCompArcKind);
  ReadLn(t, qAdvanced);
  ReadLn(t, qAdvancedNote1);
  ReadLn(t, qAdvancedNote2);
  ReadLn(t, qCompReady);
  ReadLn(t, qCompUnderWay);
  ReadLn(t, qCompWait);
  ReadLn(t, qComplete);
  ReadLn(t, qCompFinish);
  ReadLn(t, qThanks);
  ReadLn(t, qCompWelcome);
  ReadLn(t, qCompSelectFile);
  ReadLn(t, qCompAddFolders);
  ReadLn(t, qCompAddFiles);
  ReadLn(t, qCompNoSel);
  ReadLn(t, cTryAgain);
  ReadLn(t, qCompCompressType);
  ReadLn(t, qCompReadyToCompress);
  ReadLn(t, qCompWorking);
  ReadLn(t, qCompFinished);
  ReadLn(t, qCompNoPlugs);
  ReadLn(t, qCompClearList);
  ReadLn(t, cAllCompressedFiles);
  ReadLn(t, qDecArcDlg);
  ReadLn(t, qDecTargDlg);
  ReadLn(t, qDecIntro);
  ReadLn(t, qDecSelArc);
  ReadLn(t, qDecPurpose);
  ReadLn(t, qDecInstall);
  ReadLn(t, qDecCheckOut);
  ReadLn(t, qDecAntiVirus);
  ReadLn(t, qDecDecode);
  ReadLn(t, qDecLook);
  ReadLn(t, qDecReady);
  ReadLn(t, qDecUnderWay);
  ReadLn(t, qDecWait);
  ReadLn(t, qDecStartOver);
  ReadLn(t, qDecSelFolder);
  ReadLn(t, qDecSelInstall);
  ReadLn(t, qDecSelAppFolder);
  ReadLn(t, qDecSelIcons);
  ReadLn(t, qDecIconAll);
  ReadLn(t, qDecIconSome);
  ReadLn(t, qDecIconEXE);
  ReadLn(t, qDecIconHLP);
  ReadLn(t, qDecIconTXT);
  ReadLn(t, qDecNavigate);
  ReadLn(t, qDecNavigate_);
  ReadLn(t, cCodexNoPlug);
  ReadLn(t, cCodexPlugUpdate);
  ReadLn(t, cCodexGetNewPlug);
  ReadLn(t, qDecType);
  ReadLn(t, qDecInstallType);
  ReadLn(t, qDecInto);
  ReadLn(t, qDecInside);
  ReadLn(t, qDecFolderAccess);
  ReadLn(t, qDecReadyToGo);
  ReadLn(t, qDecAtWork);
  ReadLn(t, qDecAntiVirusBad);
  ReadLn(t, qDecBye);
  ReadLn(t, qDecNoPlugs);
  ReadLn(t, qDecDNDSingle);
  ReadLn(t, vasAllFolders);
  ReadLn(t, vasSelectionDetails);
  ReadLn(t, vasListCol0);
  ReadLn(t, vasListCol1);
  ReadLn(t, vasListCol2);
  ReadLn(t, vasListCol3);
  ReadLn(t, vasListCol4);
  ReadLn(t, vasListCol5);
  ReadLn(t, vasToolBar0);
  ReadLn(t, vasToolBar1);
  ReadLn(t, vasToolBar2);
  ReadLn(t, vasToolBar3);
  ReadLn(t, vasToolBar4);
  ReadLn(t, vasToolBar5);
  ReadLn(t, vasToolBar6);
  ReadLn(t, vasToolBar7);
  ReadLn(t, vasToolBar8);
  ReadLn(t, vasToolBar9);
  ReadLn(t, vasMenuBar0);
  ReadLn(t, vasMenuBar1);
  ReadLn(t, vasMenuBar2);
  ReadLn(t, vasMenuBar3);
  ReadLn(t, vasMenuBar4);
  ReadLn(t, vasMenuBar5);
  ReadLn(t, vasMenuBar6);
  ReadLn(t, vasFileMenu0);
  ReadLn(t, vasFileMenu1);
  ReadLn(t, vasFileMenu2);
  ReadLn(t, vasFileMenu3);
  ReadLn(t, vasFileMenu4);
  ReadLn(t, vasFileMenu5);
  ReadLn(t, vasFileMenu6);
  ReadLn(t, vasFileMenu7);
  ReadLn(t, vasFileMenu8);
  ReadLn(t, vasFileMenu9);
  ReadLn(t, vasFileMenu10);
  ReadLn(t, vasViewMenu0);
  ReadLn(t, vasViewMenu1);
  ReadLn(t, vasViewMenu2);
  ReadLn(t, vasViewMenu3);
  ReadLn(t, vasViewMenu4);
  ReadLn(t, vasViewMenu5);
  ReadLn(t, vasViewMenu6);
  ReadLn(t, vasViewMenu7);
  ReadLn(t, vasViewMenu8);
  ReadLn(t, vasViewMenu9);
  ReadLn(t, vasViewMenu10);
  ReadLn(t, vasViewMenu11);
  ReadLn(t, vasViewMenu12);
  ReadLn(t, vasViewMenu13);
  ReadLn(t, vasArcMenu0);
  ReadLn(t, vasArcMenu1);
  ReadLn(t, vasArcMenu2);
  ReadLn(t, vasArcMenu3);
  ReadLn(t, vasArcMenu4);
  ReadLn(t, vasAccMenu0);
  ReadLn(t, vasAccMenu1);
  ReadLn(t, vasAccMenu2);
  ReadLn(t, vasOptMenu0);
  ReadLn(t, vasOptMenu1);
  ReadLn(t, vasOptMenu2);
  ReadLn(t, vasOptMenu3);
  ReadLn(t, vasOptMenu4);
  ReadLn(t, vasOptMenu5);
  ReadLn(t, vasToolMenu0);
  ReadLn(t, vasToolMenu1);
  ReadLn(t, vasToolMenu2);
  ReadLn(t, vasToolMenu3);
  ReadLn(t, vasHelpMenu0);
  ReadLn(t, vasHelpMenu1);
  ReadLn(t, vasHelpMenu2);
  ReadLn(t, vasHelpMenu3);
  ReadLn(t, vasHelpMenu4);
  ReadLn(t, vasHelpMenu5);
  ReadLn(t, vasTreePop0);
  ReadLn(t, vasTreePop1);
  ReadLn(t, vasTreePop2);
  ReadLn(t, vasTreePop3);
  ReadLn(t, vasTreePop4);
  ReadLn(t, vasTreePop5);
  ReadLn(t, vasTreePop6);
  ReadLn(t, vasToolPop0);
  ReadLn(t, vasToolPop1);
  ReadLn(t, vasToolPop2);
  ReadLn(t, vasListPop0);
  ReadLn(t, vasListPop1);
  ReadLn(t, vasListPop2);
  ReadLn(t, vasListPop3);
  ReadLn(t, vasListPop4);
  ReadLn(t, vasListPop5);
  ReadLn(t, vasListPop6);
  ReadLn(t, vasListPop7);
  ReadLn(t, vasListPop8);
  ReadLn(t, vasListPop9);
  ReadLn(t, vasActCodec0);
  ReadLn(t, vasActCodec1);
  ReadLn(t, vasActCodec2);
  ReadLn(t, vasActCodec3);
  ReadLn(t, vasActCodec4);
  ReadLn(t, vasActCodec5);
  ReadLn(t, vasActCodec6);
  ReadLn(t, vasActCodec7);
  ReadLn(t, vasActFiles0);
  ReadLn(t, vasActFiles1);
  ReadLn(t, vasActFiles2);
  ReadLn(t, vasActFiles3);
  ReadLn(t, vasActFiles4);
  ReadLn(t, vasActFiles5);
  ReadLn(t, vasActFiles6);
  ReadLn(t, vasActFiles7);
  ReadLn(t, vasActFiles8);
  ReadLn(t, vasActFiles9);
  ReadLn(t, vasActFiles10);
  ReadLn(t, vasActFiles11);
  ReadLn(t, vasActFiles12);
  ReadLn(t, vasActFiles13);
  ReadLn(t, vasActList0);
  ReadLn(t, vasActList1);
  ReadLn(t, vasActList2);
  ReadLn(t, vasActList3);
  ReadLn(t, vasActList4);
  ReadLn(t, vasActList5);
  ReadLn(t, vasActList6);
  ReadLn(t, vasActList7);
  ReadLn(t, vasActList8);
  ReadLn(t, vasActNeig0);
  ReadLn(t, vasActNeig1);
  ReadLn(t, vasActNeig2);
  ReadLn(t, vasActNeig3);
  ReadLn(t, vasActNeig4);
  ReadLn(t, vasActPlug0);
  ReadLn(t, vasActBar0);
  ReadLn(t, vasActBar1);
  ReadLn(t, vasActBar2);
  ReadLn(t, vasActTree0);
  ReadLn(t, vasActTree1);
  ReadLn(t, vasActTree2);
  ReadLn(t, vasActTree3);
  ReadLn(t, vasHintQuit);
  ReadLn(t, vasHintNone);
  ReadLn(t, vasHintThread);
  ReadLn(t, vasHintMsgs);
  ReadLn(t, vasArcHint0);
  ReadLn(t, vasArcHint1);
  ReadLn(t, vasArcHint2);
  ReadLn(t, vasArcHint3);
  ReadLn(t, vasAccHint0);
  ReadLn(t, vasAccHint1);
  ReadLn(t, vasAccHint2);
  ReadLn(t, vasOptHint0);
  ReadLn(t, vasOptHint1);
  ReadLn(t, vasOptHint2);
  ReadLn(t, vasOptHint3);
  ReadLn(t, vasOptHint4);
  ReadLn(t, vasOptHint5);
  ReadLn(t, vasHelpHint0);
  ReadLn(t, vasHelpHint1);
  ReadLn(t, vasHelpHint2);
  ReadLn(t, vasHelpHint3);
  ReadLn(t, vasHelpHint4);
  ReadLn(t, vasHelpHint5);
  ReadLn(t, vasGuiDlg0);
  ReadLn(t, vasGuiDlg1);
  ReadLn(t, vasGuiDlg2);
  ReadLn(t, vasGuiDlg3);
  ReadLn(t, vasGuiDlg4);
  ReadLn(t, vasNoPlugs);
  ReadLn(t, vasPlugAbout);
  ReadLn(t, vasModified);
  ReadLn(t, vasSize);
  ReadLn(t, vasCompressedSize);
  ReadLn(t, vasCompressionRatio);
  ReadLn(t, vasTask0);
  ReadLn(t, vasTask1);
  ReadLn(t, vasTask2);
  ReadLn(t, vasTask3);
  ReadLn(t, vasTask4);
  ReadLn(t, vasTask5);
  ReadLn(t, vasTask6);
  ReadLn(t, vasTask7);
  ReadLn(t, vasTask8);
  ReadLn(t, vasTask9);
  ReadLn(t, vasTask10);
  ReadLn(t, vasTask11);
  ReadLn(t, vasTask12);
  ReadLn(t, vasTask13);
  ReadLn(t, vasTask14);
  ReadLn(t, vasTask15);
  ReadLn(t, vasTask16);
  ReadLn(t, vasTask17);
  ReadLn(t, vasTask18);
  ReadLn(t, vasTask19);
  ReadLn(t, vasTask20);
  ReadLn(t, vasTask21);
  ReadLn(t, vasTask22);
  ReadLn(t, vasTask23);
  ReadLn(t, vasTask24);
  ReadLn(t, vasTask25);
  ReadLn(t, vasTask26);
  ReadLn(t, cArcsSupported);
  ReadLn(t, cPlugsSupported);
  ReadLn(t, cAllArchives);
  ReadLn(t, vasObjectState);
  ReadLn(t, vasOpeningFaves);
  ReadLn(t, vasBadMAPI);
  ReadLn(t, vasWaitMAPI);
  ReadLn(t, vasDropDirect);
  ReadLn(t, vasDropNoPlug);
  ReadLn(t, cArchiveQuote);
  ReadLn(t, cQuoteExtracted);
  ReadLn(t, cPlugInLibBad);
  ReadLn(t, cPlugInLibNoEnc);
  ReadLn(t, cPlugInLibNoDec);
  ReadLn(t, vasPlugCaption);
  ReadLn(t, vasPlugPlugIns);
  ReadLn(t, vasPlugFeatures);
  ReadLn(t, vasPlugSupport);
  ReadLn(t, vasPlugExpand);
  ReadLn(t, vasPlugNone);
  ReadLn(t, vasSetSet);
  ReadLn(t, vasSetDesktop);
  ReadLn(t, vasSetViewStyle);
  ReadLn(t, vasSetPlaces);
  ReadLn(t, vasSetFolders);
  ReadLn(t, vasSetAntiVirus);
  ReadLn(t, vasSetTechnical);
  ReadLn(t, vasSetDlgFave);
  ReadLn(t, vasSetDlgView);
  ReadLn(t, vasSetDlgComp);
  ReadLn(t, vasSetDlgExt);
  ReadLn(t, vasSetLabel1);
  ReadLn(t, vasSetSingleDesk);
  ReadLn(t, vasSetMultiDesk);
  ReadLn(t, vasSetNeighbor);
  ReadLn(t, vasSetLabel2);
  ReadLn(t, vasSetView0);
  ReadLn(t, vasSetView1);
  ReadLn(t, vasSetView2);
  ReadLn(t, vasSetView3);
  ReadLn(t, vasSetView4);
  ReadLn(t, vasSetView5);
  ReadLn(t, vasSetView6);
  ReadLn(t, vasSetView7);
  ReadLn(t, vasSetView8);
  ReadLn(t, vasSetView9);
  ReadLn(t, vasSetView10);
  ReadLn(t, vasSetFave0);
  ReadLn(t, vasSetFave1);
  ReadLn(t, vasSetFave2);
  ReadLn(t, vasSetFave3);
  ReadLn(t, vasSetFave4);
  ReadLn(t, vasSetFave5);
  ReadLn(t, vasSetAnti0);
  ReadLn(t, vasSetAnti1);
  ReadLn(t, vasSetAnti2);
  ReadLn(t, vasSetAnti3);
  ReadLn(t, vasSetAnti4);
  ReadLn(t, vasSetAnti5);
  ReadLn(t, vasSetAnti6);
  ReadLn(t, vasSetTech0);
  ReadLn(t, vasSetTech1);
  ReadLn(t, vasSetTech2);
  ReadLn(t, vasSetTech3);
  ReadLn(t, vasSetTech4);
  ReadLn(t, vasSetTech5);
  ReadLn(t, vasSetTech6);
  ReadLn(t, vasSetTech7);
  ReadLn(t, vasSetTech8);
  ReadLn(t, vasSetTech9);
  ReadLn(t, vasSetFldr0);
  ReadLn(t, vasSetFldr1);
  ReadLn(t, vasSetFldr2);
  ReadLn(t, vasSetFldr3);
  ReadLn(t, vasSetFldr4);
  ReadLn(t, vasSetRefresh);
  ReadLn(t, vasSetScan0);
  ReadLn(t, vasSetScan1);
  ReadLn(t, vasSetConfirmNuke);
  ReadLn(t, vasSetAntiHint0);
  ReadLn(t, vasSetAntiHint1);
  ReadLn(t, vasSetAntiHint2);
  ReadLn(t, vasSetAntiHint3);
  ReadLn(t, vasSetAntiBad);
  ReadLn(t, vasSetAntiConfirm);
  ReadLn(t, vasSetBad0);
  ReadLn(t, vasSetBad1);
  ReadLn(t, vasSetBad2);
  ReadLn(t, vasExpMy);
  ReadLn(t, vasExpVisual);
  ReadLn(t, vasExpDesktop);
  ReadLn(t, vasExpPlaces);
  ReadLn(t, vasExpFiles);
  ReadLn(t, vasTreeExp0);
  ReadLn(t, vasTreeExp1);
  ReadLn(t, vasTreeExp2);
  ReadLn(t, vasTreeExp3);
  ReadLn(t, vasTreeExp4);
  ReadLn(t, vasTreeExp5);
  ReadLn(t, vasTreeExp6);
  ReadLn(t, vasTreeExp7);
  ReadLn(t, vasTreeExp8);
  ReadLn(t, vasTreeExp9);
  ReadLn(t, vasTreeExp10);
  ReadLn(t, vasTreeExp11);
  ReadLn(t, vasEnc0);
  ReadLn(t, vasEnc1);
  ReadLn(t, vasEnc2);
  ReadLn(t, vasEnc3);
  ReadLn(t, vasEnc4);
  ReadLn(t, vasEnc5);
  ReadLn(t, vasEnc6);
  ReadLn(t, vasEnc7);
  ReadLn(t, vasEnc8);
  ReadLn(t, vasEnc9);
  ReadLn(t, vasEnc10);
  ReadLn(t, vasEnc11);
  ReadLn(t, vasEnc12);
  ReadLn(t, vasEnc13);
  ReadLn(t, vasEnc14);
  ReadLn(t, vasEnc15);
  ReadLn(t, vasEnc16);
  ReadLn(t, vasEnc17);
  ReadLn(t, vasEnc18);
  ReadLn(t, vasEnc19);
  ReadLn(t, vasEnc20);
  ReadLn(t, vasEnc21);
  ReadLn(t, vasEnc22);
  ReadLn(t, vasEnc23);
  ReadLn(t, vasEnc24);
  ReadLn(t, vasEnc25);
  ReadLn(t, vasEnc26);
  ReadLn(t, vasEnc27);
  ReadLn(t, vasEnc28);
  ReadLn(t, vasEnc29);
  ReadLn(t, vasEnc30);
  ReadLn(t, vasEnc31);
  ReadLn(t, vasEnc32);
  ReadLn(t, cNewProfile);
  ReadLn(t, cEditProfile);
  ReadLn(t, cDeleteProfile);
  ReadLn(t, vasEnc33);
  ReadLn(t, vasEnc34);
  ReadLn(t, vasEnc35);
  ReadLn(t, vasEnc36);
  ReadLn(t, vasEnc37);
  ReadLn(t, vasEnc38);
  ReadLn(t, vasEnc39);
  ReadLn(t, vasEnc40);
  ReadLn(t, vasEncNoCodecs);
  ReadLn(t, vasEnc41);
  ReadLn(t, vasEnc42);
  ReadLn(t, vasEnc43);
  ReadLn(t, vasEnc44);
  ReadLn(t, vasEncTitle);
  ReadLn(t, vasEnc45);
  ReadLn(t, vasEnc46);
  ReadLn(t, vasEnc47);
  ReadLn(t, vasEnc48);
  ReadLn(t, vasEnc49);
  ReadLn(t, vasEnc50);
  ReadLn(t, vasEnc51);
  ReadLn(t, vasEnc52);
  ReadLn(t, cMB);
  ReadLn(t, vasNA);
  ReadLn(t, vasEnc53);
  ReadLn(t, vasEnc54);
  ReadLn(t, cNoArchiveSelected);
  ReadLn(t, cNoPlugExtConv1);
  ReadLn(t, cNoPlugExtConv2);
  ReadLn(t, cNoPlugCompConv1);
  ReadLn(t, cNoPlugCompConv2);
  ReadLn(t, cConvertingTitle);
  ReadLn(t, cExtractPhase);
  ReadLn(t, cCompressPhase);
  ReadLn(t, cStep);
  ReadLn(t, cOf);
  ReadLn(t, cBadExtEngine);
  ReadLn(t, cBadCompEngine);
  ReadLn(t, cPlugReInstall);
  ReadLn(t, cArchive);
  ReadLn(t, cUsingArchiveType);
  ReadLn(t, cConvertDone);
  ReadLn(t, cBadToolEngine);
  ReadLn(t, cForPlugIn);
  ReadLn(t, cPlugReInstallAlt);
  ReadLn(t, cTool);
  ReadLn(t, cArchiveDone);
  ReadLn(t, cBadMenu);
  ReadLn(t, cNoPlugTools);
  ReadLn(t, cNoPlugToolsHint);
  ReadLn(t, cViewEXE0);
  ReadLn(t, cViewEXE1);
  ReadLn(t, cViewEXE2);
  ReadLn(t, cNoPlugView1);
  ReadLn(t, cNoPlugView2);
  ReadLn(t, cPrepView);
  ReadLn(t, cInArchive);
  ReadLn(t, cViewUpdating);
  ReadLn(t, cBadIconSubsystem);
  ReadLn(t, cViewUpdateDone);
  ReadLn(t, cNoCheckOutRights1);
  ReadLn(t, cNoCheckOutRights2);
  ReadLn(t, cNoPlugExt);
  ReadLn(t, cPlugExtReq);
  ReadLn(t, cNoPlugCheckOut);
  ReadLn(t, cPlugCheckOutReq);
  ReadLn(t, cCheckingOut);
  ReadLn(t, cCreatingIcons);
  ReadLn(t, cBadUpdateSubsystem);
  ReadLn(t, cCheckOutDone);
  ReadLn(t, cInstalling);
  ReadLn(t, cRunning);
  ReadLn(t, cIn);
  ReadLn(t, cNoPlugOp);
  ReadLn(t, cPlugOpReq);
  ReadLn(t, cNoAutoSetup1);
  ReadLn(t, cNoAutoSetup2);
  ReadLn(t, cPreparing);
  ReadLn(t, cForOp);
  ReadLn(t, cFailedRun);
  ReadLn(t, cFailedRun_);
  ReadLn(t, cArchiveOp);
  ReadLn(t, cStartOrFinish);
  ReadLn(t, cBadAV1);
  ReadLn(t, cBadAV2);
  ReadLn(t, cNoPlugAV);
  ReadLn(t, cPlugReqAV);
  ReadLn(t, cQuarantine);
  ReadLn(t, cVirusScan);
  ReadLn(t, cAV0);
  ReadLn(t, cAV1);
  ReadLn(t, cAV2);
  ReadLn(t, cAV3);
  ReadLn(t, cExtracting);
  ReadLn(t, cExtracted);
  ReadLn(t, cBadExtract);
  ReadLn(t, cCompressing);
  ReadLn(t, cCompressed);
  ReadLn(t, cFailConfComp);
  ReadLn(t, cFailConfExt);
  ReadLn(t, vasDec0);
  ReadLn(t, vasDec1);
  ReadLn(t, vasDec2);
  ReadLn(t, vasDec3);
  ReadLn(t, vasDec4);
  ReadLn(t, vasDec5);
  ReadLn(t, vasDec6);
  ReadLn(t, vasDec7);
  ReadLn(t, vasDec8);
  ReadLn(t, vasDec9);
  ReadLn(t, vasDec10);
  ReadLn(t, vasDec11);
  ReadLn(t, vasDecNoCodecs);
  ReadLn(t, vasDec12);
  ReadLn(t, vasDec13);
  ReadLn(t, vasDec14);
  ReadLn(t, vasDec15);
  ReadLn(t, vasDec16);
  ReadLn(t, vasDec17);
  ReadLn(t, vasDec18);
  ReadLn(t, vasDec19);
  ReadLn(t, vasDecProf0);
  ReadLn(t, vasDecProf1);
  ReadLn(t, vasDecProf2);
  ReadLn(t, vasDecProf3);
  ReadLn(t, vasProfileExists);
  ReadLn(t, vasNewProfile);
  ReadLn(t, cActionError);
  ReadLn(t, vasThread0);
  ReadLn(t, vasThread1);
  ReadLn(t, vasThread2);
  ReadLn(t, vasThread3);
  ReadLn(t, vasThread4);
  ReadLn(t, vasThread5);
  ReadLn(t, vasEncProf0);
  ReadLn(t, vasSearching);
  ReadLn(t, vasAVM0);
  ReadLn(t, vasAVM1);
  ReadLn(t, vasAVM2);
  ReadLn(t, vasAVM3);
  ReadLn(t, vasAVM4);
  ReadLn(t, vasAVM5);
  ReadLn(t, vasAVM6);
  ReadLn(t, vasAVM7);
  ReadLn(t, vasAVM8);
  ReadLn(t, vasAVM9);
  ReadLn(t, vasInst0);
  ReadLn(t, vasInst1);
  ReadLn(t, vasInst2);
  ReadLn(t, vasInst3);
  ReadLn(t, vasInst4);
  ReadLn(t, vasInst5);
  ReadLn(t, vasAntiVirus0);
  ReadLn(t, vasAntiVirus1);
  ReadLn(t, vasAntiVirus2);
  ReadLn(t, vasAntiVirus3);
  ReadLn(t, vasAntiVirus4);
  ReadLn(t, vasAntiVirus5);
  ReadLn(t, vasAntiVirus6);
  ReadLn(t, vasCheck0);
  ReadLn(t, vasCheck1);
  ReadLn(t, vasCheck2);
  ReadLn(t, vasCheck3);
  ReadLn(t, vasCheck4);
  ReadLn(t, vasCheck5);
  ReadLn(t, vasCheck6);
  ReadLn(t, vasCheck7);
  ReadLn(t, vasCheck8);
  ReadLn(t, vasCheck9);
  ReadLn(t, vasCheck10);
  ReadLn(t, vasCheck11);
  ReadLn(t, vasCheck12);
  ReadLn(t, vasCheck13);
  ReadLn(t, vasCheck14);
  ReadLn(t, vasCheck15);
  ReadLn(t, vasCheck16);
  ReadLn(t, vasCheck17);
  ReadLn(t, vasCheck18);
  ReadLn(t, vasFind0);
  ReadLn(t, vasFind1);
  ReadLn(t, vasFind2);
  ReadLn(t, vasFind3);
  ReadLn(t, vasFind4);
  ReadLn(t, vasFind5);
  ReadLn(t, vasConv0);
  ReadLn(t, vasConv1);
  ReadLn(t, vasConv2);
  ReadLn(t, vasConv3);
  ReadLn(t, vasConv4);
  ReadLn(t, vasConv5);
  ReadLn(t, vasConv6);
  ReadLn(t, vasConv7);
  ReadLn(t, vasConv8);
  ReadLn(t, vasConv9);
  ReadLn(t, vasConv10);
  ReadLn(t, vasConv11);
  ReadLn(t, vasConv12);
  ReadLn(t, vasConv13);
  ReadLn(t, vasConv14);
  ReadLn(t, vasConv15);
  ReadLn(t, vasConv16);
  ReadLn(t, vasConv17);
  ReadLn(t, vasMsgs0);
  ReadLn(t, vasMsgs1);
  ReadLn(t, vasMsgs2);
  ReadLn(t, vasMail0);
  ReadLn(t, vasMail1);
  ReadLn(t, vasMail2);
  ReadLn(t, vasEncList0);
  ReadLn(t, vasEncList1);
  ReadLn(t, mtvInsertVolume);
  ReadLn(t, mtvCorruptHeader);
  ReadLn(t, mtvGetFirstDisk);
  ReadLn(t, mtvGetLastDisk);
  ReadLn(t, mtvGetDiskVolume);
  ReadLn(t, mtvGetDiskNumber);
  ReadLn(t, mtvTestTitle);
  ReadLn(t, mtvTestDone);
  ReadLn(t, mtvPassword);
  ReadLn(t, mtvInsertVolumeCont);
  ReadLn(t, mtvCurrentArchive);
  ReadLn(t, mtvCurrentFile);
  ReadLn(t, mtvError);
  ReadLn(t, mtvMessage);
  ReadLn(t, mtvBadFile);
  ReadLn(t, mtvContinueTest);
  ReadLn(t, mtvArcHeaderBad);
  ReadLn(t, mtvExtract);
  ReadLn(t, mtvSetup);
  ReadLn(t, cDecryptPassword);
  ReadLn(t, cExtractNewFolder);
  ReadLn(t, mtvEXEError);
  Readln(t, mtvGZipMulti);
  ReadLn(t, cBadMulti);
  ReadLn(t, mtvGZipExists);
  ReadLn(t, cBadDelete);
  ReadLn(t, cCompressionCancelled);
  ReadLn(t, cHasOccured);
  ReadLn(t, cCompressionKind);
  ReadLn(t, cCompMax);
  ReadLn(t, cCompNorm);
  ReadLn(t, cCompFast);
  ReadLn(t, cCompSuper);
  ReadLn(t, cDelAfterComp);
  ReadLn(t, cDelete);
  ReadLn(t, mtvDiskError);
  ReadLn(t, mtvFormattedDisk);
  ReadLn(t, mtvClickOK);
  ReadLn(t, mtvWriteProtect);
  ReadLn(t, mtvRemoveWriteProtect);
  ReadLn(t, mtvGetDisk);
  ReadLn(t, mtvlPassword);
  ReadLn(t, mtvAlg);
  ReadLn(t, cSpan);
  ReadLn(t, cAction);
  ReadLn(t, mtvRarAct0);
  ReadLn(t, mtvRarAct1);
  ReadLn(t, mtvRarAct2);
  ReadLn(t, mtvRarAct3);
  ReadLn(t, cDefault);
  ReadLn(t, cMinMax);
  ReadLn(t, cFasterTighter);
  ReadLn(t, mtvCompLevel);
  ReadLn(t, mtvDictSize);
  ReadLn(t, mtvSolid);
  ReadLn(t, mtvSolidHint);
  ReadLn(t, cEncrypt);
  ReadLn(t, mtvRecoveryInfo);
  ReadLn(t, mtvMediaPrepare);
  ReadLn(t, mtvLeaveAsIs);
  ReadLn(t, mtvEraseAll);
  ReadLn(t, cMist);
  ReadLn(t, mtvEnableSpan);
  ReadLn(t, mtvSpanSetup);
  ReadLn(t, mtvSpanAuto);
  ReadLn(t, mtvSpanSize);
  ReadLn(t, cKB);
  ReadLn(t, mtvIndepSolid);
  ReadLn(t, mtvRarGraphWin);
  ReadLn(t, mtvRarWin);
  ReadLn(t, mtvRarDos);
  ReadLn(t, mtvRarOS2);
  ReadLn(t, mtvFileAbsent);
  ReadLn(t, mtvEXEMakerHint);
  ReadLn(t, mtvTest);
  ReadLn(t, mtvTestHint);
  ReadLn(t, mtvDelete);
  ReadLn(t, mtvDeleteHint);
  ReadLn(t, mtvLock);
  ReadLn(t, mtvLockHint);
  ReadLn(t, mtvProtect);
  ReadLn(t, mtvProtectHint);
  ReadLn(t, mtvTestAdv);
  ReadLn(t, mtvTestAdvHint);
  ReadLn(t, mtvEXEAdv);
  ReadLn(t, mtvEXEAdvHint);
  ReadLn(t, mtvComm);
  ReadLn(t, mtvCommHint);
  ReadLn(t, mtvRepair);
  ReadLn(t, mtvRepairHint);
  ReadLn(t, mtvPass);
  ReadLn(t, mtvPassHint);
  ReadLn(t, cComments);
  ReadLn(t, cCommentsHint);
  ReadLn(t, cRepair);
  ReadLn(t, mtvRarRepair0);
  ReadLn(t, mtvRarRepair1);
  ReadLn(t, mtvRarRepair2);
  ReadLn(t, cRepairHint);
  ReadLn(t, cRepairProgress);
  ReadLn(t, mtvRarRepair3);
  ReadLn(t, cFile);
  ReadLn(t, cRepaired);
  ReadLn(t, mtvRepairHigh);
  ReadLn(t, mtvRepairLow);
  ReadLn(t, mtvAce0);
  ReadLn(t, mtvAce1);
  ReadLn(t, mtvAce2);
  ReadLn(t, mtvAce3);
  ReadLn(t, mtvAce4);
  ReadLn(t, mtvAce5);
  ReadLn(t, mtvAceRepair0);
  ReadLn(t, mtvAceRepair1);
  ReadLn(t, mtvAceRepair2);
  ReadLn(t, mtvAceRepair3);
  ReadLn(t, mtvAceRepair4);
  ReadLn(t, mtvAceRepair5);
  ReadLn(t, cExtract);
  ReadLn(t, mtvAceEx0);
  ReadLn(t, mtvAceEx1);
  ReadLn(t, mtvAceEx2);
  ReadLn(t, mtvAceEx3);
  ReadLn(t, mtvAceEx4);
  ReadLn(t, mtvAceEx5);
  ReadLn(t, mtvAceEx6);
  ReadLn(t, mtvAceEx7);
  ReadLn(t, mtvAceEx8);
  ReadLn(t, mtvAceEx9);
  ReadLn(t, mtvAceEx10);
  ReadLn(t, mtvAceEx11);
  ReadLn(t, mtvAceEx12);
  ReadLn(t, mtvAceEx13);
  ReadLn(t, mtvAceEx14);
  ReadLn(t, mtvAceEx15);
  ReadLn(t, mtvAceEx16);
  ReadLn(t, mtvAceEx17);
  ReadLn(t, mtvAceEx18);
  ReadLn(t, mtvAceEx19);
  ReadLn(t, mtvAceEx20);
  ReadLn(t, mtvAceEx21);
  ReadLn(t, mtvAceEx22);
  ReadLn(t, mtvAceEx23);
  ReadLn(t, mtvAceEx24);
  ReadLn(t, mtvAceEx25);
  ReadLn(t, mtvAceEx26);
  ReadLn(t, mtvAceEx27);
  ReadLn(t, mtvAceEx28);
  ReadLn(t, mtvAceEx29);
  ReadLn(t, mtvAceEx30);
  ReadLn(t, mtvAceEx31);
  ReadLn(t, mtvAceEx32);
  ReadLn(t, mtvAceEx33);
  ReadLn(t, mtvAceEx34);
  ReadLn(t, mtvAceEx35);
  ReadLn(t, mtvAceEx36);
  ReadLn(t, mtvAceEx37);
  ReadLn(t, mtvZipFix0);
  ReadLn(t, mtvZipFix1);
  ReadLn(t, mtvZipFix2);
  ReadLn(t, mtvZipFix3);
  ReadLn(t, mtvZipFix4);
  ReadLn(t, mtvZipFix5);
  ReadLn(t, mtvZipFix6);
  ReadLn(t, mtvZipFix7);
  ReadLn(t, mtvZipFix8);
  ReadLn(t, mtvZipFix9);
  ReadLn(t, mtvZipFix10);
  ReadLn(t, mtvZipFix11);
  ReadLn(t, mtvZipFix12);
  ReadLn(t, mtvZipPass0);
  ReadLn(t, mtvZipPass1);
  ReadLn(t, mtvZipPass2);
  ReadLn(t, mtvZipPass3);
  ReadLn(t, mtvZipPass4);
  ReadLn(t, mtvZipPass5);
  ReadLn(t, mtvZipPass6);
  ReadLn(t, mtvZipPass7);
  ReadLn(t, mtvZipPass8);
  ReadLn(t, mtvZipPass9);
  ReadLn(t, mtvZipPass10);
  ReadLn(t, mtvZipPass11);
  ReadLn(t, mtvZipPass12);
  ReadLn(t, mtvZipPass13);
  ReadLn(t, mtvZipPass14);
  ReadLn(t, mtvZipPass15);
  ReadLn(t, mtvZipPass16);
  ReadLn(t, mtvZipPass17);
  ReadLn(t, cStop);
  ReadLn(t, mtvZipPass18);
  ReadLn(t, mtvZipPass19);
  ReadLn(t, mtvZipPass20);
  ReadLn(t, mtvZipFix13);
  ReadLn(t, mtvContOp);
  ReadLn(t, mtvGenFail);
  ReadLn(t, mtvDecode0);
  ReadLn(t, mtvDecode1);
  ReadLn(t, mtvDecode2);
  ReadLn(t, coxMenu0);
  ReadLn(t, coxMenu1);
  ReadLn(t, coxMenu2);
  ReadLn(t, coxMenu3);
  ReadLn(t, coxMenu4);
  ReadLn(t, coxMenu5);
  ReadLn(t, coxMenu6);
  ReadLn(t, coxMenu7);
  ReadLn(t, coxMenu8);
  ReadLn(t, coxMenu9);
  ReadLn(t, coxMenu10);
  ReadLn(t, coxMenu11);
  ReadLn(t, coxMenu12);
  ReadLn(t, coxMenu13);
  ReadLn(t, coxMenu14);
  ReadLn(t, coxMenu15);
  ReadLn(t, coxMenu16);
  ReadLn(t, coxMenu17);
  ReadLn(t, coxMenu18);
  ReadLn(t, coxMenu19);
  ReadLn(t, coxMenu20);
  ReadLn(t, coxMenu21);
  ReadLn(t, coxMenu22);
  ReadLn(t, coxMenu23);
  ReadLn(t, coxMenu24);
  ReadLn(t, coxMenu25);
  ReadLn(t, coxMenu26);
  ReadLn(t, coxMenu27);
  ReadLn(t, coxMenu28);
  ReadLn(t, coxMenu29);
  ReadLn(t, coxMenu30);
  ReadLn(t, coxMenu31);
  ReadLn(t, coxMenu32);
  ReadLn(t, coxMenu33);
  ReadLn(t, coxMenu34);
  ReadLn(t, coxPlugBeg);
  ReadLn(t, coxMenu35);
  ReadLn(t, coxMenu36);
  ReadLn(t, coxMenu37);
  ReadLn(t, coxTool0);
  ReadLn(t, coxTool1);
  ReadLn(t, coxTool2);
  ReadLn(t, coxTool3);
  ReadLn(t, coxTool4);
  ReadLn(t, coxTool5);
  ReadLn(t, coxTool6);
  ReadLn(t, coxTool7);
  ReadLn(t, coxList0);
  ReadLn(t, coxList1);
  ReadLn(t, coxList2);
  ReadLn(t, coxList3);
  ReadLn(t, coxList4);
  ReadLn(t, coxList5);
  ReadLn(t, coxList6);
  ReadLn(t, coxDlg0);
  ReadLn(t, coxDlg1);
  ReadLn(t, coxDlg2);
  ReadLn(t, coxAlt0);
  ReadLn(t, coxTool8);
  ReadLn(t, coxAlt1);
  ReadLn(t, coxAlt2);
  ReadLn(t, coxAlt3);
  ReadLn(t, coxAlt4);
  ReadLn(t, coxAlt5);
  ReadLn(t, coxAlt6);
  ReadLn(t, coxAlt7);
  ReadLn(t, coxAlt8);
  ReadLn(t, coxAlt9);
  ReadLn(t, coxAlt10);
  ReadLn(t, coxAlt11);
  ReadLn(t, coxAlt12);
  ReadLn(t, coxMap0);
  ReadLn(t, coxMap1);
  ReadLn(t, coxAdd0);
  ReadLn(t, coxAdd1);
  ReadLn(t, coxAdd2);
  ReadLn(t, coxAdd3);
  ReadLn(t, coxAdd4);
  ReadLn(t, coxAdd5);
  ReadLn(t, coxAdd6);
  ReadLn(t, coxAdd7);
  ReadLn(t, coxAdd8);
  ReadLn(t, coxEx0);
  ReadLn(t, coxEx1);
  ReadLn(t, coxEx2);
  ReadLn(t, coxEx3);
  ReadLn(t, coxEx4);
  ReadLn(t, coxEx5);
  ReadLn(t, coxEx6);
  ReadLn(t, coxEx7);
  ReadLn(t, coxEx8);
  ReadLn(t, coxEx9);
  ReadLn(t, coxEx10);
  ReadLn(t, coxEx11);
  ReadLn(t, coxOut0);
  ReadLn(t, coxOut1);
  ReadLn(t, coxOut2);
  ReadLn(t, coxOut3);
  ReadLn(t, coxOut4);
  ReadLn(t, coxOut5);
  ReadLn(t, coxOut6);
  ReadLn(t, coxOut7);
  ReadLn(t, coxChk0);
  ReadLn(t, coxChk1);
  ReadLn(t, coxChk2);
  ReadLn(t, coxChk3);
  ReadLn(t, coxChk4);
  ReadLn(t, coxChk5);
  ReadLn(t, coxChk6);
  ReadLn(t, coxChk7);
  ReadLn(t, coxChk8);
  ReadLn(t, coxChk9);
  ReadLn(t, coxMail0);
  ReadLn(t, coxMail1);
  ReadLn(t, coxMail2);
  ReadLn(t, coxConf0);
  ReadLn(t, coxConf1);
  ReadLn(t, coxConf2);
  ReadLn(t, coxConf3);
  ReadLn(t, coxConf4);
  ReadLn(t, coxConf5);
  ReadLn(t, coxConf6);
  ReadLn(t, coxConf7);
  ReadLn(t, coxConf8);
  ReadLn(t, coxConf9);
  ReadLn(t, coxConf10);
  ReadLn(t, coxConf11);
  ReadLn(t, coxConf12);
  ReadLn(t, coxConf13);
  ReadLn(t, coxConf14);
  ReadLn(t, coxConf15);
  ReadLn(t, coxConf16);
  ReadLn(t, coxConf17);
  ReadLn(t, coxConf18);
  ReadLn(t, coxConf19);
  ReadLn(t, coxConf20);
  ReadLn(t, coxConf21);
  ReadLn(t, coxConf22);
  ReadLn(t, coxConf23);
  ReadLn(t, coxConf24);
  ReadLn(t, coxConf25);
  ReadLn(t, coxConf26);
  ReadLn(t, coxConf27);
  ReadLn(t, coxConf28);
  ReadLn(t, coxConf29);
  ReadLn(t, coxConf30);
  ReadLn(t, coxConf31);
  ReadLn(t, coxConf32);
  ReadLn(t, coxConf33);
  ReadLn(t, coxConf34);
  ReadLn(t, coxConf35);
  ReadLn(t, coxConf36);
  ReadLn(t, coxConf37);
  ReadLn(t, coxConf38);
  ReadLn(t, coxConf39);
  ReadLn(t, coxConf40);
  ReadLn(t, coxConf41);
  ReadLn(t, coxConf42);
  ReadLn(t, coxConf43);
  ReadLn(t, coxConf44);
  ReadLn(t, coxConf45);
  ReadLn(t, coxConf46);
  ReadLn(t, coxConf47);
  ReadLn(t, coxConf48);
  ReadLn(t, coxConf49);
  ReadLn(t, shExt0);
  ReadLn(t, shExt1);
  ReadLn(t, shExt2);
  ReadLn(t, shExt3);
  ReadLn(t, shExt4);
  ReadLn(t, shExt5);
  ReadLn(t, shExt6);
  ReadLn(t, shComp0);
  ReadLn(t, shComp1);
  ReadLn(t, shComp2);
  ReadLn(t, shComp3);
  ReadLn(t, shComp4);
  ReadLn(t, shComp5);
  ReadLn(t, shComp6);
  ReadLn(t, shComp7);
  ReadLn(t, shComp8);
  ReadLn(t, shComp9);
  ReadLn(t, shComp10);
  ReadLn(t, shComp11);
  ReadLn(t, shProf0);
  ReadLn(t, shProf1);
  ReadLn(t, shProf2);
  ReadLn(t, shProf3);
  ReadLn(t, shProf4);
  ReadLn(t, shProf5);
  ReadLn(t, shProf6);
  ReadLn(t, shProf7);
  ReadLn(t, shProf8);
  ReadLn(t, shProf9);
  ReadLn(t, shProf10);
  ReadLn(t, shProf11);
  ReadLn(t, shProf12);
  ReadLn(t, shProf13);
  ReadLn(t, shProf14);
  ReadLn(t, shProf15);
  ReadLn(t, shProf16);
  ReadLn(t, shProf17);
  ReadLn(t, shProf18);
  ReadLn(t, shProf19);
  ReadLn(t, shProf20);
  ReadLn(t, shProf21);
  ReadLn(t, shProf22);
  ReadLn(t, shProf23);
  ReadLn(t, shProf24);
  ReadLn(t, shProf25);
  ReadLn(t, shProf26);
  ReadLn(t, shProf27);
  ReadLn(t, shProf28);
  ReadLn(t, shProf29);
  ReadLn(t, shProf30);
  ReadLn(t, shProf31);
  ReadLn(t, shEnc0);
  ReadLn(t, shEnc1);
  ReadLn(t, shEnc2);
  ReadLn(t, shEnc3);
  ReadLn(t, shEnc4);
  ReadLn(t, shEnc5);
  ReadLn(t, shEnc6);
  ReadLn(t, shEnc7);
  ReadLn(t, shEnc8);
  ReadLn(t, shEnc9);
  ReadLn(t, shEnc10);
  ReadLn(t, shEnc11);
  ReadLn(t, shEnc12);
  ReadLn(t, shEnc13);
  ReadLn(t, shEnc14);
  ReadLn(t, shEnc15);
  ReadLn(t, shEnc16);
  ReadLn(t, shEnc17);
  ReadLn(t, shCut0);
  ReadLn(t, shCut1);
  ReadLn(t, shCut2);
  ReadLn(t, shCut3);
  ReadLn(t, shCut4);
  ReadLn(t, shCut5);
  ReadLn(t, shCut6);
  ReadLn(t, shCut7);
  ReadLn(t, shCut8);
  ReadLn(t, shIcons);
  ReadLn(t, shView0);
  ReadLn(t, shView1);
  ReadLn(t, shView2);
  ReadLn(t, shView3);
  ReadLn(t, shSamp0);
  ReadLn(t, shSamp1);
  ReadLn(t, shSamp2);
  ReadLn(t, shSamp3);
  ReadLn(t, shSamp4);
  ReadLn(t, shSamp5);
  ReadLn(t, shSamp6);
  ReadLn(t, shSamp7);
  ReadLn(t, shSamp8);
  ReadLn(t, shSamp9);
  ReadLn(t, shSamp10);
  ReadLn(t, shSamp11);
  ReadLn(t, shSamp12);
  ReadLn(t, shSamp13);
  ReadLn(t, shSamp14);
  ReadLn(t, shSamp15);
  ReadLn(t, shSamp16);
  ReadLn(t, shSamp17);
  ReadLn(t, shSamp18);
  ReadLn(t, shSamp19);
  ReadLn(t, shSamp20);
  ReadLn(t, shSamp21);
  ReadLn(t, shSamp22);
  ReadLn(t, shSamp23);
  ReadLn(t, shSamp24);
  ReadLn(t, shSamp25);
  ReadLn(t, cpl0);
  ReadLn(t, cpl1);
  ReadLn(t, cpl2);
  ReadLn(t, cpl3);
  ReadLn(t, cpl4);
  ReadLn(t, cpl5);
  ReadLn(t, cpl6);
  ReadLn(t, cpl7);
  ReadLn(t, stub0);
  ReadLn(t, stub1);
  ReadLn(t, stub2);
  ReadLn(t, stub3);
  ReadLn(t, stub4);
  ReadLn(t, stub5);
  ReadLn(t, stub6);
  ReadLn(t, stub7);
  ReadLn(t, stub8);
  ReadLn(t, stub9);
  ReadLn(t, stub10);
  ReadLn(t, stub11);
  ReadLn(t, stub12);
  ReadLn(t, cInternal);
  ReadLn(t, cBadDir);
  ReadLn(t, cLock);
  ReadLn(t, cProtect);
  ReadLn(t, szdd0);
  ReadLn(t, szdd1);
  ReadLn(t, szdd2);
  ReadLn(t, szdd3);
  ReadLn(t, szdd4);
  ReadLn(t, szdd5);
  ReadLn(t, szdd6);
  ReadLn(t, szdd7);
  ReadLn(t, szdd8);
  ReadLn(t, szdd9);
  ReadLn(t, szdd10);
  ReadLn(t, lib0);
  ReadLn(t, lib1);
  ReadLn(t, lib2);
  ReadLn(t, lib3);
  ReadLn(t, lib4);
  ReadLn(t, lib5);
  ReadLn(t, lib6);
  ReadLn(t, lib7);
  ReadLn(t, cProfile);
  ReadLn(t, lib8);
  ReadLn(t, lib9);
  ReadLn(t, lib10);
  ReadLn(t, lib11);
  ReadLn(t, lib12);
  ReadLn(t, lib13);
  ReadLn(t, lib14);
  ReadLn(t, lib15);
  ReadLn(t, lib16);
  ReadLn(t, lib17);
  ReadLn(t, api0);
  ReadLn(t, api1);
  ReadLn(t, api2);
  ReadLn(t, api3);
  ReadLn(t, api4);
  ReadLn(t, api5);
  ReadLn(t, api6);
  ReadLn(t, api7);
  ReadLn(t, apiExtract);
  ReadLn(t, apiExtractHere);
  ReadLn(t, apiExtractFolder);
  ReadLn(t, apiNoOpen);
  ReadLn(t, apiReInstall);
  ReadLn(t, apiExtractHint);
  ReadLn(t, apiExtractHereHint);
  ReadLn(t, apiExtractFolderHint);
  ReadLn(t, apiCompress);
  ReadLn(t, apiCompressNow);
  ReadLn(t, apiCompressEmail);
  ReadLn(t, apiCompressHint);
  ReadLn(t, apiCompressNowHint);
  ReadLn(t, apiCompressShellHint);
  ReadLn(t, apiCompressEmailHint);
  ReadLn(t, api8);
  ReadLn(t, api9);
  ReadLn(t, api10);
  ReadLn(t, api11);
  ReadLn(t, api12);
  ReadLn(t, api13);
  ReadLn(t, api14);
  ReadLn(t, api15);
  ReadLn(t, api16);
  ReadLn(t, api17);
  ReadLn(t, api18);
  ReadLn(t, api19);
  ReadLn(t, api20);
  ReadLn(t, api21);
  ReadLn(t, api22);
  ReadLn(t, api23);
  ReadLn(t, api24);
  ReadLn(t, api25);
  ReadLn(t, api26);
  ReadLn(t, api27);
  ReadLn(t, api28);
  ReadLn(t, api29);
  ReadLn(t, api30);
  ReadLn(t, api31);
  ReadLn(t, api32);
  ReadLn(t, api33);
  ReadLn(t, api34);
  ReadLn(t, api35);
  ReadLn(t, api36);
  ReadLn(t, api37);
  ReadLn(t, api38);
  ReadLn(t, api39);
  ReadLn(t, api40);
  ReadLn(t, api41);
  ReadLn(t, api42);
  ReadLn(t, api43);
  ReadLn(t, apiSheet0);
  ReadLn(t, apiSheet1);
  ReadLn(t, apiSheet2);
  ReadLn(t, apiSheet3);
  ReadLn(t, apiSheet4);
  ReadLn(t, apiSheet5);
  ReadLn(t, apiSheet6);
  ReadLn(t, apiSheet7);
  ReadLn(t, apiSheet8);
  ReadLn(t, apiSheet9);
  ReadLn(t, apiAbout0);
  ReadLn(t, apiAbout1);
  ReadLn(t, apiAbout2);
  ReadLn(t, apiAbout3);
  ReadLn(t, apiTip0);
  ReadLn(t, apiTip1);
  ReadLn(t, apiTip2);
  ReadLn(t, apiTip3);
  ReadLn(t, apiTip4);
  ReadLn(t, apiTip5);
  ReadLn(t, apiTip6);
  ReadLn(t, apiTip7);
  ReadLn(t, apiTip8);
  ReadLn(t, apiTip9);
  ReadLn(t, apiTip10);
  ReadLn(t, apiTip11);
  ReadLn(t, apiTip12);
  ReadLn(t, apiTip13);
  ReadLn(t, apiTip14);
  ReadLn(t, apiLic0);
  ReadLn(t, apiLic1);
  ReadLn(t, apiLic2);
  ReadLn(t, apiLic3);
  ReadLn(t, apiLic4);
  ReadLn(t, apiLic5);
  ReadLn(t, apiLic6);
  ReadLn(t, apiLic7);
  ReadLn(t, apiLic8);
  ReadLn(t, apiLic9);
  ReadLn(t, apiLic10);
  ReadLn(t, apiLic11);
  ReadLn(t, apiLic12);
  ReadLn(t, apiLic13);
  ReadLn(t, apiLic14);
  ReadLn(t, apiLic15);
  ReadLn(t, apiLic16);
  ReadLn(t, apiLic17);
  ReadLn(t, apiLic18);
  ReadLn(t, sz0);
  ReadLn(t, sz1);
  ReadLn(t, sz2);
  ReadLn(t, sz3);
  ReadLn(t, sz4);
  ReadLn(t, sz5);
  ReadLn(t, sz6);
  ReadLn(t, sz7);
  ReadLn(t, sz8);
  ReadLn(t, sz9);
  ReadLn(t, sz10);
  ReadLn(t, sz11);
  ReadLn(t, sz12);
  ReadLn(t, sz13);
  ReadLn(t, sz14);
  ReadLn(t, sz15);
  ReadLn(t, sz16);
  ReadLn(t, sz17);
  ReadLn(t, sz18);
  ReadLn(t, sz19);
  ReadLn(t, sz20);
  ReadLn(t, sz21);
  ReadLn(t, sz22);
  ReadLn(t, sz23);
  ReadLn(t, szTimeCritical);
  ReadLn(t, szHigh);
  ReadLn(t, szNormal);
  ReadLn(t, szIdle);
  ReadLn(t, szInteract);
  ReadLn(t, szYesToAll);
  ReadLn(t, szYes);
  ReadLn(t, szNo);
  ReadLn(t, szStore);
  ReadLn(t, szMaximum);
  ReadLn(t, szCustom);
  ReadLn(t, szOff);
  ReadLn(t, szOn);
  ReadLn(t, szNone);
  ReadLn(t, szBinary2);
  ReadLn(t, szBinary23);
  ReadLn(t, szBinary234);
  ReadLn(t, szBinary234Big);
  ReadLn(t, szPat2Remove);
  ReadLn(t, szPat2);
  ReadLn(t, szPat23);
  ReadLn(t, szPat3);
  ReadLn(t, szPat4);
  ReadLn(t, szHash23);
  ReadLn(t, szHash234);
  ReadLn(t, szBCJ);
  ReadLn(t, szBCJ2);
  ReadLn(t, szPriority);
  ReadLn(t, szUserMode);
  ReadLn(t, szMist);
  ReadLn(t, szStrength);
  ReadLn(t, szDeflateFastBytes);
  ReadLn(t, szDeflatePasses);
  ReadLn(t, szSolid);
  ReadLn(t, szHeader);
  ReadLn(t, szAlg);
  ReadLn(t, szLZMADict);
  ReadLn(t, szLZMAMatch);
  ReadLn(t, szLZMAFastBytes);
  ReadLn(t, szPPMdMemory);
  ReadLn(t, szPPMdModel);
  ReadLn(t, szConverter);
  ReadLn(t, szBCJ21);
  ReadLn(t, szBCJ22);
  ReadLn(t, sz24);
  ReadLn(t, sz25);
  ReadLn(t, sz26);
  ReadLn(t, sz27);
  ReadLn(t, sz28);
  ReadLn(t, sz29);
  ReadLn(t, sz30);
  ReadLn(t, sz31);
  ReadLn(t, sz32);
  ReadLn(t, qs0);
  ReadLn(t, qs1);
  ReadLn(t, qsNew);
  ReadLn(t, qsAdd);
  ReadLn(t, qsExtract);
  ReadLn(t, qsView1);
  ReadLn(t, qsView2);
  ReadLn(t, qsInfo);
  ReadLn(t, qsView);
  ReadLn(t, qs2);
  ReadLn(t, cPortionsBy);
  ReadLn(t, ult0);
  ReadLn(t, ult1);
  ReadLn(t, ult2);
  ReadLn(t, ult3);
  ReadLn(t, ult4);
  ReadLn(t, ult5);
  ReadLn(t, ult6);
  ReadLn(t, ult7);
  ReadLn(t, ult8);
  ReadLn(t, ult9);
  ReadLn(t, ult10);
  ReadLn(t, ult11);
  ReadLn(t, ult12);
  ReadLn(t, ult13);
  ReadLn(t, ult14);
  ReadLn(t, ult15);
  ReadLn(t, ult16);
  ReadLn(t, ult17);
  ReadLn(t, ult18);
  ReadLn(t, ult19);
  ReadLn(t, ult20);
  ReadLn(t, ult21);
  ReadLn(t, ult22);
  ReadLn(t, ult23);
  ReadLn(t, ult24);
  ReadLn(t, ult25);
  ReadLn(t, ult26);
  ReadLn(t, ult27);
  ReadLn(t, ult28);
  ReadLn(t, ult29);
  ReadLn(t, ult30);
  ReadLn(t, ult31);
  ReadLn(t, ult32);
  ReadLn(t, ult33);
  ReadLn(t, ult34);
  ReadLn(t, ult35);
  ReadLn(t, ult36);
  ReadLn(t, ult37);
  ReadLn(t, ult38);
  ReadLn(t, ult39);
  ReadLn(t, ult40);
  ReadLn(t, ult41);
  ReadLn(t, ult42);
  ReadLn(t, ult43);
  ReadLn(t, ult44);
  ReadLn(t, ult45);
  ReadLn(t, ult46);
  ReadLn(t, ult47);
  ReadLn(t, ult48);
  ReadLn(t, ult49);
  ReadLn(t, ult50);
  ReadLn(t, ult51);
  ReadLn(t, ult52);
  ReadLn(t, ult53);
  ReadLn(t, ult54);
  ReadLn(t, ult55);
  ReadLn(t, ultFolder);
  ReadLn(t, ult56);
  ReadLn(t, ult57);
  ReadLn(t, ult58);
  ReadLn(t, ult59);
  ReadLn(t, ult60);
  ReadLn(t, ult61);
  ReadLn(t, ult62);
  ReadLn(t, ult63);
  ReadLn(t, ult64);
  ReadLn(t, ult65);
  ReadLn(t, ult66);
  ReadLn(t, ult67);
  ReadLn(t, ult68);
  ReadLn(t, ult69);
  ReadLn(t, ult70);
  ReadLn(t, ult71);
  ReadLn(t, ult72);
  ReadLn(t, ult73);
  ReadLn(t, ult74);
  ReadLn(t, ult75);
  ReadLn(t, ult76);
  ReadLn(t, ult77);
  ReadLn(t, ult78);
  ReadLn(t, sz33);
  ReadLn(t, sz34);
  ReadLn(t, cw0);
  ReadLn(t, cw1);
  ReadLn(t, cw2);
  ReadLn(t, cw3);
  ReadLn(t, api44);
  ReadLn(t, api45);
  ReadLn(t, api46);
  ReadLn(t, api47);
  ReadLn(t, api48);
  ReadLn(t, vasMiss0);
  ReadLn(t, cCodexUnableToOpen);
  ReadLn(t, cIllustration);
  ReadLn(t, cNoArchivable);
  ReadLn(t, ult79);
  ReadLn(t, apiLic19);
  ReadLn(t, apiLic20);
  ReadLn(t, apiLic21);
  ReadLn(t, apiLic22);
  ReadLn(t, apiLic23);
  ReadLn(t, apiLic24);
  ReadLn(t, apiLic25);
  ReadLn(t, cTipCaption);
  ReadLn(t, cTipTitle);
  ReadLn(t, cTipShow);
  ReadLn(t, cTipNext);
  ReadLn(t, cVAS);
  ReadLn(t, cWinCox);
  ReadLn(t, cQComp);
  ReadLn(t, cQDec);
  ReadLn(t, cUltra);
  ReadLn(t, szPassword);
  ReadLn(t, wa0);
  ReadLn(t, wa1);
  ReadLn(t, wa2);
  ReadLn(t, wa3);
  ReadLn(t, wa4);
  ReadLn(t, wa5);
  ReadLn(t, wa6);
  ReadLn(t, wa7);
  ReadLn(t, wa8);
  ReadLn(t, wa9);
  ReadLn(t, wa10);
  ReadLn(t, wa11);
  ReadLn(t, wa12);
  ReadLn(t, wa13);
  ReadLn(t, wa14);
  ReadLn(t, wa15);
  ReadLn(t, wa16);
  ReadLn(t, wa17);
  ReadLn(t, wa18);
  ReadLn(t, wa19);
  ReadLn(t, wa20);
  ReadLn(t, wa21);
  ReadLn(t, wa22);
  ReadLn(t, wa23);
  ReadLn(t, wa24);
  ReadLn(t, wa25);
  ReadLn(t, wa26);
  ReadLn(t, wa27);
  ReadLn(t, wa28);
  ReadLn(t, wa29);
  ReadLn(t, wa30);
  ReadLn(t, wa31);
  ReadLn(t, wa32);
  ReadLn(t, wa33);
  ReadLn(t, wa34);
  ReadLn(t, wa35);
  ReadLn(t, wa36);
  ReadLn(t, wa37);
  ReadLn(t, wa38);
  ReadLn(t, wa39);
  ReadLn(t, wa40);
  ReadLn(t, wa41);
  ReadLn(t, wa42);
  ReadLn(t, wa43);
  ReadLn(t, wa44);
  ReadLn(t, wa45);
  ReadLn(t, wa46);
  ReadLn(t, wa47);
  ReadLn(t, wa48);
  ReadLn(t, wa49);
  ReadLn(t, wa50);
  ReadLn(t, wa51);
  ReadLn(t, wa52);
  ReadLn(t, wa53);
  ReadLn(t, wa54);
  ReadLn(t, wa55);
  ReadLn(t, oa0);
  ReadLn(t, oa1);
  ReadLn(t, oa2);
  ReadLn(t, oa3);
  ReadLn(t, oa4);
  ReadLn(t, oa5);
  ReadLn(t, oa6);
  ReadLn(t, oa7);
  ReadLn(t, oa8);
  ReadLn(t, oa9);
  ReadLn(t, oa10);
  ReadLn(t, oa11);
  ReadLn(t, oa12);
  ReadLn(t, oa13);
  ReadLn(t, oa14);
  ReadLn(t, oa15);
  ReadLn(t, oa16);
  ReadLn(t, oa17);
  ReadLn(t, oa18);
  ReadLn(t, oa19);
  ReadLn(t, oa20);
  ReadLn(t, oa21);
  ReadLn(t, oa22);
  ReadLn(t, oa23);
  ReadLn(t, oa24);
  ReadLn(t, oa25);
  ReadLn(t, oa26);
  ReadLn(t, oa27);
  ReadLn(t, oa28);
  ReadLn(t, oa29);
  ReadLn(t, oa30);
  ReadLn(t, oa31);
  ReadLn(t, oa32);
  ReadLn(t, oa33);
  ReadLn(t, oa34);
  ReadLn(t, oa35);
  ReadLn(t, oa36);
  ReadLn(t, re0);
  ReadLn(t, re1);
  ReadLn(t, re2);
  ReadLn(t, re3);
  ReadLn(t, re4);
  ReadLn(t, re5);
  ReadLn(t, re6);
  ReadLn(t, re7);
  ReadLn(t, re8);
  ReadLn(t, cEdit);
  ReadLn(t, cCopy);
  ReadLn(t, cPaste);
  ReadLn(t, cCopyHint);
  ReadLn(t, cPasteHint);
  ReadLn(t, mtvSplitZip);
  ReadLn(t, mtvSplitZipHint);
  ReadLn(t, cSplit);
  ReadLn(t, mtvSplitZip0);
  ReadLn(t, mtvSplitZip1);
  ReadLn(t, mtvSplitZip2);
  ReadLn(t, mtvSplitZip3);
  ReadLn(t, mtvSplitZip4);
  ReadLn(t, mtvSplitZip5);
  ReadLn(t, mtvSplitZip6);
  ReadLn(t, mtvSplitZip7);
  ReadLn(t, mtvSplitZip8);
  ReadLn(t, mtvSplitZip9);
  ReadLn(t, mtvSplitZip10);
  ReadLn(t, mtvSplitZip11);
  ReadLn(t, mtvSplitZip12);
  ReadLn(t, mtvSplitZip13);
  ReadLn(t, mtvSplitZip14);
  ReadLn(t, cInvalidSplitSize);
  ReadLn(t, mtvSplitZip15);
  ReadLn(t, cOnlineUpdate);
  ReadLn(t, oOpenArchive);
  ReadLn(t, oNewArchive);
  ReadLn(t, oRecommend);
  ReadLn(t, oOther);
  ReadLn(t, oDescription);
  ReadLn(t, oArchiveType);
  ReadLn(t, oByPlugIn);
  ReadLn(t, cD1);
  ReadLn(t, cD2);
  ReadLn(t, cD3);
  ReadLn(t, cD4);
  ReadLn(t, cD5);
  ReadLn(t, cD6);
  ReadLn(t, cD7);
  ReadLn(t, cD8);
  ReadLn(t, cD9);
  ReadLn(t, cD10);
  ReadLn(t, cD11);
  ReadLn(t, cD12);
  ReadLn(t, cD13);
  ReadLn(t, cD14);
  ReadLn(t, cD15);
  ReadLn(t, cD16);
  ReadLn(t, cD17);
  ReadLn(t, cD18);
  ReadLn(t, cD19);
  ReadLn(t, cD20);
  ReadLn(t, cD21);
  ReadLn(t, cD22);
  ReadLn(t, cD23);
  ReadLn(t, cD24);
  ReadLn(t, cD25);
  ReadLn(t, cD26);
  ReadLn(t, cD27);
  ReadLn(t, cD28);
  ReadLn(t, cD29);
  ReadLn(t, cD30);
  ReadLn(t, cD31);
  ReadLn(t, cD32);
  ReadLn(t, cD33);
  ReadLn(t, cD34);
  ReadLn(t, cD35);
  ReadLn(t, cD36);
  ReadLn(t, cD37);
  ReadLn(t, cD38);
  ReadLn(t, cD39);
  ReadLn(t, cD40);
  ReadLn(t, cD41);
  ReadLn(t, cD42);
  ReadLn(t, cD43);
  ReadLn(t, cD44);
  ReadLn(t, cD45);
  ReadLn(t, cD46);
  ReadLn(t, cD47);
  ReadLn(t, oNewDefaultName);
  ReadLn(t, oNewReadmeText);
  ReadLn(t, oNewReadmeFile);
  ReadLn(t, cplCaption);
  ReadLn(t, cplHelpText);
  ReadLn(t, cplContext);
  ReadLn(t, shCont0);
  ReadLn(t, shCont1);
  ReadLn(t, shCont2);
  ReadLn(t, shCont3);
  ReadLn(t, shCont4);
  ReadLn(t, shCont5);
  ReadLn(t, shCont6);
  ReadLn(t, shCont7);
  ReadLn(t, shCont8);
  ReadLn(t, shCont9);
  ReadLn(t, shCont10);
  ReadLn(t, cplCodex);
  ReadLn(t, vasCntxMenu);
  ReadLn(t, vasCntxMenuHint);
  ReadLn(t, oaAutoOn);
  ReadLn(t, oaAutoOff);
  ReadLn(t, sqPass0);
  ReadLn(t, sqPass1);
  ReadLn(t, sqPass2);
  ReadLn(t, sqPass3);
  ReadLn(t, sqPass4);
  ReadLn(t, sqErr0);
  ReadLn(t, sqErr1);
  ReadLn(t, sqErr2);
  ReadLn(t, sqErr3);
  ReadLn(t, sqErr4);
  ReadLn(t, sqErr5);
  ReadLn(t, sqErr6);
  ReadLn(t, sqErr7);
  ReadLn(t, sqErr8);
  ReadLn(t, sqErr9);
  ReadLn(t, sqErr10);
  ReadLn(t, sqErr11);
  ReadLn(t, sqErr12);
  ReadLn(t, sqErr13);
  ReadLn(t, sqErr14);
  ReadLn(t, sqErr15);
  ReadLn(t, sqErr16);
  ReadLn(t, sqErr17);
  ReadLn(t, sqErr18);
  ReadLn(t, sqErr19);
  ReadLn(t, sqErr20);
  ReadLn(t, sqErr21);
  ReadLn(t, sqErr22);
  ReadLn(t, sqErr23);
  ReadLn(t, sqErr24);
  ReadLn(t, sqErr25);
  ReadLn(t, sqErr26);
  ReadLn(t, sqErr27);
  ReadLn(t, sqErr28);
  ReadLn(t, sqErr29);
  ReadLn(t, sqErr30);
  ReadLn(t, sqErr31);
  ReadLn(t, sqErr32);
  ReadLn(t, sqErr33);
  ReadLn(t, sqErr34);
  ReadLn(t, sqErr35);
  ReadLn(t, sqErr36);
  ReadLn(t, sqErr37);
  ReadLn(t, sqErr38);
  ReadLn(t, sqErr39);
  ReadLn(t, sqErr40);
  ReadLn(t, sqErr41);
  ReadLn(t, sqErr42);
  ReadLn(t, sqErr43);
  ReadLn(t, sqErr44);
  ReadLn(t, sqErr45);
  ReadLn(t, sqErr46);
  ReadLn(t, sqErr47);
  ReadLn(t, sqErr48);
  ReadLn(t, sqErr49);
  ReadLn(t, sqErr50);
  ReadLn(t, sqErr51);
  ReadLn(t, sqErr52);
  ReadLn(t, sqExt0);
  ReadLn(t, sqExt1);
  ReadLn(t, sqExt2);
  ReadLn(t, sqExt3);
  ReadLn(t, sqExt4);
  ReadLn(t, sqExt5);
  ReadLn(t, sqExt6);
  ReadLn(t, sqExt7);
  ReadLn(t, sqDisk0);
  ReadLn(t, sqDisk1);
  ReadLn(t, sqDisk2);
  ReadLn(t, sqDisk3);
  ReadLn(t, sqDisk4);
  ReadLn(t, sqDisk5);
  ReadLn(t, sqDisk6);
  ReadLn(t, sqDisk7);
  ReadLn(t, sqDisk8);
  ReadLn(t, sqDisk9);
  ReadLn(t, sqComp0);
  ReadLn(t, sqComp1);
  ReadLn(t, sqComp2);
  ReadLn(t, sqComp3);
  ReadLn(t, sqComp4);
  ReadLn(t, sqComp5);
  ReadLn(t, sqComp6);
  ReadLn(t, sqComp7);
  ReadLn(t, sqComp8);
  ReadLn(t, sqComp9);
  ReadLn(t, sqComp10);
  ReadLn(t, sqComp11);
  ReadLn(t, sqComp12);
  ReadLn(t, sqVol0);
  ReadLn(t, sqVol1);
  ReadLn(t, sqVol2);
  ReadLn(t, sqVol3);
  ReadLn(t, sqVol4);
  ReadLn(t, sqVol5);
  ReadLn(t, sqVol6);
  ReadLn(t, sqVol7);
  ReadLn(t, sqVol8);
  ReadLn(t, sqVol9);
  ReadLn(t, sqVol10);
  ReadLn(t, sqVol11);
  ReadLn(t, sqVol12);
  ReadLn(t, sqVol13);
  ReadLn(t, sqDic0);
  ReadLn(t, sqDic1);
  ReadLn(t, sqDic2);
  ReadLn(t, sqDic3);
  ReadLn(t, sqDic4);
  ReadLn(t, sqDic5);
  ReadLn(t, sqDic6);
  ReadLn(t, sqDic7);
  ReadLn(t, sqRate0);
  ReadLn(t, sqRate1);
  ReadLn(t, sqRate2);
  ReadLn(t, sqRate3);
  ReadLn(t, sqRec0);
  ReadLn(t, sqRec1);
  ReadLn(t, sqRec2);
  ReadLn(t, sqRec3);
  ReadLn(t, sqRec4);
  ReadLn(t, sqRec5);
  ReadLn(t, sqRec6);
  ReadLn(t, sqRec7);
  ReadLn(t, sqRec8);
  ReadLn(t, sqRec9);
  ReadLn(t, sqRec10);
  ReadLn(t, cD48);
  ReadLn(t, sqTool0);
  ReadLn(t, sqTool1);
  ReadLn(t, sqTool2);
  ReadLn(t, sqTool3);
  ReadLn(t, sqTool4);
  ReadLn(t, sqTool5);
  ReadLn(t, sqTool6);
  ReadLn(t, sqTool7);
  ReadLn(t, sqErr53);
  ReadLn(t, sqTool8);
  ReadLn(t, sqTool9);
  ReadLn(t, sqRep0);
  ReadLn(t, sqRep1);
  ReadLn(t, sqRep2);
  ReadLn(t, sqRep3);
  ReadLn(t, sqRep4);
  ReadLn(t, sqRep5);
  ReadLn(t, sqRep6);
  ReadLn(t, sqRep7);
  ReadLn(t, sqRep8);
  ReadLn(t, sqEXE0);
  ReadLn(t, sqEXE1);
  ReadLn(t, cMaxLic);
  ReadLn(t, cBadLic);
  ReadLn(t, szMultiThreaded);
  ReadLn(t, cUpdate1);
  ReadLn(t, cUpdate2);
  ReadLn(t, cUpdate3);
  ReadLn(t, mtvRarLic0);
  ReadLn(t, mtvRarLic1);
  ReadLn(t, mtvRarLic2);
  ReadLn(t, mtvRarLic3);
  ReadLn(t, mtvRarLic4);
  ReadLn(t, mtvRarLic5);
  ReadLn(t, apiGenFail);
  ReadLn(t, ultM0);
  ReadLn(t, ultM1);
  ReadLn(t, ultM2);
  ReadLn(t, ultM3);
  ReadLn(t, cSlowDown);
  ReadLn(t, cSpeedUp);
  ReadLn(t, szn0);
  ReadLn(t, szn1);
  ReadLn(t, szn2);
  ReadLn(t, szn3);
  ReadLn(t, szn4);
  ReadLn(t, szn5);
  ReadLn(t, szn6);
  ReadLn(t, szn7);
  ReadLn(t, szn8);
  ReadLn(t, szn9);
  ReadLn(t, szn10);
  ReadLn(t, szn11);
  ReadLn(t, szn12);
  ReadLn(t, szn13);
  ReadLn(t, sznPathMode);
  ReadLn(t, sznPathFull);
  ReadLn(t, sznPathRelative);
  ReadLn(t, sznPathNone);
  ReadLn(t, szn14);
  ReadLn(t, cCompressedX);
  ReadLn(t, szn15);
  ReadLn(t, szn16);
  ReadLn(t, szn17);
  ReadLn(t, szn18);
  ReadLn(t, szn19);
  ReadLn(t, szn20);
  ReadLn(t, szn21);
  ReadLn(t, szn22);
  ReadLn(t, szn23);
  ReadLn(t, szn24);
  ReadLn(t, szn25);
  ReadLn(t, szn26);
  ReadLn(t, sznTryAgain);
  ReadLn(t, sznContinue);
  ReadLn(t, sznMultiWarn);
  ReadLn(t, sznTestSuccess);
  ReadLn(t, shCutTip);
  CloseFile(t);
  Result := True;
end;

initialization
  InitializeLocalization;

end.
