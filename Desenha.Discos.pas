unit Desenha.Discos;

interface

uses
  Math,
  System.UITypes,
  Vcl.ExtCtrls,
  Vcl.Graphics;

type
  TDesenjaDiscos = class
  strict private
    const
      ESCALA_TAMANHO_DISCO = 15;
      ESCALA_LARGURA_DISCO = 20;
  public
    type
      TDisco = record
        Cor: TColor;
        Tamanho: Integer; // � um sequencial
      end;
      TDiscos = array of TDisco;

      TPino = record
        Discos: TDiscos;
        Painel: TPanel;
      end;

  public
    class procedure DesenharDiscos( APainel: TPanel;  const ADiscos: TDiscos
      ); overload;
    class procedure DesenharDiscos( APainel: TPanel;  const AIndice, ATamanho:
      Integer; ACor: TColor); overload;

    class procedure Apagar( APainel: TPanel ); overload;
    class procedure Apagar( APainel: TPanel;  const AIndice, ATamanho:
      Integer; ACor: TColor); overload;
  end;


implementation

uses
  System.Types;

type
  THackPanel = class(TPanel);


{ TDesenjaDiscos }

class procedure TDesenjaDiscos.DesenharDiscos( APainel: TPanel;
  const ADiscos: TDiscos );
var
  Indice: Integer;
  CorOriginal: TColor;

begin
  TDesenjaDiscos.Apagar( APainel );

  CorOriginal := THackPanel( APainel ).Canvas.Brush.Color;

  for Indice := Low( ADiscos ) to High( ADiscos ) do
    TDesenjaDiscos.DesenharDiscos( APainel, Indice, ADiscos[Indice].Tamanho, ADiscos[Indice].Cor);

  THackPanel( APainel ).Canvas.Brush.Color := CorOriginal;

end;

class procedure TDesenjaDiscos.Apagar(APainel: TPanel; const AIndice,
  ATamanho: Integer; ACor: TColor);
begin
  TDesenjaDiscos.DesenharDiscos(APainel, AIndice, ATamanho, APainel.Color);
end;

class procedure TDesenjaDiscos.Apagar(APainel: TPanel);
begin
  THackPanel( APainel ).Canvas.Pen.Style:= psSolid;
  THackPanel( APainel ).Canvas.Brush.Color:= clBtnFace;
  THackPanel( APainel ).Canvas.Rectangle( 0, 0, APainel.Width, APainel.Height );
end;


class procedure TDesenjaDiscos.DesenharDiscos(APainel: TPanel; const AIndice,
  ATamanho: Integer; ACor: TColor);

var
  MetadeTamanhoPainel: Integer;
  MetadeTamanhoDisco, TamanhoDisco: Integer;

  Rect: TRect;
begin
  THackPanel( APainel ).Canvas.Pen.Style:= psClear;

  MetadeTamanhoPainel:= Trunc( APainel.Width / 2 );

  TamanhoDisco:= ATamanho * ESCALA_TAMANHO_DISCO;
  MetadeTamanhoDisco:= Trunc( TamanhoDisco / 2 );

  Rect.Left:= MetadeTamanhoPainel - MetadeTamanhoDisco - Trunc( ESCALA_LARGURA_DISCO / 2 );

  Rect.Top:= APainel.Height - ( ESCALA_TAMANHO_DISCO + ( AIndice * ESCALA_TAMANHO_DISCO { * 2 }  ) );

  Rect.Bottom:= APainel.Height - ( AIndice * ESCALA_TAMANHO_DISCO );

  Rect.Right:= TamanhoDisco + Rect.Left  + ESCALA_LARGURA_DISCO;

  THackPanel( APainel ).Canvas.Brush.Color:= ACor;
  THackPanel( APainel ).Canvas.Rectangle( Rect );
end;

end.
