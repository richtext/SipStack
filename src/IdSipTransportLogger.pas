unit IdSipTransportLogger;

interface

uses
  Classes, IdInterfacedObject, IdSipMessage, IdSipTransport, SysUtils;

type
  TIdMessageDirection = (dirError, dirIn, dirOut);

  TIdSipTransportLogger = class(TIdInterfacedObject,
                              IIdSipTransportListener,
                              IIdSipTransportSendingListener)
  private
    fOutputStream: TStream;

    procedure Log(const Msg: String;
                  Direction: TIdMessageDirection);
    procedure LogString(const Value: String);
    procedure OnException(E: Exception;
                          const Reason: String);
    procedure OnReceiveRequest(Request: TIdSipRequest;
                               Receiver: TIdSipTransport);
    procedure OnReceiveResponse(Response: TIdSipResponse;
                                Receiver: TIdSipTransport);
    procedure OnRejectedMessage(const Msg: String;
                                const Reason: String);
    procedure OnSendRequest(Request: TIdSipRequest;
                            Sender: TIdSipTransport);
    procedure OnSendResponse(Response: TIdSipResponse;
                             Sender: TIdSipTransport);
    function Timestamp(Direction: TIdMessageDirection): String;
  public
    procedure LogTransport(T: TIdSipTransport);

    property OutputStream: TStream read fOutputStream write fOutputStream;
  end;

const
  ErrorDirectionToken = '|||';
  InDirectionToken    = '<<<';
  OutDirectionToken   = '>>>';

const
  RejectedMsg = 'Rejected message: ';

function DirectionName(D: TIdMessageDirection): String;
function DirectionToStr(D: TIdMessageDirection): String;

implementation

uses
  TypInfo;

//******************************************************************************
//* Unit Public functions & procedures                                         *
//******************************************************************************

function DirectionName(D: TIdMessageDirection): String;
begin
  Result := GetEnumName(TypeInfo(TIdMessageDirection), Integer(D));
end;

function DirectionToStr(D: TIdMessageDirection): String;
begin
  case D of
    dirError: Result := ErrorDirectionToken;
    dirIn:    Result := InDirectionToken;
    dirOut:   Result := OutDirectionToken;
  else
    raise EConvertError.Create('Could not convert unknown MessageDirection to String');
  end;
end;

//******************************************************************************
//* TIdSipTransportLogger                                                      *
//******************************************************************************
//* TIdSipTransportLogger Public methods ***************************************

procedure TIdSipTransportLogger.LogTransport(T: TIdSipTransport);
begin
  T.AddTransportListener(Self);
  T.AddTransportSendingListener(Self);
end;

//* TIdSipTransportLogger Protected methods ************************************

procedure TIdSipTransportLogger.Log(const Msg: String;
                                    Direction: TIdMessageDirection);
begin
  Self.LogString(Self.Timestamp(Direction));
  Self.LogString(Msg);
  Self.LogString(#13#10);
end;

procedure TIdSipTransportLogger.LogString(const Value: String);
begin
  if (Value <> '') then
    Self.OutputStream.Write(Value[1], Length(Value));
end;

procedure TIdSipTransportLogger.OnException(E: Exception;
                                            const Reason: String);
begin
  Self.Log('Exception ' + E.ClassName + ': ' + E.Message
         + ' raised because: ''' + Reason + '''',
           dirError);
end;

procedure TIdSipTransportLogger.OnReceiveRequest(Request: TIdSipRequest;
                                                 Receiver: TIdSipTransport);
begin
  Self.Log(Request.AsString, dirIn);
end;

procedure TIdSipTransportLogger.OnReceiveResponse(Response: TIdSipResponse;
                                                  Receiver: TIdSipTransport);
begin
  Self.Log(Response.AsString, dirIn);
end;

procedure TIdSipTransportLogger.OnRejectedMessage(const Msg: String;
                                                  const Reason: String);
begin
  Self.Log(RejectedMsg + Reason + #13#10 + Msg, dirError);
end;

procedure TIdSipTransportLogger.OnSendRequest(Request: TIdSipRequest;
                                              Sender: TIdSipTransport);
begin
  Self.Log(Request.AsString, dirOut);
end;

procedure TIdSipTransportLogger.OnSendResponse(Response: TIdSipResponse;
                                               Sender: TIdSipTransport);
begin
  Self.Log(Response.AsString, dirOut);
end;

function TIdSipTransportLogger.Timestamp(Direction: TIdMessageDirection): String;
begin
  Result := DirectionToStr(Direction) + ' '
          + FormatDateTime('yyyy/mm/dd hh:mm:ss.zzz', Now) + #13#10;
end;

end.