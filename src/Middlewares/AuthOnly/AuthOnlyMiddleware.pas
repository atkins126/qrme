(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit AuthOnlyMiddleware;

interface

uses

    fano;

type

    (*!-----------------------------------------------
     * Middleware that check if user is logged in,
     * If not then notLoggedInHandler is called otherwise
     * it continues to next middleware
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TAuthOnlyMiddleware = class(TInjectableObject, IMiddleware)
    private
        fSessionMgr : IReadOnlySessionManager;
        fNotLoggedInHandler : IRequestHandler;
    public
        constructor create(
            const sess : IReadOnlySessionManager;
            const notLoggedInHandler : IRequestHandler
        );
        destructor destroy(); override;
        function handleRequest(
            const request : IRequest;
            const response : IResponse;
            const args : IRouteArgsReader;
            const next : IRequestHandler
        ) : IResponse;
    end;

implementation

    constructor TAuthOnlyMiddleware.create(
        const sess : IReadOnlySessionManager;
        const notLoggedInHandler : IRequestHandler
    );
    begin
        inherited create();
        fSessionMgr := sess;
        fNotLoggedInHandler := notLoggedInHandler;
    end;

    destructor TAuthOnlyMiddleware.destroy();
    begin
        fSessionMgr := nil;
        fNotLoggedInHandler := nil;
        inherited destroy();
    end;

    function TAuthOnlyMiddleware.handleRequest(
        const request : IRequest;
        const response : IResponse;
        const args : IRouteArgsReader;
        const next : IRequestHandler
    ) : IResponse;
    var
        sess : ISession;
    begin
        sess := fSessionMgr[request];
        if (sess.has('loggedIn')) then
        begin
            result := next.handleRequest(request, response, args);
        end else
        begin
            result := fNotLoggedInHandler.handleRequest(request, response, args);
        end;
    end;

end.
