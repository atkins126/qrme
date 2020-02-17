(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit QrCodeGeneratorIntf;

interface

{$MODE OBJFPC}
{$H+}

uses

    fano,
    fpimage;

type

    (*!-----------------------------------------------
     * interface for any class having capability to
     * generate QR Code to stream
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *------------------------------------------------*)
    IQrCodeGenerator = interface(IInterface)
        ['{E81EB6BF-67AF-45E4-A6E7-2134F0AABBDF}']


        (*!-----------------------------------------------
         * generate QRCode and store it in stream
         *------------------------------------------------
         * @param data string to use to encode in QR Code
         * @param colFg foreground color
         * @param colBg background color
         * @param aScale QRCode scale
         * @param aBorder QRCode border
         * @return QRCode stream
         *------------------------------------------------*)
        function generate(
            const data : string;
            colFg : TFPColor;
            colBg : TFPColor;
            AScale : Int32;
            ABorder : Int32
        ) : IResponseStream;

        (*!-----------------------------------------------
         * get content type of this QRCode
         * @return content type of QRCode
         *------------------------------------------------*)
        function contentType() : string;

    end;

implementation

end.
