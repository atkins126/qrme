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
    QrCodeGeneratorIntf;

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
    public
        constructor create(const generator : IQrCodeGenerator);
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
    fpimage,
    HtmlColConv;

    constructor TQrCodeGeneratorController.create(const generator : IQrCodeGenerator);
    begin
        fQrCodeGenerator := generator;
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
    begin
        scale := strToInt(request.getParam('sc', '10'));
        border := strToInt(request.getParam('bd', '4'));
        fgCol := HtmlColorToColor(request.getParam('fg'), colRed);
        bgCol := HtmlColorToColor(request.getParam('bg'), colWhite);
        result := TBinaryResponse.create(
            response.headers().clone() as IHeaders,
            'image/png',
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
