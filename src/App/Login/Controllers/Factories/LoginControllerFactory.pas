(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit LoginControllerFactory;

interface

uses
    fano;

type

    (*!-----------------------------------------------
     * Factory for controller TLoginController
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TLoginControllerFactory = class(TFactory, IDependencyFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses
    sysutils,

    {*! -------------------------------
        unit interfaces
    ----------------------------------- *}
    LoginController;

    function TLoginControllerFactory.build(const container : IDependencyContainer) : IDependency;
    begin
        result := TLoginController.create(
            container['loginView'] as IView,
            TViewParameters.create()
        );
    end;
end.
