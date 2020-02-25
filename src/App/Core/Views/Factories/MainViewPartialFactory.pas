(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit MainViewPartialFactory;

interface

{$MODE OBJFPC}
{$H+}

uses
    fano;

type

    (*!-----------------------------------------------
     * Factory for view TCoreView
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TMainViewPartialFactory = class(TFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses

    SysUtils,

    {*! -------------------------------
        unit interfaces
    ----------------------------------- *}
    MainViewPartial;

    function TMainViewPartialFactory.build(const container : IDependencyContainer) : IDependency;
    var fReader : IFileReader;
        tpl : string;
    begin
        tpl := fReader.readFile('resources/Templates/Adminmart/Base/template.html');
        result := TMainViewPartial.create(
            container['tplParser'] as ITemplateParser,
            tpl,
            container['topCssTemplate'] as IViewPartial,
            container['bottomJsTemplate'] as IViewPartial,
            container['topBarTemplate'] as IViewPartial,
            container['leftMenuTemplate'] as IViewPartial,
            container['breadcrumbTemplate'] as IViewPartial,
            container['footerTemplate'] as IViewPartial
        );
    end;
end.
