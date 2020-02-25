(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit TopBarViewPartialFactory;

interface

{$MODE OBJFPC}
{$H+}

uses
    fano;

type

    (*!-----------------------------------------------
     * Factory for view TTopCssViewPartial
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TTopBarViewPartialFactory = class(TFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

    function TTopBarViewPartialFactory.build(const container : IDependencyContainer) : IDependency;
    var fReader : IFileReader;
    begin
        result := TStrViewPartial.create(
            container['tplParser'] as ITemplateParser,
            fReader.readFile('resources/Templates/Adminmart/Base/topbar.html')
        );
    end;
end.
