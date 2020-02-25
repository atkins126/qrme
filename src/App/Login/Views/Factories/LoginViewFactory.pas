(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit LoginViewFactory;

interface

{$MODE OBJFPC}
{$H+}

uses
    fano;

type

    (*!-----------------------------------------------
     * Factory for view TLoginView
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TLoginViewFactory = class(TFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses

    SysUtils,

    {*! -------------------------------
        unit interfaces
    ----------------------------------- *}
    LoginView;

    function TLoginViewFactory.build(const container : IDependencyContainer) : IDependency;
    var
        fReader : IFileReader;
    begin
        fReader := container['tplReader'] as IFileReader;
        result := TLoginView.create(
            container['tplParser'] as ITemplateParser,
            fReader.readFile('resources/Templates/Adminmart/Login/index.html'),
            container['mainTemplate'] as IViewPartial
        );
    end;
end.
