unit WIMADLL;

interface
uses
  Windows;

const
  WimaDllName = 'wimadll.dll';

Type PBool     = ^WordBool;
     PBoolean  = ^Boolean;
     PByte     = ^Byte;
     PWord     = ^Word;
     PShortInt = ^ShortInt;
     PInteger  = ^Integer;
     PLongInt  = ^LongInt;
     PSingle   = ^Single;
     PDouble   = ^Double;
     PPointer  = ^Pointer;

     HGlobal                 =  THandle;
     PRGBTriple              = ^TRGBTriple;
     PRGBQuad                = ^TRGBQuad;
     PMenuItemTemplateHeader = ^TMenuItemTemplateHeader;
     PMenuItemTemplate       = ^TMenuItemTemplate;
     PMultiKeyHelp           = ^TMultiKeyHelp;



Type str_ima_handle = record
                        unused: LongInt;
                      end {str_ima_handle};

Type HIMA = str_ima_handle;



{$IFNDEF _INC_DISK}

{$IFNDEF MAXLFN}
Const MAXLFN = 256;
{$ENDIF}


Type DIRINFO = record
            nom: Array[0..8-1] of Char;
            ext: Array[0..3-1] of Char;
            szCompactName: Array[0..13-1] of Char;
            bAttr: BYTE;

            dir_CreateMSec: BYTE;
            dir_CreateDate: Word;

            DosTime: Word;
            DosDate: Word;

            fIsSubDir: Bool;
            fSel: Bool;
            fLfnEntry: Bool;
            dwSize: LongInt;
            uiPosInDir: LongInt;
            dwLocalisation: LongInt;
            dwTrueSize: LongInt;
            longname: Array[0..MAXLFN-1] of Char;
            dir_CreateTime: Word;
            dir_LastAccessDate: Word;
          end {_1};

Type PDIRINFO =  ^DIRINFO;          
Type LPDIRINFO = PDIRINFO;

Type ASPIINQUIRYTAB = record
                        dwSizeStruct: LongInt;
                        dwHost: LongInt;
                        dwTargetID: LongInt;
                        dwTargetType: LongInt;
                        szDeviceName: Array[0..32-1] of Char;
                      end;
Type PASPIINQUIRYTAB = ^ASPIINQUIRYTAB;
Type LPASPIINQUIRYTAB = PASPIINQUIRYTAB;
{$ENDIF}


{$IFNDEF SORT_NONE}
Const SORT_NONE = 72;
Const SORT_NAME = 73;
Const SORT_EXT = 74;
Const SORT_SIZE = 75;
Const SORT_DATE = 76;
{$ENDIF}

{$IFNDEF CDM_ROOT}
Const CDM_ROOT = 50;
Const CDM_UPPER = 51;
Const CDM_ENTRY = 52; {// use ChszDir}
{$ENDIF}

type CHOICEAPP = LongInt;
Const NOTHING:CHOICEAPP=0;
Const USED:CHOICEAPP = 1;
Const ALL:CHOICEAPP =2;
Const BEGINFLOPPY:CHOICEAPP=3;
{/// CreateMemFatHima : Create an Image Object. }
{/// you need call ReadImaFile, ReadFloppy or MakeEmptyImage }

function CreateMemFatHima: HIMA ;
               stdcall; external WimaDllName name 'CreateMemFatHima';

{/// CreateMemHfsHima : Create an Image Object for Mac floppy. }
{/// you need call ReadImaFile, ReadFloppy }
{/// extract, inject... cannot be used }

function CreateMemHfsHima: HIMA ;
               stdcall; external WimaDllName name 'CreateMemHfsHima';

{/// CreateCDIsoIma : Create an Image Object by loading CDRom ISO image }
{/// lpFn : Filename of .ISO file }
{/// inject,...cannot be used }

function CreateCDIsoIma(lpFn: PChar): HIMA ;
               stdcall; external WimaDllName name 'CreateCDIsoIma';

{/// DeleteIma : Delete an Image Object. }

procedure DeleteIma(Ima: HIMA) ;stdcall;
               stdcall; external WimaDllName name 'DeleteIma';

{/// Read an image file (.IMA or .IMZ) }
{/// hWnd : parent window for progress window }
{/// lpFn : FileName }
{/// lpfCompr : pointer to Boolean (will receive TRUE if file is compressed) }
{/// dwPosFileBegin : position in file (usualy 0, except in WLZ) }

function ReadImaFile(hIma: HIMA;
                     hWnd: HWND;
                     lpFn: PChar;
                     lpfCompr: PBool;
                     dwPosFileBegin: LongInt): Bool ;
               stdcall; external WimaDllName name 'ReadImaFile';
function ReadImaFileEx(hIma: HIMA;
                     hWnd: HWND;
                     lpFn: PChar;
                     lpfCompr: PBool;
                     dwPosFileBegin: LongInt;
					 lpszPassword: PChar): Bool ;
               stdcall; external WimaDllName name 'ReadImaFileEx';

{/// WriteImaFile : WriteCompressed image }
{/// hWnd : parent window for progress window }
{/// lpFn : FileName }
{/// fTruncate : TRUE if you want truncate unused part of image }
{/// fCompress : TRUE if you want compress }
{/// iLevelCompress : used is fCompress is TRUE, level of compress (1 to 9) }
{/// dwPosBeginWrite : position in file (usualy 0) }
{/// lpNameInCompr : alternate name in compressed file (can be NULL) }

function WriteImaFile(hIma: HIMA;
                      hWnd: HWND;
                      lpFn: PChar;
                      fTruncate: Bool;
                      fCompress: Bool;
                      iLevelCompress: Integer;
                      dwPosBeginWrite: LongInt;
                      lpNameInCompr: PChar): Bool ;
               stdcall; external WimaDllName name 'WriteImaFile';
function WriteImaFileEx(hIma: HIMA;
                      hWnd: HWND;
                      lpFn: PChar;
                      fTruncate: Bool;
                      fCompress: Bool;
                      iLevelCompress: Integer;
                      dwPosBeginWrite: LongInt;
                      lpNameInCompr: PChar;
					  lpszPassword: PChar): Bool ;
               stdcall; external WimaDllName name 'WriteImaFileEx';

{/// ReadFloppy : Read a floppy }
{/// hWnd : parent window for progress window }
{/// bFloppy : Floppy to read (0 for A:) }
{/// caRead : USED, or ALL (ALL if you want read unused part of floppy) }

function ReadFloppy(hIma: HIMA;
                    hWnd: HWND;
                    bFloppy: BYTE;
                    caRead: CHOICEAPP): Bool ;
               stdcall; external WimaDllName name 'ReadFloppy';

{/// WriteFloppy : Write a floppy }
{/// hWnd : parent window for progress window }
{/// bFloppy : Floppy to write (0 for A:) }
{/// caFormat : NOTHING or ALL (ALL for format) }
{/// caWrite : USED or ALL }
{/// caCompare : NOTHING, USED or ALL }
{/// fCheckDiskBeforeWrite : if you want check disk is empty }

function WriteFloppy(hIma: HIMA;
                     hWnd: HWND;
                     bFloppy: BYTE;
                     caFormat: CHOICEAPP;
                     caWrite: CHOICEAPP;
                     caCompare: CHOICEAPP;
                     fCheckDiskBeforeWrite: BYTE): Bool;
               stdcall; external WimaDllName name 'WriteFloppy';

{/// Create a directory in the image }
{/// lpDir : Directory name }

function MkDir(hIma: HIMA;
               lpDir: PChar): Bool ;stdcall;
               stdcall; external WimaDllName name 'MkDir';

{/// Change current directory by name }
{/// lpDir : Directory name }

function ChszDir(hIma: HIMA;
                 lpDir: PChar): Bool ;
               stdcall; external WimaDllName name 'ChszDir';

{/// Change current directory by mode }
{/// bMode : CDM_ROOT or CDM_UPPER (equiv. to cd \ and cd ..) }

function ChDir(hIma: HIMA;
               bMode: BYTE): Bool ;
               stdcall; external WimaDllName name 'ChDir';

{/// InjectFile : Inject a file in floppy }
{/// lpFn : file to inject }
{/// lpDwSize : Pointer to DWORD that will receive the size. Can be NULL. }
{/// lpTooBig : Pointer to BOOL, become TRUE if file too big to be injected }
{/// (if InjectFile return FALSE). Can be NULL. }
{/// lpNameWhenInjected : if not NULL, contain a new name in the image }
{/// (if the file must have another name when injected). Can be NULL. }

function InjectFile(hIma: HIMA;
                    lpFn: PChar;
                    lpDwSize: PLongInt;
                    lpTooBig: PBool;
                    lpNameWhenInjected: PChar): Bool ;
               stdcall; external WimaDllName name 'InjectFile';

{/// MakeEmptyImage : make an empty image }
{/// iNotypeDisk : 4=720K,6=1440K,7=2880K,8=DMF2048,9=DMF1024,10=1680K }
{/// 0=160K,1=180K,2=320K,3=360K,5=1200K (old, no ! :-)) }

function MakeEmptyImage(hIma: HIMA;
                        iNoTypeDisk: Integer): Bool ;
               stdcall; external WimaDllName name 'MakeEmptyImage';

{/// InitWimaSdk : Init the DLL and use hinstdll for resource }
Const DEBENUSTD = 'ENU';
Const BASEENUSTD = (10000);

function InitWimaSdk(hinstdll: HINST;
                     lpDeb: PChar;
                     wBase: Word): Bool ;
               stdcall; external WimaDllName name 'InitWimaSdk';

{/// GetCurDir : Get the name of current directory }
{/// lpBuf : buffer that will receive the name }
{/// uiMaxSize : the size of buffer }

function GetCurDir(hIma: HIMA;
                   lpBuf: PChar;
                   uiMaxSize: Word): Bool ;
               stdcall; external WimaDllName name 'GetCurDir';

{/// GetNbEntryCurDir : Get the number of entry of cur directory }

function GetNbEntryCurDir(hIma: HIMA): LongInt ;
               stdcall; external WimaDllName name 'GetNbEntryCurDir';

{/// GetDirInfo : Get info about the entry of cur directory }
{/// LPDIRINFO : array of DIRINFO that will receive the info }
{/// (use GetNbEntryCurDir for know the size needed) }
{/// bSort : specify how the file must be sort }
{/// (SORT_NONE, SORT_NAME, SORT_EXT, SORT_SIZE or SORT_DATE) }

function GetDirInfo(hIma: HIMA;
                    lpdi: PDIRINFO;
                    bSort: BYTE): Bool ;
               stdcall; external WimaDllName name 'GetDirInfo';

{/// Sort : Resort the array obtained by GetDirInfo }

function Sort(hIma: HIMA;
              lpdi: PDIRINFO;
              bSort: BYTE): Bool ;
               stdcall; external WimaDllName name 'Sort';

{/// GetLabel : Get the label of Image }
{/// lpBuf : will receive the label }

function GetLabel(hIma: HIMA;
                  lpBuf: PChar): Bool ;
               stdcall; external WimaDllName name 'GetLabel'

{/// SetLabel : Set the label of Image }
{/// lpBuf : contain the new label }

function SetLabel(hIma: HIMA;
                  lpBuf: PChar): Bool ;
               stdcall; external WimaDllName name 'SetLabel';

{/// ExtractFile : Extract one file }
{/// unPosDir : The uiPosInDir fields in DIRINFO structure that describe }
{/// the file }
{/// lpPath : Path where extract the file }
{/// lpFullName: will receive the exact full name of created file. Can be NULL }

function ExtractFile(hIma: HIMA;
                     uiPosDir: Word;
                     lpPath: PChar;
                     lpFullName: PChar): Bool ;
               stdcall; external WimaDllName name 'ExtractFile';

{/// CheckSpaceForFile : Check you've space for inject a file of dwSize bytes }

function CheckSpaceForFile(hIma: HIMA;
                           dwSize: LongInt): Bool ;
               stdcall; external WimaDllName name 'CheckSpaceForFile';

{/// to know if an inject is possible but need replace }
{/// lpFn : contain the name of file to be injected }
{/// lpDwSize : will receive the size of old file with same name. Can be NULL }
{/// lpNameWhenInjected : if not NULL, contain a new name in the image }
{/// lpShortName : will receive the short (8) name of file in image. Can be NULL }
{/// lpShortExt : will receive the short (3) ext of file in image. Can be NULL }
{/// (if the file must have another name when injected) }

function IfInjectPossibleButNeedReplace(hIma: HIMA;
                                        lpFn: PChar;
                                        lpDwSize: PLongInt;
                                        lpShortName: PChar;
                                        lpShortExt: PChar;
                                        lpNameWhenInjected: PChar): Bool ;
               stdcall; external WimaDllName name 'IfInjectPossibleButNeedReplace';

{/// RmDir : Remove a directory }
{/// unPosDir : The uiPosInDir fields in DIRINFO structure that describe }
{/// the file }

function RmDir(hIma: HIMA;
               uiPosDir: Word): Bool ;
               stdcall; external WimaDllName name 'RmDir';

{/// DeleteFileNameExt }

function DeleteFileNameExt(hIma: HIMA;
                           lpNom: PChar;
                           lpExt: PChar;
                           fRealDel: Bool): Bool ; stdcall; external WimaDllName name 'DeleteFileNameExt';


{// RenameFile :    Rename one file }
{ //  uiPosDir :     The uiPosInDir fields in DIRINFO structure that describe }
{ //                  the file }
{ //  lpNewLongName: The new name of the file }
function RenameFile(hIma: HIMA;
                    uiPosDir: Word;
		            lpNewLongName: PChar): Bool ;
               stdcall; external WimaDllName name 'RenameFile';

{ ChangeDateAndAttribute :    Change the date and attribute of a File }
{  uiPosDir :     The uiPosInDir fields in DIRINFO structure that describe }
{                  the file }
{  *lpbNewAttr:   Contain the new attribute of the file (or NULL to no change) }
{  *lpNewDosDate, }
{  *lpNewDosTime: Contain the Modified Date and Time (or NULL to no change) }
{  *lpbNewdir_CreateMSec,*lpwNewdir_CreateTime,*lpwNewdir_CreateDate }
{                 Contain the Created Date and Time (or NULL to no change) }
{  *lpwNewdir_LastAccessDate : Contain the Last Access Date (or NULL...) }

function ChangeDateAndAttribute(hIma: HIMA;
                                uiPosDir: Word;
                                lpbNewAttr: PByte;
                                lpNewDosDate: PWord;
								lpNewDosTime: PWord;
                                lpbNewdir_CreateMSec: PByte;
                                lpwNewdir_CreateTime: PWord;
								lpwNewdir_CreateDate: PWord;
                                lpwNewdir_LastAccessDate: PWord): Bool ;
               stdcall; external WimaDllName name 'ChangeDateAndAttribute';

{/// ReadData : Direct read data in image. }
{/// dwPos : begin position }
{/// dwSize : number of byte to copy (size of buffer) }
{/// lpBuf : buffer that will receive data }

function ReadData(hIma: HIMA;
                  dwPos: LongInt;
                  dwSize: LongInt;
                  lpBuf: PChar): Bool ; stdcall; external WimaDllName name 'ReadData';

{/// WriteData : Direct write data in image. Be carreful, WI don't refresh dir! }
{/// dwPos : begin position }
{/// dwSize : number of byte to copy (size of buffer) }
{/// lpBuf : buffer that contain data }

function WriteData(hIma: HIMA;
                   dwPos: LongInt;
                   dwSize: LongInt;
                   lpBuf: PChar): Bool ; stdcall; external WimaDllName name 'WriteData';

{/// To be added : DRIVEINFO, GetFatImaSizeFileName, GetDriveInfo  }


{
//
// GetFatImaSizeFileName : Get information about UNCOMPRESSED Fat image
//   lpfn :          FileName
//   lpdwSize :      Will receive the size of the image, 32 bits low part of 64 bit data
//   lpdwSize!high : Will receive the size of the image, 32 bits high part of 64 bit data
//   lpfIsBigFat :   Boolean pointer, will receive TRUE if this is a large image (>2.88MB), not floppy image
//   lpdwPosInFile : Will receive the position of the image
BOOL WIMAAPI GetFatImaSizeFileName(LPCSTR lpFn,LPDWORD lpdwSize,LPDWORD lpdwSizeHigh,LPBOOL lpfIsBigFat,LPDWORD lpdwPosInFile);
}
function GetFatImaSizeFileName(lpFn :PChar;lpdwSize:PLongInt;lpdwSizeHigh:PLongInt;lpfIsBigFat:PBoolean;lpdwPosInFile:PLongInt): Bool ; stdcall; external WimaDllName name 'GetFatImaSizeFileName';



{// GetDriveInfo : Get info about drive type
//  bDrive : number of driver (0 = 'A:', 1 = 'B:')
//  return the kind of drive}
{DriveInfo return:
  NO_FLOPPY=0,
  FLOPPY_360=1,
  FLOPPY_12M=2,
  FLOPPY_720=3,
  FLOPPY_144=4,
  FLOPPY_288=5,
  LDISK_REMOVABLE=6,
  LDISK_HARDDISK=7,
  LDISK_CDROM=8,
  FLOPPY_LS120=9
DRIVEINFO WIMAAPI GetDriveInfo(BYTE bDrive);
 }
function GetDriveInfo(bDrive: BYTE): LongInt ; stdcall; external WimaDllName name 'GetDriveInfo';

{
// Fill the ASPI Inquiry array.
// if lpAspiCdRomInquityTab is NULL AND dwMaxNumberInArray==0, just return the number of ASPI CDrom Unit.
//  lpAspiCdRomInquityTab : Will receive the Array of SCSI Unit
//  dwMaxNumberInArray : size of array (in number of ASPIINQUIRYTAB) 
DWORD WIMAAPI WimLargeAspiCdromInquiryFillArray(ASPIINQUIRYTAB* lpAspiCdRomInquityTab,DWORD dwMaxNumberInArray);
}
function WimLargeAspiCdromInquiryFillArray(lpAspiCdRomInquityTab:PASPIINQUIRYTAB;dwMaxNumberInArray:LongInt): LongInt ; stdcall; external WimaDllName name 'WimLargeAspiCdromInquiryFillArray';

{
// Create a CDRom Image fro ASPI Unit, using dwHost and dwTargetID from AspiCdromInquiy
//   lpFn : Filename to create
//   lpdwTotal : will receive the filesize
// Note : I suggest using WimLargeReadAspiCDImageIgnoreError with fIgnoreError at FALSE
BOOL WIMAAPI WimLargeReadAspiCDImage(HWND hWnd,DWORD dwHost,DWORD dwTargetID,LPSTR lpFn,LPDWORD lpdwTotal);
}
function WimLargeReadAspiCDImage(hWnd: HWND;dwHost: LongInt;dwTargetID:LongInt;lpFn:PChar;lpdwTotal:PLongInt): Bool ; stdcall; external WimaDllName name 'WimLargeReadAspiCDImage';


{
// Like WimLargeReadAspiCDImage
// fIgnoreError :
//    FALSE : if there is error ignore it only if the error is after ISO9660 size (suggested)
//    TRUE : Ignore all ISO 9660 error
BOOL WIMAAPI WimLargeReadAspiCDImageIgnoreError(HWND hWnd,DWORD dwHost,DWORD dwTargetID,LPSTR lpFn,LPDWORD lpdwTotal,BOOL fIgnoreError);
}
function WimLargeReadAspiCDImageIgnoreError(hWnd: HWND;dwHost: LongInt;dwTargetID:LongInt;lpFn:PChar;lpdwTotal:PLongInt;fIgnoreError:Bool): Bool ; stdcall; external WimaDllName name 'WimLargeReadAspiCDImageIgnoreError';


{
// return value != 0 if WimLargeReadLargeIma can be used with CDRom
// (elsewhere, only hard disk partition)
DWORD WIMAAPI WimLargeIsReadImaIsoPossible();
}
function WimLargeIsReadImaIsoPossible(): LongInt ; stdcall; external WimaDllName name 'WimLargeIsReadImaIsoPossible';

{
// Read Disk partition to image
//  cDrive : disk letter ('C' for disk C:...)
//  lpdwTotal : will receive number of byte processed
//  caRead : USED, or ALL (ALL if you want read unused part of disk)
BOOL WIMAAPI WimLargeReadLargeIma(HWND hWnd,char cDrive,LPSTR lpFn,LPDWORD lpdwTotal,CHOICEAPP caRead);
}
function WimLargeReadLargeIma(hWnd: HWND;
                              cDrive: Char;
                              lpFn: PChar;
                              lpdwTotal: PLongInt;
                              caRead: CHOICEAPP): Bool ; stdcall; external WimaDllName name 'WimLargeReadLargeIma';


{
// Write Disk partition from image
//  cDrive : disk letter ('C' for disk C:...)
//  lpdwTotal : will receive number of byte processed
//  caWrite : USED or ALL
//  fCheckDiskBeforeWrite : if you want check disk is empty
BOOL WIMAAPI WimLargeWriteLargeIma(HIMA hIma,HWND hWnd,char cDrive,LPDWORD lpdwTotal,
                                   CHOICEAPP caWrite,BOOL fCheckDiskBeforeWriteThis);
}
function WimLargeWriteLargeIma(hIma: HIMA; hWnd: HWND;
                               cDrive: Char; lpFn:PChar; lpdwTotal:PLongInt;
                               caWrite: CHOICEAPP;
                               fCheckDiskBeforeWriteThis:Bool): Bool ; stdcall; external WimaDllName name 'WimLargeWriteLargeIma';

{
// say if a letter if a CDRom
BOOL WIMAAPI WimLargeIsIsoCDDrive(char cDrive);
}
function WimLargeIsIsoCDDrive(cDrive: Char): Bool ; stdcall; external WimaDllName name 'WimLargeIsIsoCDDrive';


{ // Write the boot sector of an image
BOOL WIMAAPI WriteSectBoot(HIMA hIma,const BYTE* lpBuf,DWORD dwSizeBuf);
}
function WriteSectBoot(hIma: HIMA; lpBuf: PByte; 
                       dwSizeBuf: LongInt): Bool ; stdcall; external WimaDllName name 'WriteSectBoot';

{ // Read the boot sector of an image 
BOOL WIMAAPI GetSectBoot(HIMA hIma,LPBYTE lpBuf,DWORD dwSizeBuf,LPDWORD lpdwSizeBoot);
}
function GetSectBoot(hIma: HIMA; lpBuf: PByte; 
                       dwSizeBuf: LongInt;
                       lpdwSizeBoot: PLongInt): Bool ; stdcall; external WimaDllName name 'GetSectBoot';

implementation

end.
