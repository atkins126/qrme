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
    QlpQRCodeGenLibTypes,
    fpimage,
    fpwritepng;

    procedure TPngQrCodeGenerator.writeQrCodeToStream(
        const AQrCode : IQrCode;
        AScale : Int32;
        ABorder : Int32;
        const stream : TStream
    );
    var
        img : TQRCodeGenLibBitmap;
        writer : TFPCustomImageWriter;
    begin
        img := AQrCode.toBitmapImage(AScale, ABorder);
        try
            writer := TFPWriterPng.create;
            try
                img.saveToStream(stream, writer);
            finally
                writer.free();
            end;
        finally
            img.free();
        end;
    end;

end.
