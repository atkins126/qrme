(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit BreadcrumbViewPartialFactory;

interface

{$MODE OBJFPC}
{$H+}

uses
    fano;

type

    (*!-----------------------------------------------
     * Factory for view TBreadcrumbViewPartial
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TBreadcrumbViewPartialFactory = class(TFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

    function TBreadcrumbViewPartialFactory.build(const container : IDependencyContainer) : IDependency;
    var fReader : IFileReader;
    begin
        result := TStrViewPartial.create(
            container['tplParser'] as ITemplateParser,
            fReader.readFile('resources/Templates/Adminmart/Base/breadcrumb.html')
        );
    end;
end.
