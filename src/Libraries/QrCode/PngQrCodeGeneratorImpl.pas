(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit PngQrCodeGeneratorImpl;

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
    TPngQrCodeGenerator = class(TAbstractQrCodeGenerator)
    protected
        procedure writeQrCodeToStream(
            const AQrCode : IQrCode;
            AScale : Int32;
            ABorder : Int32;
            const stream : TStream
        ); override;
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

    procedure TPngQrCodeGenerator.writeQrCodeToStream(
        const AQrCode : IQrCode;
        AScale : Int32;
        ABorder : Int32;
        const stream : TStream
    );
    var
        LPng: TPortableNetworkGraphic;
    begin
        LPng := AQrCode.ToPngImage(AScale, ABorder);
        try
            LPng.saveToStream(stream);
        finally
            LPng.Free;
        end;
    end;

end.
