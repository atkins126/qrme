unit HtmlColConv;

{$MODE OBJFPC}
{$H+}

interface

uses

    Classes, SysUtils, fpimage;

// convert HTML color string #rgb, #rrggbb to TFPColor
// @credit https://wiki.freepascal.org/Convert_color_to/from_HTML
function HtmlColorToColor(htmlCol: string; defaultCol : TFPColor): TFPColor;

implementation

    function IsCharWord(ch: char): boolean;
    begin
        Result:= ch in ['a'..'z', 'A'..'Z', '_', '0'..'9'];
    end;

    function IsCharHex(ch: char): boolean;
    begin
        Result:= ch in ['0'..'9', 'a'..'f', 'A'..'F'];
    end;

    function HtmlColorToColor(htmlCol: string; defaultCol : TFPColor): TFPColor;
    var
        colR, colG, colB: integer;
        i, len: integer;
    begin
        result:= defaultCol;

        len:= 0;

        if (htmlCol <>'') and (htmlCol[1]='#') then
        begin
            delete(htmlCol, 1, 1);
        end;

        if (htmlCol='') then
        begin
            exit;
        end;

        //delete after first nonword char
        i:= 1;
        while (i<=Length(htmlCol)) and IsCharWord(htmlCol[i]) do
        begin
            inc(i);
        end;
        delete(htmlCol, i, Maxint);

        //allow only #rgb, #rrggbb
        Len:= Length(htmlCol);
        if (Len<>3) and (Len<>6) then
        begin
            result := colRed;
            exit;
        end;

        for i:= 1 to Len do
        begin
            if not IsCharHex(htmlCol[i]) then
            begin
                result:=colBlue;
                exit;
            end;
        end;

        if Len=6 then
        begin
            colR:= StrToInt('$' + copy(htmlCol, 1, 2));
            colG:= StrToInt('$' + copy(htmlCol, 3, 2));
            colB:= StrToInt('$' + copy(htmlCol, 5, 2));
        end else
        begin
            colR:= StrToInt('$' + htmlCol[1] + htmlCol[1]);
            colG:= StrToInt('$' + htmlCol[2] + htmlCol[2]);
            colB:= StrToInt('$' + htmlCol[3] + htmlCol[3]);
        end;

        with result do
        begin
            //convert rgb value from 0-$ff to 0-$ffff
            red := round((colR/$ff) * $ffff);
            green := round((colG/$ff) * $ffff);
            blue := round((colB/$ff) * $ffff);
            alpha := alphaOpaque;
        end;
    end;


end.
