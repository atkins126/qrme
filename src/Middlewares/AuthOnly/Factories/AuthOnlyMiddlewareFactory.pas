(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit AuthOnlyMiddlewareFactory;

interface

uses
    fano;

type

    (*!-----------------------------------------------
     * Factory for middleware TAuthOnlyMiddleware
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TAuthOnlyMiddlewareFactory = class(TFactory, IDependencyFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses
    sysutils,

    {*! -------------------------------
        unit interfaces
    ----------------------------------- *}
    AuthOnlyMiddleware;

    function TAuthOnlyMiddlewareFactory.build(const container : IDependencyContainer) : IDependency;
    begin
        //build your middleware instance here.
        //container will gives you access to all registered services
        result := TAuthOnlyMiddleware.create(
            container['sessionManager'] as IReadOnlySessionManager,
            container['notLoggedInCtrl'] as IRequestHandler
        );
    end;
end.
