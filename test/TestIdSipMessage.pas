{
  (c) 2004 Directorate of New Technologies, Royal National Institute for Deaf people (RNID)

  The RNID licence covers this unit. Read the licence at:
      http://www.ictrnid.org.uk/docs/gw/rnid_license.txt

  This unit contains code written by:
    * Frank Shearar
}
unit TestIdSipMessage;

interface

uses
  IdSipDialogID, IdSipMessage, SysUtils, TestFramework, TestFrameworkSip;

type
  TestFunctions = class(TTestCase)
  published
    procedure TestDecodeQuotedStr;
    procedure TestFirstChar;
    procedure TestIsEqual;
    procedure TestLastChar;
    procedure TestParamToTransport;
    procedure TestShortMonthToInt;
    procedure TestWithoutFirstAndLastChars;
  end;

  TIdSipTrivialMessage = class(TIdSipMessage)
  protected
    function  FirstLine: String; override;
    function  MatchRFC2543Request(InitialRequest: TIdSipRequest;
                                  UseCSeqMethod: Boolean): Boolean; override;
    function  MatchRFC3261Request(InitialRequest: TIdSipRequest;
                                  UseCSeqMethod: Boolean): Boolean; override;
    procedure ParseStartLine(Parser: TIdSipParser); override;
  public
    function  Equals(Msg: TIdSipMessage): Boolean; override;
    function  IsRequest: Boolean; override;
    function  MalformedException: EBadMessageClass; override;
  end;

  TestTIdSipMessage = class(TTestCaseSip)
  private
    Msg: TIdSipMessage;

  protected
    procedure AddRequiredHeaders(Msg: TIdSipMessage);
    procedure CheckBasicMessage(Msg: TIdSipMessage;
                                CheckBody: Boolean = true);
    function  MessageType: TIdSipMessageClass; virtual; abstract;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAccessingHeaderDoesntAddHeader;
    procedure TestAddHeader;
    procedure TestAddHeaderName;
    procedure TestAddHeaders;
    procedure TestAssignCopiesBody;
    procedure TestAssignCopiesParseInfo;
    procedure TestClearHeaders;
    procedure TestContactCount;
    procedure TestCopyHeaders;
    procedure TestFirstContact;
    procedure TestFirstExpires;
    procedure TestFirstHeader;
    procedure TestFirstMinExpires;
    procedure TestFirstRequire;
    procedure TestHasBody;
    procedure TestHasExpiry;
    procedure TestIsMalformedContentLength;
    procedure TestIsMalformedMalformedHeader;
    procedure TestIsMalformedMissingContentType;
    procedure TestIsMalformedMissingCallID;
    procedure TestIsMalformedMissingCseq;
    procedure TestIsMalformedMissingFrom;
    procedure TestIsMalformedMissingTo;
    procedure TestHeaderCount;
    procedure TestLastHop;
    procedure TestQuickestExpiry;
    procedure TestQuickestExpiryNoExpires;
    procedure TestReadBody;
    procedure TestReadBodyWithZeroContentLength;
    procedure TestRemoveHeader;
    procedure TestRemoveHeaders;
    procedure TestSetCallID;
    procedure TestSetContacts;
    procedure TestSetContentLanguage;
    procedure TestSetContentLength;
    procedure TestSetContentType;
    procedure TestSetCSeq;
    procedure TestSetFrom;
    procedure TestSetPath;
    procedure TestSetRecordRoute;
    procedure TestSetSipVersion;
    procedure TestSetTo;
    procedure TestWillEstablishDialog;
  end;

  TestTIdSipRequest = class(TestTIdSipMessage)
  private
    Request:  TIdSipRequest;
    Response: TIdSipResponse;

    procedure CheckBasicRequest(Msg: TIdSipMessage;
                                CheckBody: Boolean = true);
  protected
    function MessageType: TIdSipMessageClass; override;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAckForEstablishingDialog;
    procedure TestAckFor;
    procedure TestAckForWithAuthentication;
    procedure TestAckForWithRoute;
    procedure TestAddressOfRecord;
    procedure TestAssign;
    procedure TestAssignBad;
    procedure TestAsString;
    procedure TestAsStringNoMaxForwardsSet;
    procedure TestAuthorizationFor;
    procedure TestCopy;
    procedure TestCopyMessageMutatedFromString;
    procedure TestCreateCancel;
    procedure TestCreateCancelANonInviteRequest;
    procedure TestCreateCancelWithProxyRequire;
    procedure TestCreateCancelWithRequire;
    procedure TestCreateCancelWithRoute;
    procedure TestDestinationUri;
    procedure TestEqualsComplexMessages;
    procedure TestEqualsDifferentBodies;
    procedure TestEqualsDifferentHeaders;
    procedure TestEqualsDifferentMethod;
    procedure TestEqualsDifferentRequestUri;
    procedure TestEqualsDifferentSipVersion;
    procedure TestEqualsFromAssign;
    procedure TestEqualsResponse;
    procedure TestEqualsTrivial;
    procedure TestFirstAuthorization;
    procedure TestFirstEvent;
    procedure TestFirstProxyAuthorization;
    procedure TestFirstProxyRequire;
    procedure TestFirstReplaces;
    procedure TestFirstRoute;
    procedure TestHasAuthorization;
    procedure TestHasAuthorizationFor;
    procedure TestHasProxyAuthorization;
    procedure TestHasProxyAuthorizationFor;
    procedure TestHasReplaces;
    procedure TestHasRoute;
    procedure TestHasSipsUri;
    procedure TestInSameDialogAsRequest;
    procedure TestInSameDialogAsResponse;
    procedure TestIsAck;
    procedure TestIsBye;
    procedure TestIsCancel;
    procedure TestIsInvite;
    procedure TestIsMalformedCSeqMethod;
    procedure TestIsMalformedMethod;
    procedure TestIsMalformedMissingMaxForwards;
    procedure TestIsMalformedMissingVia;
    procedure TestIsMalformedSipVersion;
    procedure TestIsNotify;
    procedure TestIsOptions;
    procedure TestIsRefer;
    procedure TestIsRegister;
    procedure TestIsRequest;
    procedure TestIsResponse;
    procedure TestIsSubscribe;
    procedure TestMatchRFC2543Options;
    procedure TestMatchRFC2543Cancel;
    procedure TestMatchCancel;
    procedure TestMatchCancelAgainstAck;
    procedure TestNewRequestHasContentLength;
    procedure TestParse;
    procedure TestParseCompoundHeader;
    procedure TestParseFoldedHeader;
    procedure TestParseLeadingBlankLines;
    procedure TestParseMalformedRequestLine;
    procedure TestParseWithRequestUriInAngleBrackets;
    procedure TestProxyAuthorizationFor;
    procedure TestRequiresResponse;
    procedure TestSetMaxForwards;
    procedure TestSetRoute;
    procedure TestWantsAllowEventsHeader;
  end;

  TestTIdSipResponse = class(TestTIdSipMessage)
  private
    Contact:  TIdSipContactHeader;
    Request:  TIdSipRequest;
    Response: TIdSipResponse;

    procedure CheckBasicResponse(Msg: TIdSipMessage;
                                 CheckBody: Boolean = true);
    procedure TurnIntoRFC2543(Request: TIdSipRequest);
  protected
    function MessageType: TIdSipMessageClass; override;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAssign;
    procedure TestAssignBad;
    procedure TestAsString;
    procedure TestAuthenticateHeaderWithNoAuthorization;
    procedure TestAuthenticateHeaderWithProxy;
    procedure TestAuthenticateHeaderWithUser;
    procedure TestCopy;
    procedure TestCopyMessageMutatedFromString;
    procedure TestEqualsComplexMessages;
    procedure TestEqualsDifferentBodies;
    procedure TestEqualsDifferentHeaders;
    procedure TestEqualsDifferentSipVersion;
    procedure TestEqualsDifferentStatusCode;
    procedure TestEqualsDifferentStatusText;
    procedure TestEqualsRequest;
    procedure TestEqualsTrivial;
    procedure TestFirstAuthenticationInfo;
    procedure TestFirstProxyAuthenticate;
    procedure TestFirstUnsupported;
    procedure TestFirstWarning;
    procedure TestFirstWWWAuthenticate;
    procedure TestHasAuthenticationInfo;
    procedure TestHasProxyAuthenticate;
    procedure TestHasWarning;
    procedure TestHasWWWAuthenticate;
    procedure TestInResponseToRecordRoute;
    procedure TestInResponseToSipsRecordRoute;
    procedure TestInResponseToSipsRequestUri;
    procedure TestInResponseToTryingWithTimestamps;
    procedure TestInResponseToWithContact;
    procedure TestInSameDialogAsRequest;
    procedure TestInSameDialogAsResponse;
    procedure TestIsAuthenticationChallenge;
    procedure TestIsMalformedStatusCode;
    procedure TestIsFinal;
    procedure TestIsOK;
    procedure TestIsProvisional;
    procedure TestIsRedirect;
    procedure TestIsRequest;
    procedure TestIsResponse;
    procedure TestMatchToRFC2543DifferentCallID;
    procedure TestMatchToRFC2543DifferentCSeqMethod;
    procedure TestMatchToRFC2543DifferentCSeqSequenceNo;
    procedure TestMatchToRFC2543DifferentFromTag;
    procedure TestMatchToRFC2543DifferentToTag;
    procedure TestMatchToRFC2543EmptyRequestPath;
    procedure TestMatchToRFC2543EmptyResponsePath;
    procedure TestMatchToRFC2543ServerTransaction;
    procedure TestIsTrying;
    procedure TestParse;
    procedure TestParseEmptyString;
    procedure TestParseFoldedHeader;
    procedure TestParseLeadingBlankLines;
    procedure TestWantsAllowEventsHeader;
  end;

  TestTIdSipRequestList = class(TTestCase)
  private
    List: TIdSipRequestList;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAddAndCount;
    procedure TestDefaultProperty;
    procedure TestDelete;
    procedure TestFirst;
    procedure TestIsEmpty;
    procedure TestLast;
    procedure TestListStoresCopiesNotReferences;
    procedure TestSecondLast;
    procedure TestThirdLast;
  end;

  TestTIdSipResponseList = class(TTestCase)
  private
    List: TIdSipResponseList;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAddAndCount;
    procedure TestDefaultProperty;
    procedure TestDelete;
    procedure TestFirst;
    procedure TestIsEmpty;
    procedure TestLast;
    procedure TestListStoresCopiesNotReferences;
    procedure TestSecondLast;
  end;

implementation

uses
  Classes, IdSimpleParser, IdSipConsts, TestMessages;

const
  AllMethods: array[1..7] of String = (MethodAck, MethodBye, MethodCancel,
      MethodInvite, MethodOptions, MethodParam, MethodRegister);
  AllResponses: array[1..50] of Cardinal = (SIPTrying, SIPRinging,
      SIPCallIsBeingForwarded, SIPQueued, SIPSessionProgress, SIPOK,
      SIPMultipleChoices, SIPMovedPermanently, SIPMovedTemporarily,
      SIPUseProxy, SIPAlternativeService, SIPBadRequest, SIPUnauthorized,
      SIPPaymentRequired, SIPForbidden, SIPNotFound, SIPMethodNotAllowed,
      SIPNotAcceptableClient, SIPProxyAuthenticationRequired,
      SIPRequestTimeout, SIPGone, SIPRequestEntityTooLarge,
      SIPRequestURITooLarge, SIPUnsupportedMediaType, SIPUnsupportedURIScheme,
      SIPBadExtension, SIPExtensionRequired, SIPIntervalTooBrief,
      SIPTemporarilyUnavailable, SIPCallLegOrTransactionDoesNotExist,
      SIPLoopDetected, SIPTooManyHops, SIPAddressIncomplete, SIPAmbiguous,
      SIPBusyHere, SIPRequestTerminated, SIPNotAcceptableHere,
      SIPRequestPending, SIPUndecipherable, SIPInternalServerError,
      SIPNotImplemented, SIPBadGateway, SIPServiceUnavailable,
      SIPServerTimeOut, SIPSIPVersionNotSupported, SIPMessageTooLarge,
      SIPBusyEverywhere, SIPDecline, SIPDoesNotExistAnywhere,
      SIPNotAcceptableGlobal);

function Suite: ITestSuite;
begin
  Result := TTestSuite.Create('IdSipMessage tests (Messages)');
  Result.AddTest(TestFunctions.Suite);
  Result.AddTest(TestTIdSipRequest.Suite);
  Result.AddTest(TestTIdSipResponse.Suite);
  Result.AddTest(TestTIdSipRequestList.Suite);
  Result.AddTest(TestTIdSipResponseList.Suite);
end;

//******************************************************************************
//* TestFunctions                                                              *
//******************************************************************************
//* TestFunctions Published methods ********************************************

procedure TestFunctions.TestDecodeQuotedStr;
var
  Result: String;
begin
  Check(DecodeQuotedStr('', Result), 'Empty string result');
  CheckEquals('', Result,            'Empty string decoded');

  Check(DecodeQuotedStr('\"', Result), '\" result');
  CheckEquals('"', Result,             '\" decoded');

  Check(DecodeQuotedStr('\\', Result), '\\ result');
  CheckEquals('\', Result,             '\\ decoded');

  Check(DecodeQuotedStr('\a', Result), '\a result');
  CheckEquals('a', Result,             '\a decoded');

  Check(DecodeQuotedStr('foo', Result), 'foo result');
  CheckEquals('foo', Result,            'foo decoded');

  Check(DecodeQuotedStr('\"foo\\\"', Result), '\"foo\\\" result');
  CheckEquals('"foo\"', Result,               '\"foo\\\" decoded');

  Check(not DecodeQuotedStr('\', Result), '\ result');
end;

procedure TestFunctions.TestFirstChar;
begin
  CheckEquals('',  FirstChar(''),   'Empty string');
  CheckEquals('a', FirstChar('ab'), 'ab');
end;

procedure TestFunctions.TestIsEqual;
begin
  Check(    IsEqual('', ''),    'Empty strings');
  Check(not IsEqual('', 'a'),   'Empty string & ''a''');
  Check(    IsEqual('a', 'a'),  '''a'' & ''a''');
  Check(    IsEqual('A', 'a'),  '''A'' & ''a''');
  Check(    IsEqual('a', 'A'),  '''a'' & ''A''');
  Check(    IsEqual('A', 'A'),  '''A'' & ''A''');
  Check(not IsEqual(' a', 'a'), ''' a'' & ''a''');
end;

procedure TestFunctions.TestLastChar;
begin
  CheckEquals('',  LastChar(''),   'Empty string');
  CheckEquals('b', LastChar('ab'), 'ab');
end;

procedure TestFunctions.TestParamToTransport;
begin
  CheckEquals(SctpTransport, ParamToTransport(TransportParamSCTP), TransportParamSCTP);
  CheckEquals(TcpTransport,  ParamToTransport(TransportParamTCP),  TransportParamTCP);
  CheckEquals(TlsTransport,  ParamToTransport(TransportParamTLS),  TransportParamTLS);
  CheckEquals(UdpTransport,  ParamToTransport(TransportParamUDP),  TransportParamUDP);
end;

procedure TestFunctions.TestShortMonthToInt;
var
  I: Integer;
begin
  for I := Low(ShortMonthNames) to High(ShortMonthNames) do begin
    CheckEquals(I,
                ShortMonthToInt(ShortMonthNames[I]),
                ShortMonthNames[I]);
    CheckEquals(I,
                ShortMonthToInt(UpperCase(ShortMonthNames[I])),
                UpperCase(ShortMonthNames[I]));
  end;

  try
    ShortMonthToInt('foo');
    Fail('Failed to raise exception on ''foo''');
  except
    on EConvertError do;
  end;
end;

procedure TestFunctions.TestWithoutFirstAndLastChars;
begin
  CheckEquals('',    WithoutFirstAndLastChars(''),      'Empty string');
  CheckEquals('',    WithoutFirstAndLastChars('a'),     'a');
  CheckEquals('',    WithoutFirstAndLastChars('ab'),    'ab');
  CheckEquals('b',   WithoutFirstAndLastChars('abc'),   'abc');
  CheckEquals('abc', WithoutFirstAndLastChars('"abc"'), '"abc"');
  CheckEquals('abc', WithoutFirstAndLastChars('[abc]'), '[abc]');
end;

//******************************************************************************
//* TIdSipTrivialMessage                                                       *
//******************************************************************************
//* TIdSipTrivialMessage Public methods ****************************************

function TIdSipTrivialMessage.Equals(Msg: TIdSipMessage): Boolean;
begin
  Result := false;
end;

function TIdSipTrivialMessage.IsRequest: Boolean;
begin
  Result := false;
end;

function TIdSipTrivialMessage.MalformedException: EBadMessageClass;
begin
  Result := nil;
end;

//* TIdSipTrivialMessage Protected methods *************************************

function TIdSipTrivialMessage.FirstLine: String;
begin
  Result := '';
end;

function TIdSipTrivialMessage.MatchRFC2543Request(InitialRequest: TIdSipRequest;
                                                  UseCSeqMethod: Boolean): Boolean;
begin
  Result := false;
end;

function TIdSipTrivialMessage.MatchRFC3261Request(InitialRequest: TIdSipRequest;
                                                  UseCSeqMethod: Boolean): Boolean;
begin
  Result := false;
end;

procedure TIdSipTrivialMessage.ParseStartLine(Parser: TIdSipParser);
begin
end;

//******************************************************************************
//* TestTIdSipMessage                                                          *
//******************************************************************************
//* TestTIdSipMessage Public methods *******************************************

procedure TestTIdSipMessage.SetUp;
begin
  inherited SetUp;

  Self.Msg := Self.MessageType.Create;
end;

procedure TestTIdSipMessage.TearDown;
begin
  Self.Msg.Free;

  inherited TearDown;
end;

//* TestTIdSipMessage Protected methods ****************************************

procedure TestTIdSipMessage.AddRequiredHeaders(Msg: TIdSipMessage);
begin
  Msg.AddHeader(CallIDHeaderFull).Value := 'foo';
  Msg.AddHeader(CSeqHeader).Value       := '1 foo';
  Msg.AddHeader(FromHeaderFull).Value   := 'sip:foo';
  Msg.AddHeader(ToHeaderFull).Value     := 'sip:foo';
  Msg.AddHeader(ViaHeaderFull).Value    := 'SIP/2.0/UDP foo';
end;

procedure TestTIdSipMessage.CheckBasicMessage(Msg: TIdSipMessage;
                                             CheckBody: Boolean = true);
begin
  CheckEquals('SIP/2.0',                              Msg.SIPVersion,              'SipVersion');
  CheckEquals(29,                                     Msg.ContentLength,           'ContentLength');
  CheckEquals('text/plain',                           Msg.ContentType,             'ContentType');
  CheckEquals('a84b4c76e66710@gw1.leo-ix.org',        Msg.CallID,                  'CallID');
  CheckEquals('Wintermute',                           Msg.ToHeader.DisplayName,    'ToHeader.DisplayName');
  CheckEquals('sip:wintermute@tessier-ashpool.co.luna', Msg.ToHeader.Address.URI,    'ToHeader.Address.GetFullURI');
  CheckEquals(';tag=1928301775',                      Msg.ToHeader.ParamsAsString, 'Msg.ToHeader.ParamsAsString');
  CheckEquals('Case',                                 Msg.From.DisplayName,        'From.DisplayName');
  CheckEquals('sip:case@fried.neurons.org',           Msg.From.Address.URI,        'From.Address.GetFullURI');
  CheckEquals(';tag=1928301774',                      Msg.From.ParamsAsString,     'Msg.From.ParamsAsString');
  CheckEquals(314159,                                 Msg.CSeq.SequenceNo,         'Msg.CSeq.SequenceNo');
  CheckEquals('INVITE',                               Msg.CSeq.Method,             'Msg.CSeq.Method');

  CheckEquals(1,                  Msg.Path.Length,              'Path.Length');
  CheckEquals('SIP/2.0',          Msg.LastHop.SipVersion,       'LastHop.SipVersion');
  CheckEquals(TcpTransport,       Msg.LastHop.Transport,        'LastHop.Transport');
  CheckEquals('gw1.leo-ix.org',   Msg.LastHop.SentBy,           'LastHop.SentBy');
  CheckEquals(IdPORT_SIP,         Msg.LastHop.Port,             'LastHop.Port');
  CheckEquals('z9hG4bK776asdhds', Msg.LastHop.Params['branch'], 'LastHop.Params[''branch'']');

  CheckEquals('To: Wintermute <sip:wintermute@tessier-ashpool.co.luna>;tag=1928301775',
              Msg.FirstHeader(ToHeaderFull).AsString,
              'To');
  CheckEquals('From: Case <sip:case@fried.neurons.org>;tag=1928301774',
              Msg.FirstHeader(FromHeaderFull).AsString,
              'From');
  CheckEquals('CSeq: 314159 INVITE',
              Msg.FirstHeader(CSeqHeader).AsString,
              'CSeq');
  CheckEquals('Contact: sip:wintermute@tessier-ashpool.co.luna',
              Msg.FirstContact.AsString,
              'Contact');
  CheckEquals('Content-Type: text/plain',
              Msg.FirstHeader(ContentTypeHeaderFull).AsString,
              'Content-Type');

  if CheckBody then
    CheckEquals(BasicBody, Msg.Body, 'message-body');
end;

//* TestTIdSipMessage Published methods ****************************************

procedure TestTIdSipMessage.TestAccessingHeaderDoesntAddHeader;
begin
  Check(not Self.Msg.HasHeader(CallIDHeaderFull),
        'Call-ID header already present');
  CheckEquals('',
              Self.Msg.CallID,
              'Call-ID value when no header present');
  Check(not Self.Msg.HasHeader(CallIDHeaderFull),
        'Call-ID header added');

  Check(not Self.Msg.HasHeader(ContentLanguageHeader),
        'Content-Language header already present');
  CheckEquals('',
              Self.Msg.ContentLanguage,
              'Content-Language value when no header present');
  Check(not Self.Msg.HasHeader(ContentLanguageHeader),
        'Content-Language header added');

  Check(not Self.Msg.HasHeader(ContentTypeHeaderFull),
        'Content-Type header already present');
  CheckEquals('',
              Self.Msg.ContentType,
              'Content-Type value when no header present');
  Check(not Self.Msg.HasHeader(ContentTypeHeaderFull),
        'Content-Type header added');
end;

procedure TestTIdSipMessage.TestAddHeader;
var
  H: TIdSipHeader;
begin
  Self.Msg.ClearHeaders;

  H := TIdSipHeader.Create;
  try
    H.Name := UserAgentHeader;
    H.Value := 'Dog''s breakfast v0.1';

    Self.Msg.AddHeader(H);

    Check(Self.Msg.HasHeader(UserAgentHeader), 'No header added');

    CheckEquals(H.Name,
                Self.Msg.Headers.Items[0].Name,
                'Name not copied');

    CheckEquals(H.Value,
                Self.Msg.Headers.Items[0].Value,
                'Value not copied');
  finally
    H.Free;
  end;

  CheckEquals(UserAgentHeader,
              Self.Msg.Headers.Items[0].Name,
              'And we check that the header was copied & we''re not merely '
            + 'storing a reference');
end;

procedure TestTIdSipMessage.TestAddHeaderName;
begin
  Self.Msg.ClearHeaders;

  CheckNotNull(Self.Msg.AddHeader(UserAgentHeader), 'Nil returned');

  Check(Self.Msg.HasHeader(UserAgentHeader), 'No header added');
end;

procedure TestTIdSipMessage.TestAddHeaders;
var
  Headers: TIdSipHeaders;
begin
  Self.Msg.ClearHeaders;

  Headers := TIdSipHeaders.Create;
  try
    Headers.Add(UserAgentHeader).Value := '0';
    Headers.Add(UserAgentHeader).Value := '1';
    Headers.Add(UserAgentHeader).Value := '2';
    Headers.Add(UserAgentHeader).Value := '3';

    Self.Msg.AddHeaders(Headers);
    Self.Msg.Headers.Equals(Headers);
  finally
    Headers.Free;
  end;
end;

procedure TestTIdSipMessage.TestAssignCopiesBody;
var
  AnotherMsg: TIdSipMessage;
begin
  AnotherMsg := TIdSipTrivialMessage.Create;
  try
    Self.Msg.Body := 'I am a body';

    AnotherMsg.Assign(Self.Msg);
    CheckEquals(Self.Msg.Body,
                AnotherMsg.Body,
                'Body not assigned properly');
  finally
    AnotherMsg.Free;
  end;
end;

procedure TestTIdSipMessage.TestAssignCopiesParseInfo;
var
  MalformedMsg: String;
  NewMsg: TIdSipMessage;
  P:      TIdSipParser;
  S:      TStringStream;
begin
  MalformedMsg := 'Not a valid first line'#$D#$A
                + Self.Msg.AsString;

  S := TStringStream.Create(MalformedMsg);
  try
    P := TIdSipParser.Create;
    try
      P.Source := S;

      Self.Msg.Parse(P);

      Check(Self.Msg.IsMalformed,
            Self.Msg.ClassName + ' not marked as malformed');
      NewMsg := Self.Msg.Copy;
      try
        Check(Self.Msg.IsMalformed = NewMsg.IsMalformed,
              Self.Msg.ClassName + ': IsMalformed info not copied');
        CheckEquals(Self.Msg.ParseFailReason,
                    NewMsg.ParseFailReason,
                    Self.Msg.ClassName + ': ParseFailReason info not copied');
        CheckEquals(Self.Msg.RawMessage,
                    NewMsg.RawMessage,
                    Self.Msg.ClassName + ': RawMessage info not copied');
      finally
        NewMsg.Free;
      end;
    finally
      P.Free;
    end;
  finally
    S.Free;
  end;
end;

procedure TestTIdSipMessage.TestClearHeaders;
begin
  Self.Msg.AddHeader(UserAgentHeader);
  Self.Msg.AddHeader(UserAgentHeader);
  Self.Msg.AddHeader(UserAgentHeader);
  Self.Msg.AddHeader(UserAgentHeader);

  Self.Msg.ClearHeaders;

  CheckEquals(0, Self.Msg.HeaderCount, 'Headers not cleared');
end;

procedure TestTIdSipMessage.TestContactCount;
begin
  Self.Msg.ClearHeaders;
  CheckEquals(0, Self.Msg.ContactCount, 'No headers');

  Self.Msg.AddHeader(ContactHeaderFull);
  CheckEquals(1, Self.Msg.ContactCount, 'Contact');

  Self.Msg.AddHeader(ViaHeaderFull);
  CheckEquals(1, Self.Msg.ContactCount, 'Contact + Via');

  Self.Msg.AddHeader(ContactHeaderFull);
  CheckEquals(2, Self.Msg.ContactCount, '2 Contacts + Via');
end;

procedure TestTIdSipMessage.TestCopyHeaders;
var
  Expected: TIdSipHeadersFilter;
  NewMsg:   TIdSipMessage;
  Received: TIdSipHeadersFilter;
begin
  NewMsg := Self.Msg.Copy;
  try
    Self.Msg.AddHeader(WarningHeader).Value := '399 proxy.tessier-ashpool.co.luna 1234::1';
    Self.Msg.AddHeader(WarningHeader).Value := '399 gw1.leo-ix.net 5678::1';
    Self.Msg.AddHeader(WarningHeader).Value := '399 gw2.leo-ix.net 9abc::1';
    Self.Msg.AddHeader(WarningHeader).Value := '399 gw.fried.neurons.org def0::1';

    NewMsg.CopyHeaders(Self.Msg, WarningHeader);

    Expected := TIdSipHeadersFilter.Create(Self.Msg.Headers,
                                           WarningHeader);
    try
      Received := TIdSipHeadersFilter.Create(NewMsg.Headers,
                                             WarningHeader);
      try
        CheckEquals(Expected,
                    Received,
                    'Copy Warning headers');
      finally
        Received.Free;
      end;
    finally
      Expected.Free;
    end;
  finally
    NewMsg.Free;
  end;
end;

procedure TestTIdSipMessage.TestFirstContact;
var
  C: TIdSipHeader;
begin
  Self.Msg.ClearHeaders;

  CheckNotNull(Self.Msg.FirstContact, 'Contact not present');
  CheckEquals(1, Self.Msg.HeaderCount, 'Contact not auto-added');

  C := Self.Msg.FirstHeader(ContactHeaderFull);
  Self.Msg.AddHeader(ContactHeaderFull);

  Check(C = Self.Msg.FirstContact, 'Wrong Contact');
end;

procedure TestTIdSipMessage.TestFirstExpires;
var
  E: TIdSipHeader;
begin
  Self.Msg.ClearHeaders;

  CheckNotNull(Self.Msg.FirstExpires, 'Expires not present');
  CheckEquals(1, Self.Msg.HeaderCount, 'Expires not auto-added');

  E := Self.Msg.FirstHeader(ExpiresHeader);
  Self.Msg.AddHeader(ExpiresHeader);

  Check(E = Self.Msg.FirstExpires, 'Wrong Expires');
end;

procedure TestTIdSipMessage.TestFirstHeader;
var
  H: TIdSipHeader;
begin
  Self.Msg.ClearHeaders;
  H := Self.Msg.AddHeader(UserAgentHeader);
  Check(H = Self.Msg.FirstHeader(UserAgentHeader),
        'Wrong result returned for first User-Agent');

  H := Self.Msg.AddHeader(RouteHeader);
  Check(H = Self.Msg.FirstHeader(RouteHeader),
        'Wrong result returned for first Route');

  H := Self.Msg.AddHeader(RouteHeader);
  Check(H <> Self.Msg.FirstHeader(RouteHeader),
        'Wrong result returned for first Route of two');
end;

procedure TestTIdSipMessage.TestFirstMinExpires;
var
  E: TIdSipHeader;
begin
  Self.Msg.ClearHeaders;

  CheckNotNull(Self.Msg.FirstMinExpires, 'Min-Expires not present');
  CheckEquals(1, Self.Msg.HeaderCount, 'Min-Expires not auto-added');

  E := Self.Msg.FirstHeader(MinExpiresHeader);
  Self.Msg.AddHeader(MinExpiresHeader);

  Check(E = Self.Msg.FirstMinExpires, 'Wrong Min-Expires');
end;

procedure TestTIdSipMessage.TestFirstRequire;
var
  R: TIdSipHeader;
begin
  Self.Msg.ClearHeaders;

  CheckNotNull(Self.Msg.FirstRequire, 'Require not present');
  CheckEquals(1, Self.Msg.HeaderCount, 'Require not auto-added');

  R := Self.Msg.FirstHeader(RequireHeader);
  Self.Msg.AddHeader(RequireHeader);

  Check(R = Self.Msg.FirstRequire, 'Wrong Require');
end;

procedure TestTIdSipMessage.TestHasBody;
begin
  Self.Msg.Body := '';
  Check(not Self.Msg.HasBody, 'No body present');

  Self.Msg.Body := 'foo';
  Check(Self.Msg.HasBody, 'Body present');

  Self.Msg.Body := '';
  Check(not Self.Msg.HasBody, 'Body cleared');  
end;

procedure TestTIdSipMessage.TestHasExpiry;
begin
  Self.Msg.ClearHeaders;
  Check(not Self.Msg.HasExpiry, 'No headers');

  Self.Msg.AddHeader(ExpiresHeader);
  Check(Self.Msg.HasExpiry, 'Expires header');

  Self.Msg.ClearHeaders;
  Self.Msg.AddHeader(ContactHeaderFull).Value := 'sip:hiro@enki.org';
  Check(not Self.Msg.HasExpiry,
        'Contact with no Expires parameter or Expires header');

  Self.Msg.AddHeader(ContactHeaderFull).Value := 'sip:hiro@enki.org;expires=10';
  Check(Self.Msg.HasExpiry,
        'No Expires header and Contact with Expires parameter');

  Self.Msg.AddHeader(ExpiresHeader);
  Check(Self.Msg.HasExpiry,
        'Expires header and Contact with Expires parameter');
end;

procedure TestTIdSipMessage.TestIsMalformedContentLength;
begin
  Self.AddRequiredHeaders(Self.Msg);
  Self.Msg.ContentType := 'text/plain';

  Check(not Self.Msg.IsMalformed,
        'Missing Content-Length; empty body');

  Self.Msg.Body := 'foo';
  Check(Self.Msg.IsMalformed,
        'Content-Length = 0; body = ''foo''');
  CheckEquals(BadContentLength,
              Self.Msg.ParseFailReason,
              'ParseFailReason');

  Self.Msg.Body := 'foo';
  Self.Msg.ContentLength := 3;
  Check(not Self.Msg.IsMalformed,
        'Content-Length = 3; body = ''foo''');
end;

procedure TestTIdSipMessage.TestIsMalformedMalformedHeader;
const
  // Note the malformed Expires header
  MalformedMessage = 'SIP/2.0 200 OK'#13#10
                   + 'Expires: a'#13#10
                   + 'Via:     SIP/2.0/UDP c.bell-tel.com;branch=z9hG4bKkdjuw'#13#10
                   + 'Max-Forwards:     70'#13#10
                   + 'From:    A. Bell <sip:a.g.bell@bell-tel.com>;tag=qweoiqpe'#13#10
                   + 'To:      T. Watson <sip:t.watson@ieee.org>'#13#10
                   + 'Call-ID: 31417@c.bell-tel.com'#13#10
                   + 'CSeq:    1 INVITE'#13#10
                   + #13#10;
var
  ExpectedReason: String;
  Res:            TIdSipResponse;
begin
  ExpectedReason := Format(MalformedToken, [ExpiresHeader, 'a']);

  Res := TIdSipMessage.ReadResponseFrom(MalformedMessage);
  try
    Check(Res.IsMalformed,
          'Response not marked as invalid');

    CheckEquals(ExpectedReason,
                Res.ParseFailReason,
                'Unexpected parse fail reason');

    Check(Res.HasHeader(CSeqHeader),
          'The bad syntax bailed us out of parsing the rest of the message');
  finally
    Res.Free;
  end;
end;

procedure TestTIdSipMessage.TestIsMalformedMissingContentType;
begin
  Self.AddRequiredHeaders(Self.Msg);
  Self.Msg.Body := 'foo';
  Self.Msg.ContentLength := 3;
  Check(Self.Msg.IsMalformed,
        'Length(Body) > 0 but no Content-Type');

  CheckEquals(MissingContentType,
              Self.Msg.ParseFailReason,
              'ParseFailReason');

  Self.Msg.ContentType := 'text/plain';
  Check(not Self.Msg.IsMalformed,
        'Content-Type present');

  CheckEquals('',
              Self.Msg.ParseFailReason,
              'ParseFailReason when not malformed');
end;

procedure TestTIdSipMessage.TestIsMalformedMissingCallID;
begin
  Self.AddRequiredHeaders(Self.Msg);
  Self.Msg.RemoveAllHeadersNamed(CallIDHeaderFull);

  Check(Self.Msg.IsMalformed, 'Missing Call-ID header');
  CheckEquals(MissingCallID,
              Self.Msg.ParseFailReason,
              'ParseFailReason');
end;

procedure TestTIdSipMessage.TestIsMalformedMissingCseq;
begin
  Self.AddRequiredHeaders(Self.Msg);
  Self.Msg.RemoveAllHeadersNamed(CSeqHeader);

  Check(Self.Msg.IsMalformed, 'Missing CSeq header');
  CheckEquals(MissingCSeq,
              Self.Msg.ParseFailReason,
              'ParseFailReason');
end;

procedure TestTIdSipMessage.TestIsMalformedMissingFrom;
begin
  Self.AddRequiredHeaders(Self.Msg);
  Self.Msg.RemoveAllHeadersNamed(FromHeaderFull);

  Check(Self.Msg.IsMalformed, 'Missing From header');
  CheckEquals(MissingFrom,
              Self.Msg.ParseFailReason,
              'ParseFailReason');
end;

procedure TestTIdSipMessage.TestIsMalformedMissingTo;
begin
  Self.AddRequiredHeaders(Self.Msg);
  Self.Msg.RemoveAllHeadersNamed(ToHeaderFull);

  Check(Self.Msg.IsMalformed, 'Missing To header');
  CheckEquals(MissingTo,
              Self.Msg.ParseFailReason,
              'ParseFailReason');
end;

procedure TestTIdSipMessage.TestHeaderCount;
begin
  Self.Msg.ClearHeaders;
  Self.Msg.AddHeader(UserAgentHeader);

  CheckEquals(1, Self.Msg.HeaderCount, 'HeaderCount not correct');
end;

procedure TestTIdSipMessage.TestLastHop;
begin
  Self.Msg.ClearHeaders;
  Check(Self.Msg.LastHop = Self.Msg.FirstHeader(ViaHeaderFull), 'Unexpected return for empty path');

  Self.Msg.AddHeader(ViaHeaderFull);
  Check(Self.Msg.LastHop = Self.Msg.Path.LastHop, 'Unexpected return');
end;

procedure TestTIdSipMessage.TestQuickestExpiry;
begin
  Self.Msg.ClearHeaders;
  CheckEquals(0, Self.Msg.QuickestExpiry, 'No headers');

  Self.Msg.AddHeader(ExpiresHeader).Value := '10';
  CheckEquals(10, Self.Msg.QuickestExpiry, 'An Expiry header');

  Self.Msg.AddHeader(ExpiresHeader).Value := '9';
  CheckEquals(9, Self.Msg.QuickestExpiry, 'Two Expiry headers');

  Self.Msg.AddHeader(ContactHeaderFull).Value := 'sip:hiro@enki.org';
  CheckEquals(9, Self.Msg.QuickestExpiry, 'Two Expiry headers + Contact');

  Self.Msg.AddHeader(ContactHeaderFull).Value := 'sip:hiro@enki.org;expires=10';
  CheckEquals(9, Self.Msg.QuickestExpiry, 'Two Expiry headers + two Contacts');

  Self.Msg.AddHeader(ContactHeaderFull).Value := 'sip:case@fried.neurons.org;expires=8';
  CheckEquals(8, Self.Msg.QuickestExpiry, 'Two Expiry headers + three Contacts');
end;

procedure TestTIdSipMessage.TestQuickestExpiryNoExpires;
begin
  Self.Msg.AddHeader(ContactHeaderFull).Value := 'sip:hiro@enki.org;expires=10';
  CheckEquals(10, Self.Msg.QuickestExpiry, 'One Contact');

  Self.Msg.AddHeader(ContactHeaderFull).Value := 'sip:case@fried.neurons.org;expires=8';
  CheckEquals(8, Self.Msg.QuickestExpiry, 'Two Contacts');

  Self.Msg.AddHeader(ContactHeaderFull).Value := 'sip:case@fried.neurons.org;expires=22';
  CheckEquals(8, Self.Msg.QuickestExpiry, 'Three Contacts');
end;

procedure TestTIdSipMessage.TestReadBody;
var
  Len:       Integer;
  Msg:       String;
  Remainder: String;
  S:         String;
  Str:       TStringStream;
begin
  Self.Msg.ContentLength := 8;

  Msg := 'Negotium perambuians in tenebris';
  Str := TStringStream.Create(Msg);
  try
    Self.Msg.ReadBody(Str);
    CheckEquals(System.Copy(Msg, 1, 8), Self.Msg.Body, 'Body');

    Remainder := Msg;
    Delete(Remainder, 1, 8);

    Len := Length(Remainder);
    SetLength(S, Len);
    Str.Read(S[1], Len);
    CheckEquals(Remainder, S, 'Unread bits of the stream');

    Check(Pos(Self.Msg.Body, Self.Msg.RawMessage) > 0,
          'ReadBody didn''t add the body to RawMessage');
  finally
    Str.Free;
  end;
end;

procedure TestTIdSipMessage.TestReadBodyWithZeroContentLength;
var
  Len: Integer;
  S:   String;
  Str: TStringStream;
  Msg: String;
begin
  Self.Msg.ContentLength := 0;
  Msg := 'Negotium perambuians in tenebris';

  Str := TStringStream.Create(Msg);
  try
    Self.Msg.ReadBody(Str);
    CheckEquals('', Self.Msg.Body, 'Body');

    Len := Length(Msg);
    SetLength(S, Len);
    Str.Read(S[1], Len);
    CheckEquals(Msg, S, 'Unread bits of the stream');
  finally
    Str.Free;
  end;
end;

procedure TestTIdSipMessage.TestRemoveHeader;
begin
  Self.Msg.ClearHeaders;

  Self.Msg.AddHeader(ContentTypeHeaderFull);
  Check(Self.Msg.HasHeader(ContentTypeHeaderFull),
        'Content-Type wasn''t added');

  Self.Msg.RemoveHeader(Self.Msg.FirstHeader(ContentTypeHeaderFull));
  Check(not Self.Msg.HasHeader(ContentTypeHeaderFull),
        'Content-Type wasn''t removeed');
end;

procedure TestTIdSipMessage.TestRemoveHeaders;
begin
  Self.Msg.ClearHeaders;

  Self.Msg.AddHeader(ContentTypeHeaderFull);
  Self.Msg.AddHeader(ContentTypeHeaderFull);
  Self.Msg.AddHeader(ContentTypeHeaderFull);

  Self.Msg.RemoveAllHeadersNamed(ContentTypeHeaderFull);

  Check(not Self.Msg.HasHeader(ContentTypeHeaderFull),
        'Content-Type wasn''t removeed');
end;

procedure TestTIdSipMessage.TestSetCallID;
begin
  Self.Msg.CallID := '999';

  Self.Msg.CallID := '42';
  CheckEquals('42', Self.Msg.CallID, 'Call-ID not set');
end;

procedure TestTIdSipMessage.TestSetContacts;
var
  H: TIdSipHeaders;
  C: TIdSipContacts;
begin
  Self.Msg.AddHeader(ContactHeaderFull).Value := 'sip:case@fried.neurons.org';

  H := TIdSipHeaders.Create;
  try
    H.Add(ContactHeaderFull).Value := 'sips:wintermute@tessier-ashpool.co.luna';
    H.Add(ContactHeaderFull).Value := 'Wintermute <sip:wintermute@tessier-ashpool.co.luna>';
    C := TIdSipContacts.Create(H);
    try
      Self.Msg.Contacts := C;

      Check(Self.Msg.Contacts.Equals(C), 'Path not correctly set');
    finally
      C.Free;
    end;
  finally
    H.Free;
  end;
end;

procedure TestTIdSipMessage.TestSetContentLanguage;
begin
  Self.Msg.ContentLanguage := 'es';

  Self.Msg.ContentLanguage := 'en';
  CheckEquals('en', Self.Msg.ContentLanguage, 'Content-Language not set');

  Self.Msg.ContentLanguage := '';
  CheckEquals('', Self.Msg.ContentLanguage, 'Content-Language not set to blank');
  Check(not Self.Msg.HasHeader(ContentLanguageHeader),
        'Can''t have a blank Content-Language header');
end;

procedure TestTIdSipMessage.TestSetContentLength;
begin
  Self.Msg.ContentLength := 999;

  Self.Msg.ContentLength := 42;
  CheckEquals(42, Self.Msg.ContentLength, 'Content-Length not set');
end;

procedure TestTIdSipMessage.TestSetContentType;
begin
  Self.Msg.ContentType := 'text/plain';

  Self.Msg.ContentType := 'text/t140';
  CheckEquals('text/t140', Self.Msg.ContentType, 'Content-Type not set');

  Self.Msg.ContentType := '';
  CheckEquals('', Self.Msg.ContentType, 'Content-Type not set to blank');
  Check(not Self.Msg.HasHeader(ContentTypeHeaderFull),
        'Can''t have a blank Content-Type header');
end;

procedure TestTIdSipMessage.TestSetCSeq;
var
  C: TIdSipCSeqHeader;
begin
  C := TIdSipCSeqHeader.Create;
  try
    C.Value := '314159 INVITE';

    Self.Msg.CSeq := C;

    Check(Self.Msg.CSeq.Equals(C), 'CSeq not set');
  finally
    C.Free;
  end;
end;

procedure TestTIdSipMessage.TestSetFrom;
var
  From: TIdSipFromHeader;
begin
  Self.Msg.From.Value := 'Wintermute <sip:wintermute@tessier-ashpool.co.luna>';

  From := TIdSipFromHeader.Create;
  try
    From.Value := 'Case <sip:case@fried.neurons.org>';

    Self.Msg.From := From;

    CheckEquals(From.Value, Self.Msg.From.Value, 'From value not set');
  finally
    From.Free;
  end;
end;

procedure TestTIdSipMessage.TestSetPath;
var
  H: TIdSipHeaders;
  P: TIdSipViaPath;
begin
  Self.Msg.AddHeader(ViaHeaderFull).Value := 'SIP/2.0/TCP gw1.leo-ix.org;branch=z9hG4bK776asdhds';

  H := TIdSipHeaders.Create;
  try
    H.Add(ViaHeaderFull).Value := 'SIP/2.0/TCP gw2.leo-ix.org;branch=z9hG4bK776asdhds';
    H.Add(ViaHeaderFull).Value := 'SIP/2.0/TCP gw3.leo-ix.org;branch=z9hG4bK776asdhds';
    P := TIdSipViaPath.Create(H);
    try
      Self.Msg.Path := P;

      Check(Self.Msg.Path.Equals(P), 'Path not correctly set');
    finally
      P.Free;
    end;
  finally
    H.Free;
  end;
end;

procedure TestTIdSipMessage.TestSetRecordRoute;
var
  H: TIdSipHeaders;
  P: TIdSipRecordRoutePath;
begin
  Self.Msg.AddHeader(RecordRouteHeader).Value := '<sip:gw1.leo-ix.org>';

  H := TIdSipHeaders.Create;
  try
    H.Add(RecordRouteHeader).Value := '<sip:gw2.leo-ix.org>';
    H.Add(RecordRouteHeader).Value := '<sip:gw3.leo-ix.org;lr>';
    P := TIdSipRecordRoutePath.Create(H);
    try
      Self.Msg.RecordRoute := P;

      Check(Self.Msg.RecordRoute.Equals(P), 'Path not correctly set');
    finally
      P.Free;
    end;
  finally
    H.Free;
  end;
end;

procedure TestTIdSipMessage.TestSetSipVersion;
begin
  Self.Msg.SIPVersion := 'SIP/2.0';

  Self.Msg.SIPVersion := 'SIP/7.7';
  CheckEquals('SIP/7.7', Self.Msg.SipVersion, 'SipVersion not set');
end;

procedure TestTIdSipMessage.TestSetTo;
var
  ToHeader: TIdSipToHeader;
begin
  Self.Msg.ToHeader.Value := 'Wintermute <sip:wintermute@tessier-ashpool.co.luna>';

  ToHeader := TIdSipToHeader.Create;
  try
    ToHeader.Value := 'Case <sip:case@fried.neurons.org>';

    Self.Msg.ToHeader := ToHeader;

    CheckEquals(ToHeader.Value, Self.Msg.ToHeader.Value, 'To value not set');
  finally
    ToHeader.Free;
  end;
end;

procedure TestTIdSipMessage.TestWillEstablishDialog;
var
  I, J:    Integer;
  Request: TIdSipRequest;
  Response: TIdSipResponse;
begin
  Request := TIdSipRequest.Create;
  try
    Response := TIdSipResponse.Create;
    try
      for I := Low(AllMethods) to High(AllMethods) do
        for J := Low(AllResponses) to High(AllResponses) do begin
          Request.Method := AllMethods[I];
          Response.StatusCode := AllResponses[J];

          Check((Request.IsInvite and Response.IsOK)
              = TIdSipMessage.WillEstablishDialog(Request, Response),
                AllMethods[I] + ' + ' + Response.StatusText);
        end;
    finally
      Response.Free;
    end;
  finally
    Request.Free;
  end;
end;

//******************************************************************************
//* TestTIdSipRequest                                                          *
//******************************************************************************
//* TestTIdSipRequest Public methods *******************************************

procedure TestTIdSipRequest.SetUp;
begin
  inherited SetUp;

  Self.Msg.SIPVersion := SIPVersion;
  (Self.Msg as TIdSipRequest).Method := 'foo';
  (Self.Msg as TIdSipRequest).RequestUri.Uri := 'sip:foo';

  Self.Request  := TIdSipTestResources.CreateBasicRequest;
  Self.Response := TIdSipTestResources.CreateBasicResponse;
end;

procedure TestTIdSipRequest.TearDown;
begin
  Self.Response.Free;
  Self.Request.Free;

  inherited TearDown;
end;

//* TestTIdSipRequest Protected methods ****************************************

function TestTIdSipRequest.MessageType: TIdSipMessageClass;
begin
  Result := TIdSipRequest;
end;

//* TestTIdSipRequest Private methods ******************************************

procedure TestTIdSipRequest.CheckBasicRequest(Msg: TIdSipMessage;
                                             CheckBody: Boolean = true);
begin
  CheckEquals(TIdSipRequest.Classname, Msg.ClassName, 'Class type');

  CheckEquals('INVITE',
              (Msg as TIdSipRequest).Method,
              'Method');
  CheckEquals('sip:wintermute@tessier-ashpool.co.luna',
              (Msg as TIdSipRequest).RequestUri.URI,
              'Request-URI');
  CheckEquals(70, (Msg as TIdSipRequest).MaxForwards, 'MaxForwards');
  CheckEquals(9,  Msg.HeaderCount, 'Header count');

  Self.CheckBasicMessage(Msg, CheckBody);
end;

//* TestTIdSipRequest Published methods ****************************************

procedure TestTIdSipRequest.TestAckForEstablishingDialog;
var
  Ack: TIdSipRequest;
begin
  Self.Request.Method      := MethodInvite;
  Self.Response.StatusCode := SIPOK;

  Ack := Self.Request.AckFor(Self.Response);
  try
    Check(Ack.IsAck, 'Method');
    CheckEquals(Self.Request.CallID, Ack.CallID, 'Call-ID');
    CheckEquals(Self.Request.From.Address.AsString,
                Ack.From.Address.AsString,
                'From address');
    CheckEquals(Self.Request.From.Tag,
                Ack.From.Tag,
                'From tag');
    CheckEquals(Self.Request.RequestUri.Uri,
                Ack.RequestUri.Uri,
                'Request-URI');
    CheckEquals(Self.Request.ToHeader.Address.AsString,
                Ack.ToHeader.Address.AsString,
                'To address');
    CheckEquals(Self.Request.ToHeader.Tag,
                Ack.ToHeader.Tag,
                'To tag');
    CheckEquals(1, Ack.Path.Count, 'Via path hop count');
    CheckEquals(Self.Response.LastHop.Value,
                Ack.LastHop.Value,
                'Via last hop');
    CheckNotEquals(Self.Response.LastHop.Branch,
                Ack.LastHop.Branch,
                'Via last hop branch');
    CheckEquals(Self.Request.Cseq.SequenceNo,
                Ack.Cseq.SequenceNo,
                'CSeq sequence no');
    CheckEquals(MethodAck,
                Ack.Cseq.Method,
                'CSeq method');
  finally
    Ack.Free;
  end;
end;

procedure TestTIdSipRequest.TestAckFor;
var
  Ack: TIdSipRequest;
begin
  Self.Request.Method      := MethodInvite;
  Self.Response.StatusCode := SIPNotFound;

  Ack := Self.Request.AckFor(Self.Response);
  try
    Check(Ack.IsAck, 'Method');
    CheckEquals(Self.Request.CallID, Ack.CallID, 'Call-ID');
    CheckEquals(Self.Request.From.AsString,
                Ack.From.AsString,
                'From');
    CheckEquals(Self.Request.RequestUri.Uri,
                Ack.RequestUri.Uri,
                'Request-URI');
    CheckEquals(Self.Response.ToHeader.AsString,
                Ack.ToHeader.AsString,
                'To');
    CheckEquals(1, Ack.Path.Count, 'Via path hop count');
    CheckEquals(Self.Response.LastHop.Value,
                Ack.LastHop.Value,
                'Via last hop');
    CheckEquals(Self.Response.LastHop.Branch,
                Ack.LastHop.Branch,
                'Via last hop branch');
    CheckEquals(Self.Request.Cseq.SequenceNo,
                Ack.Cseq.SequenceNo,
                'CSeq sequence no');
    CheckEquals(MethodAck,
                Ack.Cseq.Method,
                'CSeq method');
  finally
    Ack.Free;
  end;
end;

procedure TestTIdSipRequest.TestAckForWithAuthentication;
var
  Ack: TIdSipRequest;
begin
  Self.Request.Method := MethodInvite;
  Self.Request.AddHeader(AuthorizationHeader).Value := 'foo';
  Self.Request.AddHeader(ProxyAuthorizationHeader).Value := 'foo';

  Ack := Self.Request.AckFor(Self.Response);
  try
    Check(Ack.HasHeader(AuthorizationHeader),
          'No Authorization header');
    Check(Ack.FirstHeader(AuthorizationHeader).Equals(Self.Request.FirstHeader(AuthorizationHeader)),
          'Authorization');

    Check(Ack.HasHeader(ProxyAuthorizationHeader),
          'No Proxy-Authorization header');
    Check(Ack.FirstHeader(ProxyAuthorizationHeader).Equals(Self.Request.FirstHeader(ProxyAuthorizationHeader)),
          'Proxy-Authorization');
  finally
    Ack.Free;
  end;
end;

procedure TestTIdSipRequest.TestAckForWithRoute;
var
  Ack: TIdSipRequest;
begin
  Self.Request.Method      := MethodInvite;
  Self.Response.StatusCode := SIPRequestTimeout;

  Self.Request.AddHeader(RouteHeader).Value := '<sip:gw1.tessier-ashpool.co.luna;lr>';
  Self.Request.AddHeader(RouteHeader).Value := '<sip:gw2.tessier-ashpool.co.luna>';

  Ack := Self.Request.AckFor(Self.Response);
  try
    Check(Self.Request.Route.Equals(Ack.Route),
          'Route path');
  finally
    Ack.Free;
  end;
end;

procedure TestTIdSipRequest.TestAddressOfRecord;
begin
  CheckEquals(Self.Request.ToHeader.AsAddressOfRecord,
              Self.Request.AddressOfRecord,
              'AddressOfRecord');

  Self.Request.RequestUri.Uri := 'sip:proxy.tessier-ashpool.co.luna';
  CheckEquals(Self.Request.ToHeader.AsAddressOfRecord,
              Self.Request.AddressOfRecord,
              'AddressOfRecord');
end;

procedure TestTIdSipRequest.TestAssign;
var
  R: TIdSipRequest;
begin
  R := TIdSipRequest.Create;
  try
    R.SIPVersion := 'SIP/1.5';
    R.Method := 'NewMethod';
    R.RequestUri.URI := 'sip:wintermute@tessier-ashpool.co.luna';
    R.AddHeader(ViaHeaderFull).Value := 'SIP/2.0/TCP gw1.leo-ix.org;branch=z9hG4bK776asdhds';
    R.ContentLength := 5;
    R.Body := 'hello';

    Self.Request.Assign(R);
    CheckEquals(R.SIPVersion,    Self.Request.SipVersion,    'SIP-Version');
    CheckEquals(R.Method,        Self.Request.Method,        'Method');
    CheckEquals(R.RequestUri,    Self.Request.RequestUri,    'Request-URI');

    Check(R.Headers.Equals(Self.Request.Headers),
          'Headers not assigned properly');
  finally
    R.Free;
  end;
end;

procedure TestTIdSipRequest.TestAssignBad;
var
  P: TPersistent;
begin
  P := TPersistent.Create;
  try
    try
      Self.Request.Assign(P);
      Fail('Failed to bail out assigning a TPersistent to a TIdSipRequest');
    except
      on EConvertError do;
    end;
  finally
    P.Free;
  end;
end;

procedure TestTIdSipRequest.TestAsString;
var
  Req: TIdSipRequest;
begin
  Req := TIdSipMessage.ReadRequestFrom(Self.Request.AsString);
  try
    Check(Req.Equals(Self.Request), 'AsString');
  finally
    Req.Free;
  end;
end;

procedure TestTIdSipRequest.TestAsStringNoMaxForwardsSet;
begin
  Check(Pos(MaxForwardsHeader, Self.Request.AsString) > 0,
        'No Max-Forwards header');
end;

procedure TestTIdSipRequest.TestAuthorizationFor;
var
  Auth1:     TIdSipHeader;
  Auth2:     TIdSipHeader;
  ProxyAuth: TIdSipHeader;
begin
  ProxyAuth := Self.Request.AddHeader(ProxyAuthorizationHeader);
  Auth1     := Self.Request.AddHeader(AuthorizationHeader);
  Auth2     := Self.Request.AddHeader(AuthorizationHeader);

  ProxyAuth.Value := 'Digest realm="Auth1"';
  Auth1.Value     := 'Digest realm="Auth1"';
  Auth2.Value     := 'Digest realm="Auth2"';

  CheckNull(Self.Request.AuthorizationFor('Unknown realm'),
            'Unknown realm');
  Check(Auth1 = Self.Request.AuthorizationFor('Auth1'),
        'Auth1');
  Check(Auth2 = Self.Request.AuthorizationFor('Auth2'),
        'Auth2');
end;

procedure TestTIdSipRequest.TestCopy;
var
  Cancel: TIdSipRequest;
  Copy:   TIdSipMessage;
begin
  Cancel := Self.Request.CreateCancel;
  try
    Cancel.Body := 'Foo';
    Cancel.ContentLength := Length(Cancel.Body);
    Cancel.ContentType   := 'text/plain';

    Copy := Cancel.Copy;
    try
      Check(Copy.Equals(Cancel), 'Copy = Cancel');
      Check(Cancel.Equals(Copy), 'Cancel = Copy');
    finally
      Copy.Free;
    end;
  finally
    Cancel.Free;
  end;
end;

procedure TestTIdSipRequest.TestCopyMessageMutatedFromString;
var
  Copy:     TIdSipRequest;
  Original: TIdSipRequest;
begin
  Original := TIdSipMessage.ReadRequestFrom(LocalLoopRequest) as TIdSipRequest;
  try
    Original.Method := Original.Method + '1';

    Copy := Original.Copy as TIdSipRequest;
    try
      CheckEquals(Original.Method,
                  Copy.Method,
                  'Newly changed values not copied properly');
    finally
      Copy.Free;
    end;
  finally
    Original.Free;
  end;
end;

procedure TestTIdSipRequest.TestCreateCancel;
var
  Cancel: TIdSipRequest;
begin
  Cancel := Self.Request.CreateCancel;
  try
    CheckEquals(MethodCancel, Cancel.Method, 'Unexpected method');
    CheckEquals(MethodCancel,
                Cancel.CSeq.Method,
                'CSeq method');
    Check(Self.Request.RequestUri.Equals(Cancel.RequestUri),
          'Request-URI');
    CheckEquals(Self.Request.CallID,
                Cancel.CallID,
                'Call-ID header');
    Check(Self.Request.ToHeader.Equals(Cancel.ToHeader),
          'To header');
    CheckEquals(Self.Request.CSeq.SequenceNo,
                Cancel.CSeq.SequenceNo,
                'CSeq numerical portion');
    Check(Self.Request.From.Equals(Cancel.From),
          'From header');
    CheckEquals(1,
                Cancel.Path.Length,
                'Via headers');
  finally
    Cancel.Free;
  end;
end;

procedure TestTIdSipRequest.TestCreateCancelANonInviteRequest;
begin
  Self.Request.Method := MethodOptions;
  try
    Self.Request.CreateCancel;
    Fail('Failed to bail out of creating a CANCEL for a non-INVITE request');
  except
    on EAssertionFailed do;
  end;
end;

procedure TestTIdSipRequest.TestCreateCancelWithProxyRequire;
var
  Cancel: TIdSipRequest;
begin
  Self.Request.AddHeader(ProxyRequireHeader).Value := 'foofoo';

  Cancel := Self.Request.CreateCancel;
  try
    Check(not Cancel.HasHeader(ProxyRequireHeader),
          'Proxy-Require headers copied');
  finally
    Cancel.Free;
  end;
end;

procedure TestTIdSipRequest.TestCreateCancelWithRequire;
var
  Cancel: TIdSipRequest;
begin
  Self.Request.AddHeader(RequireHeader).Value := 'foofoo, barbar';

  Cancel := Self.Request.CreateCancel;
  try
    Check(not Cancel.HasHeader(RequireHeader),
          'Require headers copied');
  finally
    Cancel.Free;
  end;
end;

procedure TestTIdSipRequest.TestCreateCancelWithRoute;
var
  Cancel: TIdSipRequest;
begin
  Self.Request.AddHeader(RouteHeader).Value := '<sip:127.0.0.1>';
  Self.Request.AddHeader(RouteHeader).Value := '<sip:127.0.0.2>';

  Cancel := Self.Request.CreateCancel;
  try
    Check(Self.Request.Route.Equals(Cancel.Route),
          'Route headers not copied');
  finally
    Cancel.Free;
  end;
end;

procedure TestTIdSipRequest.TestDestinationUri;
const
  ProxyUri   = '';
  RequestUri = '';
begin
  Self.Request.RequestUri.Uri := RequestUri;

  CheckEquals(RequestUri, Self.Request.DestinationUri, 'No Route headers');

  Self.Request.AddHeader(RouteHeader).Value := '<' + ProxyUri + '>';
  CheckEquals(RequestUri, Self.Request.DestinationUri, 'A strict router');

  Self.Request.FirstRoute.IsLooseRoutable := true;
  CheckEquals(ProxyUri, Self.Request.DestinationUri, 'A loose router');
end;

procedure TestTIdSipRequest.TestEqualsComplexMessages;
var
  R: TIdSipRequest;
begin
  R := TIdSipTestResources.CreateBasicRequest;
  try
    Check(Self.Request.Equals(R), 'Request = R');
    Check(R.Equals(Self.Request), 'R = Request');
  finally
    R.Free
  end;
end;

procedure TestTIdSipRequest.TestEqualsDifferentBodies;
var
  R1, R2: TIdSipRequest;
begin
  R1 := TIdSipRequest.Create;
  try
    R2 := TIdSipRequest.Create;
    try
      R1.Body := 'non-blank';

      Check(not R1.Equals(R2), 'R1 <> R2');
      Check(not R2.Equals(R1), 'R2 <> R1');
    finally
      R2.Free;
    end;
  finally
    R1.Free;
  end;
end;

procedure TestTIdSipRequest.TestEqualsDifferentHeaders;
var
  R1, R2: TIdSipRequest;
begin
  R1 := TIdSipRequest.Create;
  try
    R2 := TIdSipRequest.Create;
    try
      R1.AddHeader(ViaHeaderFull);

      Check(not R1.Equals(R2), 'R1 <> R2');
      Check(not R2.Equals(R1), 'R2 <> R1');
    finally
      R2.Free;
    end;
  finally
    R1.Free;
  end;
end;

procedure TestTIdSipRequest.TestEqualsDifferentMethod;
var
  R1, R2: TIdSipRequest;
begin
  R1 := TIdSipRequest.Create;
  try
    R2 := TIdSipRequest.Create;
    try
      R1.Method := MethodInvite;
      R2.Method := MethodOptions;

      Check(not R1.Equals(R2), 'R1 <> R2');
      Check(not R2.Equals(R1), 'R2 <> R1');
    finally
      R2.Free;
    end;
  finally
    R1.Free;
  end;
end;

procedure TestTIdSipRequest.TestEqualsDifferentRequestUri;
var
  R1, R2: TIdSipRequest;
begin
  R1 := TIdSipRequest.Create;
  try
    R2 := TIdSipRequest.Create;
    try
      R1.RequestUri.URI := 'sip:wintermute@tessier-ashpool.co.luna';
      R1.RequestUri.URI := 'sip:case@fried.neurons.org';

      Check(not R1.Equals(R2), 'R1 <> R2');
      Check(not R2.Equals(R1), 'R2 <> R1');
    finally
      R2.Free;
    end;
  finally
    R1.Free;
  end;
end;

procedure TestTIdSipRequest.TestEqualsDifferentSipVersion;
var
  R1, R2: TIdSipRequest;
begin
  R1 := TIdSipRequest.Create;
  try
    R2 := TIdSipRequest.Create;
    try
      R1.SIPVersion := 'SIP/2.0';
      R2.SIPVersion := 'SIP/2.1';

      Check(not R1.Equals(R2), 'R1 <> R2');
      Check(not R2.Equals(R1), 'R2 <> R1');
    finally
      R2.Free;
    end;
  finally
    R1.Free;
  end;
end;

procedure TestTIdSipRequest.TestEqualsFromAssign;
var
  Req: TIdSipRequest;
begin
  Req := TIdSipRequest.Create;
  try
    Req.Assign(Self.Request);

    Check(Req.Equals(Self.Request), 'Assigned = Original');
    Check(Self.Request.Equals(Req), 'Original = Assigned');
  finally
    Req.Free;
  end;
end;

procedure TestTIdSipRequest.TestEqualsResponse;
var
  Req: TIdSipRequest;
  Res: TIdSipResponse;
begin
  Req := TIdSipRequest.Create;
  try
    Res := TIdSipResponse.Create;
    try
      Check(not Req.Equals(Res), 'Req <> Res');
    finally
      Res.Free;
    end;
  finally
    Req.Free;
  end;
end;

procedure TestTIdSipRequest.TestEqualsTrivial;
var
  R1, R2: TIdSipRequest;
begin
  R1 := TIdSipRequest.Create;
  try
    R2 := TIdSipRequest.Create;
    try
      Check(R1.Equals(R2), 'R1 = R2');
      Check(R2.Equals(R1), 'R2 = R1');
    finally
      R2.Free;
    end;
  finally
    R1.Free;
  end;
end;

procedure TestTIdSipRequest.TestFirstAuthorization;
var
  A: TIdSipHeader;
begin
  Self.Request.ClearHeaders;

  CheckNotNull(Self.Request.FirstAuthorization, 'Authorization not present');
  CheckEquals(1, Self.Request.HeaderCount, 'Authorization not auto-added');

  A := Self.Request.FirstHeader(AuthorizationHeader);
  Self.Request.AddHeader(AuthorizationHeader);

  Check(A = Self.Request.FirstAuthorization, 'Wrong Authorization');
end;

procedure TestTIdSipRequest.TestFirstEvent;
var
  A: TIdSipHeader;
begin
  Self.Request.ClearHeaders;

  CheckNotNull(Self.Request.FirstEvent, 'Event not present');
  CheckEquals(1, Self.Request.HeaderCount, 'Event not auto-added');

  A := Self.Request.FirstHeader(EventHeaderFull);
  Self.Request.AddHeader(EventHeaderFull);

  Check(A = Self.Request.FirstEvent, 'Wrong Event');
end;

procedure TestTIdSipRequest.TestFirstProxyAuthorization;
var
  A: TIdSipHeader;
begin
  Self.Request.ClearHeaders;

  CheckNotNull(Self.Request.FirstProxyAuthorization, 'Proxy-Authorization not present');
  CheckEquals(1, Self.Request.HeaderCount, 'Proxy-Authorization not auto-added');

  A := Self.Request.FirstHeader(ProxyAuthorizationHeader);
  Self.Request.AddHeader(AuthorizationHeader);

  Check(A = Self.Request.FirstProxyAuthorization, 'Wrong Proxy-Authorization');
end;

procedure TestTIdSipRequest.TestFirstProxyRequire;
var
  P: TIdSipHeader;
begin
  Self.Request.ClearHeaders;

  CheckNotNull(Self.Request.FirstProxyRequire, 'Proxy-Require not present');
  CheckEquals(1, Self.Request.HeaderCount, 'Proxy-Require not auto-added');

  P := Self.Request.FirstHeader(ProxyRequireHeader);
  Self.Request.AddHeader(ProxyRequireHeader);

  Check(P = Self.Request.FirstProxyRequire, 'Wrong Proxy-Require');
end;

procedure TestTIdSipRequest.TestFirstReplaces;
var
  A: TIdSipHeader;
begin
  Self.Request.ClearHeaders;

  CheckNotNull(Self.Request.FirstReplaces, 'Replaces not present');
  CheckEquals(1, Self.Request.HeaderCount, 'Replaces not auto-added');

  A := Self.Request.FirstHeader(ReplacesHeader);
  Self.Request.AddHeader(ReplacesHeader);

  Check(A = Self.Request.FirstReplaces, 'Wrong Replaces');
  Check(Self.Request.IsMalformed,
        'A request with multiple Replaces header should be malformed');
end;

procedure TestTIdSipRequest.TestFirstRoute;
var
  A: TIdSipHeader;
begin
  Self.Request.ClearHeaders;

  CheckNotNull(Self.Request.FirstRoute, 'Route not present');
  CheckEquals(1, Self.Request.HeaderCount, 'Route not auto-added');

  A := Self.Request.FirstHeader(RouteHeader);
  Self.Request.AddHeader(RouteHeader);

  Check(A = Self.Request.FirstRoute, 'Wrong Route');
end;

procedure TestTIdSipRequest.TestHasAuthorization;
begin
  Check(not Self.Request.HasHeader(AuthorizationHeader),
        'Sanity check');

  Check(not Self.Request.HasAuthorization,
        'New request');


  Self.Request.AddHeader(AuthorizationHeader);
  Check(Self.Request.HasAuthorization,
        'Lies! There is too a Authorization header!');
end;

procedure TestTIdSipRequest.TestHasAuthorizationFor;
begin
  Check(not Self.Request.HasHeader(AuthorizationHeader),
        'Sanity check');

  Check(not Self.Request.HasAuthorizationFor('leo-ix.net'),
        'New request');

  Self.Request.AddHeader(AuthorizationHeader);
  Check(not Self.Request.HasAuthorizationFor('leo-ix.net'),
        'Still no leo-ix.net realm though');

  Self.Request.AddHeader(AuthorizationHeader).Value := 'Digest realm="leo-ix.net"';
  Check(Self.Request.HasAuthorizationFor('leo-ix.net'),
        'Cannot find existing Authorization');
end;

procedure TestTIdSipRequest.TestHasProxyAuthorization;
begin
  Check(not Self.Request.HasHeader(AuthorizationHeader),
        'Sanity check');

  Check(not Self.Request.HasAuthorization,
        'New request');


  Self.Request.AddHeader(AuthorizationHeader);
  Check(Self.Request.HasAuthorization,
        'Lies! There is too a Authorization header!');
end;

procedure TestTIdSipRequest.TestHasProxyAuthorizationFor;
begin
  Check(not Self.Request.HasHeader(ProxyAuthorizationHeader),
        'Sanity check');

  Check(not Self.Request.HasProxyAuthorizationFor('leo-ix.net'),
        'New request');

  Self.Request.AddHeader(ProxyAuthorizationHeader);
  Check(not Self.Request.HasProxyAuthorizationFor('leo-ix.net'),
        'Still no leo-ix.net realm though');

  Self.Request.AddHeader(ProxyAuthorizationHeader).Value := 'Digest realm="leo-ix.net"';
  Check(Self.Request.HasProxyAuthorizationFor('leo-ix.net'),
        'Cannot find existing Proxy-Authorization');
end;

procedure TestTIdSipRequest.TestHasReplaces;
begin
  Check(not Self.Request.HasHeader(ReplacesHeader),
        'Sanity check');

  Check(not Self.Request.HasReplaces,
        'New request');


  Self.Request.AddHeader(ReplacesHeader);
  Check(Self.Request.HasReplaces,
        'Lies! There is too a Replaces header!');
end;

procedure TestTIdSipRequest.TestHasRoute;
begin
  Check(not Self.Request.HasHeader(RouteHeader),
        'Sanity check');

  Check(not Self.Request.HasRoute,
        'New request');


  Self.Request.AddHeader(RouteHeader);
  Check(Self.Request.HasRoute,
        'Lies! There is too a Route header!');
end;

procedure TestTIdSipRequest.TestHasSipsUri;
begin
  Self.Request.RequestUri.URI := 'tel://999';
  Check(not Self.Request.HasSipsUri, 'tel URI');

  Self.Request.RequestUri.URI := 'sip:wintermute@tessier-ashpool.co.luna';
  Check(not Self.Request.HasSipsUri, 'sip URI');

  Self.Request.RequestUri.URI := 'sips:wintermute@tessier-ashpool.co.luna';
  Check(Self.Request.HasSipsUri, 'sips URI');
end;

procedure TestTIdSipRequest.TestInSameDialogAsRequest;
var
  Req: TIdSipRequest;
begin
  Req := TIdSipRequest.Create;
  try
    Req.Assign(Self.Request);
    Check(Req.InSameDialogAs(Self.Request),
          'Req not in same dialog as Self.Request');
    Check(Self.Request.InSameDialogAs(Req),
          'Self.Request not in same dialog as Req');

    Req.From.Tag := Self.Request.From.Tag + '1';
    Check(not Self.Request.InSameDialogAs(Req),
          'From tag differs');

     Req.From.Tag := Self.Request.From.Tag;
     Req.ToHeader.Tag := Self.Request.ToHeader.Tag + '1';
     Check(not Self.Request.InSameDialogAs(Req),
           'To tag differs');

     Req.ToHeader.Tag := Self.Request.ToHeader.Tag;
     Req.CallID := '1' + Self.Request.CallID;
     Check(not Self.Request.InSameDialogAs(Req),
           'Call-ID tag differs');
  finally
    Req.Free;
  end;
end;

procedure TestTIdSipRequest.TestInSameDialogAsResponse;
begin
  Self.Response.CallID       := Self.Request.CallID;
  Self.Response.From.Tag     := Self.Request.From.Tag;
  Self.Response.ToHeader.Tag := Self.Request.ToHeader.Tag;

  Check(Self.Request.InSameDialogAs(Self.Response),
        'Response not in same dialog as request');

  Self.Response.CallID := '1' + Self.Request.CallID;
  Check(not Self.Request.InSameDialogAs(Self.Response),
        'Call-ID differs');

  Self.Response.CallID   := Self.Request.CallID;
  Self.Response.From.Tag := Self.Request.From.Tag + '1';
  Check(not Self.Request.InSameDialogAs(Self.Response),
        'From tag differs');

  Self.Response.From.Tag     := Self.Request.From.Tag;
  Self.Response.ToHeader.Tag := Self.Request.ToHeader.Tag + '1';
  Check(not Self.Request.InSameDialogAs(Self.Response),
        'To tag differs');
end;

procedure TestTIdSipRequest.TestIsAck;
begin
  Self.Request.Method := MethodAck;
  Check(Self.Request.IsAck, MethodAck);

  Self.Request.Method := MethodBye;
  Check(not Self.Request.IsAck, MethodBye);

  Self.Request.Method := MethodCancel;
  Check(not Self.Request.IsAck, MethodCancel);

  Self.Request.Method := MethodInvite;
  Check(not Self.Request.IsAck, MethodInvite);

  Self.Request.Method := MethodOptions;
  Check(not Self.Request.IsAck, MethodOptions);

  Self.Request.Method := MethodRefer;
  Check(not Self.Request.IsOptions, MethodRefer);

  Self.Request.Method := MethodRegister;
  Check(not Self.Request.IsAck, MethodRegister);

  Self.Request.Method := 'XXX';
  Check(not Self.Request.IsAck, 'XXX');
end;

procedure TestTIdSipRequest.TestIsBye;
begin
  Self.Request.Method := MethodAck;
  Check(not Self.Request.IsBye, MethodAck);

  Self.Request.Method := MethodBye;
  Check(Self.Request.IsBye, MethodBye);

  Self.Request.Method := MethodCancel;
  Check(not Self.Request.IsBye, MethodCancel);

  Self.Request.Method := MethodInvite;
  Check(not Self.Request.IsBye, MethodInvite);

  Self.Request.Method := MethodOptions;
  Check(not Self.Request.IsBye, MethodOptions);

  Self.Request.Method := MethodRefer;
  Check(not Self.Request.IsOptions, MethodRefer);

  Self.Request.Method := MethodRegister;
  Check(not Self.Request.IsBye, MethodRegister);

  Self.Request.Method := 'XXX';
  Check(not Self.Request.IsBye, 'XXX');
end;

procedure TestTIdSipRequest.TestIsCancel;
begin
  Self.Request.Method := MethodAck;
  Check(not Self.Request.IsCancel, MethodAck);

  Self.Request.Method := MethodBye;
  Check(not Self.Request.IsCancel, MethodBye);

  Self.Request.Method := MethodCancel;
  Check(Self.Request.IsCancel, MethodCancel);

  Self.Request.Method := MethodInvite;
  Check(not Self.Request.IsCancel, MethodInvite);

  Self.Request.Method := MethodOptions;
  Check(not Self.Request.IsCancel, MethodOptions);

  Self.Request.Method := MethodRefer;
  Check(not Self.Request.IsOptions, MethodRefer);

  Self.Request.Method := MethodRegister;
  Check(not Self.Request.IsCancel, MethodRegister);

  Self.Request.Method := 'XXX';
  Check(not Self.Request.IsCancel, 'XXX');
end;

procedure TestTIdSipRequest.TestIsInvite;
begin
  Self.Request.Method := MethodAck;
  Check(not Self.Request.IsInvite, MethodAck);

  Self.Request.Method := MethodBye;
  Check(not Self.Request.IsInvite, MethodBye);

  Self.Request.Method := MethodCancel;
  Check(not Self.Request.IsInvite, MethodCancel);

  Self.Request.Method := MethodInvite;
  Check(Self.Request.IsInvite, MethodInvite);

  Self.Request.Method := MethodOptions;
  Check(not Self.Request.IsInvite, MethodOptions);

  Self.Request.Method := MethodRefer;
  Check(not Self.Request.IsOptions, MethodRefer);

  Self.Request.Method := MethodRegister;
  Check(not Self.Request.IsInvite, MethodRegister);

  Self.Request.Method := 'XXX';
  Check(not Self.Request.IsInvite, 'XXX');
end;

procedure TestTIdSipRequest.TestIsMalformedCSeqMethod;
begin
  Self.Request.Method := MethodInvite;
  Self.Request.CSeq.Method := Self.Request.Method;

  Check(not Self.Request.IsMalformed,
       'CSeq method matches request method');

  Self.Request.CSeq.Method := Self.Request.CSeq.Method + '1';;
  Check(Self.Request.IsMalformed,
       'CSeq method matches request method');
  CheckEquals(CSeqMethodMismatch,
              Self.Request.ParseFailReason,
              'ParseFailReason');
end;

procedure TestTIdSipRequest.TestIsMalformedMethod;
var
  ExpectedReason: String;
begin
  Self.Request.ClearHeaders;
  Self.AddRequiredHeaders(Self.Request);
  Self.Request.Method := 'Bad"Method';

  ExpectedReason := Format(MalformedToken, [MethodToken, Self.Request.Method]);

  Check(Self.Request.IsMalformed, 'Bad Method');
  CheckEquals(ExpectedReason,
              Self.Request.ParseFailReason,
              'ParseFailReason');
end;

procedure TestTIdSipRequest.TestIsMalformedMissingMaxForwards;
begin
  Self.AddRequiredHeaders(Self.Request);
  Self.Request.RemoveAllHeadersNamed(MaxForwardsHeader);

  Check(Self.Request.IsMalformed, 'Missing Max-Forwards header');
  CheckEquals(MissingMaxForwards,
              Self.Request.ParseFailReason,
              'ParseFailReason');
end;

procedure TestTIdSipRequest.TestIsMalformedMissingVia;
begin
  Self.AddRequiredHeaders(Self.Request);
  Self.Request.RemoveAllHeadersNamed(ViaHeaderFull);

  Check(Self.Request.IsMalformed, 'Missing Via header');

  CheckEquals(MissingVia,
              Self.Request.ParseFailReason,
              'ParseFailReason');
end;

procedure TestTIdSipRequest.TestIsMalformedSipVersion;
const
  MalformedMessage = 'INVITE sip:wintermute@tessier-ashpool.co.luna SIP/;2.0'#13#10
                   + 'Via: SIP/2.0/UDP c.bell-tel.com;branch=z9hG4bK0'#13#10
                   + 'Max-Forwards: 70'#13#10
                   + 'From: sip:case@fried-neurons.org;tag=0'#13#10
                   + 'To: sip:wintermute@tessier-ashpool.co.luna'#13#10
                   + 'Call-ID: 0'#13#10
                   + 'CSeq: 1 INVITE'#13#10
                   + #13#10;
var
  ExpectedReason: String;
  Msg:            TIdSipMessage;
begin
  Check(Length(MalformedMessage) < 255,
        'Sanity check: DUnit uses ShortStrings, and MalformedMessage contains '
      + 'too much data');

  ExpectedReason := Format(InvalidSipVersion, ['SIP/;2.0']);

  Msg := TIdSipMessage.ReadMessageFrom(MalformedMessage);
  try
    Check(Msg.IsMalformed,
          'Msg has invalid SIP-Version, but not branded as such');
    CheckEquals(ExpectedReason,
                Msg.ParseFailReason,
                'Unexpected parse error reason');
    CheckEquals(MalformedMessage,
                Msg.RawMessage,
                'Unexpected raw message');
  finally
    Msg.Free;
  end;
end;

procedure TestTIdSipRequest.TestIsNotify;
begin
  Self.Request.Method := MethodAck;
  Check(not Self.Request.IsOptions, MethodAck);

  Self.Request.Method := MethodNotify;
  Check(Self.Request.IsNotify, MethodNotify);
end;

procedure TestTIdSipRequest.TestIsOptions;
begin
  Self.Request.Method := MethodAck;
  Check(not Self.Request.IsOptions, MethodAck);

  Self.Request.Method := MethodBye;
  Check(not Self.Request.IsOptions, MethodBye);

  Self.Request.Method := MethodCancel;
  Check(not Self.Request.IsOptions, MethodCancel);

  Self.Request.Method := MethodInvite;
  Check(not Self.Request.IsOptions, MethodInvite);

  Self.Request.Method := MethodOptions;
  Check(Self.Request.IsOptions, MethodOptions);

  Self.Request.Method := MethodRefer;
  Check(not Self.Request.IsOptions, MethodRefer);

  Self.Request.Method := MethodRegister;
  Check(not Self.Request.IsOptions, MethodRegister);

  Self.Request.Method := 'XXX';
  Check(not Self.Request.IsOptions, 'XXX');
end;

procedure TestTIdSipRequest.TestIsRefer;
begin
  Self.Request.Method := MethodAck;
  Check(not Self.Request.IsRefer, MethodAck);

  Self.Request.Method := MethodBye;
  Check(not Self.Request.IsRefer, MethodBye);

  Self.Request.Method := MethodCancel;
  Check(not Self.Request.IsRefer, MethodCancel);

  Self.Request.Method := MethodInvite;
  Check(not Self.Request.IsRefer, MethodInvite);

  Self.Request.Method := MethodOptions;
  Check(not Self.Request.IsRefer, MethodOptions);

  Self.Request.Method := MethodRefer;
  Check(Self.Request.IsRefer, MethodRefer);

  Self.Request.Method := MethodRegister;
  Check(not Self.Request.IsOptions, MethodRegister);

  Self.Request.Method := 'XXX';
  Check(not Self.Request.IsRefer, 'XXX');
end;

procedure TestTIdSipRequest.TestIsRegister;
begin
  Self.Request.Method := MethodAck;
  Check(not Self.Request.IsRegister, MethodAck);

  Self.Request.Method := MethodBye;
  Check(not Self.Request.IsRegister, MethodBye);

  Self.Request.Method := MethodCancel;
  Check(not Self.Request.IsRegister, MethodCancel);

  Self.Request.Method := MethodInvite;
  Check(not Self.Request.IsRegister, MethodInvite);

  Self.Request.Method := MethodOptions;
  Check(not Self.Request.IsRegister, MethodOptions);

  Self.Request.Method := MethodRefer;
  Check(not Self.Request.IsOptions, MethodRefer);

  Self.Request.Method := MethodRegister;
  Check(Self.Request.IsRegister, MethodRegister);

  Self.Request.Method := 'XXX';
  Check(not Self.Request.IsRegister, 'XXX');
end;

procedure TestTIdSipRequest.TestIsRequest;
begin
  Check(Self.Request.IsRequest, 'IsRequest');
end;

procedure TestTIdSipRequest.TestIsResponse;
begin
  Check(not Self.Request.IsResponse, 'IsResponse');
end;

procedure TestTIdSipRequest.TestIsSubscribe;
begin
  Self.Request.Method := MethodAck;
  Check(not Self.Request.IsOptions, MethodAck);

  Self.Request.Method := MethodSubscribe;
  Check(Self.Request.IsSubscribe, MethodSubscribe);
end;

procedure TestTIdSipRequest.TestMatchRFC2543Options;
var
  Options:  TIdSipRequest;
begin
  Options := TIdSipRequest.Create;
  try
    Options.Method := MethodOptions;
    Options.RequestUri.Uri := 'sip:franks@192.168.0.254';
    Options.AddHeader(ViaHeaderFull).Value  := 'SIP/2.0/UDP roke.angband.za.org:3442';
    Options.From.Value := '<sip:sipsak@roke.angband.za.org:3442>';
    Options.ToHeader.Value := '<sip:franks@192.168.0.254>';
    Options.CallID := '1631106896@roke.angband.za.org';
    Options.CSeq.Value := '1 OPTIONS';
    Options.AddHeader(ContactHeaderFull).Value := '<sip:sipsak@roke.angband.za.org:3442>';
    Options.ContentLength := 0;
    Options.MaxForwards := 0;
    Options.AddHeader(UserAgentHeader).Value := 'sipsak v0.8.1';

    Check(Options.Match(Options),
          'An RFC 2543 OPTIONS message should match itself!');
  finally
    Options.Free;
  end;
end;

procedure TestTIdSipRequest.TestMatchRFC2543Cancel;
var
  Cancel: TIdSipRequest;
  Invite: TIdSipRequest;
begin
  Invite := TIdSipRequest.Create;
  try
    Invite.Method := MethodInvite;
    Invite.RequestUri.Uri := 'sip:franks@192.168.0.254';
    Invite.AddHeader(ViaHeaderFull).Value  := 'SIP/2.0/UDP roke.angband.za.org:3442';
    Invite.From.Value := '<sip:sipsak@roke.angband.za.org:3442>';
    Invite.ToHeader.Value := '<sip:franks@192.168.0.254>';
    Invite.CallID := '1631106896@roke.angband.za.org';
    Invite.CSeq.Value := '1 Invite';
    Invite.AddHeader(ContactHeaderFull).Value := '<sip:sipsak@roke.angband.za.org:3442>';
    Invite.ContentLength := 0;
    Invite.MaxForwards := 0;
    Invite.AddHeader(UserAgentHeader).Value := 'sipsak v0.8.1';

    Cancel := Invite.CreateCancel;
    try
      Check(Invite.MatchCancel(Cancel), 'Matching CANCEL');

      Cancel.LastHop.Branch := Cancel.LastHop.Branch + '1';
      Check(not Invite.MatchCancel(Cancel), 'Non-matching CANCEL');
    finally
      Cancel.Free;
    end;
  finally
    Invite.Free;
  end;
end;

procedure TestTIdSipRequest.TestMatchCancel;
var
  Cancel: TIdSipRequest;
begin
  Cancel := Self.Request.CreateCancel;
  try
    Check(Self.Request.MatchCancel(Cancel), 'Matching CANCEL');

    Cancel.LastHop.Branch := Cancel.LastHop.Branch + '1';
    Check(not Self.Request.MatchCancel(Cancel), 'Non-matching CANCEL');
  finally
    Cancel.Free;
  end;
end;

procedure TestTIdSipRequest.TestMatchCancelAgainstAck;
var
  Ack:    TIdSipRequest;
  Cancel: TIdSipRequest;
begin
  Ack := Self.Request.AckFor(Self.Response);
  try
    Cancel := Self.Request.CreateCancel;
    try
      Check(Ack.MatchCancel(Cancel), '"Matching" CANCEL');

      Cancel.LastHop.Branch := Cancel.LastHop.Branch + '1';
      Check(not Ack.MatchCancel(Cancel), 'Non-"matching" CANCEL');
    finally
      Cancel.Free;
    end;
  finally
    Ack.Free;
  end;
end;

procedure TestTIdSipRequest.TestNewRequestHasContentLength;
var
  R: TIdSipRequest;
begin
  R := TIdSipRequest.Create;
  try
    Check(Pos(ContentLengthHeaderFull, R.AsString) > 0,
          'Content-Length missing from new request');
  finally
    R.Free;
  end;
end;

procedure TestTIdSipRequest.TestParse;
var
  Req: TIdSipRequest;
begin
  Req := TIdSipMessage.ReadRequestFrom(BasicRequest);
  try
    Self.CheckBasicRequest(Req);
  finally
    Req.Free;
  end;
end;

procedure TestTIdSipRequest.TestParseCompoundHeader;
const
  Route = 'Route: <sip:127.0.0.1>'#13#10
        + 'Route: wsfrank <sip:192.168.0.1>;low, <sip:192.168.0.1>'#13#10
        + BasicContentLengthHeader;
var
  Expected: TIdSipHeaders;
  Req: TIdSipRequest;
  Routes:   TIdSipHeadersFilter;
begin
  Req := TIdSipMessage.ReadRequestFrom(StringReplace(BasicRequest,
                                                     BasicContentLengthHeader,
                                                     Route,
                                                     []));
  try
    Expected := TIdSipHeaders.Create;
    try
      Expected.Add(RouteHeader).Value := '<sip:127.0.0.1>';
      Expected.Add(RouteHeader).Value := 'wsfrank <sip:192.168.0.1>;low';
      Expected.Add(RouteHeader).Value := '<sip:192.168.0.1>';

      Routes := TIdSipHeadersFilter.Create(Req.Headers, RouteHeader);
      try
        Check(Expected.Equals(Routes),
        'Routes not split into separate headers');
      finally
        Routes.Free;
      end;
    finally
      Expected.Free;
    end;
  finally
    Req.Free;
  end;
end;

procedure TestTIdSipRequest.TestParseFoldedHeader;
var
  Req: TIdSipRequest;
begin
  Req := TIdSipMessage.ReadRequestFrom('INVITE sip:wintermute@tessier-ashpool.co.luna SIP/2.0'#13#10
                            + 'Via: SIP/2.0/TCP gw1.leo-ix.org;branch=z9hG4bK776asdhds'#13#10
                            + 'Call-ID: a84b4c76e66710@gw1.leo-ix.org'#13#10
                            + 'Max-Forwards: 70'#13#10
                            + 'From: Case'#13#10
                            + ' <sip:case@fried.neurons.org>'#13#10
                            + #9';tag=1928301774'#13#10
                            + 'To: Wintermute <sip:wintermute@tessier-ashpool.co.luna>'#13#10
                            + 'CSeq: 8'#13#10
                            + '  INVITE'#13#10
                            + #13#10);
  try
    CheckEquals('From: Case <sip:case@fried.neurons.org>;tag=1928301774',
                Req.FirstHeader(FromHeaderFull).AsString,
                'From header');
  finally
    Req.Free;
  end;
end;

procedure TestTIdSipRequest.TestParseLeadingBlankLines;
var
  Req: TIdSipRequest;
begin
  Req := TIdSipMessage.ReadRequestFrom(#13#10#13#10 + BasicRequest);
  try
    Self.CheckBasicRequest(Req);
  finally
    Req.Free;
  end;
end;

procedure TestTIdSipRequest.TestParseMalformedRequestLine;
var
  Req: TIdSipRequest;
begin
  Req := TIdSipMessage.ReadRequestFrom('INVITE  sip:wintermute@tessier-ashpool.co.luna SIP/2.0'#13#10);
  try
    Check(Req.IsMalformed,
          'Malformed start line (too many spaces between Method and Request-URI) parsed without error');
    CheckEquals(RequestUriNoSpaces,
                Req.ParseFailReason,
                'Unexpected fail reason (too many spaces between Method and Request-URI)');
  finally
    Req.Free;
  end;

  Req := TIdSipMessage.ReadRequestFrom('INVITEsip:wintermute@tessier-ashpool.co.lunaSIP/2.0'#13#10);
  try
    Check(Req.IsMalformed,
          'Malformed start line (no spaces between Method and Request-URI) parsed without error');
    CheckEquals(Format(MalformedToken,
                       ['Method', 'INVITEsip:wintermute@tessier-ashpool.co.lunaSIP/2.0']),
                Req.ParseFailReason,
                'Unexpected fail reason (no spaces between Method and Request-URI)');
  finally
    Req.Free;
  end;

  Req := TIdSipMessage.ReadRequestFrom('sip:wintermute@tessier-ashpool.co.luna SIP/2.0');
  try
    Check(Req.IsMalformed,
          'Malformed start line (no Method) parsed without error');
    CheckEquals(Format(MalformedToken,
                       ['Method', 'sip:wintermute@tessier-ashpool.co.luna']),
                Req.ParseFailReason,
                'Unexpected fail reason (no Method)');
  finally
    Req.Free;
  end;

  Req := TIdSipMessage.ReadRequestFrom('INVITE'#13#10);
  try
    Check(Req.IsMalformed,
          'Malformed start line (no Request-URI, no SIP-Version) parsed without error');
    CheckEquals(RequestUriNoSpaces,
                Req.ParseFailReason,
                'Unexpected fail reason (no Request-URI, no SIP-Version)');
  finally
    Req.Free;
  end;

  Req := TIdSipMessage.ReadRequestFrom('INVITE sip:wintermute@tessier-ashpool.co.luna SIP/;2.0'#13#10);
  try
    Check(Req.IsMalformed,
          'Malformed start line (malformed SIP-Version) parsed without error');
    CheckEquals(Format(InvalidSipVersion,
                       ['SIP/;2.0']),
                Req.ParseFailReason,
                'Unexpected fail reason (malformed SIP-Version)');
  finally
    Req.Free;
  end;

  Req := TIdSipMessage.ReadRequestFrom('INVITE <sip:abc@80.168.137.82:5060> SIP/2.0'#13#10);
  try
    Check(Req.IsMalformed,
          'Malformed start line (Request-URI in angle brackets) parsed without error');
    CheckEquals(RequestUriNoAngleBrackets,
                Req.ParseFailReason,
                'Unexpected fail reason (Request-URI in angle brackets)');
  finally
    Req.Free;
  end;
end;

procedure TestTIdSipRequest.TestParseWithRequestUriInAngleBrackets;
var
  R: TIdSipRequest;
begin
  R := TIdSipMessage.ReadRequestFrom('INVITE <sip:foo> SIP/2.0'#13#10);
  try
    Self.AddRequiredHeaders(R);
    Check(R.IsMalformed,
          'Request not marked as malformed');

    CheckEquals(RequestUriNoAngleBrackets,
                R.ParseFailReason,
                'Unexpected error message');
  finally
    R.Free;
  end;
end;

procedure TestTIdSipRequest.TestProxyAuthorizationFor;
var
  Auth:       TIdSipHeader;
  ProxyAuth1: TIdSipHeader;
  ProxyAuth2: TIdSipHeader;
begin
  Auth       := Self.Request.AddHeader(AuthorizationHeader);
  ProxyAuth1 := Self.Request.AddHeader(ProxyAuthorizationHeader);
  ProxyAuth2 := Self.Request.AddHeader(ProxyAuthorizationHeader);

  Auth.Value       := 'Digest realm="ProxyAuth1"';  
  ProxyAuth1.Value := 'Digest realm="ProxyAuth1"';
  ProxyAuth2.Value := 'Digest realm="ProxyAuth2"';

  CheckNull(Self.Request.ProxyAuthorizationFor('Unknown realm'),
            'Unknown realm');
  Check(ProxyAuth1 = Self.Request.ProxyAuthorizationFor('ProxyAuth1'),
        'ProxyAuth1');
  Check(ProxyAuth2 = Self.Request.ProxyAuthorizationFor('ProxyAuth2'),
        'ProxyAuth2');
end;

procedure TestTIdSipRequest.TestRequiresResponse;
begin
  Self.Request.Method := MethodAck;
  Check(not Self.Request.RequiresResponse, 'ACKs don''t need responses');
  Self.Request.Method := MethodBye;
  Check(Self.Request.RequiresResponse, 'BYEs need responses');
  Self.Request.Method := MethodCancel;
  Check(Self.Request.RequiresResponse, 'CANCELs need responses');
  Self.Request.Method := MethodInvite;
  Check(Self.Request.RequiresResponse, 'INVITEs need responses');
  Self.Request.Method := MethodOptions;
  Check(Self.Request.RequiresResponse, 'OPTIONS need responses');
  Self.Request.Method := MethodRegister;
  Check(Self.Request.RequiresResponse, 'REGISTERs need responses');

  Self.Request.Method := 'NewFangledMethod';
  Check(Self.Request.RequiresResponse,
        'Unknown methods, by default (our assumption) require responses');
end;

procedure TestTIdSipRequest.TestSetMaxForwards;
var
  OrigMaxForwards: Byte;
begin
  OrigMaxForwards := Self.Request.MaxForwards;

  Self.Request.MaxForwards := Self.Request.MaxForwards + 1;

  CheckEquals(OrigMaxForwards + 1,
              Self.Request.MaxForwards,
              'Max-Forwards not set');
end;

procedure TestTIdSipRequest.TestSetRoute;
var
  H: TIdSipHeaders;
  P: TIdSipRoutePath;
begin
  Self.Request.AddHeader(RouteHeader).Value := '<sip:gw1.leo-ix.org>';

  H := TIdSipHeaders.Create;
  try
    H.Add(RouteHeader).Value := '<sip:gw2.leo-ix.org>';
    H.Add(RouteHeader).Value := '<sip:gw3.leo-ix.org;lr>';
    P := TIdSipRoutePath.Create(H);
    try
      Self.Request.Route := P;

      Check(Self.Request.Route.Equals(P), 'Path not correctly set');
    finally
      P.Free;
    end;
  finally
    H.Free;
  end;
end;

procedure TestTIdSipRequest.TestWantsAllowEventsHeader;
begin
  Self.Request.Method := MethodInvite;
  Check(Self.Request.WantsAllowEventsHeader,
        Self.Request.Method + ' method');

  Self.Request.Method := MethodRegister;
  Check(not Self.Request.WantsAllowEventsHeader,
        Self.Request.Method + ' method');

  Self.Request.Method := MethodSubscribe;
  Check(Self.Request.WantsAllowEventsHeader,
        Self.Request.Method + ' method');
end;

//******************************************************************************
//* TestTIdSipResponse                                                         *
//******************************************************************************
//* TestTIdSipResponse Public methods ******************************************

procedure TestTIdSipResponse.SetUp;
begin
  inherited SetUp;

  Self.Msg.SIPVersion := SIPVersion;
  (Self.Msg as TIdSipResponse).StatusCode := SIPTrying;

  Self.Request := TIdSipTestResources.CreateBasicRequest;

  Self.Contact := TIdSipContactHeader.Create;
  Self.Contact.Value := Self.Request.RequestUri.Uri;

  Self.Response := TIdSipResponse.Create;
end;

procedure TestTIdSipResponse.TearDown;
begin
  Self.Response.Free;
  Self.Contact.Free;
  Self.Request.Free;

  inherited TearDown;
end;

//* TestTIdSipResponse Protected methods ***************************************

function TestTIdSipResponse.MessageType: TIdSipMessageClass;
begin
  Result := TIdSipResponse;
end;

//* TestTIdSipResponse Private methods *****************************************

procedure TestTIdSipResponse.CheckBasicResponse(Msg: TIdSipMessage;
                                                CheckBody: Boolean = true);
begin
  CheckEquals(TIdSipResponse.Classname, Msg.ClassName, 'Class type');

  CheckEquals(486,         TIdSipResponse(Msg).StatusCode, 'StatusCode');
  CheckEquals('Busy Here', TIdSipResponse(Msg).StatusText, 'StatusText');
  CheckEquals(8,           Msg.HeaderCount,                'Header count');

  Self.CheckBasicMessage(Msg, CheckBody);
end;

procedure TestTIdSipResponse.TurnIntoRFC2543(Request: TIdSipRequest);
begin
  Request.LastHop.RemoveBranch;
end;

//* TestTIdSipResponse Published methods ***************************************

procedure TestTIdSipResponse.TestAssign;
var
  R: TIdSipResponse;
begin
  R := TIdSipResponse.Create;
  try
    R.RequestRequestUri := Self.Request.RequestUri;
    R.SIPVersion := 'SIP/1.5';
    R.StatusCode := 101;
    R.StatusText := 'Hehaeha I''ll get back to you';
    R.AddHeader(ViaHeaderFull).Value := 'SIP/2.0/TCP gw1.leo-ix.org;branch=z9hG4bK776asdhds';
    R.ContentLength := 5;
    R.Body := 'hello';

    Self.Response.Assign(R);
    CheckEquals(R.SIPVersion,    Self.Response.SipVersion,    'SIP-Version');
    CheckEquals(R.StatusCode,    Self.Response.StatusCode,    'Status-Code');
    CheckEquals(R.StatusText,    Self.Response.StatusText,    'Status-Text');

    CheckEquals(R.RequestRequestUri.Uri,
                Self.Response.RequestRequestUri.Uri,
                'RequestRequestUri');

    Check(R.Headers.Equals(Self.Response.Headers),
          'Headers not assigned properly');
  finally
    R.Free;
  end;
end;

procedure TestTIdSipResponse.TestAssignBad;
var
  P: TPersistent;
begin
  P := TPersistent.Create;
  try
    try
      Self.Response.Assign(P);
      Fail('Failed to bail out assigning a TObject to a TIdSipResponse');
    except
      on EConvertError do;
    end;
  finally
    P.Free;
  end;
end;

procedure TestTIdSipResponse.TestAsString;
var
  Expected: TStrings;
  Received: TStrings;
  Res:      TIdSipResponse;
begin
  Self.Response.StatusCode                             := 486;
  Self.Response.StatusText                             := 'Busy Here';
  Self.Response.SIPVersion                             := SIPVersion;
  Self.Response.AddHeader(ViaHeaderFull).Value         := 'SIP/2.0/TCP gw1.leo-ix.org;branch=z9hG4bK776asdhds';
  Self.Response.AddHeader(ToHeaderFull).Value          := 'Wintermute <sip:wintermute@tessier-ashpool.co.luna>;tag=1928301775';
  Self.Response.AddHeader(FromHeaderFull).Value        := 'Case <sip:case@fried.neurons.org>;tag=1928301774';
  Self.Response.CallID                                 := 'a84b4c76e66710@gw1.leo-ix.org';
  Self.Response.AddHeader(CSeqHeader).Value            := '314159 INVITE';
  Self.Response.AddHeader(ContactHeaderFull).Value     := '<sip:wintermute@tessier-ashpool.co.luna>';
  Self.Response.AddHeader(ContentTypeHeaderFull).Value := 'text/plain';
  Self.Response.ContentLength                          := 29;
  Self.Response.Body                                   := 'I am a message. Hear me roar!';

  Expected := TStringList.Create;
  try
    Expected.Text := BasicResponse;

    Received := TStringList.Create;
    try
      Received.Text := Self.Response.AsString;

      CheckEquals(Expected, Received, 'AsString');

      Res := TIdSipMessage.ReadResponseFrom(Self.Response.AsString);
      try
        Check(not Res.IsMalformed, 'Sanity check AsString');
      finally
        Res.Free;
      end;
    finally
      Received.Free;
    end;
  finally
    Expected.Free;
  end;
end;

procedure TestTIdSipResponse.TestAuthenticateHeaderWithNoAuthorization;
begin
  Check(nil = Self.Response.AuthenticateHeader,
        'No (Proxy-)Authorization header'); 
end;

procedure TestTIdSipResponse.TestAuthenticateHeaderWithProxy;
begin
  Self.Response.AddHeader(ProxyAuthenticateHeader);
  Check(Self.Response.AuthenticateHeader = Self.Response.FirstProxyAuthenticate,
        'AuthenticateHeader with a Proxy-Authenticate header');
end;

procedure TestTIdSipResponse.TestAuthenticateHeaderWithUser;
begin
  Self.Response.AddHeader(WWWAuthenticateHeader);
  Check(Self.Response.AuthenticateHeader = Self.Response.FirstWWWAuthenticate,
        'AuthenticateHeader with a WWW-Authenticate header');
end;

procedure TestTIdSipResponse.TestCopy;
var
  Copy: TIdSipMessage;
begin
  Copy := Self.Response.Copy;
  try
    Check(Copy.Equals(Self.Response), 'Copy = Self.Response');
    Check(Self.Response.Equals(Copy), 'Self.Response = Copy');
  finally
    Copy.Free;
  end;
end;

procedure TestTIdSipResponse.TestCopyMessageMutatedFromString;
var
  Copy:     TIdSipResponse;
  Original: TIdSipResponse;
begin
  Original := TIdSipMessage.ReadResponseFrom(LocalLoopResponse) as TIdSipResponse;
  try
    Original.StatusCode := Original.StatusCode + 1;

    Copy := Original.Copy as TIdSipResponse;
    try
      CheckEquals(Original.StatusCode,
                  Copy.StatusCode,
                  'Newly changed values not copied properly');
    finally
      Copy.Free;
    end;
  finally
    Original.Free;
  end;
end;

procedure TestTIdSipResponse.TestEqualsComplexMessages;
var
  R1, R2: TIdSipResponse;
begin
  R1 := TIdSipTestResources.CreateLocalLoopResponse;
  try
    R2 := TIdSipTestResources.CreateLocalLoopResponse;
    try
      Check(R1.Equals(R2), 'R1 = R2');
      Check(R2.Equals(R1), 'R2 = R1');
    finally
      R2.Free;
    end;
  finally
    R1.Free;
  end;
end;

procedure TestTIdSipResponse.TestEqualsDifferentBodies;
var
  R1, R2: TIdSipResponse;
begin
  R1 := TIdSipResponse.Create;
  try
    R2 := TIdSipResponse.Create;
    try
      R1.Body := 'non-blank';

      Check(not R1.Equals(R2), 'R1 <> R2');
      Check(not R2.Equals(R1), 'R2 <> R1');
    finally
      R2.Free;
    end;
  finally
    R1.Free;
  end;
end;

procedure TestTIdSipResponse.TestEqualsDifferentHeaders;
var
  R1, R2: TIdSipResponse;
begin
  R1 := TIdSipResponse.Create;
  try
    R2 := TIdSipResponse.Create;
    try
      R1.AddHeader(ViaHeaderFull);

      Check(not R1.Equals(R2), 'R1 <> R2');
      Check(not R2.Equals(R1), 'R2 <> R1');
    finally
      R2.Free;
    end;
  finally
    R1.Free;
  end;
end;

procedure TestTIdSipResponse.TestEqualsDifferentSipVersion;
var
  R1, R2: TIdSipResponse;
begin
  R1 := TIdSipResponse.Create;
  try
    R2 := TIdSipResponse.Create;
    try
      R1.SIPVersion := 'SIP/2.0';
      R2.SIPVersion := 'SIP/2.1';

      Check(not R1.Equals(R2), 'R1 <> R2');
      Check(not R2.Equals(R1), 'R2 <> R1');
    finally
      R2.Free;
    end;
  finally
    R1.Free;
  end;
end;

procedure TestTIdSipResponse.TestEqualsDifferentStatusCode;
var
  R1, R2: TIdSipResponse;
begin
  R1 := TIdSipResponse.Create;
  try
    R2 := TIdSipResponse.Create;
    try
      R1.StatusCode := SIPOK;
      R2.StatusCode := SIPTrying;

      Check(not R1.Equals(R2), 'R1 <> R2');
      Check(not R2.Equals(R1), 'R2 <> R1');
    finally
      R2.Free;
    end;
  finally
    R1.Free;
  end;
end;

procedure TestTIdSipResponse.TestEqualsDifferentStatusText;
var
  R1, R2: TIdSipResponse;
begin
  R1 := TIdSipResponse.Create;
  try
    R2 := TIdSipResponse.Create;
    try
      R1.StatusText := RSSIPOK;
      R2.StatusText := RSSIPTrying;

      Check(not R1.Equals(R2), 'R1 <> R2');
      Check(not R2.Equals(R1), 'R2 <> R1');
    finally
      R2.Free;
    end;
  finally
    R1.Free;
  end;
end;

procedure TestTIdSipResponse.TestEqualsRequest;
var
  Req: TIdSipRequest;
  Res: TIdSipResponse;
begin
  Req := TIdSipRequest.Create;
  try
    Res := TIdSipResponse.Create;
    try
      Check(not Res.Equals(Req), 'Res <> Req');
    finally
      Res.Free;
    end;
  finally
    Req.Free;
  end;
end;

procedure TestTIdSipResponse.TestEqualsTrivial;
var
  R1, R2: TIdSipResponse;
begin
  R1 := TIdSipResponse.Create;
  try
    R2 := TIdSipResponse.Create;
    try
      Check(R1.Equals(R2), 'R1 = R2');
      Check(R2.Equals(R1), 'R2 = R1');
    finally
      R2.Free;
    end;
  finally
    R1.Free;
  end;
end;

procedure TestTIdSipResponse.TestFirstAuthenticationInfo;
var
  A: TIdSipHeader;
begin
  Self.Response.ClearHeaders;

  CheckNotNull(Self.Response.FirstAuthenticationInfo,
               'Authentication-Info not present');
  CheckEquals(1,
              Self.Response.HeaderCount,
              'Authentication-Info not auto-added');

  A := Self.Response.FirstHeader(AuthenticationInfoHeader);
  Self.Response.AddHeader(AuthenticationInfoHeader);

  Check(A = Self.Response.FirstAuthenticationInfo, 'Wrong Authentication-Info');
end;

procedure TestTIdSipResponse.TestFirstProxyAuthenticate;
var
  P: TIdSipHeader;
begin
  Self.Response.ClearHeaders;

  CheckNotNull(Self.Response.FirstProxyAuthenticate,
               'Proxy-Authenticate not present');
  CheckEquals(1,
              Self.Response.HeaderCount,
              'Proxy-Authenticate not auto-added');

  P := Self.Response.FirstHeader(ProxyAuthenticateHeader);
  Self.Response.AddHeader(ProxyAuthenticateHeader);

  Check(P = Self.Response.FirstProxyAuthenticate,
        'Wrong Proxy-Authenticate');
end;

procedure TestTIdSipResponse.TestFirstUnsupported;
var
  U: TIdSipHeader;
begin
  Self.Response.ClearHeaders;

  CheckNotNull(Self.Response.FirstUnsupported, 'Unsupported not present');
  CheckEquals(1, Self.Response.HeaderCount, 'Unsupported not auto-added');

  U := Self.Response.FirstHeader(UnsupportedHeader);
  Self.Response.AddHeader(UnsupportedHeader);

  Check(U = Self.Response.FirstUnsupported, 'Wrong Unsupported');
end;

procedure TestTIdSipResponse.TestFirstWarning;
var
  W: TIdSipHeader;
begin
  Self.Response.ClearHeaders;

  CheckNotNull(Self.Response.FirstWarning, 'Warning not present');
  CheckEquals(1, Self.Response.HeaderCount, 'Warning not auto-added');

  W := Self.Response.FirstHeader(WarningHeader);
  Self.Response.AddHeader(WarningHeader);

  Check(W = Self.Response.FirstWarning, 'Wrong Warning');
end;

procedure TestTIdSipResponse.TestFirstWWWAuthenticate;
var
  P: TIdSipHeader;
begin
  Self.Response.ClearHeaders;

  CheckNotNull(Self.Response.FirstWWWAuthenticate,
               'WWW-Authenticate not present');
  CheckEquals(1,
              Self.Response.HeaderCount,
              'WWW-Authenticate not auto-added');

  P := Self.Response.FirstHeader(WWWAuthenticateHeader);
  Self.Response.AddHeader(WWWAuthenticateHeader);

  Check(P = Self.Response.FirstWWWAuthenticate,
        'Wrong WWW-Authenticate');
end;

procedure TestTIdSipResponse.TestHasAuthenticationInfo;
begin
  Check(not Self.Response.HasHeader(AuthenticationInfoHeader),
        'Sanity check');

  Check(not Self.Response.HasAuthenticationInfo,
        'New response');


  Self.Response.AddHeader(AuthenticationInfoHeader);
  Check(Self.Response.HasAuthenticationInfo,
        'Lies! There is too an Authentication-Info header!');
end;

procedure TestTIdSipResponse.TestHasProxyAuthenticate;
begin
  Check(not Self.Response.HasHeader(ProxyAuthenticateHeader),
        'Sanity check');

  Check(not Self.Response.HasProxyAuthenticate,
        'New response');


  Self.Response.AddHeader(ProxyAuthenticateHeader);
  Check(Self.Response.HasProxyAuthenticate,
        'Lies! There is too a Proxy-Authenticate header!');
end;

procedure TestTIdSipResponse.TestHasWarning;
begin
  Check(not Self.Response.HasHeader(WarningHeader),
        'Sanity check');

  Check(not Self.Response.HasWarning,
        'New response');

  Self.Response.AddHeader(WarningHeader);
  Check(Self.Response.HasWarning,
        'Lies! There is too a Warning header!');
end;

procedure TestTIdSipResponse.TestHasWWWAuthenticate;
begin
  Check(not Self.Response.HasHeader(WWWAuthenticateHeader),
        'Sanity check');

  Check(not Self.Response.HasWWWAuthenticate,
        'New response');


  Self.Response.AddHeader(WWWAuthenticateHeader);
  Check(Self.Response.HasWWWAuthenticate,
        'Lies! There is too a WWW-Authenticate header!');
end;

procedure TestTIdSipResponse.TestInResponseToRecordRoute;
var
  RequestRecordRoutes:  TIdSipHeadersFilter;
  Response:             TIdSipResponse;
  ResponseRecordRoutes: TIdSipHeadersFilter;
begin
  Self.Request.AddHeader(RecordRouteHeader).Value := '<sip:127.0.0.1:6000>';
  Self.Request.AddHeader(RecordRouteHeader).Value := '<sip:127.0.0.1:6001>';
  Self.Request.AddHeader(RecordRouteHeader).Value := '<sip:127.0.0.1:6002>';

  RequestRecordRoutes := TIdSipHeadersFilter.Create(Self.Request.Headers, RecordRouteHeader);
  try
    Response := TIdSipResponse.InResponseTo(Self.Request, SIPOK, Contact);
    try
      ResponseRecordRoutes := TIdSipHeadersFilter.Create(Response.Headers, RecordRouteHeader);
      try
        Check(ResponseRecordRoutes.Equals(RequestRecordRoutes),
              'Record-Route header sets mismatch');
      finally
        ResponseRecordRoutes.Free;
      end;
    finally
      Response.Free;
    end;
  finally
    RequestRecordRoutes.Free;
  end;
end;

procedure TestTIdSipResponse.TestInResponseToSipsRecordRoute;
var
  Response:    TIdSipResponse;
  SipsContact: TIdSipContactHeader;
begin
  Self.Request.AddHeader(RecordRouteHeader).Value := '<sips:127.0.0.1:6000>';

  Response := TIdSipResponse.InResponseTo(Self.Request, SIPOK, Contact);
  try
    SipsContact := Response.FirstContact;
    CheckEquals(SipsScheme, SipsContact.Address.Scheme,
                'Must use a SIPS URI in the Contact');
  finally
    Response.Free;
  end;
end;

procedure TestTIdSipResponse.TestInResponseToSipsRequestUri;
var
  Response:    TIdSipResponse;
  SipsContact: TIdSipContactHeader;
begin
  Self.Request.RequestUri.URI := 'sips:wintermute@tessier-ashpool.co.luna';

  Response := TIdSipResponse.InResponseTo(Self.Request, SIPOK, Contact);
  try
    SipsContact := Response.FirstContact;
    CheckEquals(SipsScheme, SipsContact.Address.Scheme,
                'Must use a SIPS URI in the Contact');
  finally
    Response.Free;
  end;
end;

procedure TestTIdSipResponse.TestInResponseToTryingWithTimestamps;
var
  Response: TIdSipResponse;
begin
  Self.Request.AddHeader(TimestampHeader).Value := '1';

  Response := TIdSipResponse.InResponseTo(Self.Request, SIPTrying);
  try
    Check(Response.HasHeader(TimestampHeader),
          'Timestamp header(s) not copied');
  finally
    Response.Free;
  end;
end;

procedure TestTIdSipResponse.TestInResponseToWithContact;
var
  FromFilter: TIdSipHeadersFilter;
  P:          TIdSipParser;
  Response:   TIdSipResponse;
begin
  P := TIdSipParser.Create;
  try
    Response := TIdSipResponse.InResponseTo(Self.Request, SIPOK, Contact);
    try
      CheckEquals(Self.Request.RequestUri.Uri,
                  Response.RequestRequestUri.Uri,
                  'Response''s copy of Request''s Request-URI');

      FromFilter := TIdSipHeadersFilter.Create(Response.Headers, FromHeaderFull);
      try
        CheckEquals(1, FromFilter.Count, 'Number of From headers');
      finally
        FromFilter.Free;
      end;

      CheckEquals(SIPOK, Response.StatusCode,        'StatusCode mismatch');
      Check(Response.CSeq.Equals(Self.Request.CSeq), 'Cseq header mismatch');
      Check(Response.From.Equals(Self.Request.From), 'From header mismatch');
      Check(Response.Path.Equals(Self.Request.Path), 'Via headers mismatch');

      Check(Request.ToHeader.Equals(Response.ToHeader),
            'To header mismatch');

      Check(Response.HasHeader(ContactHeaderFull), 'Missing Contact header');
    finally
      Response.Free;
    end;
  finally
    P.Free;
  end;
end;

procedure TestTIdSipResponse.TestInSameDialogAsRequest;
begin
  Self.Response.CallID       := Self.Request.CallID;
  Self.Response.From.Tag     := Self.Request.From.Tag;
  Self.Response.ToHeader.Tag := Self.Request.ToHeader.Tag;

  Check(Self.Response.InSameDialogAs(Self.Request),
        'Response not in same dialog as request');

  Self.Request.CallID := '1' + Self.Response.CallID;
  Check(not Self.Response.InSameDialogAs(Self.Request),
        'Call-ID differs');

  Self.Request.CallID   := Self.Response.CallID;
  Self.Request.From.Tag := Self.Response.From.Tag + '1';
  Check(not Self.Response.InSameDialogAs(Self.Request),
        'From tag differs');

  Self.Request.From.Tag     := Self.Response.From.Tag;
  Self.Request.ToHeader.Tag := Self.Response.ToHeader.Tag + '1';
  Check(not Self.Response.InSameDialogAs(Self.Request),
        'To tag differs');
end;

procedure TestTIdSipResponse.TestInSameDialogAsResponse;
var
  Res: TIdSipResponse;
begin
  Res := TIdSipResponse.Create;
  try
    Res.Assign(Self.Response);

    Check(Self.Response.InSameDialogAs(Res),
          'Self.Response not in same dialog as Res');
    Check(Res.InSameDialogAs(Self.Response),
          'Res not in same dialog as Self.Response');

    Res.CallID := '1' + Self.Response.CallID;
    Check(not Self.Response.InSameDialogAs(Res),
          'Call-ID differs');

    Res.CallID   := Self.Response.CallID;
    Res.From.Tag := Self.Response.From.Tag + '1';
    Check(not Self.Response.InSameDialogAs(Res),
          'From tag differs');

    Res.From.Tag     := Self.Response.From.Tag;
    Res.ToHeader.Tag := Self.Response.ToHeader.Tag + '1';
    Check(not Self.Response.InSameDialogAs(Res),
          'To tag differs');
  finally
    Res.Free;
  end;
end;

procedure TestTIdSipResponse.TestIsAuthenticationChallenge;
var
  I: Integer;
begin
  for I := 100 to 400 do begin
    Self.Response.StatusCode := I;
    Check(not Self.Response.IsAuthenticationChallenge,
          IntToStr(Self.Response.StatusCode)
        + ' ' + Self.Response.StatusText);
  end;

  Self.Response.StatusCode := 401;
  Check(Self.Response.IsAuthenticationChallenge,
        IntToStr(Self.Response.StatusCode)
      + ' ' + Self.Response.StatusText);

  for I := 402 to 406 do begin
    Self.Response.StatusCode := I;
    Check(not Self.Response.IsAuthenticationChallenge,
          IntToStr(Self.Response.StatusCode)
        + ' ' + Self.Response.StatusText);
  end;

  Self.Response.StatusCode := 407;
  Check(Self.Response.IsAuthenticationChallenge,
        IntToStr(Self.Response.StatusCode)
      + ' ' + Self.Response.StatusText);

  for I := 408 to 699 do begin
    Self.Response.StatusCode := I;
    Check(not Self.Response.IsAuthenticationChallenge,
          IntToStr(I)
        + ' ' + Self.Response.StatusText);
  end;
end;

procedure TestTIdSipResponse.TestIsMalformedStatusCode;
var
  Res: TIdSipResponse;
begin
  Res := TIdSipMessage.ReadResponseFrom('SIP/2.0 Aheh OK'#13#10);
  try
    Check(Res.IsMalformed,
          'Failed to reject a non-numeric Status-Code');
    CheckEquals(Format(InvalidStatusCode, ['Aheh']),
                Res.ParseFailReason,
                'Unexpected parse fail reason');
  finally
    Res.Free;
  end;
end;

procedure TestTIdSipResponse.TestIsFinal;
var
  I: Integer;
begin
  for I := 100 to 199 do begin
    Self.Response.StatusCode := I;
    Check(not Self.Response.IsFinal,
          IntToStr(Self.Response.StatusCode)
        + ' ' + Self.Response.StatusText);
  end;

  for I := 200 to 699 do begin
    Self.Response.StatusCode := I;
    Check(Self.Response.IsFinal,
          IntToStr(Self.Response.StatusCode)
        + ' ' + Self.Response.StatusText);
  end;
end;

procedure TestTIdSipResponse.TestIsOK;
var
  I: Integer;
begin
  for I := 100 to 199 do begin
    Self.Response.StatusCode := I;
    Check(not Self.Response.IsOK,
          IntToStr(I) + ' ' + Self.Response.StatusText);
  end;

  for I := 200 to 299 do begin
    Self.Response.StatusCode := I;
    Check(Self.Response.IsOK,
          IntToStr(I) + ' ' + Self.Response.StatusText);
  end;

  for I := 301 to 699 do begin
    Self.Response.StatusCode := I;
    Check(not Self.Response.IsOK,
          IntToStr(I) + ' ' + Self.Response.StatusText);
  end;
end;

procedure TestTIdSipResponse.TestIsProvisional;
var
  I: Integer;
begin
  for I := 100 to 199 do begin
    Self.Response.StatusCode := I;
    Check(Self.Response.IsProvisional,
          IntToStr(Self.Response.StatusCode)
        + ' ' + Self.Response.StatusText);
  end;

  for I := 200 to 699 do begin
    Self.Response.StatusCode := I;
    Check(not Self.Response.IsProvisional,
          IntToStr(Self.Response.StatusCode)
        + ' ' + Self.Response.StatusText);
  end;
end;

procedure TestTIdSipResponse.TestIsRedirect;
var
  I: Integer;
begin
  for I := 100 to 299 do begin
    Self.Response.StatusCode := I;
    Check(not Self.Response.IsRedirect,
          IntToStr(Self.Response.StatusCode)
        + ' ' + Self.Response.StatusText);
  end;

  for I := 300 to 399 do begin
    Self.Response.StatusCode := I;
    Check(Self.Response.IsRedirect,
          IntToStr(Self.Response.StatusCode)
        + ' ' + Self.Response.StatusText);
  end;

  for I := 400 to 699 do begin
    Self.Response.StatusCode := I;
    Check(not Self.Response.IsRedirect,
          IntToStr(Self.Response.StatusCode)
        + ' ' + Self.Response.StatusText);
  end;
end;

procedure TestTIdSipResponse.TestIsRequest;
begin
  Check(not Self.Response.IsRequest, 'IsRequest');
end;

procedure TestTIdSipResponse.TestIsResponse;
begin
  Check(Self.Response.IsResponse, 'IsResponse');
end;

procedure TestTIdSipResponse.TestMatchToRFC2543DifferentCallID;
var
  Response: TIdSipResponse;
begin
  Self.TurnIntoRFC2543(Self.Request);

  Response := TIdSipResponse.InResponseTo(Self.Request, SIPOK);
  try
    Response.CallID := Self.Request.CallID + '1';

    Check(not Self.Request.Match(Response),
          'Response matched with different Call-ID');
  finally
    Response.Free;
  end;
end;

procedure TestTIdSipResponse.TestMatchToRFC2543DifferentCSeqMethod;
var
  Response: TIdSipResponse;
begin
  Self.TurnIntoRFC2543(Self.Request);

  Response := TIdSipResponse.InResponseTo(Self.Request, SIPOK);
  try
    Response.CSeq.Method := Self.Request.Method + '1';

    Check(not Self.Request.Match(Response),
          'Response matched with different CSeq method');
  finally
    Response.Free;
  end;
end;

procedure TestTIdSipResponse.TestMatchToRFC2543DifferentCSeqSequenceNo;
var
  Response: TIdSipResponse;
begin
  Self.TurnIntoRFC2543(Self.Request);

  Response := TIdSipResponse.InResponseTo(Self.Request, SIPOK);
  try
    Response.CSeq.Increment;

    Check(not Self.Request.Match(Response),
          'Response matched with different CSeq sequence number');
  finally
    Response.Free;
  end;
end;

procedure TestTIdSipResponse.TestMatchToRFC2543DifferentFromTag;
var
  Response: TIdSipResponse;
begin
  Self.TurnIntoRFC2543(Self.Request);

  Response := TIdSipResponse.InResponseTo(Self.Request, SIPOK);
  try
    Response.From.Tag := Self.Request.From.Tag + '1';

    Check(not Self.Request.Match(Response),
          'Response matched with different From tag');
  finally
    Response.Free;
  end;
end;

procedure TestTIdSipResponse.TestMatchToRFC2543DifferentToTag;
var
  Response: TIdSipResponse;
begin
  Self.TurnIntoRFC2543(Self.Request);

  Response := TIdSipResponse.InResponseTo(Self.Request, SIPOK);
  try
    Response.ToHeader.Tag := Self.Request.ToHeader.Tag + '1';

    Check(not Self.Request.Match(Response),
          'Response matched with different To tag');
  finally
    Response.Free;
  end;
end;

procedure TestTIdSipResponse.TestMatchToRFC2543EmptyRequestPath;
var
  Response: TIdSipResponse;
begin
  Self.TurnIntoRFC2543(Self.Request);
  Self.Request.Path.Clear;

  Response := TIdSipResponse.InResponseTo(Self.Request, SIPOK);
  try
    Check(not Self.Request.Match(Response),
          'Request matched despite no Via headers');
  finally
    Response.Free;
  end;
end;

procedure TestTIdSipResponse.TestMatchToRFC2543EmptyResponsePath;
var
  Response: TIdSipResponse;
begin
  Self.TurnIntoRFC2543(Self.Request);

  Response := TIdSipResponse.InResponseTo(Self.Request, SIPOK);
  try
    Response.Path.Clear;
    
    Check(not Self.Request.Match(Response),
          'Response matched despite no Via headers');
  finally
    Response.Free;
  end;
end;

procedure TestTIdSipResponse.TestMatchToRFC2543ServerTransaction;
var
  InviteOne:     TIdSipRequest;
  InviteTwo:     TIdSipRequest;
  ResponseToOne: TIdSipResponse;
begin
  // Take especial note of RFC 3261, section 17.2.3, the inspiration for this
  // test.

  InviteOne := TIdSipTestResources.CreateBasicRequest;
  try
    InviteTwo := TIdSipRequest.Create;
    try
      InviteOne.LastHop.RemoveBranch;

      InviteTwo.Assign(InviteOne);
      InviteTwo.CallID   := '1' + InviteOne.CallID;
      InviteTwo.From.Tag := InviteOne.From.Tag + '1';

      ResponseToOne := TIdSipResponse.InResponseTo(InviteOne, SIPOK);
      try
        Check(InviteOne.Match(ResponseToOne),
              'Response doesn''t match InviteOne');
        Check(not InviteTwo.Match(ResponseToOne),
              'Response matches InviteTwo');
      finally
        ResponseToOne.Free;
      end;
    finally
      InviteTwo.Free;
    end;
  finally
    InviteOne.Free;
  end;
end;

procedure TestTIdSipResponse.TestIsTrying;
var
  I: Integer;
begin
  for I := 101 to 699 do begin
    Self.Response.StatusCode := I;
    Check(not Self.Response.IsTrying,
          'StatusCode ' + IntToStr(Self.Response.StatusCode)
        + ' ' + Self.Response.StatusText);
  end;

  Self.Response.StatusCode := SIPTrying;
  Check(Self.Response.IsTrying, Self.Response.StatusText);
end;

procedure TestTIdSipResponse.TestParse;
var
  Res: TIdSipResponse;
begin
  Res := TIdSipMessage.ReadResponseFrom(BasicResponse);
  try
    Self.CheckBasicResponse(Res);
  finally
    Res.Free;
  end;
end;

procedure TestTIdSipResponse.TestParseEmptyString;
var
  Res: TIdSipResponse;
begin
  Res := TIdSipMessage.ReadResponseFrom('');
  try
    CheckEquals('', Res.SipVersion, 'Sip-Version');
    CheckEquals(0,  Res.StatusCode, 'Status-Code');
    CheckEquals('', Res.StatusText, 'Status-Text');
  finally
    Res.Free;
  end;
end;

procedure TestTIdSipResponse.TestParseFoldedHeader;
var
  Res: TIdSipResponse;
begin
  Res := TIdSipMessage.ReadResponseFrom('SIP/2.0 200 OK'#13#10
                          + 'From: Case'#13#10
                          + ' <sip:case@fried.neurons.org>'#13#10
                          + #9';tag=1928301774'#13#10
                          + 'To: Wintermute <sip:wintermute@tessier-ashpool.co.luna>'#13#10
                          + 'Via: SIP/2.0/TCP gw1.leo-ix.org'#13#10
                          + 'CSeq: 271828 INVITE'#13#10
                          + 'Call-ID: cafebabe@sip.neurons.org'#13#10
                          + #13#10);
  try
    CheckEquals('SIP/2.0', Res.SipVersion, 'SipVersion');
    CheckEquals(200,       Res.StatusCode, 'StatusCode');
    CheckEquals('OK',      Res.StatusText, 'StatusTest');

    CheckEquals('From: Case <sip:case@fried.neurons.org>;tag=1928301774',
                Res.From.AsString,
                'From header');
    CheckEquals('To: Wintermute <sip:wintermute@tessier-ashpool.co.luna>',
                Res.ToHeader.AsString,
                'To header');
  finally
    Res.Free;
  end;
end;

procedure TestTIdSipResponse.TestParseLeadingBlankLines;
var
  Res: TIdSipResponse;
begin
  Res := TIdSipMessage.ReadResponseFrom(#13#10#13#10 + BasicResponse);
  try
    Self.CheckBasicResponse(Res);
  finally
    Res.Free;
  end;
end;

procedure TestTIdSipResponse.TestWantsAllowEventsHeader;
begin
  Self.Response.CSeq.Method := MethodInvite;
  Check(Self.Response.WantsAllowEventsHeader,
        Self.Response.CSeq.Method + ' CSeq method');

  Self.Response.CSeq.Method := MethodRegister;
  Check(not Self.Response.WantsAllowEventsHeader,
        Self.Response.CSeq.Method + ' CSeq method');

  Self.Response.CSeq.Method := MethodSubscribe;
  Check(Self.Response.WantsAllowEventsHeader,
        Self.Response.CSeq.Method + ' CSeq method');

  Self.Response.CSeq.Method := MethodOptions;
  Check(Self.Response.WantsAllowEventsHeader,
        Self.Response.CSeq.Method + ' CSeq method');
end;

//******************************************************************************
 //* TestTIdSipRequestList                                                     *
//******************************************************************************
//* TestTIdSipRequestList Public methods ***************************************

procedure TestTIdSipRequestList.SetUp;
begin
  inherited SetUp;

  Self.List := TIdSipRequestList.Create;
end;

procedure TestTIdSipRequestList.TearDown;
begin
  Self.List.Free;

  inherited TearDown;
end;

//* TestTIdSipRequestList Published methods ************************************

procedure TestTIdSipRequestList.TestAddAndCount;
var
  Request: TIdSipRequest;
begin
  CheckEquals(0, Self.List.Count, 'Empty list');

  Request := TIdSipRequest.Create;
  try
    Self.List.AddCopy(Request);
    CheckEquals(1, Self.List.Count, 'One Request');

    Self.List.AddCopy(Request);
    CheckEquals(2, Self.List.Count, 'Two Requests');

    Self.List.AddCopy(Request);
    CheckEquals(3, Self.List.Count, 'Three Requests');
  finally
    Request.Free;
  end;
end;

procedure TestTIdSipRequestList.TestDefaultProperty;
var
  Request: TIdSipRequest;
begin
  Request := TIdSipRequest.Create;
  try
    Request.Method := MethodInvite;
    Self.List.AddCopy(Request);

    Request.Method := MethodRegister;
    Self.List.AddCopy(Request);

    CheckEquals(MethodInvite,   Self.List[0].Method, 'Index = 0');
    CheckEquals(MethodRegister, Self.List[1].Method, 'Index = 1');

    Check(not Assigned(Self.List[-1]), 'Index < 0');
    Check(not Assigned(Self.List[Self.List.Count]), 'Index >= List.Count');
  finally
    Request.Free;
  end;
end;

procedure TestTIdSipRequestList.TestDelete;
var
  Request: TIdSipRequest;
begin
  Request := TIdSipRequest.Create;
  try
    Request.Method := MethodInvite;
    Self.List.AddCopy(Request);

    Request.Method := MethodOptions;
    Self.List.AddCopy(Request);

    Self.List.Delete(0);

    CheckEquals(1,
                Self.List.Count,
                'Nothing deleted');
    CheckEquals(MethodOptions,
                Self.List.First.Method,
                'Wrong Request deleted');
  finally
    Request.Free;
  end;
end;

procedure TestTIdSipRequestList.TestFirst;
var
  Request: TIdSipRequest;
begin
  Request := TIdSipRequest.Create;
  try
    Request.Method := MethodInvite;

    Check(nil = Self.List.First,
          'Empty list');

    Self.List.AddCopy(Request);

    CheckEquals(MethodInvite,
                Self.List.First.Method,
                'Non-empty list');

    Request.Method := MethodOptions;
    Self.List.AddCopy(Request);

    CheckEquals(MethodInvite,
                Self.List.First.Method,
                'List with multiple Requests');
  finally
    Request.Free;
  end;
end;

procedure TestTIdSipRequestList.TestIsEmpty;
var
  Request: TIdSipRequest;
begin
  Check(Self.List.IsEmpty, 'Empty list');

  Request := TIdSipRequest.Create;
  try
    Self.List.AddCopy(Request);
    Check(not Self.List.IsEmpty, 'Non-empty list');
  finally
    Request.Free;
  end;

  Self.List.Delete(0);
  Check(Self.List.IsEmpty, 'Empty list after Delete');
end;

procedure TestTIdSipRequestList.TestLast;
var
  Request: TIdSipRequest;
begin
  Request := TIdSipRequest.Create;
  try
    Request.Method := MethodInvite;

    Check(nil = Self.List.First,
          'Empty list');

    Self.List.AddCopy(Request);

    CheckEquals(Request.Method,
                Self.List.First.Method,
                'Non-empty list');

    Request.Method := MethodOptions;

    Self.List.AddCopy(Request);

    CheckEquals(Request.Method,
                Self.List.Last.Method,
                'List with multiple Requests');
  finally
    Request.Free;
  end;
end;

procedure TestTIdSipRequestList.TestListStoresCopiesNotReferences;
var
  OriginalMethod: String;
  Request:        TIdSipRequest;
begin
  OriginalMethod := MethodInvite;

  Request := TIdSipRequest.Create;
  try
    Request.Method := OriginalMethod;

    Self.List.AddCopy(Request);

    Request.Method := MethodOptions;

    CheckEquals(OriginalMethod,
                Self.List.First.Method,
                'List copy got mutated');
  finally
    Request.Free;
  end;
end;

procedure TestTIdSipRequestList.TestSecondLast;
var
  Request: TIdSipRequest;
begin
  Request := TIdSipRequest.Create;
  try
    Request.Method := MethodOptions;

    Check(nil = Self.List.SecondLast,
          'Empty list');

    Self.List.AddCopy(Request);

    Check(nil = Self.List.SecondLast,
          'Non-empty list');

    Request.Method := MethodInvite;
    Self.List.AddCopy(Request);

    CheckEquals(MethodOptions,
                Self.List.SecondLast.Method,
                'List with two Requests');

    Request.Method := MethodRegister;
    Self.List.AddCopy(Request);

    CheckEquals(MethodInvite,
                Self.List.SecondLast.Method,
                'List with three Requests');
  finally
    Request.Free;
  end;
end;

procedure TestTIdSipRequestList.TestThirdLast;
var
  Request: TIdSipRequest;
begin
  Request := TIdSipRequest.Create;
  try
    Request.Method := MethodOptions;

    Check(nil = Self.List.ThirdLast,
          'Empty list');

    Self.List.AddCopy(Request);

    Check(nil = Self.List.ThirdLast,
          'Non-empty list');

    Request.Method := MethodInvite;
    Self.List.AddCopy(Request);

    Check(nil = Self.List.ThirdLast,
         'List with two Requests');

    Request.Method := MethodRegister;
    Self.List.AddCopy(Request);

    CheckEquals(MethodOptions,
                Self.List.ThirdLast.Method,
                'List with three Requests');

    Request.Method := MethodCancel;
    Self.List.AddCopy(Request);

    CheckEquals(MethodInvite,
                Self.List.ThirdLast.Method,
                'List with four Requests');
  finally
    Request.Free;
  end;
end;

//******************************************************************************
//* TestTIdSipResponseList                                                     *
//******************************************************************************
//* TestTIdSipResponseList Public methods **************************************

procedure TestTIdSipResponseList.SetUp;
begin
  inherited SetUp;

  Self.List := TIdSipResponseList.Create;
end;

procedure TestTIdSipResponseList.TearDown;
begin
  Self.List.Free;

  inherited TearDown;
end;

//* TestTIdSipResponseList Published methods ***********************************

procedure TestTIdSipResponseList.TestAddAndCount;
var
  Response: TIdSipResponse;
begin
  CheckEquals(0, Self.List.Count, 'Empty list');

  Response := TIdSipResponse.Create;
  try
    Self.List.AddCopy(Response);
    CheckEquals(1, Self.List.Count, 'One response');

    Self.List.AddCopy(Response);
    CheckEquals(2, Self.List.Count, 'Two responses');

    Self.List.AddCopy(Response);
    CheckEquals(3, Self.List.Count, 'Three responses');
  finally
    Response.Free;
  end;
end;

procedure TestTIdSipResponseList.TestDefaultProperty;
var
  Response: TIdSipResponse;
begin
  Response := TIdSipResponse.Create;
  try
    Response.StatusCode := SIPTrying;
    Self.List.AddCopy(Response);

    Response.StatusCode := SIPOK;
    Self.List.AddCopy(Response);

    CheckEquals(SIPTrying, Self.List[0].StatusCode, 'Index = 0');
    CheckEquals(SIPOK,     Self.List[1].StatusCode, 'Index = 1');

    Check(not Assigned(Self.List[-1]), 'Index < 0');
    Check(not Assigned(Self.List[Self.List.Count]), 'Index >= List.Count');
  finally
    Response.Free;
  end;
end;

procedure TestTIdSipResponseList.TestDelete;
var
  Response: TIdSipResponse;
begin
  Response := TIdSipResponse.Create;
  try
    Response.StatusCode := SIPTrying;
    Self.List.AddCopy(Response);

    Response.StatusCode := SIPOK;
    Self.List.AddCopy(Response);

    Self.List.Delete(0);

    CheckEquals(1,
                Self.List.Count,
                'Nothing deleted');
    CheckEquals(SIPOK,
                Self.List.First.StatusCode,
                'Wrong response deleted');
  finally
    Response.Free;
  end;
end;

procedure TestTIdSipResponseList.TestFirst;
var
  Response: TIdSipResponse;
begin
  Response := TIdSipResponse.Create;
  try
    Response.StatusCode := SIPOK;

    Check(nil = Self.List.First,
          'Empty list');

    Self.List.AddCopy(Response);

    CheckEquals(SIPOK,
                Self.List.First.StatusCode,
                'Non-empty list');

    Response.StatusCode := SIPTrying;
    Self.List.AddCopy(Response);

    CheckEquals(SIPOK,
                Self.List.First.StatusCode,
                'List with multiple responses');
  finally
    Response.Free;
  end;
end;

procedure TestTIdSipResponseList.TestIsEmpty;
var
  Response: TIdSipResponse;
begin
  Check(Self.List.IsEmpty, 'Empty list');

  Response := TIdSipResponse.Create;
  try
    Self.List.AddCopy(Response);
    Check(not Self.List.IsEmpty, 'Non-empty list');
  finally
    Response.Free;
  end;

  Self.List.Delete(0);
  Check(Self.List.IsEmpty, 'Empty list after Delete');
end;

procedure TestTIdSipResponseList.TestLast;
var
  Response: TIdSipResponse;
begin
  Response := TIdSipResponse.Create;
  try
    Response.StatusCode := SIPOK;

    Check(nil = Self.List.First,
          'Empty list');

    Self.List.AddCopy(Response);

    CheckEquals(Response.StatusCode,
                Self.List.First.StatusCode,
                'Non-empty list');

    Response.StatusCode := SIPTrying;

    Self.List.AddCopy(Response);

    CheckEquals(Response.StatusCode,
                Self.List.Last.StatusCode,
                'List with multiple responses');
  finally
    Response.Free;
  end;
end;

procedure TestTIdSipResponseList.TestListStoresCopiesNotReferences;
var
  OriginalStatusCode: Cardinal;
  Response:           TIdSipResponse;
begin
  OriginalStatusCode := SIPOK;

  Response := TIdSipResponse.Create;
  try
    Response.StatusCode := OriginalStatusCode;

    Self.List.AddCopy(Response);

    Response.StatusCode := SIPNotFound;

    CheckEquals(OriginalStatusCode,
                Self.List.First.StatusCode,
                'List copy got mutated');
  finally
    Response.Free;
  end;
end;

procedure TestTIdSipResponseList.TestSecondLast;
var
  Response: TIdSipResponse;
begin
  Response := TIdSipResponse.Create;
  try
    Response.StatusCode := SIPTrying;

    Check(nil = Self.List.SecondLast,
          'Empty list');

    Self.List.AddCopy(Response);

    Check(nil = Self.List.SecondLast,
          'Non-empty list');

    Response.StatusCode := SIPOK;
    Self.List.AddCopy(Response);

    CheckEquals(SIPTrying,
                Self.List.SecondLast.StatusCode,
                'List with two responses');

    Response.StatusCode := SIPMultipleChoices;
    Self.List.AddCopy(Response);

    CheckEquals(SIPOK,
                Self.List.SecondLast.StatusCode,
                'List with three responses');
  finally
    Response.Free;
  end;
end;

initialization
  RegisterTest('SIP Messages', Suite);
end.
