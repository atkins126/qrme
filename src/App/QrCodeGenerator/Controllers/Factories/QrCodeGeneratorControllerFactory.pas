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
    HtmlColConv,
    PngQrCodeGeneratorImpl,
    {*! -------------------------------
        unit interfaces
    ----------------------------------- *}
    QrCodeGeneratorController;

    function TQrCodeGeneratorControllerFactory.build(const container : IDependencyContainer) : IDependency;
    var
        defaultFgCol : TFPColor;
        defaultBgCol : TFPColor;
        defaultScale : int32;
        defaultBorder : int32;
        config : IAppConfiguration;
    begin
        config := container['config'] as IAppConfiguration;
        defaultFgCol := HtmlColorToColor(config.getString('qrcode.default.fgColor'), colBlack);
        defaultbgCol := HtmlColorToColor(config.getString('qrcode.default.bgColor'), colWhite);
        defaultScale := config.getInt('qrcode.default.scale');
        defaultBorder := config.getInt('qrcode.default.border');
        result := TQrCodeGeneratorController.create(
            TPngQrCodeGenerator.create(),
            defaultFgCol,
            defaultBgCol,
            defaultScale,
            defaultBorder
        );
    end;
end.
