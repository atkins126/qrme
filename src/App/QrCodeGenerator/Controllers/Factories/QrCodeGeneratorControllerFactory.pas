(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit QrCodeGeneratorControllerFactory;

interface

uses

    fano,
    QrConfigTypes;

type

    (*!-----------------------------------------------
     * Abstract factory for controller TQrCodeGeneratorController
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TQrCodeGeneratorControllerFactory = class abstract (TFactory, IDependencyFactory)
    protected
        function getDefaultCfg(const config : IAppConfiguration) : TQrConfig;
    end;

implementation

uses

    sysutils,
    fpimage,
    HtmlColConv;

    function TQrCodeGeneratorControllerFactory.getDefaultCfg(const config : IAppConfiguration) : TQrConfig;
    begin
        result.fgCol := HtmlColorToColor(config.getString('qrcode.default.fgColor'), colBlack);
        result.bgCol := HtmlColorToColor(config.getString('qrcode.default.bgColor'), colWhite);
        result.scale := config.getInt('qrcode.default.scale');
        result.border := config.getInt('qrcode.default.border');
    end;
end.
