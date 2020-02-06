(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit QrCodeGeneratorControllerFactory;

interface

uses
    fano;

type

    (*!-----------------------------------------------
     * Factory for controller TQrQodeGeneratorController
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TQrCodeGeneratorControllerFactory = class(TFactory, IDependencyFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses

    sysutils,
    PngQrCodeGeneratorImpl,
    {*! -------------------------------
        unit interfaces
    ----------------------------------- *}
    QrCodeGeneratorController;

    function TQrCodeGeneratorControllerFactory.build(const container : IDependencyContainer) : IDependency;
    begin
        result := TQrCodeGeneratorController.create(
            TPngQrCodeGenerator.create()
        );
    end;
end.
