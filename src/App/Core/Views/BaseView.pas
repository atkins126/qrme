(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit BaseView;

interface

{$MODE OBJFPC}
{$H+}

uses

    fano;

type

    (*!-----------------------------------------------
     * View instance
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TBaseView = class(TInjectableObject, IView)
    protected
        fTplParser : ITemplateParser;
        fTemplateContent : string;
        fMainTpl : IViewPartial;
    public
        constructor create(
            const atplParser : ITemplateParser;
            const tpl : string;
            const mainTpl : IViewPartial
        );
        destructor destroy(); override;

        (*!------------------------------------------------
         * render view
         *------------------------------------------------
         * @param viewParams view parameters
         * @param response response instance
         * @return response
         *-----------------------------------------------*)
        function render(
            const viewParams : IViewParameters;
            const response : IResponse
        ) : IResponse;

    end;

implementation

    constructor TBaseView.create(
        const atplParser : ITemplateParser;
        const tpl : string;
        const mainTpl : IViewPartial
    );
    begin
        fTplParser := atplParser;
        fTemplateContent := tpl;
        fMainTpl := mainTpl;
    end;

    destructor TBaseView.destroy();
    begin
        fTplParser := nil;
        fMainTpl := nil;
        inherited destroy();
    end;

    (*!------------------------------------------------
     * render view
     *------------------------------------------------
     * @param viewParams view parameters
     * @param response response instance
     * @return response
     *-----------------------------------------------*)
    function TBaseView.render(
        const viewParams : IViewParameters;
        const response : IResponse
    ) : IResponse;
    begin
        viewParams['pageWrapper'] := fTplParser.parse(fTemplateContent, viewParams);
        response.body().write(fMainTpl.partial(fTemplateContent, viewParams));
        result := response;
    end;

end.
