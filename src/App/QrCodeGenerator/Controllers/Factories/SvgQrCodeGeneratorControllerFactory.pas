(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit SvgQrCodeGeneratorControllerFactory;

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
    TSvgQrCodeGeneratorControllerFactory = class(TQrCodeGeneratorControllerFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses

    sysutils,
    SvgQrCodeGeneratorImpl,
    {*! -------------------------------
        unit interfaces
    ----------------------------------- *}
    QrCodeGeneratorController;

    function TSvgQrCodeGeneratorControllerFactory.build(const container : IDependencyContainer) : IDependency;
    begin
        result := TQrCodeGeneratorController.create(
            TSvgQrCodeGenerator.create(),
            getDefaultCfg(container['config'] as IAppConfiguration)
        );
    end;
end.
