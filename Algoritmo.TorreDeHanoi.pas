unit Algoritmo.TorreDeHanoi;

interface

uses
  Vcl.ExtCtrls, Desenha.Discos;

type
  TAlgoritmo = class
  public

    procedure Hanoi(AQuantidadeDiscos: Integer;
      var APinoOrigem,  APinoDestino, APinoAuxiliar: TDesenjaDiscos.TPino );
  end;

implementation

uses
  Winapi.Windows;

{ TAlgoritmo }

procedure TAlgoritmo.Hanoi(AQuantidadeDiscos: Integer;
  var APinoOrigem, APinoDestino, APinoAuxiliar: TDesenjaDiscos.TPino );

  procedure Mover();
  var
    IndicePinoOrigem, IndicePinoDestino: Integer;
  begin
    // Pega o ultimo elemento no pino de origem;
    IndicePinoOrigem:= Length( APinoOrigem.Discos ) - 1 ;

    // Aloca espa�o no pino destino
    IndicePinoDestino:= Length( APinoDestino.Discos );
    SetLength( APinoDestino.Discos, IndicePinoDestino + 1);

    // E grava o novo valor no pino destino
    APinoDestino.Discos[ IndicePinoDestino ].Cor:=  APinoOrigem.Discos[ IndicePinoOrigem ].Cor;
    APinoDestino.Discos[ IndicePinoDestino ].Tamanho := APinoOrigem.Discos[ IndicePinoOrigem ].Tamanho;

    // pinta os paineis
    TDesenjaDiscos.Apagar( APinoOrigem.Painel, IndicePinoOrigem, APinoOrigem.Discos[IndicePinoOrigem].Tamanho,
      APinoOrigem.Discos[IndicePinoOrigem].Cor );
    // Desaloca o disco pino de origem;
    SetLength( APinoOrigem.Discos, IndicePinoOrigem );

    TDesenjaDiscos.Desenhar( APinoDestino.Painel, IndicePinoDestino, APinoDestino.Discos[IndicePinoDestino].Tamanho,
      APinoDestino.Discos[IndicePinoDestino].Cor );

    Sleep( 500 );
  end;

begin

  if ( AQuantidadeDiscos = 1 ) then
  begin
    Mover()
  end else
  begin
    Hanoi( AQuantidadeDiscos - 1, APinoOrigem, APinoAuxiliar, APinoDestino);
    Mover();
    Hanoi( AQuantidadeDiscos - 1, APinoAuxiliar, APinoDestino, APinoOrigem);
  end;


end;

end.
