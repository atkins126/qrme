(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit AbstractQrCodeGeneratorImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    fano,
    Classes,
    fpimage,
    QlpIQrCode,
    QrCodeGeneratorIntf;

type

    (*!-----------------------------------------------
     * helper class that generate QR Code from string
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TAbstractQrCodeGenerator = class(TInterfacedObject, IQrCodeGenerator)
    protected
        procedure writeQrCodeToStream(
            const AQrCode : IQrCode;
            AScale : Int32;
            ABorder : Int32;
            const stream : TStream
        ); virtual; abstract;

    public
        (*!-----------------------------------------------
         * generate QRCode and store it in stream
         *------------------------------------------------
         * @param data string to use to encode in QR Code
         * @param colFg foreground color
         * @param colBg background color
         * @param aScale QRCode scale
         * @param aBorder QRCode border
         *------------------------------------------------*)
        function generate(
            const data : string;
            colFg : TFPColor;
            colBg : TFPColor;
            AScale : Int32;
            ABorder : Int32
        ) : IResponseStream;
    end;

implementation

uses

    SysUtils,
    QlpQrCode,
    QlpIQrSegment,
    QlpQrSegment,
    QlpQrSegmentMode,
    QlpBitBuffer,
    QlpConverters,
    QlpQRCodeGenLibTypes;

    (*!-----------------------------------------------
     * generate QRCode and store it in stream
     *------------------------------------------------
     * @param data string to use to encode in QR Code
     * @param aScale QRCode scale
     * @param aBorder QRCode border
     * @param colFg foreground color
     * @param colBg background color
     *------------------------------------------------*)
    function TAbstractQrCodeGenerator.generate(
        const data : string;
        colFg : TFPColor;
        colBg : TFPColor;
        AScale : Int32;
        ABorder : Int32
    ) : IResponseStream;
    var
        LErrCorLvl: TQrCode.TEcc;
        LQrCode: IQrCode;
        stream : TStream;
    begin
        // Low error correction level
        LErrCorLvl := TQrCode.TEcc.eccLow;
        LQrCode := TQrCode.EncodeText(data, LErrCorLvl, TEncoding.UTF8);
        stream := TMemoryStream.create();
        LQrCode.ForegroundColor := colFg;
        LQrCode.BackgroundColor := colBg;
        writeQrCodeToStream(LQrCode, AScale, ABorder, stream);
        result := TResponseStream.create(stream);
    end;


end.
