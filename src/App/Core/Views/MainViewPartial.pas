(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit MainViewPartial;

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
    TMainViewPartial = class(TStrViewPartial)
    private
        fTplParser : ITemplateParser;
        fTopCss : IViewPartial;
        fBottomJs : IViewPartial;
        fTopBar : IViewPartial;
        fLeftMenu : IViewPartial;
        fBreadcrumb : IViewPartial;
        fFooter : IViewPartial;
    public
        constructor create(
            const aTplParser : ITemplateParser;
            const tplStr : string;
            aTopCss : IViewPartial;
            aBottomJs : IViewPartial;
            aTopBar : IViewPartial;
            aLeftMenu : IViewPartial;
            abreadcrumb : IViewPartial;
            afooter : IViewPartial
        );

        destructor destroy(); override;

        (*!------------------------------------------------
         * read template file, parse and replace its variable
         * and output to string
         *-----------------------------------------------
         * @param templatePath file path of template
         * @param viewParams instance contains view parameters
         * @return string which all variables replaced with value from
         *        view parameters
         *-----------------------------------------------*)
        function partial(
            const templatePath : string;
            const viewParams : IViewParameters
        ) : string;
    end;

implementation

    constructor TMainViewPartial.create(
        const aTplParser : ITemplateParser;
        const tplStr : string;
        aTopCss : IViewPartial;
        aBottomJs : IViewPartial;
        aTopBar : IViewPartial;
        aLeftMenu : IViewPartial;
        abreadcrumb : IViewPartial;
        afooter : IViewPartial
    );
    begin
        inherited create(aTplParser, tplStr);
        fTopCss := aTopCss;
        fBottomJs := aBottomJs;
        fTopBar := aTopBar;
        fLeftMenu := aLeftMenu;
        fBreadcrumb := abreadcrumb;
        fFooter := afooter;
    end;

    destructor TMainViewPartial.destroy();
    begin
        fTopCss := nil;
        fBottomJs := nil;
        fTopBar := nil;
        fLeftMenu := nil;
        fBreadcrumb := nil;
        fFooter := nil;
        inherited destroy();
    end;

    (*!------------------------------------------------
     * read template file, parse and replace its variable
     * and output to string
     *-----------------------------------------------
     * @param templatePath file path of template
     * @param viewParams instance contains view parameters
     * @return string which all variables replaced with value from
     *        view parameters
     *-----------------------------------------------*)
    function TMainViewPartial.partial(
        const templatePath : string;
        const viewParams : IViewParameters
    ) : string;
    begin
        viewParams['topCss'] := fTopCss.partial(templatePath, viewParams);
        viewParams['leftMenu'] := fleftMenu.partial(templatePath, viewParams);
        viewParams['topBar'] := fTopBar.partial(templatePath, viewParams);
        viewParams['leftMenu'] := fLeftMenu.partial(templatePath, viewParams);
        viewParams['breadcrumb'] := fBreadcrumb.partial(templatePath, viewParams);
        viewParams['footer'] := fFooter.partial(templatePath, viewParams);
        inherited partial(templatePath, viewParams);
    end;

end.
