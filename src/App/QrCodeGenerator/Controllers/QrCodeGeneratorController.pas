(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit QrCodeGeneratorController;

interface

uses

    fano,
    fpimage,
    QrCodeGeneratorIntf,
    QrConfigTypes;

type

    (*!-----------------------------------------------
     * controller that handle route :
     * /qrqodegenerator
     *
     * See Routes/QrCodeGenerator/routes.inc
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TQrCodeGeneratorController = class(TAbstractController)
    private
        fQrCodeGenerator : IQrCodeGenerator;
        fDefaultCfg : TQrConfig;
    public
        constructor create(
            const generator : IQrCodeGenerator;
            const defaultCfg : TQrConfig
        );
        destructor destroy(); override;
        function handleRequest(
            const request : IRequest;
            const response : IResponse;
            const args : IRouteArgsReader
        ) : IResponse; override;
    end;

implementation

uses

    SysUtils,
    HtmlColConv;

    constructor TQrCodeGeneratorController.create(
        const generator : IQrCodeGenerator;
        const defaultCfg : TQrConfig
    );
    begin
        fQrCodeGenerator := generator;
        fDefaultCfg := defaultCfg;
    end;

    destructor TQrCodeGeneratorController.destroy();
    begin
        fQrCodeGenerator := nil;
        inherited destroy();
    end;

    function TQrCodeGeneratorController.handleRequest(
        const request : IRequest;
        const response : IResponse;
        const args : IRouteArgsReader
    ) : IResponse;
    var scale : int32;
        border : int32;
        fgCol : TFPColor;
        bgCol : TFPColor;
        param : string;
    begin
        param := request.getParam('sc');
        if (param <> '') then
        begin
            scale := strToInt(param);
        end else
        begin
            scale := fDefaultCfg.scale;
        end;

        param := request.getParam('bd');
        if (param <> '') then
        begin
            border := strToInt(param);
        end else
        begin
            border := fDefaultCfg.border;
        end;

        param := request.getParam('fg');
        if (param <> '') then
        begin
            fgCol := HtmlColorToColor(param, fDefaultCfg.fgCol);
        end else
        begin
            fgCol := fDefaultCfg.fgCol;
        end;

        param := request.getParam('bg');
        if (param <> '') then
        begin
            bgCol := HtmlColorToColor(param, fDefaultCfg.bgCol);
        end else
        begin
            bgCol := fDefaultCfg.bgCol;
        end;

        result := TBinaryResponse.create(
            response.headers().clone() as IHeaders,
            fQrCodeGenerator.contentType(),
            fQrCodeGenerator.generate(
                request.getParam('ud'),
                fgCol,
                bgCol,
                scale,
                border
            )
        );
    end;

end.
