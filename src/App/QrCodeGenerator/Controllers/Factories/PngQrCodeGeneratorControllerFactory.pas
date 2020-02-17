(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit PngQrCodeGeneratorControllerFactory;

interface

uses

    fano,
    QrCodeGeneratorControllerFactory;

type

    (*!-----------------------------------------------
     * Factory for controller TQrQodeGeneratorController
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TPngQrCodeGeneratorControllerFactory = class(TQrCodeGeneratorControllerFactory)
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

    function TPngQrCodeGeneratorControllerFactory.build(const container : IDependencyContainer) : IDependency;
    begin
        result := TQrCodeGeneratorController.create(
            TPngQrCodeGenerator.create(),
            getDefaultCfg(container['config'] as IAppConfiguration)
        );
    end;
end.
