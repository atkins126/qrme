(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit SvgQrCodeGeneratorImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    fano,
    Classes,
    QlpIQrCode,
    QrCodeGeneratorIntf,
    AbstractQrCodeGeneratorImpl;

type

    (*!-----------------------------------------------
     * helper class that generate QR Code from string
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TSvgQrCodeGenerator = class(TAbstractQrCodeGenerator)
    protected
        procedure writeQrCodeToStream(
            const AQrCode : IQrCode;
            AScale : Int32;
            ABorder : Int32;
            const stream : TStream
        ); override;
    public
        (*!-----------------------------------------------
         * get content type of this QRCode
         * @return content type of QRCode
         *------------------------------------------------*)
        function contentType() : string; override;
    end;

implementation

uses

    QlpQrCode,
    QlpIQrSegment,
    QlpQrSegment,
    QlpQrSegmentMode,
    QlpBitBuffer,
    QlpConverters,
    QlpQRCodeGenLibTypes;

    procedure TSvgQrCodeGenerator.writeQrCodeToStream(
        const AQrCode : IQrCode;
        AScale : Int32;
        ABorder : Int32;
        const stream : TStream
    );
    var
        img : TStringStream;
    begin
        img := TStringStream.create(AQrCode.toSvgString(ABorder));
        try
            stream.copyFrom(img, 0);
        finally
            img.free();
        end;
    end;

    (*!-----------------------------------------------
     * get content type of this QRCode
     * @return content type of QRCode
     *------------------------------------------------*)
    function TSvgQrCodeGenerator.contentType() : string;
    begin
        result := 'image/svg+xml';
    end;
end.
