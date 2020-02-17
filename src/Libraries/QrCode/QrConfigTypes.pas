unit QrConfigTypes;

{$MODE OBJFPC}
{$H+}

interface

uses

    fpImage;

type

    TQrConfig = record
        fgCol : TFPColor;
        bgCol : TFPColor;
        scale : int32;
        border : int32;
    end;

implementation


end.
