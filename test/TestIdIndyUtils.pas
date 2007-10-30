unit TestIdIndyUtils;

interface

uses
  IdIndyUtils, IdSocketHandle, TestFramework;

type
  TestFunctions = class(TTestCase)
  private
     Sockets: TIdSocketHandles;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestBindingsToStrEmptyList;
    procedure TestBindingsToStrMultipleSockets;
    procedure TestBindingsToStrOneSocket;
    procedure TestRaiseSocketError;
  end;

implementation

uses
  IdException, SysUtils;

function Suite: ITestSuite;
begin
  Result := TTestSuite.Create('IdIndyUtils unit tests');
  Result.AddTest(TestFunctions.Suite);
end;

//******************************************************************************
//* TestFunctions                                                              *
//******************************************************************************
//* TestFunctions Public methods ***********************************************

procedure TestFunctions.SetUp;
begin
  inherited SetUp;

  Self.Sockets := TIdSocketHandles.Create(nil);
end;

procedure TestFunctions.TearDown;
begin
  Self.Sockets.Free;

  inherited TearDown;
end;

//* TestFunctions Published methods ********************************************

procedure TestFunctions.TestBindingsToStrEmptyList;
begin
  Self.Sockets.DefaultPort := 1000;
  CheckEquals('*:' + IntToStr(Self.Sockets.DefaultPort), BindingsToStr(Self.Sockets), 'Empty socket list');
end;

procedure TestFunctions.TestBindingsToStrMultipleSockets;
begin
  Self.Sockets.Add;
  Self.Sockets.Add;

  Self.Sockets[0].IP := '127.0.0.1';
  Self.Sockets[0].Port := 9;
  Self.Sockets[1].IP := '127.0.0.2';
  Self.Sockets[1].Port := 80;

  CheckEquals('127.0.0.1:9, 127.0.0.2:80', BindingsToStr(Self.Sockets), 'Two-entry socket list');
end;

procedure TestFunctions.TestBindingsToStrOneSocket;
begin
  Self.Sockets.Add;

  Self.Sockets[0].IP := '127.0.0.1';
  Self.Sockets[0].Port := 9;

  CheckEquals('127.0.0.1:9', BindingsToStr(Self.Sockets), 'One-entry socket list');
end;

procedure TestFunctions.TestRaiseSocketError;
begin
  try
    RaiseSocketError(Self.Sockets);
    Fail('No exception raised');
  except
    on EIdSocketError do;
  end;
end;

initialization
  RegisterTest('Indy utility function tests', Suite);
end.
