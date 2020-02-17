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
    fano;

type

    (*!-----------------------------------------------
     * Factory for controller TQrQodeGeneratorController
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TQrCodeGeneratorControllerFactory = class(TFactory, IDependencyFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses

    sysutils,
    fpimage,
    QrConfigTypes,
    HtmlColConv,
    PngQrCodeGeneratorImpl,
    {*! -------------------------------
        unit interfaces
    ----------------------------------- *}
    QrCodeGeneratorController;

    function TQrCodeGeneratorControllerFactory.build(const container : IDependencyContainer) : IDependency;
    var
        defaultCfg : TQrConfig;
        config : IAppConfiguration;
    begin
        config := container['config'] as IAppConfiguration;
        defaultcfg.fgCol := HtmlColorToColor(config.getString('qrcode.default.fgColor'), colBlack);
        defaultCfg.bgCol := HtmlColorToColor(config.getString('qrcode.default.bgColor'), colWhite);
        defaultCfg.scale := config.getInt('qrcode.default.scale');
        defaultCfg.border := config.getInt('qrcode.default.border');
        result := TQrCodeGeneratorController.create(
            TPngQrCodeGenerator.create(),
            defaultCfg
        );
    end;
end.
